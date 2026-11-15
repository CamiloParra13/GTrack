using Gtrack.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;
using NSubstitute.ExceptionExtensions;

namespace Gtrack.Tests;

// CU-24 Generar reporte de pedidos y CU-22 Exportar historial
public class ReporteControllerTests
{
    private static readonly DateTime Desde = new(2026, 11, 1);
    private static readonly DateTime Hasta = new(2026, 11, 30);
    private static readonly byte[] Archivo = [1, 2, 3];

    private sealed class Escenario
    {
        public IReporteService Reportes { get; } = Substitute.For<IReporteService>();
        public IExportadorReportes Exportador { get; } = Substitute.For<IExportadorReportes>();
        public ReporteController Controlador { get; }

        public Escenario()
        {
            Controlador = new ReporteController(Reportes, Exportador, NullLogger<ReporteController>.Instance)
                .Preparar(usuarioId: 1, rol: "Negocio");
            Exportador.ReporteNegocioExcel(Arg.Any<ReporteNegocioDto>()).Returns(Archivo);
            Exportador.ReporteNegocioPdf(Arg.Any<ReporteNegocioDto>()).Returns(Archivo);
            Exportador.HistorialExcel(Arg.Any<HistorialExportDto>()).Returns(Archivo);
            Exportador.HistorialPdf(Arg.Any<HistorialExportDto>()).Returns(Archivo);
            Exportador.HistorialCsv(Arg.Any<HistorialExportDto>()).Returns(Archivo);
        }

        public void ConReporte(int totalPedidos) =>
            Reportes.GenerarReporteNegocioAsync(1, Desde, Hasta)
                .Returns(new ReporteNegocioDto { NombreNegocio = "Comidas Rápidas", TotalPedidos = totalPedidos });

        public void ConHistorial(int filas) =>
            Reportes.ObtenerHistorialAsync(1, Desde, Hasta)
                .Returns(new HistorialExportDto
                {
                    Filas = Enumerable.Range(1, filas).Select(i => new FilaPedidoReporte { Codigo = $"PED{i}" }).ToList()
                });
    }

    // ===== Index =====

