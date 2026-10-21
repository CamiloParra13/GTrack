using Microsoft.EntityFrameworkCore;

public class NotificacionRepository(AppDbContext db) : INotificacionRepository
{
    public async Task AgregarAsync(IEnumerable<Notificacion> notificaciones)
    {
        db.Notificaciones.AddRange(notificaciones);
        await db.SaveChangesAsync();
    }

    public Task<List<Notificacion>> ListarAsync(int usuarioId, int maximo) =>
        db.Notificaciones
            .AsNoTracking()
            .Where(n => n.UsuarioId == usuarioId)
            .OrderByDescending(n => n.FechaCreacion)
            .ThenByDescending(n => n.Id)
            .Take(maximo)
            .ToListAsync();

    public Task<int> ContarNoLeidasAsync(int usuarioId) =>
        db.Notificaciones.CountAsync(n => n.UsuarioId == usuarioId && !n.Leida);

    public Task<Notificacion?> ObtenerAsync(int usuarioId, int id) =>
        db.Notificaciones.AsNoTracking()
            .FirstOrDefaultAsync(n => n.Id == id && n.UsuarioId == usuarioId);

    public async Task MarcarLeidaAsync(int usuarioId, int id)
    {
        var notificacion = await db.Notificaciones
            .FirstOrDefaultAsync(n => n.Id == id && n.UsuarioId == usuarioId);
        if (notificacion is null || notificacion.Leida) return;

        notificacion.Leida = true;
        await db.SaveChangesAsync();
    }

    public async Task MarcarTodasLeidasAsync(int usuarioId)
    {
        var pendientes = await db.Notificaciones
            .Where(n => n.UsuarioId == usuarioId && !n.Leida)
            .ToListAsync();
        if (pendientes.Count == 0) return;

        foreach (var notificacion in pendientes) notificacion.Leida = true;
        await db.SaveChangesAsync();
    }

    public Task<List<Usuario>> ListarAdministradoresActivosAsync() =>
        db.Usuarios
            .AsNoTracking()
            .Where(u => u.Rol == RolUsuario.Administrador && u.Estado == EstadoCuenta.Activo)
            .ToListAsync();
}
