using Microsoft.AspNetCore.Identity;

public interface IAdministracionService
{
    Task<List<NegocioAdminDto>> ListarNegociosAsync();
    Task<bool> AprobarNegocioAsync(int negocioId);
    Task<List<AdministradorDto>> ListarAdministradoresAsync();
    Task<ResultadoRegistro> RegistrarAdministradorAsync(RegistroAdministradorDto dto);
}

public class AdministracionService(
    IAdministracionRepository admins,
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    INotificacionService avisos,
    ILogger<AdministracionService> logger) : IAdministracionService
{
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

    public async Task<ResultadoRegistro> RegistrarAdministradorAsync(RegistroAdministradorDto dto)
    {
        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        if (await negocios.ExisteDocumentoAsync(documento) || await usuarios.ObtenerPorCorreoAsync(correo) is not null)
            return new(false, "Este documento o correo ya se encuentra registrado", false, null);
        if (await admins.TelefonoEnUsoAsync(telefono))
            return new(false, "El teléfono ya está registrado en el sistema", false, null);

        var password = GeneradorPassword.Temporal();
        var usuario = new Usuario
        {
            Correo = correo,
            Documento = documento,
            Rol = RolUsuario.Administrador,
            Estado = EstadoCuenta.Activo
        };
        usuario.PasswordHash = hasher.HashPassword(usuario, password);

        var admin = new Administrador { NombreCompleto = dto.NombreCompleto.Trim(), Telefono = telefono };
        await admins.RegistrarAdministradorAsync(usuario, admin);

        try
        {
            await email.EnviarAsync(correo, "Tus credenciales de administrador en GTrack", PlantillaCorreo.Crear(
                titulo: "Tu cuenta de administrador está lista",
                saludo: $"Hola, {admin.NombreCompleto}",
                parrafos: ["Fuiste registrado como administrador de GTrack. Estas son tus credenciales de acceso:"],
                datos: [("Usuario", correo), ("O tu documento", documento), ("Contraseña temporal", password)],
                nota: "Guarda esta información en un lugar seguro y no la compartas con nadie."));
            return new(true, null, true, password);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudieron enviar las credenciales al administrador {Correo}", correo);
            return new(true, null, false, password);
        }
    }
}