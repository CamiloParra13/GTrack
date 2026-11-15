using System.ComponentModel.DataAnnotations;

// Campo: propiedad del formulario donde se muestra el error (null = mensaje general)
public record ResultadoRegistro(bool Ok, string? Error, bool CorreoEnviado, string? PasswordTemporal, string? Campo = null);

// CU-09
public class RegistroRepartidorDto : IValidatableObject
{
    [Display(Name = "Nombre completo")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Debe tener entre 2 y 100 caracteres")]
    [RegularExpression(ReglasValidacion.NombrePersona, ErrorMessage = ReglasValidacion.NombrePersonaMensaje)]
    public string NombreCompleto { get; set; } = "";

    [Display(Name = "Número de documento")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Documento, ErrorMessage = ReglasValidacion.DocumentoMensaje)]
    public string Documento { get; set; } = "";

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

    // La placa solo es obligatoria si el vehículo es Moto o Carro
    public IEnumerable<ValidationResult> Validate(ValidationContext context)
    {
        return ReglasValidacion.ValidarVehiculo(Vehiculo, Placa);
    }
}

// CU-26
public class RegistroAdministradorDto
{
    [Display(Name = "Nombre completo")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Debe tener entre 2 y 100 caracteres")]
    [RegularExpression(ReglasValidacion.NombrePersona, ErrorMessage = ReglasValidacion.NombrePersonaMensaje)]
    public string NombreCompleto { get; set; } = "";

    [Display(Name = "Número de documento")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Documento, ErrorMessage = ReglasValidacion.DocumentoMensaje)]
    public string Documento { get; set; } = "";

    [Display(Name = "Correo electrónico")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Correo, ErrorMessage = ReglasValidacion.CorreoMensaje)]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Teléfono")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Telefono, ErrorMessage = ReglasValidacion.TelefonoMensaje)]
    public string Telefono { get; set; } = "";
}

// Listados del panel de administrador
public class NegocioAdminDto
{
    public int Id { get; set; }
    public string Nombre { get; set; } = "";
    public string TipoActividad { get; set; } = "";
    public string Documento { get; set; } = "";
    public string Correo { get; set; } = "";
    public string Telefono { get; set; } = "";
    public EstadoCuenta Estado { get; set; }
    public DateTime FechaRegistro { get; set; }
}

public class AdministradorDto
{
    public int UsuarioId { get; set; }
    public string NombreCompleto { get; set; } = "";
    public string Documento { get; set; } = "";
    public string Correo { get; set; } = "";
    public string Telefono { get; set; } = "";
    public EstadoCuenta Estado { get; set; }
    public DateTime? FechaRegistro { get; set; }
}