namespace Gtrack;

// Datos del negocio. Correo y Documento (NIT/CC) viven en Usuario (cuenta de acceso);
// aquí va la información del perfil del negocio.
public class Negocio
{
    public int Id { get; set; }
    public int UsuarioId { get; set; }
    public Usuario? Usuario { get; set; }
    public string Nombre { get; set; } = "";
    public string TipoActividad { get; set; } = "";
    public string Telefono { get; set; } = "";
    public string Direccion { get; set; } = "";
    public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;
}
