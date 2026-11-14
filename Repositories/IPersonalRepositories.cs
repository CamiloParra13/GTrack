public interface IRepartidorRepository
{
    Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor);
    Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId);
    Task<bool> TelefonoEnUsoAsync(string telefono);

    // Repartidor de un negocio, con su cuenta de usuario (null si no existe o es de otro negocio)
    Task<Repartidor?> ObtenerDeNegocioAsync(int negocioId, int repartidorId);

    // Repartidor dueño de una cuenta de usuario
    Task<Repartidor?> ObtenerPorUsuarioIdAsync(int usuarioId);
}

public interface IAdministracionRepository
{
    Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador);
    Task<List<AdministradorDto>> ListarAdministradoresAsync();
    Task<List<NegocioAdminDto>> ListarNegociosAsync();
    Task<bool> AprobarNegocioAsync(int negocioId);
    Task<bool> TelefonoEnUsoAsync(string telefono);

    // Administrador dueño de una cuenta de usuario (null para el administrador principal)
    Task<Administrador?> ObtenerPorUsuarioIdAsync(int usuarioId);
}
