using System.ComponentModel.DataAnnotations;

// CU-03: Formulario de registro de un pedido
public class RegistrarPedidoDto : IValidatableObject
{
    [Display(Name = "Nombre del cliente")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
    public string ClienteNombre { get; set; } = "";

    [Display(Name = "Teléfono del cliente")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(@"^\d{7,10}$", ErrorMessage = "Debe tener entre 7 y 10 dígitos")]
    public string ClienteTelefono { get; set; } = "";

    [Display(Name = "Dirección de entrega")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(200, ErrorMessage = "Máximo 200 caracteres")]
    public string DireccionEntrega { get; set; } = "";

    [Display(Name = "Método de pago")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    public MetodoPago? MetodoPago { get; set; }

    public List<ItemPedidoDto> Productos { get; set; } = [];

    public IEnumerable<ValidationResult> Validate(ValidationContext context)
    {
        // Regla: no puede registrarse si la lista de productos está vacía o si todos tienen la descripción vacía
        if (Productos is null || Productos.Count == 0 || Productos.All(p => string.IsNullOrWhiteSpace(p.Descripcion)))
        {
            yield return new ValidationResult("Debes completar todos los campos obligatorios del pedido", [nameof(Productos)]);
        }
    }
}

public class ItemPedidoDto
{
    [Display(Name = "Descripción")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
    public string Descripcion { get; set; } = "";

    [Display(Name = "Cantidad")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [Range(1, int.MaxValue, ErrorMessage = "La cantidad mínima es 1")]
    public int Cantidad { get; set; } = 1;

    [Display(Name = "Precio unitario")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [Range(0.01, double.MaxValue, ErrorMessage = "El precio unitario mínimo es 0.01")]
    public decimal PrecioUnitario { get; set; }
}

public class ClienteAutocompletarDto
{
    public string Nombre { get; set; } = "";
    public string Direccion { get; set; } = "";
}

