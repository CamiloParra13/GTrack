// CU-03: Repositorio para la gestión de pedidos
public interface IPedidoRepository
{
    Task<bool> ExisteCodigoAsync(string codigo);
    Task AgregarAsync(Pedido pedido);
    Task<Pedido?> ObtenerPorCodigoAsync(string codigo);
    Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono);
}

