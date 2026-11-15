public class PedidoRepositoryFalso : IPedidoRepository
{
    public List<Pedido> Pedidos { get; } = new();
    public bool DebeFallarAlAgregar { get; set; }
    public bool DebeFallarAlActualizar { get; set; }

    public Task<Pedido?> ObtenerPorIdAsync(int id) =>
        Task.FromResult(Pedidos.FirstOrDefault(p => p.Id == id));

    public Task<Pedido?> ObtenerPorCodigoAsync(string codigo) =>
        Task.FromResult(Pedidos.FirstOrDefault(p => p.Codigo == codigo));

    public Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono) =>
        Task.FromResult(Pedidos
            .Where(p => p.NegocioId == negocioId && p.Cliente != null && p.Cliente.Telefono == telefono)
            .OrderByDescending(p => p.FechaCreacion)
            .FirstOrDefault());

    public bool CodigosSiempreExisten { get; set; }

    public Task<bool> ExisteCodigoAsync(string codigo) =>
        Task.FromResult(CodigosSiempreExisten || Pedidos.Any(p => p.Codigo == codigo));

    public Task AgregarAsync(Pedido pedido)
    {
        if (DebeFallarAlAgregar) throw new Exception("Fallo simulado al agregar");
        if (pedido.Id == 0) pedido.Id = Pedidos.Count + 1;
        Pedidos.Add(pedido);
        return Task.CompletedTask;
    }

    public Task ActualizarAsync(Pedido pedido)
    {
        if (DebeFallarAlActualizar) throw new Exception("Fallo simulado al actualizar");
        return Task.CompletedTask;
    }

    public Task<List<Pedido>> ObtenerPorNegocioAsync(int negocioId) =>
        Task.FromResult(Pedidos.Where(p => p.NegocioId == negocioId).ToList());
}