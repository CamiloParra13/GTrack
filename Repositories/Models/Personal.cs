public enum TipoVehiculo { Bicicleta, Moto, Carro, APie }

public class Repartidor
{
    public int Id { get; set; }
    public int UsuarioId { get; set; }
    public Usuario? Usuario { get; set; }
    public int NegocioId { get; set; }          // RN-2-CU09: vinculado al negocio que lo creó
    public string NombreCompleto { get; set; } = "";
    public string Telefono { get; set; } = "";
    public TipoVehiculo Vehiculo { get; set; }
    public string? Placa { get; set; }
    public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;
}

public class Administrador
{
    public int Id { get; set; }
    public int UsuarioId { get; set; }
    public Usuario? Usuario { get; set; }
    public string NombreCompleto { get; set; } = "";
    public string Telefono { get; set; } = "";
    public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;
}