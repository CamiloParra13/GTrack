using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;
using NSubstitute.ExceptionExtensions;

namespace Gtrack.Tests;

// Reporte general de la plataforma (administrador) y reenvío de activación
public class AdminControllerReportesTests
{
    private static readonly DateTime Desde = new(2026, 11, 1);
    private static readonly DateTime Hasta = new(2026, 11, 30);
    private static readonly byte[] Archivo = [1, 2, 3];

    private sealed class Escenario
    {
        public IAdministracionService Admin { get; } = Substitute.For<IAdministracionService>();
        public IReporteService Reportes { get; } = Substitute.For<IReporteService>();
        public IExportadorReportes Exportador { get; } = Substitute.For<IExportadorReportes>();
        public AdminController Controlador { get; }

        public Escenario()
        {
            Controlador = new AdminController(Admin, Reportes, Exportador, NullLogger<AdminController>.Instance)
                .Preparar(usuarioId: 1, rol: "Administrador");
            Exportador.ReporteAdminExcel(Arg.Any<ReporteAdminDto>()).Returns(Archivo);
            Exportador.ReporteAdminPdf(Arg.Any<ReporteAdminDto>()).Returns(Archivo);
        }

        public void ConReporte(int negocios = 0, int repartidores = 0, int pedidos = 0) =>
            Reportes.GenerarReporteAdminAsync(Desde, Hasta).Returns(new ReporteAdminDto
            {
                NegociosRegistrados = negocios,
                RepartidoresRegistrados = repartidores,
                TotalPedidos = pedidos
            });
    }

    // ===== Reportes =====

    [Fact]
    public async Task Reportes_Get_SinFechas_MuestraSoloElFormulario()
    {
        var e = new Escenario();

        var modelo = Assert.IsType<ReporteAdminVista>(Assert.IsType<ViewResult>(await e.Controlador.Reportes(null, null)).Model);

        Assert.Null(modelo.Reporte);
        Assert.Equal(DateTime.Today, modelo.Hasta);
    }

    [Fact]
    public async Task Reportes_Get_RangoInvalido_MuestraError()
    {
        var e = new Escenario();

        var modelo = Assert.IsType<ReporteAdminVista>(Assert.IsType<ViewResult>(await e.Controlador.Reportes(Hasta, Desde)).Model);

        Assert.Equal(RangoReporte.MensajeInvalido, modelo.Error);
    }

    [Fact]
    public async Task Reportes_Get_SinInformacion_MuestraAviso()
    {
        var e = new Escenario();
        e.ConReporte();

        var modelo = Assert.IsType<ReporteAdminVista>(Assert.IsType<ViewResult>(await e.Controlador.Reportes(Desde, Hasta)).Model);

        Assert.NotNull(modelo.Aviso);
        Assert.Null(modelo.Reporte);
    }

    [Fact]
    public async Task Reportes_Get_ConInformacion_MuestraElReporte()
    {
        var e = new Escenario();
        e.ConReporte(negocios: 2, pedidos: 5);

        var modelo = Assert.IsType<ReporteAdminVista>(Assert.IsType<ViewResult>(await e.Controlador.Reportes(Desde, Hasta)).Model);

        Assert.NotNull(modelo.Reporte);
        Assert.Equal(2, modelo.Reporte.NegociosRegistrados);
    }

    [Fact]
    public async Task Reportes_Get_FallaElServicio_MuestraError()
    {
        var e = new Escenario();
        e.Reportes.GenerarReporteAdminAsync(Desde, Hasta).ThrowsAsync(new InvalidOperationException("Falla"));

        var modelo = Assert.IsType<ReporteAdminVista>(Assert.IsType<ViewResult>(await e.Controlador.Reportes(Desde, Hasta)).Model);

        Assert.Equal("No fue posible generar el reporte. Intenta nuevamente", modelo.Error);
    }

    // ===== DescargarReporte =====

    [Fact]
    public async Task DescargarReporte_RangoInvalido_RedirigeConError()
    {
        var e = new Escenario();

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.DescargarReporte(Desde, null));

        Assert.Equal("Reportes", r.ActionName);
        Assert.Equal(RangoReporte.MensajeInvalido, e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task DescargarReporte_SinInformacion_RedirigeConError()
    {
        var e = new Escenario();
        e.ConReporte();

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.DescargarReporte(Desde, Hasta));

        Assert.Equal("Reportes", r.ActionName);
        Assert.Equal("2026-11-30", r.RouteValues!["hasta"]);
    }

    [Fact]
    public async Task DescargarReporte_Excel_RetornaArchivoExcel()
    {
        var e = new Escenario();
        e.ConReporte(repartidores: 1);

        var archivo = Assert.IsType<FileContentResult>(await e.Controlador.DescargarReporte(Desde, Hasta));

        Assert.Equal("Reporte_Plataforma_20261101_20261130.xlsx", archivo.FileDownloadName);
    }

    [Fact]
    public async Task DescargarReporte_Pdf_RetornaArchivoPdf()
    {
        var e = new Escenario();
        e.ConReporte(pedidos: 1);

        var archivo = Assert.IsType<FileContentResult>(await e.Controlador.DescargarReporte(Desde, Hasta, "pdf"));

        Assert.Equal("application/pdf", archivo.ContentType);
    }

    [Fact]
    public async Task DescargarReporte_FallaElServicio_RedirigeConError()
    {
        var e = new Escenario();
        e.Reportes.GenerarReporteAdminAsync(Desde, Hasta).ThrowsAsync(new InvalidOperationException("Falla"));

        Assert.IsType<RedirectToActionResult>(await e.Controlador.DescargarReporte(Desde, Hasta));

        Assert.Equal("No fue posible generar el archivo. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }

    // ===== ReenviarActivacion =====

    [Theory]
    [InlineData(true, "Mensaje")]
    [InlineData(false, "Error")]
    public async Task ReenviarActivacion_GuardaElMensajeSegunElResultado(bool exito, string clave)
    {
        var e = new Escenario();
        e.Admin.ReenviarActivacionAsync(3, Arg.Any<Func<string, string>>()).Returns((exito, "Resultado del reenvío"));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ReenviarActivacion(3));

        Assert.Equal("Administradores", r.ActionName);
        Assert.Equal("Resultado del reenvío", e.Controlador.TempData[clave]);
    }
}
