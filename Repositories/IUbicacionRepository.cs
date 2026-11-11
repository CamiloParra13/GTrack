public interface IUbicacionRepository
{
    Task<UbicacionPedido?> ObtenerAsync(int pedidoId);
    Task GuardarAsync(int pedidoId, decimal lat, decimal lng);
}

