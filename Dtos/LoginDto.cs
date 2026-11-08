using System.ComponentModel.DataAnnotations;

public class LoginDto
{
    public RolUsuario Rol { get; set; } = RolUsuario.Negocio;

    [Display(Name = "Correo o número de documento")]
    [Required(ErrorMessage = "Todos los campos son obligatorios")]
    public string Identificador { get; set; } = "";

    [Display(Name = "Contraseña")]
    [Required(ErrorMessage = "Todos los campos son obligatorios")]
    [DataType(DataType.Password)]
    public string Password { get; set; } = "";
}