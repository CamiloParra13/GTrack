using System.ComponentModel.DataAnnotations;

public class RegistroNegocioDto
{
    public const string Obligatorio = "Campo obligatorio";

    [Display(Name = "Nombre del negocio")]
    [Required(ErrorMessage = Obligatorio)]
    [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
    public string Nombre { get; set; } = "";

    [Display(Name = "Tipo de actividad económica")]
    [Required(ErrorMessage = Obligatorio)]
    public string TipoActividad { get; set; } = "";

    [Display(Name = "Número de documento (NIT/CC)")]
    [Required(ErrorMessage = Obligatorio)]
    [RegularExpression(@"^\d{6,12}$", ErrorMessage = "Debe tener entre 6 y 12 dígitos, sin puntos ni guiones")]
    public string Documento { get; set; } = "";

    [Display(Name = "Correo electrónico corporativo")]
    [Required(ErrorMessage = Obligatorio)]
    [EmailAddress(ErrorMessage = "Correo no válido")]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Teléfono de contacto")]
    [Required(ErrorMessage = Obligatorio)]
    [RegularExpression(@"^\d{7,10}$", ErrorMessage = "Debe tener entre 7 y 10 dígitos")]
    public string Telefono { get; set; } = "";

    [Display(Name = "Dirección legal/comercial")]
    [Required(ErrorMessage = Obligatorio)]
    [StringLength(200, ErrorMessage = "Máximo 200 caracteres")]
    public string Direccion { get; set; } = "";

    [Display(Name = "Contraseña")]
    [Required(ErrorMessage = Obligatorio)]
    [DataType(DataType.Password)]
    public string Password { get; set; } = "";

    [Display(Name = "Confirmar contraseña")]
    [Required(ErrorMessage = Obligatorio)]
    [DataType(DataType.Password)]
    public string ConfirmarPassword { get; set; } = "";
}
