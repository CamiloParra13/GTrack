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
    ILogger<AdministracionService> logger) : IAdministracionService
{
    public Task<List<NegocioAdminDto>> ListarNegociosAsync() => admins.ListarNegociosAsync();
    public Task<bool> AprobarNegocioAsync(int negocioId) => admins.AprobarNegocioAsync(negocioId);
    public Task<List<AdministradorDto>> ListarAdministradoresAsync() => admins.ListarAdministradoresAsync();

    public async Task<ResultadoRegistro> RegistrarAdministradorAsync(RegistroAdministradorDto dto)
    {
        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        // RN-1-CU26 / FA-26-CU26
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

        // FE-64-CU26: si falla el correo, se registra igual
        try
        {
            await email.EnviarAsync(correo, "Tus credenciales de administrador en GTrack",
                $"Hola {admin.NombreCompleto}, fuiste registrado como administrador de GTrack.\n" +
                $"Usuario: {correo} (o tu número de documento)\nContraseña temporal: {password}");
            return new(true, null, true, password);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudieron enviar las credenciales al administrador {Correo}", correo);
            return new(true, null, false, password);
        }
    }
}