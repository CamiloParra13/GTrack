using Microsoft.EntityFrameworkCore;

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
}
