using System.ComponentModel.DataAnnotations;

namespace Gtrack;

public class RegistrarPedidoDto
{
    [Display(Name = "Nombre del cliente")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Debe tener entre 2 y 100 caracteres")]
    [RegularExpression(ReglasValidacion.NombrePersona, ErrorMessage = ReglasValidacion.NombrePersonaMensaje)]
    public string ClienteNombre { get; set; } = "";

    [Display(Name = "Teléfono del cliente")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Telefono, ErrorMessage = ReglasValidacion.TelefonoMensaje)]
    public string ClienteTelefono { get; set; } = "";

    [Display(Name = "Dirección de entrega")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(200, MinimumLength = 5, ErrorMessage = "Debe tener entre 5 y 200 caracteres")]
    public string DireccionEntrega { get; set; } = "";

    [Display(Name = "Método de pago")]
    [Required(ErrorMessage = "Selecciona un método de pago")]
    public MetodoPago? MetodoPago { get; set; }

    [MinLength(1, ErrorMessage = "Agrega al menos un producto")]
    public List<ItemPedidoDto> Productos { get; set; } = [];
}

public class ItemPedidoDto
{
    [Display(Name = "Descripción")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Descripcion { get; set; } = "";

    [Range(1, 1000, ErrorMessage = "La cantidad debe ser un número entero entre 1 y 1000")]
    public int Cantidad { get; set; } = 1;

    [Range(0.01, 100000000, ErrorMessage = "El precio debe ser mayor a 0")]
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