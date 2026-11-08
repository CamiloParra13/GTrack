using System.ComponentModel.DataAnnotations;

public class RegistrarPedidoDto
{
    public string ClienteNombre { get; set; } = "";
    public string ClienteTelefono { get; set; } = "";
    public string DireccionEntrega { get; set; } = "";
    public MetodoPago? MetodoPago { get; set; }
    public List<ItemPedidoDto> Productos { get; set; } = [];
}

public class ItemPedidoDto
{
    public string Descripcion { get; set; } = "";
    public int Cantidad { get; set; } = 1;
    public decimal PrecioUnitario { get; set; }
}

public class ClienteAutocompletarDto
{
    public string Nombre { get; set; } = "";
    public string Direccion { get; set; } = "";
}

public enum MetodoPago
{
    Efectivo,
    Transferencia,
    Tarjeta
}