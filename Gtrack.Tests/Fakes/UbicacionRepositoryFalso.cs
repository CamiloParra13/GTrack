namespace Gtrack.Tests;

public class UbicacionRepositoryFalso : IUbicacionRepository
{
    public Dictionary<int, UbicacionPedido> Ubicaciones { get; } = new();
    public bool DebeFallarAlGuardar { get; set; }

    public Task<UbicacionPedido?> ObtenerAsync(int pedidoId) =>
        Task.FromResult(Ubicaciones.GetValueOrDefault(pedidoId));

    public Task GuardarAsync(int pedidoId, decimal lat, decimal lng)
    {
        if (DebeFallarAlGuardar) throw new Exception("Fallo simulado al guardar");
        Ubicaciones[pedidoId] = new UbicacionPedido
        {
            PedidoId = pedidoId,
            Latitud = lat,
            Longitud = lng,
            FechaActualizacion = DateTime.UtcNow
        };
        return Task.CompletedTask;
    }
}