using Microsoft.AspNetCore.Identity;

public class RepositorioEnMemoria : IUsuarioRepository, ITokenRecuperacionRepository
{
    private readonly List<Usuario> _usuarios = [];
    private readonly List<TokenRecuperacion> _tokens = [];

    public RepositorioEnMemoria()
    {
        var hasher = new PasswordHasher<Usuario>();

        void Agregar(int id, string correo, string doc, RolUsuario rol, EstadoCuenta estado, string? motivo = null)
        {
            var u = new Usuario { Id = id, Correo = correo, Documento = doc, Rol = rol, Estado = estado, MotivoRechazo = motivo };
            u.PasswordHash = hasher.HashPassword(u, "Clave123");
            _usuarios.Add(u);
        }

        Agregar(1, "admin@gtrack.local", "1000000001", RolUsuario.Administrador, EstadoCuenta.Activo);
        Agregar(2, "negocio@gtrack.local", "900000001", RolUsuario.Negocio, EstadoCuenta.Activo);
        Agregar(3, "pendiente@gtrack.local", "900000002", RolUsuario.Negocio, EstadoCuenta.PendienteValidacion);
        Agregar(4, "rechazado@gtrack.local", "900000003", RolUsuario.Negocio, EstadoCuenta.Rechazado, "Documento ilegible");
        Agregar(5, "repartidor@gtrack.local", "1000000002", RolUsuario.Repartidor, EstadoCuenta.Suspendido);
    }

    public Task<Usuario?> ObtenerPorIdentificadorYRolAsync(string identificador, RolUsuario rol) =>
        Task.FromResult(_usuarios.FirstOrDefault(u => u.Rol == rol &&
            (u.Correo.Equals(identificador, StringComparison.OrdinalIgnoreCase) || u.Documento == identificador)));

    public Task<Usuario?> ObtenerPorCorreoAsync(string correo) =>
        Task.FromResult(_usuarios.FirstOrDefault(u => u.Correo.Equals(correo, StringComparison.OrdinalIgnoreCase)));

    public Task<Usuario?> ObtenerPorIdAsync(int id) =>
        Task.FromResult(_usuarios.FirstOrDefault(u => u.Id == id));

    public Task ActualizarAsync(Usuario usuario) => Task.CompletedTask; // los objetos ya se modifican en memoria

    public Task AgregarAsync(TokenRecuperacion token)
    {
        token.Id = _tokens.Count + 1;
        _tokens.Add(token);
        return Task.CompletedTask;
    }

    public Task<TokenRecuperacion?> ObtenerPorHashAsync(string hash) =>
        Task.FromResult(_tokens.FirstOrDefault(t => t.TokenHash == hash));

    public Task<int> ContarDesdeAsync(int usuarioId, DateTime desde) =>
        Task.FromResult(_tokens.Count(t => t.UsuarioId == usuarioId && t.FechaCreacion >= desde));

    public Task ActualizarAsync(TokenRecuperacion token) => Task.CompletedTask;
}