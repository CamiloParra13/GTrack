namespace Gtrack;

public class Pedido
{
    public int Id { get; set; }
    public string Codigo { get; set; } = "";
    public int NegocioId { get; set; }
    public Negocio? Negocio { get; set; }

    public int ClienteId { get; set; }
    public Cliente? Cliente { get; set; }

    public int? RepartidorId { get; set; }
    public Repartidor? Repartidor { get; set; }

    public string DireccionEntrega { get; set; } = "";

    // Columnas reales en la base de datos SQL Server
    public int MetodoPagoId { get; set; }
    public int EstadoPedidoId { get; set; } = 0;

    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    public List<ItemPedido> Items { get; set; } = [];
}

public class ItemPedido
{
    public int Id { get; set; }
    public int PedidoId { get; set; }
    public Pedido? Pedido { get; set; }
    public string Descripcion { get; set; } = "";
    public int Cantidad { get; set; }
    public decimal PrecioUnitario { get; set; }
}

public enum EstadoPedido
{
    Recibido,
    EnPreparacion,
    ListoParaEntrega,
    Asignado,
    EnCamino,
    Entregado,
    Cancelado
}