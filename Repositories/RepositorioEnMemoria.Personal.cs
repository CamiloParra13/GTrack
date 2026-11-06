// Segunda parte de RepositorioEnMemoria (por eso la clase es "partial")
public partial class RepositorioEnMemoria : IRepartidorRepository, IAdministracionRepository
{
    private readonly List<Repartidor> _repartidores = [];
    private readonly List<Administrador> _administradores = [];

    // ---------- Compartido ----------
    public Task<bool> TelefonoEnUsoAsync(string telefono) =>
        Task.FromResult(
            _negocios.Any(n => n.Telefono == telefono) ||
            _repartidores.Any(r => r.Telefono == telefono) ||
            _administradores.Any(a => a.Telefono == telefono));

    // ---------- IRepartidorRepository (CU-09) ----------
    public Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor)
    {
        usuario.Id = _usuarios.Count == 0 ? 1 : _usuarios.Max(u => u.Id) + 1;
        _usuarios.Add(usuario);

        repartidor.Id = _repartidores.Count == 0 ? 1 : _repartidores.Max(r => r.Id) + 1;
        repartidor.UsuarioId = usuario.Id;
        repartidor.Usuario = usuario;
        _repartidores.Add(repartidor);
        return Task.CompletedTask;
    }

    public Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId) =>
        Task.FromResult(_repartidores
            .Where(r => r.NegocioId == negocioId && r.Usuario?.Estado != EstadoCuenta.Eliminado)
            .OrderByDescending(r => r.FechaRegistro)
            .ToList());

    // ---------- IAdministracionRepository (CU-26 y validación de negocios) ----------
    public Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador)
    {
        usuario.Id = _usuarios.Count == 0 ? 1 : _usuarios.Max(u => u.Id) + 1;
        _usuarios.Add(usuario);

        administrador.Id = _administradores.Count == 0 ? 1 : _administradores.Max(a => a.Id) + 1;
        administrador.UsuarioId = usuario.Id;
        administrador.Usuario = usuario;
        _administradores.Add(administrador);
        return Task.CompletedTask;
    }

    public Task<List<AdministradorDto>> ListarAdministradoresAsync()
    {
        var lista = _usuarios
            .Where(u => u.Rol == RolUsuario.Administrador && u.Estado != EstadoCuenta.Eliminado)
            .OrderByDescending(u => u.Id)
            .Select(u =>
            {
                var a = _administradores.FirstOrDefault(x => x.UsuarioId == u.Id);
                return new AdministradorDto
                {
                    NombreCompleto = a?.NombreCompleto ?? "Administrador principal",
                    Documento = u.Documento,
                    Correo = u.Correo,
                    Telefono = a?.Telefono ?? "—",
                    Estado = u.Estado,
                    FechaRegistro = a?.FechaRegistro
                };
            }).ToList();
        return Task.FromResult(lista);
    }

    public Task<List<NegocioAdminDto>> ListarNegociosAsync()
    {
        var lista = new List<NegocioAdminDto>();
        foreach (var n in _negocios.OrderByDescending(n => n.FechaRegistro))
        {
            var u = _usuarios.FirstOrDefault(x => x.Id == n.UsuarioId);
            if (u is null) continue;
            lista.Add(new NegocioAdminDto
            {
                Id = n.Id,
                Nombre = n.Nombre,
                TipoActividad = n.TipoActividad,
                Documento = u.Documento,
                Correo = u.Correo,
                Telefono = n.Telefono,
                Estado = u.Estado,
                FechaRegistro = n.FechaRegistro
            });
        }
        return Task.FromResult(lista);
    }

    public Task<bool> AprobarNegocioAsync(int negocioId)
    {
        var negocio = _negocios.FirstOrDefault(n => n.Id == negocioId);
        var usuario = negocio is null ? null : _usuarios.FirstOrDefault(u => u.Id == negocio.UsuarioId);
        if (usuario is null || usuario.Estado != EstadoCuenta.PendienteValidacion) return Task.FromResult(false);

        usuario.Estado = EstadoCuenta.Activo;
        usuario.MotivoRechazo = null;
        return Task.FromResult(true);
    }
}