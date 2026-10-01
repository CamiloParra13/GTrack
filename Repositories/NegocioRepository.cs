using Microsoft.EntityFrameworkCore;

public class NegocioRepository(AppDbContext db) : INegocioRepository
{
    public Task<Negocio?> BuscarPorIdAsync(int id) =>
        db.Negocios.FirstOrDefaultAsync(n => n.Id == id);

    public Task<Negocio?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        db.Negocios.FirstOrDefaultAsync(n => n.UsuarioId == usuarioId);

    public Task<bool> ExisteDocumentoAsync(string documento) =>
        db.Usuarios.AnyAsync(u => u.Documento == documento);

    public Task<bool> ExisteTelefonoAsync(string telefono, int? excluirNegocioId = null) =>
        db.Negocios.AnyAsync(n => n.Telefono == telefono &&
            (excluirNegocioId == null || n.Id != excluirNegocioId));

    public async Task RegistrarAsync(Usuario usuario, Negocio negocio)
    {
        // Un solo SaveChanges: o se guardan los dos o ninguno
        negocio.Usuario = usuario;
        db.Negocios.Add(negocio);
        await db.SaveChangesAsync();
    }

    public async Task ActualizarAsync(Negocio negocio)
    {
        db.Negocios.Update(negocio);
        await db.SaveChangesAsync();
    }

    // TODO: consultar la tabla de pedidos cuando exista (estados distintos de Entregado/Cancelado)
    public Task<bool> TienePedidosActivosAsync(int negocioId) => Task.FromResult(false);

    // TODO: consultar la tabla de repartidores cuando exista
    public Task<bool> TieneRepartidoresVinculadosAsync(int negocioId) => Task.FromResult(false);
}
