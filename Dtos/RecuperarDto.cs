using System.ComponentModel.DataAnnotations;

public class RecuperarDto
{
    [Display(Name = "Correo electrónico registrado")]
    [Required(ErrorMessage = "Ingresa tu correo electrónico")]
    [EmailAddress(ErrorMessage = "Correo no válido")]
    public string Correo { get; set; } = "";
}