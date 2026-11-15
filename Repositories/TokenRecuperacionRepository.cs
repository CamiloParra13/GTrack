using Microsoft.EntityFrameworkCore;

namespace Gtrack;

public class TokenRecuperacionRepository(AppDbContext db) : ITokenRecuperacionRepository
{
    public async Task AgregarAsync(TokenRecuperacion token)
    {
        db.TokensRecuperacion.Add(token);
        await db.SaveChangesAsync();
    }

    public Task<TokenRecuperacion?> ObtenerPorHashAsync(string hash) =>
        db.TokensRecuperacion.FirstOrDefaultAsync(t => t.TokenHash == hash);

    public Task<int> ContarDesdeAsync(int usuarioId, DateTime desde) =>
        db.TokensRecuperacion.CountAsync(t => t.UsuarioId == usuarioId && t.FechaCreacion >= desde);

    public async Task ActualizarAsync(TokenRecuperacion token)
    {
        db.TokensRecuperacion.Update(token);
        await db.SaveChangesAsync();
    }

    public async Task InvalidarPendientesAsync(int usuarioId)
    {
        var pendientes = await db.TokensRecuperacion
            .Where(t => t.UsuarioId == usuarioId && !t.Usado)
            .ToListAsync();
        if (pendientes.Count == 0) return;

        foreach (var t in pendientes) t.Usado = true;
        await db.SaveChangesAsync();
    }
}
