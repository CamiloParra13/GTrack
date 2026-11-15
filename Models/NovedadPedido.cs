namespace Gtrack;

// CU-16: novedad que reporta el repartidor sobre un pedido activo (tabla NovedadPedido).
// El pedido conserva su estado (PE-32-CU16); la novedad queda guardada con su fecha y hora.
public class NovedadPedido
{
    public int Id { get; set; }
    public int PedidoId { get; set; }
    public Pedido? Pedido { get; set; }
    public int TipoNovedadId { get; set; }
    public string? Observaciones { get; set; }
    public DateTime Fecha { get; set; } = DateTime.UtcNow;
}

// Valores del catálogo TipoNovedad de la base de datos
public enum TipoNovedad
{
    ClienteAusente,
    DireccionIncorrecta,
    ProductoNoDisponible,
    Otro
}
