using System.ComponentModel.DataAnnotations;

namespace Gtrack;

public class RecuperarDto
{
    [Display(Name = "Correo electrónico registrado")]
    [Required(ErrorMessage = "Ingresa tu correo electrónico")]
    [RegularExpression(ReglasValidacion.Correo, ErrorMessage = ReglasValidacion.CorreoMensaje)]
    public string Correo { get; set; } = "";
}