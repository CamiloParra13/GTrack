public class UsuarioRepositoryFalso : IUsuarioRepository
{
    public List<Usuario> Usuarios { get; } = new();
    public bool SeLlamoActualizar { get; private set; }

    public Task<Usuario?> ObtenerPorIdentificadorYRolAsync(string identificador, RolUsuario rol) =>
        Task.FromResult(Usuarios.FirstOrDefault(u =>
            u.Rol == rol && (u.Correo == identificador || u.Documento == identificador)));

    public Task<Usuario?> ObtenerPorCorreoAsync(string correo) =>
        Task.FromResult(Usuarios.FirstOrDefault(u => u.Correo == correo));

    public Task<Usuario?> ObtenerPorIdAsync(int id) =>
        Task.FromResult(Usuarios.FirstOrDefault(u => u.Id == id));

    public Task ActualizarAsync(Usuario usuario)
    {
        SeLlamoActualizar = true;
        return Task.CompletedTask;
    }
}