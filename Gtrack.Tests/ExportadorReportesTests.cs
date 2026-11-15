using System.Text;
using QuestPDF.Infrastructure;

namespace Gtrack.Tests;

// CU-22 y CU-24: archivos Excel, PDF y CSV de los reportes
public class ExportadorReportesTests
{
    private readonly ExportadorReportes exportador = new();

    public ExportadorReportesTests()
    {
        // En la aplicación se configura en Program.cs
        QuestPDF.Settings.License = LicenseType.Community;
    }

    // Un .xlsx es un archivo ZIP: empieza con "PK"
    private static bool EsExcel(byte[] archivo) =>
        archivo.Length > 4 && archivo[0] == (byte)'P' && archivo[1] == (byte)'K';

    private static bool EsPdf(byte[] archivo) =>
        archivo.Length > 4 && Encoding.ASCII.GetString(archivo, 0, 4) == "%PDF";

    private static List<FilaPedidoReporte> Filas() =>
    [
        new() { Codigo = "ABC12345", Cliente = "Ana Pérez", Fecha = new DateTime(2026, 11, 10, 9, 30, 0),
                Estado = "Entregado", Repartidor = "Juan Gómez", ValorTotal = 25000m },
        new() { Codigo = "XYZ98765", Cliente = "=SUMA(A1)", Fecha = new DateTime(2026, 11, 11, 15, 0, 0),
                Estado = "Cancelado", Repartidor = "Sin asignar", ValorTotal = 12500.5m }
    ];

    private static ReporteNegocioDto ReporteNegocio(bool conDatos = true) => new()
    {
        NombreNegocio = "Comidas Rápidas",
        Desde = new DateTime(2026, 10, 1),
        Hasta = new DateTime(2026, 11, 30),
        GeneradoEn = new DateTime(2026, 11, 14, 20, 0, 0),
        TotalPedidos = conDatos ? 2 : 0,
        Entregados = conDatos ? 1 : 0,
        Cancelados = conDatos ? 1 : 0,
        TasaEntrega = conDatos ? 50m : 0m,
        ValorEntregado = conDatos ? 25000m : 0m,
        PorEstado = conDatos
            ? [new() { EstadoId = 5, Estado = "Entregado", Color = "#198754", Cantidad = 1, Porcentaje = 50m },
               new() { EstadoId = 6, Estado = "Cancelado", Color = "#dc3545", Cantidad = 1, Porcentaje = 50m },
               new() { EstadoId = 0, Estado = "Recibido", Color = "#6c757d", Cantidad = 0, Porcentaje = 0m }]
            : [],
        PorMes = conDatos
            ? [new() { Mes = "Octubre 2026", Total = 0 },
               new() { Mes = "Noviembre 2026", Total = 2, Entregados = 1, Cancelados = 1, ValorEntregado = 25000m }]
            : [],
        Pedidos = conDatos ? Filas() : []
    };

    private static HistorialExportDto Historial(bool conDatos = true) => new()
    {
        NombreNegocio = "Comidas Rápidas",
        Desde = new DateTime(2026, 11, 1),
        Hasta = new DateTime(2026, 11, 30),
        GeneradoEn = new DateTime(2026, 11, 14, 20, 0, 0),
        Filas = conDatos ? Filas() : []
    };

    private static ReporteAdminDto ReporteAdmin(bool conDatos = true) => new()
    {
        Desde = new DateTime(2026, 10, 1),
        Hasta = new DateTime(2026, 11, 30),
        GeneradoEn = new DateTime(2026, 11, 14, 20, 0, 0),
        NegociosRegistrados = conDatos ? 2 : 0,
        NegociosActivosTotal = conDatos ? 5 : 0,
        RepartidoresRegistrados = conDatos ? 3 : 0,
        TotalPedidos = conDatos ? 4 : 0,
        PedidosEntregados = conDatos ? 2 : 0,
        ValorEntregado = conDatos ? 80000m : 0m,
        NegociosPorMes = conDatos
            ? [new() { Mes = "Octubre 2026", Total = 0 }, new() { Mes = "Noviembre 2026", Total = 2 }]
            : [],
        NegociosPorEstado = conDatos
            ? [new() { Etiqueta = "Activo", Color = "#198754", Cantidad = 2, Porcentaje = 100m }]
            : [],
        NegociosPorActividad = conDatos
            ? [new() { Etiqueta = "Restaurante", Cantidad = 2, Porcentaje = 100m }]
            : [],
        PedidosPorEstado = conDatos
            ? [new() { EstadoId = 5, Estado = "Entregado", Color = "#198754", Cantidad = 2, Porcentaje = 50m }]
            : [],
        TopNegocios = conDatos
            ? [new() { Nombre = "Comidas Rápidas", Pedidos = 4, Entregados = 2, ValorEntregado = 80000m }]
            : [],
        Negocios = conDatos
            ? [new() { Nombre = "Comidas Rápidas", Actividad = "Restaurante", Documento = "900123456",
                       Correo = "negocio@gtrack.local", FechaRegistro = new DateTime(2026, 11, 2), Estado = "Activo" }]
            : []
    };

