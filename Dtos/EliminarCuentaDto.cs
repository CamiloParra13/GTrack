using System.ComponentModel.DataAnnotations;

namespace Gtrack;

public class EliminarCuentaDto
{
    [Display(Name = "Contraseña")]
    [Required(ErrorMessage = "Ingresa tu contraseña")]
    [DataType(DataType.Password)]
    public string Password { get; set; } = "";
}
