public class Notificacion
{
    public int Id { get; set; }
    public int UsuarioId { get; set; }
    public int? PedidoId { get; set; }
    public string Titulo { get; set; } = "";
    public string Mensaje { get; set; } = "";
    public string? Enlace { get; set; }
    public bool Leida { get; set; }
    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;
}
