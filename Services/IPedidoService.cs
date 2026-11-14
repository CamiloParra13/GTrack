public interface IPedidoService
{
    Task<ClienteAutocompletarDto?> BuscarClienteFrecuenteAsync(int usuarioNegocioId, string telefono);
    Task<(bool Ok, string? Error, string? Codigo)> RegistrarAsync(int usuarioNegocioId, RegistrarPedidoDto dto);
    Task<(bool Ok, string? Error)> ActualizarEstadoAsync(int usuarioId, int pedidoId, int nuevoEstadoId, int? repartidorId = null);
    Task<List<Pedido>> ObtenerPedidosActivosAsync(int usuarioNegocioId);
    Task<List<Pedido>> ObtenerHistorialPedidosAsync(int usuarioNegocioId);

    // CU-17: el cliente cancela su pedido con el código único (sin iniciar sesión)
    Task<(bool Ok, string? Error)> CancelarPorClienteAsync(string? codigo, string? motivo);
}