using Microsoft.EntityFrameworkCore;

public class PedidoRepository(AppDbContext db) : IPedidoRepository
{
    public Task<bool> ExisteCodigoAsync(string codigo) =>
        db.Pedidos.AnyAsync(p => p.Codigo == codigo);

    public async Task AgregarAsync(Pedido pedido)
    {
        db.Pedidos.Add(pedido);          // los Items se guardan junto con el pedido (una sola transacción)
        await db.SaveChangesAsync();
    }

    public Task<Pedido?> ObtenerPorCodigoAsync(string codigo) =>
        db.Pedidos.Include(p => p.Items).FirstOrDefaultAsync(p => p.Codigo == codigo);

    public Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono) =>
        db.Pedidos
            .Where(p => p.NegocioId == negocioId && p.ClienteTelefono == telefono)
            .OrderByDescending(p => p.FechaCreacion)
            .FirstOrDefaultAsync();
}
