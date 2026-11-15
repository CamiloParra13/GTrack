using Microsoft.EntityFrameworkCore;

namespace Gtrack;

public class PedidoRepository(AppDbContext db) : IPedidoRepository
{
    public async Task<Pedido?> ObtenerPorIdAsync(int id) =>
        await db.Pedidos
            .Include(p => p.Cliente) // Opcional pero recomendado para detalles por ID
            .FirstOrDefaultAsync(p => p.Id == id);

    public async Task<Pedido?> ObtenerPorCodigoAsync(string codigo) =>
        await db.Pedidos
            .Include(p => p.Items)
            .Include(p => p.Cliente)
            .FirstOrDefaultAsync(p => p.Codigo == codigo);

    public async Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono) =>
        await db.Pedidos
            .Include(p => p.Cliente)
            .Where(p => p.NegocioId == negocioId && p.Cliente != null && p.Cliente.Telefono == telefono)
            .OrderByDescending(p => p.FechaCreacion)
            .FirstOrDefaultAsync();

    public async Task<bool> ExisteCodigoAsync(string codigo) =>
        await db.Pedidos.AnyAsync(p => p.Codigo == codigo);

    public async Task AgregarAsync(Pedido pedido)
    {
        db.Pedidos.Add(pedido);
        await db.SaveChangesAsync();
    }

    public async Task ActualizarAsync(Pedido pedido)
    {
        db.Pedidos.Update(pedido);
        await db.SaveChangesAsync();
    }

    public async Task<List<Pedido>> ObtenerPorNegocioAsync(int negocioId) =>
        await db.Pedidos
            .Include(p => p.Cliente) // <--- ¡Esta es la clave para que traiga el nombre y no muestre el ID!
            .Where(p => p.NegocioId == negocioId)
            .ToListAsync();
}