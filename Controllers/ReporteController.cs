using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace Gtrack.Controllers
{

    // CU-24 Generar reporte de pedidos y CU-22 Exportar historial (rol Negocio)
    [Authorize(Roles = "Negocio")]
    public class ReporteController(
        IReporteService reportes,
        IExportadorReportes exportador,
        ILogger<ReporteController> logger) : Controller
    {
        private const string MimeExcel = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        private const string MimePdf = "application/pdf";
        private const string MimeCsv = "text/csv";
        private const string SinPedidos = "No hay pedidos registrados en este rango para generar el reporte";

        private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

        private static string Dia(DateTime? d) => d!.Value.ToString("yyyy-MM-dd");

        // ---------- CU-24: pantalla de reportes ----------
        [HttpGet]
        public async Task<IActionResult> Index(DateTime? desde, DateTime? hasta)
        {
            var hoy = DateTime.Today;
            var vista = new ReporteNegocioVista
            {
                Desde = desde?.Date ?? new DateTime(hoy.Year, hoy.Month, 1),
                Hasta = hasta?.Date ?? hoy
            };

            // Paso 2: primera visita, solo se muestra el formulario
            if (desde is null && hasta is null) return View(vista);

            // FE-60-CU24: rango de fechas inválido
            vista.Error = RangoReporte.Validar(desde, hasta);
            if (vista.Error is not null) return View(vista);

            try
            {
                var reporte = await reportes.GenerarReporteNegocioAsync(UsuarioId, desde!.Value, hasta!.Value);
                if (reporte is null)
                    vista.Error = "No fue posible identificar tu negocio";
                else if (reporte.TotalPedidos == 0)
                    vista.Aviso = SinPedidos;           // FA-25-CU24: no se muestra gráfica ni tabla
                else
                    vista.Reporte = reporte;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error al generar el reporte de pedidos del usuario {UsuarioId}", UsuarioId);
                vista.Error = "No fue posible generar el reporte. Intenta nuevamente";
            }

            return View(vista);
        }

        // Descarga del mismo reporte en Excel o PDF
        [HttpGet]
        public async Task<IActionResult> Descargar(DateTime? desde, DateTime? hasta, string formato = "excel")
        {
            var error = RangoReporte.Validar(desde, hasta);
            if (error is not null)
            {
                TempData["Error"] = error;
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var reporte = await reportes.GenerarReporteNegocioAsync(UsuarioId, desde!.Value, hasta!.Value);
                if (reporte is null || reporte.TotalPedidos == 0)
                {
                    TempData["Error"] = SinPedidos;
                    return RedirectToAction(nameof(Index), new { desde = Dia(desde), hasta = Dia(hasta) });
                }

                var nombre = $"Reporte_Pedidos_{desde.Value:yyyyMMdd}_{hasta.Value:yyyyMMdd}";
                return formato.Equals("pdf", StringComparison.OrdinalIgnoreCase)
                    ? File(exportador.ReporteNegocioPdf(reporte), MimePdf, nombre + ".pdf")
                    : File(exportador.ReporteNegocioExcel(reporte), MimeExcel, nombre + ".xlsx");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error al exportar el reporte de pedidos del usuario {UsuarioId}", UsuarioId);
                TempData["Error"] = "No fue posible generar el archivo. Intenta nuevamente";
                return RedirectToAction(nameof(Index), new { desde = Dia(desde), hasta = Dia(hasta) });
            }
        }

        // ---------- CU-22: exportar historial de pedidos (desde "Historial de Pedidos") ----------
        [HttpGet]
        public async Task<IActionResult> ExportarHistorial(DateTime? desde, DateTime? hasta, string formato = "excel")
        {
            // FE-55-CU22: rango inválido
            var error = RangoReporte.Validar(desde, hasta);
            if (error is not null)
            {
                TempData["Error"] = error;
                return RedirectToAction("Historial", "Pedido");
            }

            try
            {
                var historial = await reportes.ObtenerHistorialAsync(UsuarioId, desde!.Value, hasta!.Value);

                // FA-23-CU22: rango sin pedidos finalizados
                if (historial is null || historial.Filas.Count == 0)
                {
                    TempData["Error"] = "No hay pedidos finalizados en el rango seleccionado";
                    return RedirectToAction("Historial", "Pedido");
                }

                var nombre = $"Historial_Pedidos_{desde.Value:yyyyMMdd}_{hasta.Value:yyyyMMdd}";
                return formato.ToLowerInvariant() switch
                {
                    "pdf" => File(exportador.HistorialPdf(historial), MimePdf, nombre + ".pdf"),
                    "csv" => File(exportador.HistorialCsv(historial), MimeCsv, nombre + ".csv"),
                    _ => File(exportador.HistorialExcel(historial), MimeExcel, nombre + ".xlsx")
                };
            }
            catch (Exception ex)
            {
                // FE-56-CU22: se registra el error para soporte
                logger.LogError(ex, "Error al exportar el historial de pedidos del usuario {UsuarioId}", UsuarioId);
                TempData["Error"] = "No fue posible generar el archivo. Intenta nuevamente";
                return RedirectToAction("Historial", "Pedido");
            }
        }
    }
}