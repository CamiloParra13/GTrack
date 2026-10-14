// CU-13: código de verificación de identidad para editar el perfil.
public class CodigoVerificacion
{
    public int Id { get; set; }
    public int UsuarioId { get; set; }
    public string CodigoHash { get; set; } = "";
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    public DateTime Expira { get; set; }
    public int Intentos { get; set; }
    public DateTime? BloqueadoHasta { get; set; }
    public bool Verificado { get; set; }
    public bool Usado { get; set; }
}
