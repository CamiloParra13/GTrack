using System.Security.Cryptography;

namespace Gtrack;

public static class GeneradorPassword
{
    private const string Letras = "ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz";
    private const string Digitos = "23456789";

    // Siempre cumple RN-2-CU01: mínimo 6 caracteres, con al menos una letra y un número
    public static string Temporal(int largo = 10)
    {
        var todos = Letras + Digitos;
        var chars = new List<char>
        {
            Letras[RandomNumberGenerator.GetInt32(Letras.Length)],
            Digitos[RandomNumberGenerator.GetInt32(Digitos.Length)]
        };
        while (chars.Count < largo)
            chars.Add(todos[RandomNumberGenerator.GetInt32(todos.Length)]);

        return new string(chars.OrderBy(_ => RandomNumberGenerator.GetInt32(int.MaxValue)).ToArray());
    }
}