    // ===== Excel =====

    [Fact]
    public void ReporteNegocioExcel_ConDatos_GeneraUnArchivoExcel()
    {
        Assert.True(EsExcel(exportador.ReporteNegocioExcel(ReporteNegocio())));
    }

    [Fact]
    public void ReporteNegocioExcel_SinPedidos_GeneraUnArchivoExcel()
    {
        Assert.True(EsExcel(exportador.ReporteNegocioExcel(ReporteNegocio(conDatos: false))));
    }

    [Fact]
    public void HistorialExcel_ConDatos_GeneraUnArchivoExcel()
    {
        Assert.True(EsExcel(exportador.HistorialExcel(Historial())));
    }

    [Fact]
    public void ReporteAdminExcel_ConDatos_GeneraUnArchivoExcel()
    {
        Assert.True(EsExcel(exportador.ReporteAdminExcel(ReporteAdmin())));
    }

    [Fact]
    public void ReporteAdminExcel_SinDatos_GeneraUnArchivoExcel()
    {
        Assert.True(EsExcel(exportador.ReporteAdminExcel(ReporteAdmin(conDatos: false))));
    }

    // ===== CSV =====

    [Fact]
    public void HistorialCsv_IncluyeEncabezadoYUnaFilaPorPedido()
    {
        var archivo = exportador.HistorialCsv(Historial());
        var texto = Encoding.UTF8.GetString(archivo).TrimStart('﻿');
        var lineas = texto.Split(Environment.NewLine, StringSplitOptions.RemoveEmptyEntries);

        Assert.Equal("Código;Cliente;Fecha;Estado final;Repartidor;Valor total", lineas[0]);
        Assert.Equal(3, lineas.Length);
        Assert.Contains("\"ABC12345\"", lineas[1]);
        Assert.EndsWith(";25000", lineas[1]);
    }

    [Fact]
    public void HistorialCsv_IniciaConBomParaQueSeVeanLasTildes()
    {
        var archivo = exportador.HistorialCsv(Historial());

        Assert.Equal(new byte[] { 0xEF, 0xBB, 0xBF }, archivo.Take(3).ToArray());
    }

    [Fact]
    public void HistorialCsv_TextoQueEmpiezaConIgual_SeEscapaParaQueExcelNoLoTomeComoFormula()
    {
        var texto = Encoding.UTF8.GetString(exportador.HistorialCsv(Historial()));

        Assert.Contains("\"'=SUMA(A1)\"", texto);
    }

    [Fact]
    public void HistorialCsv_SinPedidos_SoloTieneElEncabezado()
    {
        var texto = Encoding.UTF8.GetString(exportador.HistorialCsv(Historial(conDatos: false))).TrimStart('﻿');
        var lineas = texto.Split(Environment.NewLine, StringSplitOptions.RemoveEmptyEntries);

        Assert.Single(lineas);
    }

    // ===== PDF =====

    [Fact]
    public void ReporteNegocioPdf_ConDatos_GeneraUnPdf()
    {
        Assert.True(EsPdf(exportador.ReporteNegocioPdf(ReporteNegocio())));
    }

    [Fact]
    public void ReporteNegocioPdf_SinPedidos_GeneraUnPdf()
    {
        Assert.True(EsPdf(exportador.ReporteNegocioPdf(ReporteNegocio(conDatos: false))));
    }

    [Fact]
    public void HistorialPdf_ConDatos_GeneraUnPdf()
    {
        Assert.True(EsPdf(exportador.HistorialPdf(Historial())));
    }

    [Fact]
    public void HistorialPdf_SinPedidos_GeneraUnPdf()
    {
        Assert.True(EsPdf(exportador.HistorialPdf(Historial(conDatos: false))));
    }

    [Fact]
    public void ReporteAdminPdf_ConDatos_GeneraUnPdf()
    {
        Assert.True(EsPdf(exportador.ReporteAdminPdf(ReporteAdmin())));
    }

    [Fact]
    public void ReporteAdminPdf_SinDatos_GeneraUnPdf()
    {
        Assert.True(EsPdf(exportador.ReporteAdminPdf(ReporteAdmin(conDatos: false))));
    }
}
