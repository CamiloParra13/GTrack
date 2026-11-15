using System.ComponentModel.DataAnnotations;

namespace Gtrack;

public class RegistroNegocioDto
{
    public const string Obligatorio = "Campo obligatorio";

    [Display(Name = "Nombre del negocio")]
    [Required(ErrorMessage = Obligatorio)]
    [StringLength(100, MinimumLength = 2, ErrorMessage = "Debe tener entre 2 y 100 caracteres")]
    public string Nombre { get; set; } = "";

    [Display(Name = "Tipo de actividad económica")]
    [Required(ErrorMessage = Obligatorio)]
    public string TipoActividad { get; set; } = "";

    [Display(Name = "Número de documento (NIT/CC)")]
    [Required(ErrorMessage = Obligatorio)]
    [RegularExpression(ReglasValidacion.Documento, ErrorMessage = ReglasValidacion.DocumentoMensaje)]
    public string Documento { get; set; } = "";

    [Display(Name = "Correo electrónico corporativo")]
    [Required(ErrorMessage = Obligatorio)]
    [RegularExpression(ReglasValidacion.Correo, ErrorMessage = ReglasValidacion.CorreoMensaje)]
    [StringLength(150, ErrorMessage = "Máximo 150 caracteres")]
    public string Correo { get; set; } = "";

    [Display(Name = "Teléfono de contacto")]
    [Required(ErrorMessage = Obligatorio)]
    [RegularExpression(ReglasValidacion.Telefono, ErrorMessage = ReglasValidacion.TelefonoMensaje)]
    public string Telefono { get; set; } = "";

    [Display(Name = "Dirección legal/comercial")]
    [Required(ErrorMessage = Obligatorio)]
    [StringLength(200, MinimumLength = 5, ErrorMessage = "Debe tener entre 5 y 200 caracteres")]
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