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

    // RN-1-CU11: pedidos en curso = cualquier estado distinto de Entregado o Cancelado
    public Task<bool> TienePedidosActivosAsync(int negocioId) =>
        db.Pedidos.AnyAsync(p => p.NegocioId == negocioId &&
            p.Estado != EstadoPedido.Entregado && p.Estado != EstadoPedido.Cancelado);

    // FE-26-CU11: repartidores vinculados que no estén dados de baja
    public Task<bool> TieneRepartidoresVinculadosAsync(int negocioId) =>
        db.Repartidores.AnyAsync(r => r.NegocioId == negocioId &&
            r.Usuario!.Estado != EstadoCuenta.Eliminado);
}