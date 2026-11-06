// Implementación en memoria de IPedidoRepository para CU-03
public partial class RepositorioEnMemoria : IPedidoRepository
{
    private readonly List<Pedido> _pedidos = [];

    public Task<bool> ExisteCodigoAsync(string codigo) =>
        Task.FromResult(_pedidos.Any(p => p.Codigo.Equals(codigo, StringComparison.OrdinalIgnoreCase)));

    public Task AgregarAsync(Pedido pedido)
    {
        pedido.Id = _pedidos.Count == 0 ? 1 : _pedidos.Max(p => p.Id) + 1;
        int itemId = 1;
        foreach (var item in pedido.Items)
        {
            item.PedidoId = pedido.Id;
            if (item.Id == 0) item.Id = itemId++;
        }

        _pedidos.Add(pedido);
        return Task.CompletedTask;
    }

    public Task<Pedido?> ObtenerPorCodigoAsync(string codigo) =>
        Task.FromResult(_pedidos.FirstOrDefault(p => p.Codigo.Equals(codigo, StringComparison.OrdinalIgnoreCase)));

    public Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono) =>
        Task.FromResult(_pedidos
            .Where(p => p.NegocioId == negocioId && p.ClienteTelefono == telefono)
            .OrderByDescending(p => p.FechaCreacion)
            .FirstOrDefault());
}

