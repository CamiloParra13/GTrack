using Microsoft.AspNetCore.Identity;

public class RecuperacionService(
    IUsuarioRepository usuarios,
    ITokenRecuperacionRepository tokens,
    IPasswordHasher<Usuario> hasher,
    IEmailService email) : IRecuperacionService
{
    public const string MensajeTokenInvalido = "Este enlace ya expiró o ya fue utilizado. Solicita uno nuevo";
    private const int MaxSolicitudesPorHora = 3;
    private const int MinutosVigencia = 15;

    public async Task<ResultadoSolicitud> SolicitarAsync(string correo, Func<string, string> construirEnlace)
    {
        var usuario = await usuarios.ObtenerPorCorreoAsync(correo.Trim());
        if (usuario is null) return ResultadoSolicitud.Procesada; // FA-21: mensaje neutro, sin correo

        var desde = DateTime.UtcNow.AddHours(-1);
        if (await tokens.ContarDesdeAsync(usuario.Id, desde) >= MaxSolicitudesPorHora)
            return ResultadoSolicitud.LimiteSuperado; // RN-4 / FE-53

        var token = TokenUtil.Generar();
        await tokens.AgregarAsync(new TokenRecuperacion
        {
            UsuarioId = usuario.Id,
            TokenHash = TokenUtil.Hash(token),
            Expira = DateTime.UtcNow.AddMinutes(MinutosVigencia)
        });

        await email.EnviarAsync(usuario.Correo, "Restablece tu contraseña de Gtrack",
            $"Usa este enlace para restablecer tu contraseña. Es válido por {MinutosVigencia} minutos y solo puede usarse una vez:\n{construirEnlace(token)}");

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

        // FE-52: coincidir y formato
        if (nueva != confirmacion || !ValidadorPassword.EsValida(nueva))
            return (false, "Las contraseñas no coinciden o no cumplen el formato requerido");

        var usuario = await usuarios.ObtenerPorIdAsync(t.UsuarioId);
        if (usuario is null) return (false, MensajeTokenInvalido);

        // RN-3: no puede ser igual a la anterior
        if (hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, nueva) != PasswordVerificationResult.Failed)
            return (false, "La nueva contraseña no puede ser igual a la anterior");

        usuario.PasswordHash = hasher.HashPassword(usuario, nueva);
        await usuarios.ActualizarAsync(usuario);

        t.Usado = true; // RN-2: un solo uso
        await tokens.ActualizarAsync(t);

        await email.EnviarAsync(usuario.Correo, "Tu contraseña fue restablecida",
            "Tu contraseña de Gtrack fue restablecida exitosamente. Si no fuiste tú, contacta a soporte.");

        return (true, null);
    }
}