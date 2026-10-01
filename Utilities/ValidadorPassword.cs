public static class ValidadorPassword
{
    // RN-2-CU01 / RN-3-CU20: mínimo 6 caracteres, al menos un número y una letra
    public static bool EsValida(string? password) =>
        !string.IsNullOrEmpty(password)
        && password.Length >= 6
        && password.Any(char.IsDigit)
        && password.Any(char.IsLetter);
}