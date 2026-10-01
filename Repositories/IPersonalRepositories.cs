public interface IRepartidorRepository
{
    Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor);
    Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId);
    Task<bool> TelefonoEnUsoAsync(string telefono);
}

public interface IAdministracionRepository
{
    Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador);
    Task<List<AdministradorDto>> ListarAdministradoresAsync();
    Task<List<NegocioAdminDto>> ListarNegociosAsync();
    Task<bool> AprobarNegocioAsync(int negocioId);
    Task<bool> TelefonoEnUsoAsync(string telefono);
}