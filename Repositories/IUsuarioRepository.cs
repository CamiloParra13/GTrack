public interface IUsuarioRepository
{
    Task<Usuario?> ObtenerPorIdentificadorYRolAsync(string identificador, RolUsuario rol);
    Task<Usuario?> ObtenerPorCorreoAsync(string correo);
    Task<Usuario?> ObtenerPorIdAsync(int id);
    Task ActualizarAsync(Usuario usuario);
}