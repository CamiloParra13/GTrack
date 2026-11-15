using Microsoft.EntityFrameworkCore;

namespace Gtrack;

// CU-09: repartidores guardados en SQL Server
public class RepartidorRepository(AppDbContext db) : IRepartidorRepository
{
    public async Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor)
    {
        // Un solo SaveChanges: se guardan la cuenta y el repartidor juntos, o ninguno
        repartidor.Usuario = usuario;
        await LiberarPlacaDeEliminadosAsync(repartidor.Placa, null);
        db.Repartidores.Add(repartidor);
        await db.SaveChangesAsync();
    }

    public async Task<Repartidor?> BuscarEliminadoAsync(string correo, string documento)
    {
        // El correo/documento pudo quedar "liberado" con prefijo (eliminado.{Id}.correo / X{Id}-documento)
        var candidatos = await db.Repartidores
            .Include(r => r.Usuario)
            .Where(r => r.Usuario!.Estado == EstadoCuenta.Eliminado &&
                (r.Usuario.Correo == correo || r.Usuario.Correo.EndsWith("." + correo) ||
                 r.Usuario.Documento == documento || r.Usuario.Documento.EndsWith("-" + documento)))
            .OrderByDescending(r => r.Id)
            .ToListAsync();

        return candidatos.FirstOrDefault(r =>
            r.Usuario!.Correo == correo || r.Usuario.Correo == $"eliminado.{r.UsuarioId}.{correo}" ||
            r.Usuario.Documento == documento || r.Usuario.Documento == $"X{r.UsuarioId}-{documento}");
    }

    public async Task ReactivarAsync(Repartidor repartidor)
    {
        await LiberarPlacaDeEliminadosAsync(repartidor.Placa, repartidor.Id);
        await db.SaveChangesAsync();
    }

    // Si otro repartidor eliminado tiene la misma placa, se la quita para que no choque con el índice único
    private async Task LiberarPlacaDeEliminadosAsync(string? placa, int? excluirId)
    {
        if (string.IsNullOrEmpty(placa)) return;
        var conPlaca = await db.Repartidores
            .Where(r => r.Placa == placa && r.Usuario!.Estado == EstadoCuenta.Eliminado &&
                        (excluirId == null || r.Id != excluirId))
            .ToListAsync();
        foreach (var r in conPlaca) r.Placa = null;
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
        // Los repartidores eliminados no bloquean su teléfono
        await db.Repartidores.AnyAsync(r => r.Telefono == telefono && r.Usuario!.Estado != EstadoCuenta.Eliminado) ||
        await db.Administradores.AnyAsync(a => a.Telefono == telefono);

    public Task<Repartidor?> ObtenerDeNegocioAsync(int negocioId, int repartidorId) =>
        db.Repartidores
            .Include(r => r.Usuario)
            .FirstOrDefaultAsync(r => r.Id == repartidorId && r.NegocioId == negocioId);

    public Task<Repartidor?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        db.Repartidores
            .AsNoTracking()
            .FirstOrDefaultAsync(r => r.UsuarioId == usuarioId);
}
