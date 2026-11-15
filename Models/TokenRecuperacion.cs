namespace Gtrack;

public class TokenRecuperacion
{
    public int Id { get; set; }
    public int UsuarioId { get; set; }
    public string TokenHash { get; set; } = "";
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
    public DateTime Expira { get; set; }
    public bool Usado { get; set; }
}