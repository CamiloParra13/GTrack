namespace Gtrack;

public interface INegocioRepository
{
    Task<Negocio?> BuscarPorIdAsync(int id);
    Task<Negocio?> ObtenerPorUsuarioIdAsync(int usuarioId);
    Task<bool> ExisteDocumentoAsync(string documento);
    Task<bool> ExisteTelefonoAsync(string telefono, int? excluirNegocioId = null);

    // Crea la cuenta (Usuario) y el negocio juntos (cascada de registro, CU-01)
    Task RegistrarAsync(Usuario usuario, Negocio negocio);
    Task ActualizarAsync(Negocio negocio);

    // Precondiciones de CU-11. Devuelven false hasta que existan Pedido y Repartidor.
    Task<bool> TienePedidosActivosAsync(int negocioId);
    Task<bool> TieneRepartidoresVinculadosAsync(int negocioId);
}
