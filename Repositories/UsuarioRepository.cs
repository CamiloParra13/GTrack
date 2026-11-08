using Microsoft.EntityFrameworkCore;

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
}