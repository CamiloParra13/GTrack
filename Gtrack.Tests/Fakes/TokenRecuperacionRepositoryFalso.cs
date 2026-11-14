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
}