public interface ITokenRecuperacionRepository
{
    Task AgregarAsync(TokenRecuperacion token);
    Task<TokenRecuperacion?> ObtenerPorHashAsync(string hash);
    Task<int> ContarDesdeAsync(int usuarioId, DateTime desde);
    Task ActualizarAsync(TokenRecuperacion token);
}