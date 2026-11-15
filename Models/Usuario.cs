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

    // Baja lógica: la fila se conserva (historial de pedidos), pero el correo y el documento
    // tienen índice único. Se les agrega un prefijo con el Id para "liberarlos" y que se puedan
    // volver a usar en un registro nuevo. El prefijo con el Id garantiza que sigan siendo únicos.
    public void LiberarIdentificadores()
    {
        Correo = Recortar($"eliminado.{Id}.{Correo}", 150);
        Documento = Recortar($"X{Id}-{Documento}", 20);
    }

    private static string Recortar(string valor, int max) => valor.Length <= max ? valor : valor[..max];
}
