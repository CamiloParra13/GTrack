public interface INotificacionService
{

    Task NegocioPendienteAsync(string nombreNegocio, string documento, string correoNegocio);

    Task NegocioAprobadoAsync(int usuarioNegocioId, string nombreNegocio, string correoNegocio);

    Task RepartidorRegistradoAsync(int usuarioNegocioId, string nombreRepartidor);

    Task<List<Notificacion>> ListarAsync(int usuarioId, int maximo = 50);
    Task<int> ContarNoLeidasAsync(int usuarioId);

    Task<string?> AbrirAsync(int usuarioId, int id);
    Task MarcarTodasLeidasAsync(int usuarioId);
}
