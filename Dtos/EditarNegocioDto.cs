using System.ComponentModel.DataAnnotations;

// CU-13: el documento (NIT/CC) no se puede editar.
public class EditarNegocioDto
{
    [Display(Name = "Nombre comercial")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, ErrorMessage = "Máximo 100 caracteres")]
    public string Nombre { get; set; } = "";

    [Display(Name = "Categoría de actividad")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    public string TipoActividad { get; set; } = "";

    [Display(Name = "Correo electrónico")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [EmailAddress(ErrorMessage = "Correo no válido")]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Teléfono de contacto")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(@"^\d{7,10}$", ErrorMessage = "Debe tener entre 7 y 10 dígitos")]
    public string Telefono { get; set; } = "";

    [Display(Name = "Dirección")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(200, ErrorMessage = "Máximo 200 caracteres")]
    public string Direccion { get; set; } = "";
}
