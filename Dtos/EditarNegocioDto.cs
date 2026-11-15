using System.ComponentModel.DataAnnotations;

namespace Gtrack;

// CU-13: el documento (NIT/CC) no se puede editar.
public class EditarNegocioDto
{
    [Display(Name = "Nombre comercial")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Debe tener entre 2 y 100 caracteres")]
    public string Nombre { get; set; } = "";

    [Display(Name = "Categoría de actividad")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    public string TipoActividad { get; set; } = "";

    [Display(Name = "Correo electrónico")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Correo, ErrorMessage = ReglasValidacion.CorreoMensaje)]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Teléfono de contacto")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [RegularExpression(ReglasValidacion.Telefono, ErrorMessage = ReglasValidacion.TelefonoMensaje)]
    public string Telefono { get; set; } = "";

    [Display(Name = "Dirección")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [StringLength(200, MinimumLength = 5, ErrorMessage = "Debe tener entre 5 y 200 caracteres")]
    public string Direccion { get; set; } = "";
}