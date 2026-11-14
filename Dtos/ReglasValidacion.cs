using System.ComponentModel.DataAnnotations;
using System.Text.RegularExpressions;

// Reglas de validación compartidas por todos los formularios.
// Se usan con [RegularExpression] para que se validen igual en el navegador (jQuery Validation) y en el servidor.
public static class ReglasValidacion
{
    // Teléfono móvil colombiano: exactamente 10 dígitos, sin espacios ni símbolos
    public const string Telefono = @"^\d{10}$";
    public const string TelefonoMensaje = "El teléfono debe tener exactamente 10 dígitos, sin espacios ni símbolos";

    // Documento (CC, NIT, CE): entre 6 y 10 dígitos, sin puntos ni guiones.
    // CC antiguas: 6-8 dígitos · CC actuales: 10 · NIT: 9 (10 con dígito de verificación)
    public const string Documento = @"^\d{6,10}$";
    public const string DocumentoMensaje = "El documento debe tener entre 6 y 10 dígitos, sin puntos ni guiones";

    // Correo: texto@dominio.extensión (extensión de al menos 2 letras). Rechaza "a@b", "a@b.", "a b@c.com", "a@@b.com"
    public const string Correo = @"^[A-Za-z0-9._%+\-]+@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$";
    public const string CorreoMensaje = "Ingresa un correo válido, por ejemplo nombre@dominio.com";

    // Nombres de personas: solo letras (con tildes y ñ), espacios, punto, apóstrofo y guion
    public const string NombrePersona = @"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ][A-Za-zÁÉÍÓÚÜÑáéíóúüñ .'\-]+$";
    public const string NombrePersonaMensaje = "Solo puede contener letras y espacios (mínimo 2 caracteres)";

    // Placas en Colombia (se comparan en mayúsculas y sin guion)
    //   Carro: 3 letras + 3 números   (ABC123)
    //   Moto:  3 letras + 2 números + 1 letra (ABC12D)
    public const string PlacaCarro = @"^[A-Z]{3}\d{3}$";
    public const string PlacaMoto = @"^[A-Z]{3}\d{2}[A-Z]$";
    public const string PlacaMensajeCarro = "Placa de carro no válida: 3 letras y 3 números (ej. ABC123)";
    public const string PlacaMensajeMoto = "Placa de moto no válida: 3 letras, 2 números y 1 letra (ej. ABC12D)";

    public static string NormalizarPlaca(string? placa) =>
        (placa ?? "").Trim().Replace("-", "").Replace(" ", "").ToUpperInvariant();

    // Reglas del vehículo: "A pie" ya no se acepta y la placa depende de si es carro o moto
    public static IEnumerable<ValidationResult> ValidarVehiculo(TipoVehiculo? vehiculo, string? placa)
    {
        if (vehiculo == TipoVehiculo.APie)
        {
            yield return new ValidationResult("Selecciona Bicicleta, Moto o Carro", ["Vehiculo"]);
            yield break;
        }

        if (vehiculo is not (TipoVehiculo.Moto or TipoVehiculo.Carro)) yield break;

        if (string.IsNullOrWhiteSpace(placa))
        {
            yield return new ValidationResult(RegistroNegocioDto.Obligatorio, ["Placa"]);
            yield break;
        }

        var esMoto = vehiculo == TipoVehiculo.Moto;
        if (!Regex.IsMatch(NormalizarPlaca(placa), esMoto ? PlacaMoto : PlacaCarro))
            yield return new ValidationResult(esMoto ? PlacaMensajeMoto : PlacaMensajeCarro, ["Placa"]);
    }
}
