using Microsoft.EntityFrameworkCore;

// CU-09: repartidores guardados en SQL Server
public class RepartidorRepository(AppDbContext db) : IRepartidorRepository
{
    public async Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor)
    {
        // Un solo SaveChanges: se guardan la cuenta y el repartidor juntos, o ninguno
        repartidor.Usuario = usuario;
        db.Repartidores.Add(repartidor);
        await db.SaveChangesAsync();
    }

    public Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId) =>
        db.Repartidores
            .AsNoTracking()
            .Include(r => r.Usuario)
            .Where(r => r.NegocioId == negocioId && r.Usuario!.Estado != EstadoCuenta.Eliminado)
            .OrderByDescending(r => r.FechaRegistro)
            .ToListAsync();

    public async Task<bool> TelefonoEnUsoAsync(string telefono) =>
        await db.Negocios.AnyAsync(n => n.Telefono == telefono) ||
        await db.Repartidores.AnyAsync(r => r.Telefono == telefono) ||
        await db.Administradores.AnyAsync(a => a.Telefono == telefono);
}
