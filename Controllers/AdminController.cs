using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[Authorize(Roles = "Administrador")]
public class AdminController(
    IAdministracionService admin,
    IWebHostEnvironment env,
    IReporteService reportes,
    IExportadorReportes exportador,
    ILogger<AdminController> logger) : Controller
{
    // ----- Validación de negocios (versión mínima de CU-18 para poder activar cuentas nuevas) -----
    [HttpGet]
    public async Task<IActionResult> Negocios() => View(await admin.ListarNegociosAsync());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> AprobarNegocio(int id)
    {
        if (await admin.AprobarNegocioAsync(id)) TempData["Mensaje"] = "Negocio validado correctamente";
        else TempData["Aviso"] = "No fue posible validar el negocio";
        return RedirectToAction(nameof(Negocios));
    }

    // ----- CU-26 Registrar administrador -----
    [HttpGet]
    public async Task<IActionResult> Administradores() => View(await admin.ListarAdministradoresAsync());

    [HttpGet]
    public IActionResult RegistrarAdministrador() => View(new RegistroAdministradorDto());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> RegistrarAdministrador(RegistroAdministradorDto dto)
    {
        if (!ModelState.IsValid)
        {
            // FE-63-CU26
            if (ModelState.Values.SelectMany(v => v.Errors).Any(e => e.ErrorMessage == RegistroNegocioDto.Obligatorio))
                ModelState.AddModelError("", "Debes completar todos los campos obligatorios");
            return View(dto);
        }

        var r = await admin.RegistrarAdministradorAsync(dto);
        if (!r.Ok)
        {
            ModelState.AddModelError("", r.Error!);
            return View(dto);
        }

        TempData["Mensaje"] = "Administrador registrado exitosamente";
        if (!r.CorreoEnviado) // FE-64-CU26
            TempData["Aviso"] = "No fue posible enviar las credenciales por correo. Puedes enviarlas manualmente";
        if (!r.CorreoEnviado || env.IsDevelopment())
            TempData["Credenciales"] = $"Usuario: {dto.Correo.Trim()} — Contraseña temporal: {r.PasswordTemporal}";

        return RedirectToAction(nameof(Administradores));
    }

    // ----- Reportes del administrador: negocios que ingresaron a la plataforma y actividad de pedidos -----
    private const string MimeExcel = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    private const string MimePdf = "application/pdf";
    private const string SinInformacion = "No hay información registrada en este rango para generar el reporte";

    private static string Dia(DateTime? d) => d!.Value.ToString("yyyy-MM-dd");

    [HttpGet]
    public async Task<IActionResult> Reportes(DateTime? desde, DateTime? hasta)
    {
        var hoy = DateTime.Today;
        var vista = new ReporteAdminVista
        {
            Desde = desde?.Date ?? new DateTime(hoy.Year, hoy.Month, 1),
            Hasta = hasta?.Date ?? hoy
        };

        if (desde is null && hasta is null) return View(vista);

        vista.Error = RangoReporte.Validar(desde, hasta);
        if (vista.Error is not null) return View(vista);

        try
        {
            var reporte = await reportes.GenerarReporteAdminAsync(desde!.Value, hasta!.Value);
            if (reporte.NegociosRegistrados == 0 && reporte.RepartidoresRegistrados == 0 && reporte.TotalPedidos == 0)
                vista.Aviso = SinInformacion;
            else
                vista.Reporte = reporte;
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al generar el reporte general de la plataforma");
            vista.Error = "No fue posible generar el reporte. Intenta nuevamente";
        }

        return View(vista);
    }

    [HttpGet]
    public async Task<IActionResult> DescargarReporte(DateTime? desde, DateTime? hasta, string formato = "excel")
    {
        var error = RangoReporte.Validar(desde, hasta);
        if (error is not null)
        {
            TempData["Error"] = error;
            return RedirectToAction(nameof(Reportes));
        }

        try
        {
            var reporte = await reportes.GenerarReporteAdminAsync(desde!.Value, hasta!.Value);
            if (reporte.NegociosRegistrados == 0 && reporte.RepartidoresRegistrados == 0 && reporte.TotalPedidos == 0)
            {
                TempData["Error"] = SinInformacion;
                return RedirectToAction(nameof(Reportes), new { desde = Dia(desde), hasta = Dia(hasta) });
            }

            var nombre = $"Reporte_Plataforma_{desde.Value:yyyyMMdd}_{hasta.Value:yyyyMMdd}";
            return formato.Equals("pdf", StringComparison.OrdinalIgnoreCase)
                ? File(exportador.ReporteAdminPdf(reporte), MimePdf, nombre + ".pdf")
                : File(exportador.ReporteAdminExcel(reporte), MimeExcel, nombre + ".xlsx");
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al exportar el reporte general de la plataforma");
            TempData["Error"] = "No fue posible generar el archivo. Intenta nuevamente";
            return RedirectToAction(nameof(Reportes), new { desde = Dia(desde), hasta = Dia(hasta) });
        }
    }
}