    [Fact]
    public async Task Index_Get_SinFechas_MuestraSoloElFormulario()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index(null, null));

        var modelo = Assert.IsType<ReporteNegocioVista>(vista.Model);
        Assert.Null(modelo.Reporte);
        Assert.Null(modelo.Error);
        Assert.Equal(DateTime.Today, modelo.Hasta);
        await e.Reportes.DidNotReceiveWithAnyArgs().GenerarReporteNegocioAsync(default, default, default);
    }

    [Fact]
    public async Task Index_Get_RangoInvalido_MuestraError()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index(Hasta, Desde));

        Assert.Equal(RangoReporte.MensajeInvalido, Assert.IsType<ReporteNegocioVista>(vista.Model).Error);
    }

    [Fact]
    public async Task Index_Get_NegocioNoExiste_MuestraError()
    {
        var e = new Escenario();
        e.Reportes.GenerarReporteNegocioAsync(1, Desde, Hasta).Returns((ReporteNegocioDto?)null);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index(Desde, Hasta));

        Assert.Equal("No fue posible identificar tu negocio", Assert.IsType<ReporteNegocioVista>(vista.Model).Error);
    }

    [Fact]
    public async Task Index_Get_SinPedidos_MuestraAvisoSinReporte()
    {
        var e = new Escenario();
        e.ConReporte(totalPedidos: 0);

        var modelo = Assert.IsType<ReporteNegocioVista>(Assert.IsType<ViewResult>(await e.Controlador.Index(Desde, Hasta)).Model);

        Assert.NotNull(modelo.Aviso);
        Assert.Null(modelo.Reporte);
    }

    [Fact]
    public async Task Index_Get_ConPedidos_MuestraElReporte()
    {
        var e = new Escenario();
        e.ConReporte(totalPedidos: 3);

        var modelo = Assert.IsType<ReporteNegocioVista>(Assert.IsType<ViewResult>(await e.Controlador.Index(Desde, Hasta)).Model);

        Assert.NotNull(modelo.Reporte);
        Assert.Equal(3, modelo.Reporte.TotalPedidos);
    }

    [Fact]
    public async Task Index_Get_FallaElServicio_MuestraError()
    {
        var e = new Escenario();
        e.Reportes.GenerarReporteNegocioAsync(1, Desde, Hasta).ThrowsAsync(new InvalidOperationException("Falla"));

        var modelo = Assert.IsType<ReporteNegocioVista>(Assert.IsType<ViewResult>(await e.Controlador.Index(Desde, Hasta)).Model);

        Assert.Equal("No fue posible generar el reporte. Intenta nuevamente", modelo.Error);
    }

    // ===== Descargar =====

    [Fact]
    public async Task Descargar_RangoInvalido_RedirigeConError()
    {
        var e = new Escenario();

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.Descargar(null, Hasta));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal(RangoReporte.MensajeInvalido, e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task Descargar_SinPedidos_RedirigeConError()
    {
        var e = new Escenario();
        e.ConReporte(totalPedidos: 0);

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.Descargar(Desde, Hasta));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal("2026-11-01", r.RouteValues!["desde"]);
    }

    [Fact]
    public async Task Descargar_Excel_RetornaArchivoExcel()
    {
        var e = new Escenario();
        e.ConReporte(totalPedidos: 2);

        var archivo = Assert.IsType<FileContentResult>(await e.Controlador.Descargar(Desde, Hasta));

        Assert.EndsWith(".xlsx", archivo.FileDownloadName);
        Assert.Equal("Reporte_Pedidos_20261101_20261130.xlsx", archivo.FileDownloadName);
    }

    [Fact]
    public async Task Descargar_Pdf_RetornaArchivoPdf()
    {
        var e = new Escenario();
        e.ConReporte(totalPedidos: 2);

        var archivo = Assert.IsType<FileContentResult>(await e.Controlador.Descargar(Desde, Hasta, "PDF"));

        Assert.Equal("application/pdf", archivo.ContentType);
    }

    [Fact]
    public async Task Descargar_FallaElServicio_RedirigeConError()
    {
        var e = new Escenario();
        e.Reportes.GenerarReporteNegocioAsync(1, Desde, Hasta).ThrowsAsync(new InvalidOperationException("Falla"));

        Assert.IsType<RedirectToActionResult>(await e.Controlador.Descargar(Desde, Hasta));

        Assert.Equal("No fue posible generar el archivo. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }

    // ===== ExportarHistorial =====

    [Fact]
    public async Task ExportarHistorial_RangoInvalido_RedirigeAlHistorial()
    {
        var e = new Escenario();

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ExportarHistorial(Hasta, Desde));

        Assert.Equal("Historial", r.ActionName);
        Assert.Equal("Pedido", r.ControllerName);
    }

    [Fact]
    public async Task ExportarHistorial_SinPedidosFinalizados_RedirigeConError()
    {
        var e = new Escenario();
        e.ConHistorial(filas: 0);

        Assert.IsType<RedirectToActionResult>(await e.Controlador.ExportarHistorial(Desde, Hasta));

        Assert.Equal("No hay pedidos finalizados en el rango seleccionado", e.Controlador.TempData["Error"]);
    }

    [Theory]
    [InlineData("excel", ".xlsx")]
    [InlineData("pdf", ".pdf")]
    [InlineData("csv", ".csv")]
    public async Task ExportarHistorial_SegunElFormato_RetornaElArchivo(string formato, string extension)
    {
        var e = new Escenario();
        e.ConHistorial(filas: 2);

        var archivo = Assert.IsType<FileContentResult>(await e.Controlador.ExportarHistorial(Desde, Hasta, formato));

        Assert.EndsWith(extension, archivo.FileDownloadName);
    }

    [Fact]
    public async Task ExportarHistorial_FallaElServicio_RedirigeConError()
    {
        var e = new Escenario();
        e.Reportes.ObtenerHistorialAsync(1, Desde, Hasta).ThrowsAsync(new InvalidOperationException("Falla"));

        Assert.IsType<RedirectToActionResult>(await e.Controlador.ExportarHistorial(Desde, Hasta));

        Assert.Equal("No fue posible generar el archivo. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }
}
