using Microsoft.EntityFrameworkCore;

namespace Gtrack;

// CU-26 y validación de negocios, guardados en SQL Server
public class AdministracionRepository(AppDbContext db) : IAdministracionRepository
{
    public async Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador)
    {
        administrador.Usuario = usuario;
        db.Administradores.Add(administrador);
        await db.SaveChangesAsync();
    }

    public Task<List<AdministradorDto>> ListarAdministradoresAsync() =>
        (from u in db.Usuarios
         where u.Rol == RolUsuario.Administrador && u.Estado != EstadoCuenta.Eliminado
         join adm in db.Administradores on u.Id equals adm.UsuarioId into grupo
         from a in grupo.DefaultIfEmpty()
         orderby u.Id descending
         select new AdministradorDto
         {
             UsuarioId = u.Id,
             NombreCompleto = a != null ? a.NombreCompleto : "Administrador principal",
             Documento = u.Documento,
             Correo = u.Correo,
             Telefono = a != null ? a.Telefono : "—",
             Estado = u.Estado,
             FechaRegistro = a != null ? a.FechaRegistro : (DateTime?)null
         }).ToListAsync();

    public Task<List<NegocioAdminDto>> ListarNegociosAsync() =>
        db.Negocios
            .OrderByDescending(n => n.FechaRegistro)
            .Select(n => new NegocioAdminDto
            {
                Id = n.Id,
                Nombre = n.Nombre,
                TipoActividad = n.TipoActividad,
                Documento = n.Usuario!.Documento,
                Correo = n.Usuario.Correo,
                Telefono = n.Telefono,
                Estado = n.Usuario.Estado,
                FechaRegistro = n.FechaRegistro
            })
            .ToListAsync();

    public async Task<bool> AprobarNegocioAsync(int negocioId)
    {
        var negocio = await db.Negocios.Include(n => n.Usuario)
            .FirstOrDefaultAsync(n => n.Id == negocioId);
        var usuario = negocio?.Usuario;
        if (negocio is null || usuario is null || usuario.Estado != EstadoCuenta.PendienteValidacion)
            return false;

        usuario.Estado = EstadoCuenta.Activo;
        usuario.MotivoRechazo = null;
        db.Entry(negocio).Property("FechaValidacion").CurrentValue = DateTime.UtcNow;
        await db.SaveChangesAsync();
        return true;
    }

    public async Task<bool> TelefonoEnUsoAsync(string telefono) =>
        await db.Negocios.AnyAsync(n => n.Telefono == telefono) ||
        await db.Repartidores.AnyAsync(r => r.Telefono == telefono && r.Usuario!.Estado != EstadoCuenta.Eliminado) ||
        await db.Administradores.AnyAsync(a => a.Telefono == telefono);

    public Task<Administrador?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        db.Administradores
            .AsNoTracking()
            .FirstOrDefaultAsync(a => a.UsuarioId == usuarioId);
}
