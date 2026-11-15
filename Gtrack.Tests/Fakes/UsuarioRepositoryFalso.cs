namespace Gtrack.Tests;

public class UsuarioRepositoryFalso : IUsuarioRepository
{
    public List<Usuario> Usuarios { get; } = new();
    public bool SeLlamoActualizar { get; private set; }
    public bool SeLlamoLiberarEliminados { get; private set; }

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

    public Task<List<string>> CorreosAdministradoresActivosAsync() =>
        Task.FromResult(Usuarios
            .Where(u => u.Rol == RolUsuario.Administrador && u.Estado == EstadoCuenta.Activo)
            .Select(u => u.Correo)
            .ToList());

    public Task LiberarEliminadosAsync(string correo, string documento)
    {
        SeLlamoLiberarEliminados = true;
        foreach (var u in Usuarios.Where(u =>
                     u.Estado == EstadoCuenta.Eliminado && (u.Correo == correo || u.Documento == documento)))
            u.LiberarIdentificadores();
        return Task.CompletedTask;
    }
}