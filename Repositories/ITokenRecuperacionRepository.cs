// Enlaces de un solo uso enviados por correo: recuperación de contraseña (CU-20)
// y activación de la cuenta del repartidor (CU-09).
public interface ITokenRecuperacionRepository
{
    Task AgregarAsync(TokenRecuperacion token);
    Task<TokenRecuperacion?> ObtenerPorHashAsync(string hash);
    Task<int> ContarDesdeAsync(int usuarioId, DateTime desde);
    Task ActualizarAsync(TokenRecuperacion token);

    // Marca como usados todos los enlaces que la cuenta aún tenga sin usar
    Task InvalidarPendientesAsync(int usuarioId);
}
