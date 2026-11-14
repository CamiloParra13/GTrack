public enum RolUsuario { Negocio, Repartidor, Administrador }

// Los estados nuevos van al final para no cambiar los valores numéricos de los existentes.
// El número debe coincidir con dbo.EstadoCuenta (0 a 5).
// PendienteActivacion (5): repartidor registrado por un negocio que aún no crea su contraseña desde el correo.
public enum EstadoCuenta { PendienteValidacion, Activo, Suspendido, Rechazado, Eliminado, PendienteActivacion }

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
