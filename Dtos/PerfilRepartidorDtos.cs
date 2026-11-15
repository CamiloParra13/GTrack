using System.ComponentModel.DataAnnotations;

// CU-12 / CU-14: datos que el repartidor ve en "Mi perfil"
public class PerfilRepartidorDto
{
    public string NombreCompleto { get; set; } = "";
    public string Documento { get; set; } = "";
    public string Telefono { get; set; } = "";
    public string Correo { get; set; } = "";
    public TipoVehiculo Vehiculo { get; set; }
    public string? Placa { get; set; }
    public string Negocio { get; set; } = "";
    public DateTime FechaRegistro { get; set; }
    public EstadoCuenta Estado { get; set; }
    public int PedidosPendientes { get; set; }   // Asignados o En camino
}

// CU-14: el documento no se puede modificar (identifica al repartidor en el sistema)
public class EditarRepartidorDto : IValidatableObject
{
    [Display(Name = "Nombre completo")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Debe tener entre 2 y 100 caracteres")]
    [RegularExpression(ReglasValidacion.NombrePersona, ErrorMessage = ReglasValidacion.NombrePersonaMensaje)]
    public string NombreCompleto { get; set; } = "";

    [Display(Name = "Teléfono")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Telefono, ErrorMessage = ReglasValidacion.TelefonoMensaje)]
    public string Telefono { get; set; } = "";

    [Display(Name = "Correo electrónico")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Correo, ErrorMessage = ReglasValidacion.CorreoMensaje)]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Tipo de vehículo")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    public TipoVehiculo? Vehiculo { get; set; }

    [Display(Name = "Placa")]
    public string? Placa { get; set; }

    // Mismas reglas del registro (CU-09): la placa depende del vehículo (carro: ABC123, moto: ABC12D)
    public IEnumerable<ValidationResult> Validate(ValidationContext context)
    {
        return ReglasValidacion.ValidarVehiculo(Vehiculo, Placa);
    }
}
