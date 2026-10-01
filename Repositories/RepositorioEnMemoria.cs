using Microsoft.AspNetCore.Identity;

public partial class RepositorioEnMemoria :
    IUsuarioRepository, ITokenRecuperacionRepository, INegocioRepository, ICodigoVerificacionRepository
{
    private readonly List<Usuario> _usuarios = [];
    private readonly List<TokenRecuperacion> _tokens = [];
    private readonly List<Negocio> _negocios = [];
    private readonly List<CodigoVerificacion> _codigos = [];

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

        // Datos de negocio para las cuentas de prueba de rol Negocio (usuarios 2, 3 y 4)
        _negocios.Add(new Negocio
        {
            Id = 1, UsuarioId = 2, Nombre = "Logística y Alimentos Facatativá S.A.S.",
            TipoActividad = "Logística y distribución", Telefono = "3105551234",
            Direccion = "Carrera 24 #5-40, Centro, Facatativá, Cundinamarca",
            FechaRegistro = new DateTime(2026, 3, 15, 0, 0, 0, DateTimeKind.Utc)
        });
        _negocios.Add(new Negocio
        {
            Id = 2, UsuarioId = 3, Nombre = "Pizzería Los Sauces",
            TipoActividad = "Restaurante y comidas", Telefono = "3115552345",
            Direccion = "Calle 10 #8-20, Facatativá, Cundinamarca"
        });
        _negocios.Add(new Negocio
        {
            Id = 3, UsuarioId = 4, Nombre = "Floristería Aurora",
            TipoActividad = "Floristería", Telefono = "3125553456",
            Direccion = "Avenida 15 #12-30, Facatativá, Cundinamarca"
        });
    }

    // ---------- IUsuarioRepository ----------
    public Task<Usuario?> ObtenerPorIdentificadorYRolAsync(string identificador, RolUsuario rol) =>
        Task.FromResult(_usuarios.FirstOrDefault(u => u.Rol == rol &&
            (u.Correo.Equals(identificador, StringComparison.OrdinalIgnoreCase) || u.Documento == identificador)));

    public Task<Usuario?> ObtenerPorCorreoAsync(string correo) =>
        Task.FromResult(_usuarios.FirstOrDefault(u => u.Correo.Equals(correo, StringComparison.OrdinalIgnoreCase)));

    public Task<Usuario?> ObtenerPorIdAsync(int id) =>
        Task.FromResult(_usuarios.FirstOrDefault(u => u.Id == id));

    public Task ActualizarAsync(Usuario usuario) => Task.CompletedTask; // los objetos ya se modifican en memoria

    // ---------- ITokenRecuperacionRepository ----------
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

    // ---------- INegocioRepository ----------
    public Task<Negocio?> BuscarPorIdAsync(int id) =>
        Task.FromResult(_negocios.FirstOrDefault(n => n.Id == id));

    public Task<Negocio?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(_negocios.FirstOrDefault(n => n.UsuarioId == usuarioId));

    public Task<bool> ExisteDocumentoAsync(string documento) =>
        Task.FromResult(_usuarios.Any(u => u.Documento == documento));

    public Task<bool> ExisteTelefonoAsync(string telefono, int? excluirNegocioId = null) =>
        Task.FromResult(_negocios.Any(n => n.Telefono == telefono &&
            (excluirNegocioId == null || n.Id != excluirNegocioId)));

    public Task RegistrarAsync(Usuario usuario, Negocio negocio)
    {
        usuario.Id = _usuarios.Count == 0 ? 1 : _usuarios.Max(u => u.Id) + 1;
        _usuarios.Add(usuario);

        negocio.Id = _negocios.Count == 0 ? 1 : _negocios.Max(n => n.Id) + 1;
        negocio.UsuarioId = usuario.Id;
        negocio.Usuario = usuario;
        _negocios.Add(negocio);
        return Task.CompletedTask;
    }

    public Task ActualizarAsync(Negocio negocio) => Task.CompletedTask;

    // TODO: cuando existan Pedido y Repartidor, consultar sus listas aquí
    public Task<bool> TienePedidosActivosAsync(int negocioId) => Task.FromResult(false);

    public Task<bool> TieneRepartidoresVinculadosAsync(int negocioId) => Task.FromResult(false);

    // ---------- ICodigoVerificacionRepository ----------
    public Task AgregarAsync(CodigoVerificacion codigo)
    {
        codigo.Id = _codigos.Count + 1;
        _codigos.Add(codigo);
        return Task.CompletedTask;
    }

    public Task<CodigoVerificacion?> ObtenerUltimoAsync(int usuarioId) =>
        Task.FromResult(_codigos
            .Where(c => c.UsuarioId == usuarioId)
            .OrderByDescending(c => c.FechaCreacion)
            .ThenByDescending(c => c.Id)
            .FirstOrDefault());

    public Task ActualizarAsync(CodigoVerificacion codigo) => Task.CompletedTask;
}
