using Microsoft.AspNetCore.Identity;

public class RecuperacionService(
    IUsuarioRepository usuarios,
    ITokenRecuperacionRepository tokens,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    ILogger<RecuperacionService> logger) : IRecuperacionService
{
    public const string MensajeTokenInvalido = "Este enlace ya expiró o ya fue utilizado. Solicita uno nuevo";
    private const int MaxSolicitudesPorHora = 3;
    private const int MinutosVigencia = 15;

    public async Task<ResultadoSolicitud> SolicitarAsync(string correo, Func<string, string> construirEnlace)
    {
        var usuario = await usuarios.ObtenerPorCorreoAsync(correo.Trim());
        if (usuario is null) return ResultadoSolicitud.Procesada;

        var desde = DateTime.UtcNow.AddHours(-1);
        if (await tokens.ContarDesdeAsync(usuario.Id, desde) >= MaxSolicitudesPorHora)
            return ResultadoSolicitud.LimiteSuperado;

        var token = TokenUtil.Generar();
        await tokens.AgregarAsync(new TokenRecuperacion
        {
            UsuarioId = usuario.Id,
            TokenHash = TokenUtil.Hash(token),
            Expira = DateTime.UtcNow.AddMinutes(MinutosVigencia)
        });

        await email.EnviarAsync(usuario.Correo, "Restablece tu contraseña de GTrack", PlantillaCorreo.Crear(
            titulo: "Restablece tu contraseña",
            saludo: "Hola",
            parrafos:
            [
                "Recibimos una solicitud para restablecer la contraseña de tu cuenta de GTrack.",
                "Haz clic en el botón para crear una nueva contraseña."
            ],
            textoBoton: "Restablecer contraseña",
            urlBoton: construirEnlace(token),
            nota: $"El enlace es válido por {MinutosVigencia} minutos y solo puede usarse una vez. Si no lo solicitaste, ignora este mensaje: tu contraseña actual seguirá funcionando."));

        return ResultadoSolicitud.Procesada;
    }

    public async Task<bool> TokenVigenteAsync(string token)
    {
        if (string.IsNullOrWhiteSpace(token)) return false;
        var t = await tokens.ObtenerPorHashAsync(TokenUtil.Hash(token));
        return t is not null && !t.Usado && t.Expira > DateTime.UtcNow;
    }

    public async Task<(bool Ok, string? Error)> RestablecerAsync(string token, string nueva, string confirmacion)
    {
        var t = string.IsNullOrWhiteSpace(token) ? null : await tokens.ObtenerPorHashAsync(TokenUtil.Hash(token));
        if (t is null || t.Usado || t.Expira <= DateTime.UtcNow)
            return (false, MensajeTokenInvalido);

        if (nueva != confirmacion || !ValidadorPassword.EsValida(nueva))
            return (false, "Las contraseñas no coinciden o no cumplen el formato requerido");

        var usuario = await usuarios.ObtenerPorIdAsync(t.UsuarioId);
        if (usuario is null) return (false, MensajeTokenInvalido);

        if (hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, nueva) != PasswordVerificationResult.Failed)
            return (false, "La nueva contraseña no puede ser igual a la anterior");

        usuario.PasswordHash = hasher.HashPassword(usuario, nueva);
        await usuarios.ActualizarAsync(usuario);

        t.Usado = true;
        await tokens.ActualizarAsync(t);

        try
        {
            await email.EnviarAsync(usuario.Correo, "Tu contraseña fue restablecida", PlantillaCorreo.Crear(
                titulo: "Tu contraseña fue restablecida",
                saludo: "Hola",
                parrafos:
                [
                    "Tu contraseña de GTrack fue restablecida exitosamente.",
                    "Ya puedes iniciar sesión con tu nueva contraseña."
                ],
                nota: "Si no fuiste tú, contacta a soporte de inmediato."));
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el correo de confirmación de cambio de contraseña a {Correo}", usuario.Correo);
        }

        return (true, null);
    }
}