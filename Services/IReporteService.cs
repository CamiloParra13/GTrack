namespace Gtrack;

public interface IReporteService
{
    // CU-24: reporte de pedidos del negocio (agrupado por estado y por mes)
    Task<ReporteNegocioDto?> GenerarReporteNegocioAsync(int usuarioNegocioId, DateTime desde, DateTime hasta);

    // CU-22: pedidos finalizados (Entregado / Cancelado) para exportar el historial
    Task<HistorialExportDto?> ObtenerHistorialAsync(int usuarioNegocioId, DateTime desde, DateTime hasta);

    // Reporte del administrador: negocios que ingresaron a la plataforma y actividad de pedidos
    Task<ReporteAdminDto> GenerarReporteAdminAsync(DateTime desde, DateTime hasta);
}

public static class RangoReporte
{
    public const string MensajeInvalido = "El rango de fechas no es válido, verifica e intenta nuevamente";

    // RN-3-CU24 / RN-2-CU22: el rango máximo es de 12 meses
    public static string? Validar(DateTime? desde, DateTime? hasta)
    {
        if (desde is null || hasta is null) return MensajeInvalido;

        var d = desde.Value.Date;
        var h = hasta.Value.Date;

        if (d > h) return MensajeInvalido;
        if (h >= d.AddMonths(12)) return MensajeInvalido;
        return null;
    }
}
