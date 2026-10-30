public interface IPedidoRepository
{
    Task<Pedido?> ObtenerPorIdAsync(int id);
    Task<Pedido?> ObtenerPorCodigoAsync(string codigo);
    Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono);
    Task<bool> ExisteCodigoAsync(string codigo);
    Task AgregarAsync(Pedido pedido);
    Task ActualizarAsync(Pedido pedido);
    Task<List<Pedido>> ObtenerPorNegocioAsync(int negocioId);
}