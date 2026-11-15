namespace Gtrack;

// Datos que muestra la pantalla "Mi Perfil" (CU-11 / CU-13).
public class PerfilNegocioDto
{
    public int Id { get; set; }
    public string Nombre { get; set; } = "";
    public string TipoActividad { get; set; } = "";
    public string Documento { get; set; } = "";
    public string Correo { get; set; } = "";
    public string Telefono { get; set; } = "";
    public string Direccion { get; set; } = "";
    public DateTime FechaRegistro { get; set; }
    public EstadoCuenta Estado { get; set; }
}