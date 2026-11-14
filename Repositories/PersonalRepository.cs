using Microsoft.EntityFrameworkCore;

// Repartidores (CU-09) y administradores (CU-26 / validación de negocios) con EF Core.
// TelefonoEnUsoAsync está en las dos interfaces: un solo método cumple ambas.
public class PersonalRepository(AppDbContext db) : IRepartidorRepository, IAdministracionRepository
{
    // ---------- Compartido ----------
    public async Task<bool> TelefonoEnUsoAsync(string telefono) =>
        await db.Negocios.AnyAsync(n => n.Telefono == telefono) ||
        await db.Repartidores.AnyAsync(r => r.Telefono == telefono) ||
        await db.Administradores.AnyAsync(a => a.Telefono == telefono);

    // ---------- IRepartidorRepository ----------
    public async Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor)
    {
        repartidor.Usuario = usuario;    // un solo SaveChanges: se guardan los dos o ninguno
        db.Repartidores.Add(repartidor);
        await db.SaveChangesAsync();
    }

    public Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId) =>
        db.Repartidores
            .AsNoTracking()
            .Include(r => r.Usuario)
            .Where(r => r.NegocioId == negocioId && r.Usuario!.Estado != EstadoCuenta.Eliminado)
            .OrderByDescending(r => r.FechaRegistro)
            .ToListAsync();

    // ---------- IAdministracionRepository ----------
    public async Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador)
    {
        administrador.Usuario = usuario;
        db.Administradores.Add(administrador);
        await db.SaveChangesAsync();
    }

    public Task<List<AdministradorDto>> ListarAdministradoresAsync() =>
        (from u in db.Usuarios.AsNoTracking()
         where u.Rol == RolUsuario.Administrador && u.Estado != EstadoCuenta.Eliminado
         join adm in db.Administradores.AsNoTracking() on u.Id equals adm.UsuarioId into grupo
         from a in grupo.DefaultIfEmpty()
         orderby u.Id descending
         select new AdministradorDto
         {
             NombreCompleto = a != null ? a.NombreCompleto : "Administrador principal",
             Documento = u.Documento,
             Correo = u.Correo,
             Telefono = a != null ? a.Telefono : "—",
             Estado = u.Estado,
             FechaRegistro = a != null ? a.FechaRegistro : (DateTime?)null
         }).ToListAsync();

    public Task<List<NegocioAdminDto>> ListarNegociosAsync() =>
        (from n in db.Negocios.AsNoTracking()
         join u in db.Usuarios.AsNoTracking() on n.UsuarioId equals u.Id
         orderby n.FechaRegistro descending
         select new NegocioAdminDto
         {
             Id = n.Id,
             Nombre = n.Nombre,
             TipoActividad = n.TipoActividad,
             Documento = u.Documento,
             Correo = u.Correo,
             Telefono = n.Telefono,
             Estado = u.Estado,
             FechaRegistro = n.FechaRegistro
         }).ToListAsync();

    public async Task<bool> AprobarNegocioAsync(int negocioId)
    {
        var negocio = await db.Negocios.FirstOrDefaultAsync(n => n.Id == negocioId);
        if (negocio is null) return false;

        var usuario = await db.Usuarios.FirstOrDefaultAsync(u => u.Id == negocio.UsuarioId);
        if (usuario is null || usuario.Estado != EstadoCuenta.PendienteValidacion) return false;

        usuario.Estado = EstadoCuenta.Activo;
        usuario.MotivoRechazo = null;
        await db.SaveChangesAsync();
        return true;
    }
}
