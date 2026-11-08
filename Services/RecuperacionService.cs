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

        var enlace = construirEnlace(token);
        await email.EnviarAsync(usuario.Correo, "Restablece tu contraseña de GTrack",
            "Recibimos una solicitud para restablecer la contraseña de tu cuenta de GTrack.\n\n" +
            "Haz clic en el siguiente enlace para crear una nueva contraseña:\n" +
            enlace + "\n\n" +
            $"El enlace es válido por {MinutosVigencia} minutos y solo puede usarse una vez. " +
            "Si no lo solicitaste, ignora este mensaje: tu contraseña actual seguirá funcionando.");

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

        // FE-52: coinciden y formato
        if (nueva != confirmacion || !ValidadorPassword.EsValida(nueva))
            return (false, "Las contraseñas no coinciden o no cumplen el formato requerido");

        var usuario = await usuarios.ObtenerPorIdAsync(t.UsuarioId);
        if (usuario is null) return (false, MensajeTokenInvalido);

        // RN-3: no puede ser igual a la anterior
        if (EsLaMismaContrasena(usuario, nueva))
            return (false, "La nueva contraseña no puede ser igual a la anterior");

        usuario.PasswordHash = hasher.HashPassword(usuario, nueva);
        await usuarios.ActualizarAsync(usuario);

        t.Usado = true; // RN-2: un solo uso
        await tokens.ActualizarAsync(t);

        try
        {
            await email.EnviarAsync(usuario.Correo, "Tu contraseña fue restablecida",
                "Tu contraseña de Gtrack fue restablecida exitosamente. Si no fuiste tú, contacta a soporte.");
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el correo de confirmación de cambio de contraseña a {Correo}", usuario.Correo);
        }

        return (true, null);
    }

    // Si el hash guardado no es válido (por ejemplo, una cuenta creada por SQL con un valor temporal),
    // no hay contraseña anterior con la que comparar y se permite el cambio.
    private bool EsLaMismaContrasena(Usuario usuario, string nueva)
    {
        try
        {
            return hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, nueva) != PasswordVerificationResult.Failed;
        }
        catch (FormatException)
        {
            return false;
        }
    }
}