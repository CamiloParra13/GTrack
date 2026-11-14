# GTrack

## Seguridad de contraseñas (RNF-01)

Las contraseñas se guardan cifradas con **bcrypt** (paquete NuGet `BCrypt.Net-Next`, factor de trabajo 12), implementado en `Utilities/BCryptPasswordHasher.cs` y registrado en `Program.cs`. Las cuentas que ya tenían el hash anterior (PBKDF2 de ASP.NET Identity) siguen funcionando y se vuelven a guardar con bcrypt automáticamente en su siguiente inicio de sesión correcto.
