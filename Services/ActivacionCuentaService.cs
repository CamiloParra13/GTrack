using Microsoft.AspNetCore.Identity;

// Activación de cuenta por correo para los usuarios que registra otra persona:
//   - Repartidor (CU-09): lo registra un negocio.
//   - Administrador (CU-26): lo registra otro administrador.
// La cuenta nace sin contraseña; la persona recibe un enlace de un solo uso y crea la contraseña que quiera.
// El enlace usa la tabla TokenRecuperacion (el mismo mecanismo de "Restablecer contraseña"): se guarda
// solo el hash del token, con fecha de vencimiento y marca de uso.
public enum EstadoEnlaceActivacion { Valido, Invalido, Vencido, CuentaYaActiva }

public record InfoActivacion(
    EstadoEnlaceActivacion Estado,
    RolUsuario? Rol = null,
    string Nombre = "",
    string Correo = "",
    string Negocio = "");

public interface IActivacionCuentaService
{
    // Genera un enlace nuevo y lo envía al correo de la cuenta. Devuelve false si el correo no salió.
    // nombreNegocio solo aplica a los repartidores.
    Task<bool> EnviarEnlaceAsync(Usuario usuario, string nombre, string? nombreNegocio, Func<string, string> construirEnlace);

    // Enlaces generados para la cuenta en la última hora (para limitar los reenvíos)
    Task<int> EnviosUltimaHoraAsync(int usuarioId);

    Task<InfoActivacion> ConsultarAsync(string? token);

    // urlLogin: enlace absoluto al inicio de sesión con el perfil de la cuenta ya elegido
    Task<(bool Ok, string? Error, InfoActivacion Info)> ActivarAsync(
        string? token, string? password, string? confirmacion, Func<RolUsuario, string> urlLogin);
}

