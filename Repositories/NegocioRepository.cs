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

    // CU-11: pedidos que aún no terminaron (distintos de Entregado y Cancelado)
    public Task<bool> TienePedidosActivosAsync(int negocioId) =>
        db.Pedidos.AnyAsync(p => p.NegocioId == negocioId &&
            p.Estado != EstadoPedido.Entregado && p.Estado != EstadoPedido.Cancelado);

    // CU-11: repartidores del negocio cuya cuenta no está eliminada
    public Task<bool> TieneRepartidoresVinculadosAsync(int negocioId) =>
        db.Repartidores.AnyAsync(r => r.NegocioId == negocioId &&
            r.Usuario!.Estado != EstadoCuenta.Eliminado);
}
