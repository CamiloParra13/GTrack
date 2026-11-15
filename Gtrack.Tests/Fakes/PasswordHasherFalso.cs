using Microsoft.AspNetCore.Identity;

namespace Gtrack.Tests;

public class PasswordHasherFalso : IPasswordHasher<Usuario>
{
    public string HashPassword(Usuario user, string password) => $"HASH:{password}";

    public PasswordVerificationResult VerifyHashedPassword(Usuario user, string hashedPassword, string providedPassword) =>
        hashedPassword == $"HASH:{providedPassword}"
            ? PasswordVerificationResult.Success
            : PasswordVerificationResult.Failed;
}