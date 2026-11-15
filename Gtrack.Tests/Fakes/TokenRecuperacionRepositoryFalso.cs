namespace Gtrack.Tests;

public class TokenRecuperacionRepositoryFalso : ITokenRecuperacionRepository
{
    public List<TokenRecuperacion> Tokens { get; } = new();

    public Task AgregarAsync(TokenRecuperacion token)
    {
        Tokens.Add(token);
        return Task.CompletedTask;
    }

    public Task<TokenRecuperacion?> ObtenerPorHashAsync(string hash) =>
        Task.FromResult(Tokens.FirstOrDefault(t => t.TokenHash == hash));

    public Task<int> ContarDesdeAsync(int usuarioId, DateTime desde) =>
        Task.FromResult(Tokens.Count(t => t.UsuarioId == usuarioId && t.FechaCreacion >= desde));

    public Task ActualizarAsync(TokenRecuperacion token) => Task.CompletedTask;

    // Igual que el real: marca como usados solo los tokens pendientes de ese usuario
    public Task InvalidarPendientesAsync(int usuarioId)
    {
        foreach (var t in Tokens.Where(t => t.UsuarioId == usuarioId && !t.Usado))
            t.Usado = true;
        return Task.CompletedTask;
    }
}