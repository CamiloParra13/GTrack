// CU-17: solicitud de cancelación hecha por el cliente desde la consulta del pedido.
// Una sola por pedido (RN-1-CU17): la tabla tiene índice único en PedidoId.
public class SolicitudCancelacion
{
    public int Id { get; set; }
    public int PedidoId { get; set; }
    public Pedido? Pedido { get; set; }
    public string Motivo { get; set; } = "";
    public DateTime FechaSolicitud { get; set; } = DateTime.UtcNow;
}
