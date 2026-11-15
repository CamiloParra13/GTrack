namespace Gtrack;

public class UbicacionPedido
{
    public int PedidoId { get; set; }
    public Pedido? Pedido { get; set; }
    public decimal Latitud { get; set; }
    public decimal Longitud { get; set; }
    public DateTime FechaActualizacion { get; set; } = DateTime.UtcNow;
}

