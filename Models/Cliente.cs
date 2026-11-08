public class Cliente
{
    public int Id { get; set; }
    public string NombreCompleto { get; set; } = "";
    public string Telefono { get; set; } = "";
    public string? DireccionPredeterminada { get; set; }
    public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;
    public int NegocioId { get; set; }
    public Negocio? Negocio { get; set; }
}