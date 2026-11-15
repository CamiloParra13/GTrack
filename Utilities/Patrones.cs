using System.Text.RegularExpressions;

namespace Gtrack;

// Expresiones regulares de la aplicación, generadas en tiempo de compilación ([GeneratedRegex])
// y con un tiempo límite de ejecución para evitar ataques de denegación de servicio (ReDoS).
public static partial class Patrones
{
    private const int TiempoLimiteMs = 100;

    // Código de pedido de 8 caracteres en mayúsculas (CU-05 y CU-17)
    [GeneratedRegex("^[A-Z0-9]{8}$", RegexOptions.None, TiempoLimiteMs)]
    public static partial Regex CodigoPedido();

    // Código de pedido de 8 caracteres, en mayúsculas o minúsculas
    [GeneratedRegex("^[A-Za-z0-9]{8}$", RegexOptions.None, TiempoLimiteMs)]
    public static partial Regex CodigoPedidoSinDistinguirMayusculas();

    // Placas de vehículos (CU-09 y CU-14)
    [GeneratedRegex(ReglasValidacion.PlacaMoto, RegexOptions.None, TiempoLimiteMs)]
    public static partial Regex PlacaMoto();

    [GeneratedRegex(ReglasValidacion.PlacaCarro, RegexOptions.None, TiempoLimiteMs)]
    public static partial Regex PlacaCarro();

    // Texto entre ** ** que se muestra en negrita en los correos
    [GeneratedRegex(@"\*\*(.+?)\*\*", RegexOptions.None, TiempoLimiteMs)]
    public static partial Regex Negrita();
}