public class ActivacionCuentaService(
    IUsuarioRepository usuarios,
    ITokenRecuperacionRepository tokens,
    IRepartidorRepository repartidores,
    IAdministracionRepository administradores,
    INegocioRepository negocios,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    ILogger<ActivacionCuentaService> logger) : IActivacionCuentaService
{
    public const int HorasVigencia = 48;

    public async Task<bool> EnviarEnlaceAsync(Usuario usuario, string nombre, string? nombreNegocio, Func<string, string> construirEnlace)
    {
        try
        {
            var token = TokenUtil.Generar();
            await tokens.AgregarAsync(new TokenRecuperacion
            {
                UsuarioId = usuario.Id,
                TokenHash = TokenUtil.Hash(token),
                Expira = DateTime.UtcNow.AddHours(HorasVigencia)
            });

            var enlace = construirEnlace(token);
            var (asunto, correo) = usuario.Rol == RolUsuario.Administrador
                ? CorreoActivacionAdministrador(usuario, nombre, enlace)
                : CorreoActivacionRepartidor(usuario, nombre, nombreNegocio ?? "", enlace);

            await email.EnviarAsync(usuario.Correo, asunto, correo);
            return true;
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el correo de activación a {Correo}", usuario.Correo);
            return false;
        }
    }

    public Task<int> EnviosUltimaHoraAsync(int usuarioId) =>
        tokens.ContarDesdeAsync(usuarioId, DateTime.UtcNow.AddHours(-1));

    public async Task<InfoActivacion> ConsultarAsync(string? token)
    {
        var (estado, usuario) = await ValidarAsync(token);
        return await InfoAsync(estado, usuario);
    }

    public async Task<(bool Ok, string? Error, InfoActivacion Info)> ActivarAsync(
        string? token, string? password, string? confirmacion, Func<RolUsuario, string> urlLogin)
    {
        var (estado, usuario) = await ValidarAsync(token);
        var info = await InfoAsync(estado, usuario);
        if (estado != EstadoEnlaceActivacion.Valido || usuario is null) return (false, null, info);

        // Mismas reglas de contraseña del registro (RN-2-CU01)
        if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmacion))
            return (false, "Escribe y confirma la contraseña que quieres usar", info);
        if (password != confirmacion)
            return (false, "Las contraseñas no coinciden", info);
        if (!ValidadorPassword.EsValida(password))
            return (false, "La contraseña debe tener mínimo 6 caracteres, con al menos un número y una letra", info);

        usuario.PasswordHash = hasher.HashPassword(usuario, password);
        usuario.Estado = EstadoCuenta.Activo;
        usuario.IntentosFallidos = 0;
        usuario.BloqueadoHasta = null;
        await usuarios.ActualizarAsync(usuario);

        // El enlace es de un solo uso: se anula junto con cualquier otro que la cuenta tenga pendiente
        await tokens.InvalidarPendientesAsync(usuario.Id);

        try
        {
            await email.EnviarAsync(usuario.Correo, "Tu cuenta de GTrack está activa",
                CorreoCuentaActivada(usuario, info, urlLogin(usuario.Rol)));
        }
        catch (Exception ex)
        {
            // La cuenta ya quedó activa; el aviso por correo es solo informativo
            logger.LogWarning(ex, "No se pudo enviar la confirmación de activación a {Correo}", usuario.Correo);
        }

        return (true, null, info);
    }

    // ---------------------------------------------------------------- correos

    private static (string Asunto, CorreoHtml Correo) CorreoActivacionRepartidor(Usuario usuario, string nombre, string negocio, string enlace) =>
        ("Activa tu cuenta de repartidor en GTrack", PlantillaCorreo.Crear(
            etiqueta: "Activación de cuenta",
            titulo: "Activa tu cuenta de repartidor",
            saludo: Saludo(nombre),
            parrafos:
            [
                $"**{negocio}** te registró como repartidor en GTrack. Para empezar a recibir y gestionar tus entregas, activa tu cuenta creando tu propia contraseña.",
                "Cuando la actives podrás iniciar sesión con tu correo o con tu número de documento."
            ],
            datos: [("Negocio", negocio), ("Correo", usuario.Correo), ("Documento", usuario.Documento)],
            textoBoton: "Activar mi cuenta",
            urlBoton: enlace,
            nota: $"Este enlace vence en {HorasVigencia} horas y solo se puede usar una vez. Si vence, pídele a tu negocio que te reenvíe el correo de activación.",
            tipoNota: TipoNota.Aviso,
            resumen: $"{negocio} te registró como repartidor. Crea tu contraseña para empezar."));

    private static (string Asunto, CorreoHtml Correo) CorreoActivacionAdministrador(Usuario usuario, string nombre, string enlace) =>
        ("Activa tu cuenta de administrador en GTrack", PlantillaCorreo.Crear(
            etiqueta: "Activación de cuenta",
            titulo: "Activa tu cuenta de administrador",
            saludo: Saludo(nombre),
            parrafos:
            [
                "Te registraron como **administrador** de GTrack. Para empezar a validar negocios y gestionar la plataforma, activa tu cuenta creando tu propia contraseña.",
                "Cuando la actives podrás iniciar sesión con tu correo o con tu número de documento."
            ],
            datos: [("Perfil", "Administrador"), ("Correo", usuario.Correo), ("Documento", usuario.Documento)],
            textoBoton: "Activar mi cuenta",
            urlBoton: enlace,
            nota: $"Este enlace vence en {HorasVigencia} horas y solo se puede usar una vez. Si vence, pídele a otro administrador que te reenvíe el correo de activación.",
            tipoNota: TipoNota.Aviso,
            resumen: "Te registraron como administrador de GTrack. Crea tu contraseña para empezar."));

    private static CorreoHtml CorreoCuentaActivada(Usuario usuario, InfoActivacion info, string urlLogin)
    {
        var esAdmin = usuario.Rol == RolUsuario.Administrador;
        var perfil = esAdmin ? "Administrador" : "Repartidor";
        var registro = esAdmin
            ? "Activaste tu cuenta de administrador de GTrack."
            : string.IsNullOrWhiteSpace(info.Negocio)
                ? "Activaste tu cuenta de repartidor en GTrack."
                : $"Activaste tu cuenta de repartidor de **{info.Negocio}** en GTrack.";

        return PlantillaCorreo.Crear(
            etiqueta: "Cuenta activada",
            titulo: "¡Tu cuenta está lista!",
            saludo: Saludo(info.Nombre),
            parrafos:
            [
                registro + " Desde ahora puedes iniciar sesión con la contraseña que acabas de crear.",
                $"Al ingresar, elige el perfil **{perfil}** y escribe tu correo o tu número de documento."
            ],
            datos: [("Perfil", perfil), ("Correo", usuario.Correo), ("Documento", usuario.Documento)],
            textoBoton: "Iniciar sesión",
            urlBoton: urlLogin,
            nota: esAdmin
                ? "Si no reconoces esta activación, avisa de inmediato a otro administrador de GTrack."
                : "Si no reconoces esta activación, avisa de inmediato al negocio que te registró.",
            tipoNota: TipoNota.Info,
            resumen: $"Tu cuenta de {perfil.ToLowerInvariant()} quedó activa. Ya puedes iniciar sesión en GTrack.");
    }

    // ---------------------------------------------------------------- validación del enlace

    private async Task<(EstadoEnlaceActivacion Estado, Usuario? Usuario)> ValidarAsync(string? token)
    {
        if (string.IsNullOrWhiteSpace(token)) return (EstadoEnlaceActivacion.Invalido, null);

        var t = await tokens.ObtenerPorHashAsync(TokenUtil.Hash(token));
        if (t is null) return (EstadoEnlaceActivacion.Invalido, null);

        // Los negocios crean su contraseña al registrarse: la activación es solo para repartidores y administradores
        var usuario = await usuarios.ObtenerPorIdAsync(t.UsuarioId);
        if (usuario is null || usuario.Rol == RolUsuario.Negocio) return (EstadoEnlaceActivacion.Invalido, null);

        if (usuario.Estado == EstadoCuenta.Activo) return (EstadoEnlaceActivacion.CuentaYaActiva, usuario);
        if (usuario.Estado != EstadoCuenta.PendienteActivacion || t.Usado) return (EstadoEnlaceActivacion.Invalido, usuario);
        if (t.Expira <= DateTime.UtcNow) return (EstadoEnlaceActivacion.Vencido, usuario);

        return (EstadoEnlaceActivacion.Valido, usuario);
    }

    // Nombre de la persona (y de su negocio, si es repartidor) para mostrarlos en la página de activación
    private async Task<InfoActivacion> InfoAsync(EstadoEnlaceActivacion estado, Usuario? usuario)
    {
        if (usuario is null) return new InfoActivacion(estado);

        if (usuario.Rol == RolUsuario.Administrador)
        {
            var administrador = await administradores.ObtenerPorUsuarioIdAsync(usuario.Id);
            return new InfoActivacion(estado, usuario.Rol, administrador?.NombreCompleto ?? "", usuario.Correo);
        }

        var repartidor = await repartidores.ObtenerPorUsuarioIdAsync(usuario.Id);
        var negocio = repartidor is null ? null : await negocios.BuscarPorIdAsync(repartidor.NegocioId);
        return new InfoActivacion(estado, usuario.Rol, repartidor?.NombreCompleto ?? "", usuario.Correo, negocio?.Nombre ?? "");
    }

    private static string Saludo(string? nombre) =>
        string.IsNullOrWhiteSpace(nombre) ? "Hola," : $"Hola, {nombre}";
}
