namespace Gtrack;

public interface IRepartidorRepository
{
    Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor);
    Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId);
    Task<bool> TelefonoEnUsoAsync(string telefono);

    // Repartidor de un negocio, con su cuenta de usuario (null si no existe o es de otro negocio)
    Task<Repartidor?> ObtenerDeNegocioAsync(int negocioId, int repartidorId);

    // Repartidor dueño de una cuenta de usuario
    Task<Repartidor?> ObtenerPorUsuarioIdAsync(int usuarioId);

    // Repartidor eliminado (baja lógica) que corresponde a la misma persona por correo o documento
    Task<Repartidor?> BuscarEliminadoAsync(string correo, string documento);

    // Guarda los cambios de un repartidor eliminado que se vuelve a registrar
    Task ReactivarAsync(Repartidor repartidor);
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
