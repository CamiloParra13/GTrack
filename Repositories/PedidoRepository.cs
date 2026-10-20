using Microsoft.EntityFrameworkCore;

// CU-03: pedidos guardados en SQL Server
public class PedidoRepository(AppDbContext db) : IPedidoRepository
{
    public Task<bool> ExisteCodigoAsync(string codigo) =>
        db.Pedidos.AnyAsync(p => p.Codigo == codigo);

    public async Task AgregarAsync(Pedido pedido)
    {
        db.Pedidos.Add(pedido);   // guarda también sus Items
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
