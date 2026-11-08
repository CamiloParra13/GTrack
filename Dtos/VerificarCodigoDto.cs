using System.ComponentModel.DataAnnotations;

public class VerificarCodigoDto
{
    [Display(Name = "Código de verificación")]
    [Required(ErrorMessage = "Ingresa el código que recibiste")]
    [RegularExpression(@"^\d{6}$", ErrorMessage = "El código tiene 6 dígitos")]
    public string Codigo { get; set; } = "";
}
