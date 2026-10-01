using System.Security.Cryptography;
using System.Text;
using Microsoft.AspNetCore.WebUtilities;

public static class TokenUtil
{
    public static string Generar() =>
        WebEncoders.Base64UrlEncode(RandomNumberGenerator.GetBytes(32));

    public static string Hash(string token) =>
        Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(token)));
}