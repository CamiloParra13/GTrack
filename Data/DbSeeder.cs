using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

// Perfiles de prueba. Solo se ejecuta en Development y solo si la tabla Usuario está vacía.
// Contraseña de TODOS los perfiles de prueba: Clave123  (se guarda hasheada con PasswordHasher).
public static class DbSeeder
{
    public static async Task SembrarAsync(AppDbContext db)
    {
        if (await db.Usuarios.AnyAsync()) return;

        var hasher = new PasswordHasher<Usuario>();

        Usuario Crear(string correo, string doc, RolUsuario rol, EstadoCuenta estado, string? motivo = null)
        {
            var u = new Usuario { Correo = correo, Documento = doc, Rol = rol, Estado = estado, MotivoRechazo = motivo };
            u.PasswordHash = hasher.HashPassword(u, "Clave123");
            return u;
        }

        // Administrador
        var admin = Crear("admin@gtrack.local", "1000000001", RolUsuario.Administrador, EstadoCuenta.Activo);
        db.Administradores.Add(new Administrador
        {
            Usuario = admin, NombreCompleto = "Administrador de Prueba", Telefono = "3000000001"
        });

        // Negocios: activo, pendiente de validación y rechazado
        var uNegocio = Crear("negocio@gtrack.local", "900000001", RolUsuario.Negocio, EstadoCuenta.Activo);
        var negocioActivo = new Negocio
        {
            Usuario = uNegocio, Nombre = "Logística y Alimentos Facatativá S.A.S.",
            TipoActividad = "Logística y distribución", Telefono = "3105551234",
            Direccion = "Carrera 24 #5-40, Centro, Facatativá, Cundinamarca"
        };
        db.Negocios.Add(negocioActivo);

        db.Negocios.Add(new Negocio
        {
            Usuario = Crear("pendiente@gtrack.local", "900000002", RolUsuario.Negocio, EstadoCuenta.PendienteValidacion),
            Nombre = "Pizzería Los Sauces", TipoActividad = "Restaurante y comidas",
            Telefono = "3115552345", Direccion = "Calle 10 #8-20, Facatativá, Cundinamarca"
        });
        db.Negocios.Add(new Negocio
        {
            Usuario = Crear("rechazado@gtrack.local", "900000003", RolUsuario.Negocio, EstadoCuenta.Rechazado, "Documento ilegible"),
            Nombre = "Floristería Aurora", TipoActividad = "Floristería",
            Telefono = "3125553456", Direccion = "Avenida 15 #12-30, Facatativá, Cundinamarca"
        });

        await db.SaveChangesAsync();   // aquí se generan los Id del negocio

        // Repartidores del negocio activo (uno activo en bicicleta, uno suspendido en moto)
        db.Repartidores.Add(new Repartidor
        {
            Usuario = Crear("repartidor@gtrack.local", "1000000002", RolUsuario.Repartidor, EstadoCuenta.Suspendido),
            NegocioId = negocioActivo.Id, NombreCompleto = "Repartidor Suspendido",
            Telefono = "3205550001", Vehiculo = TipoVehiculo.Moto, Placa = "ABC12D"
        });
        db.Repartidores.Add(new Repartidor
        {
            Usuario = Crear("repartidor2@gtrack.local", "1000000003", RolUsuario.Repartidor, EstadoCuenta.Activo),
            NegocioId = negocioActivo.Id, NombreCompleto = "Repartidor Activo",
            Telefono = "3205550002", Vehiculo = TipoVehiculo.Bicicleta
        });

        await db.SaveChangesAsync();
    }
}
