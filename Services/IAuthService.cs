namespace Gtrack;

public interface IAuthService
{
    Task<(Usuario? Usuario, string? Error)> IniciarSesionAsync(LoginDto dto);
}