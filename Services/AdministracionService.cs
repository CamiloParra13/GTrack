using Microsoft.EntityFrameworkCore;

public interface IAdministracionService
{
    Task<List<NegocioAdminDto>> ListarNegociosAsync();

    // Valida el negocio y le avisa por correo. urlLogin: inicio de sesión con el perfil Negocio ya elegido
    Task<(bool Ok, bool CorreoEnviado)> AprobarNegocioAsync(int negocioId, string urlLogin);

    Task<List<AdministradorDto>> ListarAdministradoresAsync();

    // CU-26: registra al administrador sin contraseña y le envía el correo para activar su cuenta
    Task<ResultadoRegistro> RegistrarAdministradorAsync(RegistroAdministradorDto dto, Func<string, string> construirEnlace);

    // Vuelve a enviar el correo de activación a un administrador que aún no activa su cuenta
    Task<(bool Ok, string Mensaje)> ReenviarActivacionAsync(int usuarioId, Func<string, string> construirEnlace);
}

public class AdministracionService(
    IAdministracionRepository admins,
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    IActivacionCuentaService activacion,
    IEmailService email,
    INotificacionService avisos,
    ILogger<AdministracionService> logger) : IAdministracionService
{
    // Evita que la persona reciba una ráfaga de correos de activación
    private const int MaxCorreosActivacionPorHora = 3;

    public Task<List<NegocioAdminDto>> ListarNegociosAsync() => admins.ListarNegociosAsync();

    public async Task<bool> AprobarNegocioAsync(int negocioId)
    {
        if (!await admins.AprobarNegocioAsync(negocioId)) return false;

        var negocio = await negocios.BuscarPorIdAsync(negocioId);
        var usuario = negocio is null ? null : await usuarios.ObtenerPorIdAsync(negocio.UsuarioId);
        if (negocio is not null && usuario is not null)
            await avisos.NegocioAprobadoAsync(usuario.Id, negocio.Nombre, usuario.Correo);

        return true;
    }

    public Task<List<AdministradorDto>> ListarAdministradoresAsync() => admins.ListarAdministradoresAsync();

    // ----- Validación de negocios (CU-18) -----
    public async Task<(bool Ok, bool CorreoEnviado)> AprobarNegocioAsync(int negocioId, string urlLogin)
    {
        if (!await admins.AprobarNegocioAsync(negocioId)) return (false, false);

        var negocio = await negocios.BuscarPorIdAsync(negocioId);
        var usuario = negocio is null ? null : await usuarios.ObtenerPorIdAsync(negocio.UsuarioId);
        if (negocio is null || usuario is null) return (true, false);

        // El negocio queda validado aunque el aviso por correo falle
        try
        {
            await email.EnviarAsync(usuario.Correo, "Tu negocio fue validado en GTrack", PlantillaCorreo.Crear(
                etiqueta: "Cuenta validada",
                titulo: "¡Tu negocio ya está activo!",
                saludo: $"Hola, {negocio.Nombre}",
                parrafos:
                [
                    "Buenas noticias: un administrador revisó y aprobó la información de tu negocio.",
                    "Ya puedes iniciar sesión con el perfil **Negocio** para registrar pedidos y gestionar a tus repartidores."
                ],
                datos: [("Negocio", negocio.Nombre), ("Correo", usuario.Correo), ("Documento", usuario.Documento), ("Estado", "Activo")],
                textoBoton: "Iniciar sesión",
                urlBoton: urlLogin,
                nota: "Ingresa con tu correo o con tu número de documento (NIT/CC) y la contraseña que creaste al registrarte.",
                tipoNota: TipoNota.Exito,
                resumen: $"{negocio.Nombre} fue validado. Ya puedes iniciar sesión en GTrack."));
            return (true, true);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo avisar por correo al negocio {Negocio} que fue validado", negocio.Nombre);
            return (true, false);
        }
    }

    // ----- CU-26 Registrar administrador -----
    public async Task<ResultadoRegistro> RegistrarAdministradorAsync(RegistroAdministradorDto dto, Func<string, string> construirEnlace)
    {
        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        if (await negocios.ExisteDocumentoAsync(documento) || await usuarios.ObtenerPorCorreoAsync(correo) is not null)
            return new(false, "Este documento o correo ya se encuentra registrado", false, null);
        if (await admins.TelefonoEnUsoAsync(telefono))
            return new(false, "El teléfono ya está registrado en el sistema", false, null);

        // Igual que el repartidor: la cuenta nace sin contraseña y el administrador la crea
        // desde el enlace que le llega al correo (nadie más conoce su contraseña)
        var usuario = new Usuario
        {
            Correo = correo,
            Documento = documento,
            PasswordHash = "",
            Rol = RolUsuario.Administrador,
            Estado = EstadoCuenta.PendienteActivacion
        };

        var admin = new Administrador { NombreCompleto = dto.NombreCompleto.Trim(), Telefono = telefono };

        try
        {
            await admins.RegistrarAdministradorAsync(usuario, admin);
            await email.EnviarAsync(correo, "Tus credenciales de administrador en GTrack", PlantillaCorreo.Crear(
                titulo: "Tu cuenta de administrador está lista",
                saludo: $"Hola, {admin.NombreCompleto}",
                parrafos: ["Fuiste registrado como administrador de GTrack. Estas son tus credenciales de acceso:"],
                datos: [("Usuario", correo), ("O tu documento", documento), ("Contraseña temporal", password)],
                nota: "Guarda esta información en un lugar seguro y no la compartas con nadie."));
            return new(true, null, true, password);
        }
        catch (DbUpdateException ex)
        {
            logger.LogError(ex, "No se pudo guardar el administrador {Correo}", correo);
            return new(false, "No fue posible registrar al administrador. Intenta nuevamente", false, null);
        }

        // FE-64-CU26: si falla el correo, el administrador queda registrado y se le puede reenviar
        var enviado = await activacion.EnviarEnlaceAsync(usuario, admin.NombreCompleto, null, construirEnlace);
        return new(true, null, enviado, null);
    }

    public async Task<(bool Ok, string Mensaje)> ReenviarActivacionAsync(int usuarioId, Func<string, string> construirEnlace)
    {
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null || usuario.Rol != RolUsuario.Administrador)
            return (false, "El administrador no existe.");

        var admin = await admins.ObtenerPorUsuarioIdAsync(usuario.Id);
        var nombre = admin?.NombreCompleto ?? usuario.Correo;

        if (usuario.Estado != EstadoCuenta.PendienteActivacion)
            return (false, $"{nombre} ya activó su cuenta.");

        if (await activacion.EnviosUltimaHoraAsync(usuario.Id) >= MaxCorreosActivacionPorHora)
            return (false, "Ya enviaste varios correos de activación a este administrador en la última hora. Intenta más tarde.");

        var enviado = await activacion.EnviarEnlaceAsync(usuario, admin?.NombreCompleto ?? "", null, construirEnlace);
        return enviado
            ? (true, $"Reenviamos el correo de activación a {usuario.Correo}.")
            : (false, "No fue posible enviar el correo de activación. Intenta nuevamente.");
    }
}
