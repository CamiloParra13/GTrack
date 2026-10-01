// CU-25 / RN-1-CU25: solo información pública (sin documento ni correo).
public class PerfilPublicoNegocioDto
{
    public string Nombre { get; set; } = "";
    public string TipoActividad { get; set; } = "";
    public string Direccion { get; set; } = "";
    public string Telefono { get; set; } = "";
    public DateTime FechaRegistro { get; set; }
}
