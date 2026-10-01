public enum RolUsuario { Negocio, Repartidor, Administrador }

public enum EstadoCuenta { PendienteValidacion, Activo, Suspendido, Rechazado }

public class Usuario
{
    public int Id { get; set; }
    public string Correo { get; set; } = "";
    public string Documento { get; set; } = "";
    public string PasswordHash { get; set; } = "";
    public RolUsuario Rol { get; set; }
    public EstadoCuenta Estado { get; set; } = EstadoCuenta.PendienteValidacion;
    public string? MotivoRechazo { get; set; }
    public int IntentosFallidos { get; set; }
    public DateTime? BloqueadoHasta { get; set; }
}