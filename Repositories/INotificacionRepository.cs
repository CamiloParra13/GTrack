public interface INotificacionRepository
{
    Task AgregarAsync(IEnumerable<Notificacion> notificaciones);
    Task<List<Notificacion>> ListarAsync(int usuarioId, int maximo);
    Task<int> ContarNoLeidasAsync(int usuarioId);
    Task<Notificacion?> ObtenerAsync(int usuarioId, int id);
    Task MarcarLeidaAsync(int usuarioId, int id);
    Task MarcarTodasLeidasAsync(int usuarioId);
    Task<List<Usuario>> ListarAdministradoresActivosAsync();
}
