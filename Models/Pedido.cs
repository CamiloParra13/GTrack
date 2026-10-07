namespace Gtrack.Models
{
    public enum EstadoPedido { Recibido, EnPreparacion, ListoParaEntrega, Asignado, EnCamino, Entregado, Cancelado }
    public enum MetodoPago { Efectivo, Transferencia, Tarjeta }

    // CU-03: pedido registrado por el negocio.
    public class Pedido
    {
        public int Id { get; set; }
        public string Codigo { get; set; } = "";     // RN-1-CU03: alfanumérico 8 caracteres en mayúsculas, único
        public int NegocioId { get; set; }
        public Negocio? Negocio { get; set; }
        public string ClienteNombre { get; set; } = "";
        public string ClienteTelefono { get; set; } = "";
        public string DireccionEntrega { get; set; } = "";
        public MetodoPago MetodoPago { get; set; }
        public EstadoPedido Estado { get; set; } = EstadoPedido.Recibido; // PE-6-CU03
        public decimal ValorTotal { get; set; }
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
}