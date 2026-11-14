using System.ComponentModel.DataAnnotations;

// CU-09: el repartidor crea su contraseña desde el enlace que recibió por correo
public class ActivarCuentaDto
{
    public string Token { get; set; } = "";

    [Display(Name = "Contraseña")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [DataType(DataType.Password)]
    public string NuevaPassword { get; set; } = "";

    [Display(Name = "Confirmar contraseña")]
    [Required(ErrorMessage = RegistroNegocioDto.Obligatorio)]
    [DataType(DataType.Password)]
    [Compare(nameof(NuevaPassword), ErrorMessage = "Las contraseñas no coinciden")]
    public string ConfirmarPassword { get; set; } = "";

    // Solo para mostrar en la página (no se envían en el formulario)
    public RolUsuario Rol { get; set; } = RolUsuario.Repartidor;
    public string Nombre { get; set; } = "";
    public string Correo { get; set; } = "";
    public string Negocio { get; set; } = "";
}
