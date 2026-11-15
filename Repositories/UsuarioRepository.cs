using Microsoft.EntityFrameworkCore;

namespace Gtrack;

public class UsuarioRepository(AppDbContext db) : IUsuarioRepository
{
    public Task<Usuario?> ObtenerPorIdentificadorYRolAsync(string identificador, RolUsuario rol) =>
        db.Usuarios.FirstOrDefaultAsync(u =>
            u.Rol == rol && (u.Correo == identificador || u.Documento == identificador));

    public Task<Usuario?> ObtenerPorCorreoAsync(string correo) =>
        db.Usuarios.FirstOrDefaultAsync(u => u.Correo == correo);

    public Task<Usuario?> ObtenerPorIdAsync(int id) =>
        db.Usuarios.FirstOrDefaultAsync(u => u.Id == id);

    public async Task ActualizarAsync(Usuario usuario)
    {
        db.Usuarios.Update(usuario);
        await db.SaveChangesAsync();
    }

    public Task<List<string>> CorreosAdministradoresActivosAsync() =>
        db.Usuarios
            .AsNoTracking()
            .Where(u => u.Rol == RolUsuario.Administrador && u.Estado == EstadoCuenta.Activo)
            .Select(u => u.Correo)
            .ToListAsync();

    public async Task LiberarEliminadosAsync(string correo, string documento)
    {
        var eliminados = await db.Usuarios
            .Where(u => u.Estado == EstadoCuenta.Eliminado && (u.Correo == correo || u.Documento == documento))
            .ToListAsync();
        if (eliminados.Count == 0) return;

        foreach (var u in eliminados) u.LiberarIdentificadores();
        await db.SaveChangesAsync();
    }
}
