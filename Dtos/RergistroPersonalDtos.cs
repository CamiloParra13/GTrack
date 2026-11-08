using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

public record ResultadoRegistro(bool Ok, string? Error, bool CorreoEnviado, string? PasswordTemporal);

// CU-09
public class RegistroRepartidorDto : IValidatableObject
{
    [Display(Name = "Nombre completo")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
    public string NombreCompleto { get; set; } = "";

    [Display(Name = "Número de documento")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(@"^\d{6,12}$", ErrorMessage = "Debe tener entre 6 y 12 dígitos, sin puntos ni guiones")]
    public string Documento { get; set; } = "";

    [Display(Name = "Teléfono")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(@"^\d{7,10}$", ErrorMessage = "Debe tener entre 7 y 10 dígitos")]
    public string Telefono { get; set; } = "";

    [Display(Name = "Correo electrónico")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [EmailAddress(ErrorMessage = "Correo no válido")]
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
        if (Vehiculo is TipoVehiculo.Moto or TipoVehiculo.Carro)
        {
            if (string.IsNullOrWhiteSpace(Placa))
                yield return new ValidationResult(RegistroNegocioDto.Obligatorio, [nameof(Placa)]);
            else if (!Regex.IsMatch(Placa.Trim(), @"^[A-Za-z]{3}-?\d{2}[A-Za-z0-9]$"))
                yield return new ValidationResult("Placa no válida (ej. ABC123 o ABC12D)", [nameof(Placa)]);
        }
    }
}

// CU-26
public class RegistroAdministradorDto
{
    [Display(Name = "Nombre completo")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
    public string NombreCompleto { get; set; } = "";

    [Display(Name = "Número de documento")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(@"^\d{6,12}$", ErrorMessage = "Debe tener entre 6 y 12 dígitos, sin puntos ni guiones")]
    public string Documento { get; set; } = "";

    [Display(Name = "Correo electrónico")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [EmailAddress(ErrorMessage = "Correo no válido")]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Teléfono")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(@"^\d{7,10}$", ErrorMessage = "Debe tener entre 7 y 10 dígitos")]
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
    public string NombreCompleto { get; set; } = "";
    public string Documento { get; set; } = "";
    public string Correo { get; set; } = "";
    public string Telefono { get; set; } = "";
    public EstadoCuenta Estado { get; set; }
    public DateTime? FechaRegistro { get; set; }
}