using Microsoft.EntityFrameworkCore;

public class CodigoVerificacionRepository(AppDbContext db) : ICodigoVerificacionRepository
{
    public async Task AgregarAsync(CodigoVerificacion codigo)
    {
        db.CodigosVerificacion.Add(codigo);
        await db.SaveChangesAsync();
    }

    public Task<CodigoVerificacion?> ObtenerUltimoAsync(int usuarioId) =>
        db.CodigosVerificacion
            .Where(c => c.UsuarioId == usuarioId)
            .OrderByDescending(c => c.FechaCreacion)
            .ThenByDescending(c => c.Id)
            .FirstOrDefaultAsync();

    public async Task ActualizarAsync(CodigoVerificacion codigo)
    {
        db.CodigosVerificacion.Update(codigo);
        await db.SaveChangesAsync();
    }
}
