using Microsoft.AspNetCore.Identity;

// RNF-01 Seguridad: las contraseñas se guardan con bcrypt (nunca en texto plano).
//
// bcrypt genera una sal aleatoria por cada contraseña y la incluye en el resultado, por lo que dos
// usuarios con la misma contraseña quedan con valores distintos. El "factor de trabajo" hace que cada
// cálculo sea deliberadamente lento (2^12 rondas), lo que vuelve impráctico un ataque de fuerza bruta
// si alguien llegara a robar la tabla Usuario.
//
// Formato guardado en Usuario.ContrasenaHash (60 caracteres):  $2a$12$<sal de 22 car.><hash de 31 car.>
//
// Migración: las cuentas creadas antes de este cambio tienen el hash anterior (PBKDF2 de ASP.NET Identity).
// Esas contraseñas se siguen aceptando, y en el siguiente inicio de sesión correcto se vuelven a guardar con
// bcrypt automáticamente (AuthService). Así nadie tiene que restablecer su contraseña.
public class BCryptPasswordHasher : IPasswordHasher<Usuario>
{
    // 12 es el valor recomendado hoy (~250 ms por verificación). Subirlo hace que las cuentas se
    // actualicen solas al nuevo factor en su próximo inicio de sesión.
    public const int FactorTrabajo = 12;

    private readonly PasswordHasher<Usuario> hasherAnterior = new();

    public string HashPassword(Usuario usuario, string password) =>
        BCrypt.Net.BCrypt.HashPassword(password, FactorTrabajo);

    public PasswordVerificationResult VerifyHashedPassword(Usuario usuario, string hashedPassword, string providedPassword)
    {
        if (string.IsNullOrEmpty(hashedPassword) || string.IsNullOrEmpty(providedPassword))
            return PasswordVerificationResult.Failed;

        if (EsHashBCrypt(hashedPassword))
        {
            try
            {
                if (!BCrypt.Net.BCrypt.Verify(providedPassword, hashedPassword))
                    return PasswordVerificationResult.Failed;

                return BCrypt.Net.BCrypt.PasswordNeedsRehash(hashedPassword, FactorTrabajo)
                    ? PasswordVerificationResult.SuccessRehashNeeded
                    : PasswordVerificationResult.Success;
            }
            catch (BCrypt.Net.SaltParseException)
            {
                return PasswordVerificationResult.Failed;
            }
        }

        // Hash anterior (PBKDF2 de ASP.NET Identity): si coincide, se pide volver a guardarlo con bcrypt
        try
        {
            return hasherAnterior.VerifyHashedPassword(usuario, hashedPassword, providedPassword)
                   == PasswordVerificationResult.Failed
                ? PasswordVerificationResult.Failed
                : PasswordVerificationResult.SuccessRehashNeeded;
        }
        catch (FormatException)
        {
            // Valor que no es un hash válido (por ejemplo, una cuenta creada a mano por SQL)
            return PasswordVerificationResult.Failed;
        }
    }

    private static bool EsHashBCrypt(string hash) =>
        hash.Length == 60 && (hash.StartsWith("$2a$") || hash.StartsWith("$2b$") || hash.StartsWith("$2y$"));
}
