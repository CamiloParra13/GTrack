using ClosedXML.Excel;
using QuestPDF.Fluent;
using QuestPDF.Helpers;
using QuestPDF.Infrastructure;
using System.Globalization;
using System.Text;

// Genera los archivos Excel (ClosedXML), PDF (QuestPDF) y CSV de los reportes de GTrack
public class ExportadorReportes : IExportadorReportes
{
    private static readonly CultureInfo Es = new("es-CO");
    private static readonly XLColor Azul = XLColor.FromHtml("#1F5EFF");
    private const string AzulHex = "#1f5eff";
    private const string FormatoMoneda = "$ #,##0";
    private const string FormatoFechaHora = "dd/mm/yyyy hh:mm";

    private static string Moneda(decimal v) => v.ToString("C0", Es);
    private static string Fecha(DateTime d) => d.ToString("dd/MM/yyyy", Es);
    private static string FechaHora(DateTime d) => d.ToString("dd/MM/yyyy HH:mm", Es);
    private static string Rango(DateTime d, DateTime h) => $"{Fecha(d)} al {Fecha(h)}";

    // =====================================================================
    //  EXCEL
    // =====================================================================

    private static void Poner(IXLCell c, object? v)
    {
        switch (v)
        {
            case null: c.Value = ""; break;
            case string s: c.Value = s; break;
            case int i: c.Value = i; break;
            case decimal d: c.Value = (double)d; break;
            case DateTime dt: c.Value = dt; break;
            default: c.Value = v.ToString() ?? ""; break;
        }
    }

    private static void TituloHoja(IXLWorksheet ws, string titulo, params string[] lineas)
    {
        ws.Cell(1, 1).Value = titulo;
        ws.Cell(1, 1).Style.Font.Bold = true;
        ws.Cell(1, 1).Style.Font.FontSize = 16;
        ws.Cell(1, 1).Style.Font.FontColor = Azul;
        for (var i = 0; i < lineas.Length; i++)
            ws.Cell(2 + i, 1).Value = lineas[i];
    }

    private static void Subtitulo(IXLWorksheet ws, int fila, string texto)
    {
        ws.Cell(fila, 1).Value = texto;
        ws.Cell(fila, 1).Style.Font.Bold = true;
        ws.Cell(fila, 1).Style.Font.FontSize = 12;
    }

    // Escribe una tabla con encabezado azul y devuelve la siguiente fila libre
    private static int Tabla(IXLWorksheet ws, int fila, string[] cabeceras, List<object?[]> datos, string?[] formatos)
    {
        for (var c = 0; c < cabeceras.Length; c++)
            ws.Cell(fila, c + 1).Value = cabeceras[c];

        var enc = ws.Range(fila, 1, fila, cabeceras.Length);
        enc.Style.Font.Bold = true;
        enc.Style.Font.FontColor = XLColor.White;
        enc.Style.Fill.BackgroundColor = Azul;
        enc.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;

        var f = fila + 1;
        foreach (var d in datos)
        {
            for (var c = 0; c < cabeceras.Length; c++)
            {
                var celda = ws.Cell(f, c + 1);
                Poner(celda, d[c]);
                if (formatos[c] is string fmt) celda.Style.NumberFormat.Format = fmt;
            }
            f++;
        }

        var cuerpo = ws.Range(fila, 1, Math.Max(f - 1, fila), cabeceras.Length);
        cuerpo.Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
        cuerpo.Style.Border.InsideBorder = XLBorderStyleValues.Hair;
        return f + 1;   // deja una fila en blanco después de la tabla
    }

    private static byte[] Guardar(XLWorkbook wb)
    {
        using var ms = new MemoryStream();
        wb.SaveAs(ms);
        return ms.ToArray();
    }

    private static void HojaPedidos(XLWorkbook wb, string nombreHoja, List<FilaPedidoReporte> filas, string tituloEstado)
    {
        var ws = wb.Worksheets.Add(nombreHoja);
        Tabla(ws, 1,
            ["Código", "Cliente", "Fecha", tituloEstado, "Repartidor", "Valor total"],
            filas.Select(f => new object?[] { f.Codigo, f.Cliente, f.Fecha, f.Estado, f.Repartidor, f.ValorTotal }).ToList(),
            [null, null, FormatoFechaHora, null, null, FormatoMoneda]);

        double[] anchos = [14, 30, 18, 20, 28, 16];
        for (var i = 0; i < anchos.Length; i++) ws.Column(i + 1).Width = anchos[i];
        ws.SheetView.FreezeRows(1);
    }

    public byte[] ReporteNegocioExcel(ReporteNegocioDto r)
    {
        using var wb = new XLWorkbook();
        var ws = wb.Worksheets.Add("Resumen");

        TituloHoja(ws, "GTrack — Reporte de pedidos",
            $"Negocio: {r.NombreNegocio}",
            $"Rango: {Rango(r.Desde, r.Hasta)}",
            $"Generado: {FechaHora(r.GeneradoEn)}");

        var fila = 6;
        Subtitulo(ws, fila++, "Indicadores");
        fila = Tabla(ws, fila, ["Indicador", "Valor"],
        [
            ["Total de pedidos", r.TotalPedidos],
            ["Pedidos entregados", r.Entregados],
            ["Pedidos cancelados", r.Cancelados],
            ["Tasa de entrega (%)", r.TasaEntrega],
            ["Valor total entregado", r.ValorEntregado]
        ], [null, null]);
        // formatos de los dos últimos indicadores (tasa de entrega y valor entregado)
        ws.Cell(fila - 3, 2).Style.NumberFormat.Format = "0.0\"%\"";
        ws.Cell(fila - 2, 2).Style.NumberFormat.Format = FormatoMoneda;

        Subtitulo(ws, fila++, "Pedidos por estado");
        fila = Tabla(ws, fila, ["Estado", "Cantidad", "Porcentaje"],
            r.PorEstado.Select(e => new object?[] { e.Estado, e.Cantidad, e.Porcentaje }).ToList(),
            [null, null, "0.0\"%\""]);

        Subtitulo(ws, fila++, "Pedidos por mes");
        var porMes = r.PorMes
            .Select(m => new object?[] { m.Mes, m.Total, m.Entregados, m.Cancelados, m.ValorEntregado })
            .ToList();
        porMes.Add(["TOTAL", r.PorMes.Sum(m => m.Total), r.PorMes.Sum(m => m.Entregados),
                    r.PorMes.Sum(m => m.Cancelados), r.PorMes.Sum(m => m.ValorEntregado)]);
        var inicioMes = fila;
        fila = Tabla(ws, fila, ["Mes", "Pedidos", "Entregados", "Cancelados", "Valor entregado"],
            porMes, [null, null, null, null, FormatoMoneda]);
        ws.Range(inicioMes + porMes.Count, 1, inicioMes + porMes.Count, 5).Style.Font.Bold = true;

        double[] anchos = [28, 14, 14, 14, 20];
        for (var i = 0; i < anchos.Length; i++) ws.Column(i + 1).Width = anchos[i];

        HojaPedidos(wb, "Pedidos", r.Pedidos, "Estado");
        return Guardar(wb);
    }

    public byte[] HistorialExcel(HistorialExportDto h)
    {
        using var wb = new XLWorkbook();
        HojaPedidos(wb, "Historial", h.Filas, "Estado final");
        return Guardar(wb);
    }

    public byte[] ReporteAdminExcel(ReporteAdminDto r)
    {
        using var wb = new XLWorkbook();
        var ws = wb.Worksheets.Add("Resumen");

        TituloHoja(ws, "GTrack — Reporte general de la plataforma",
            $"Rango: {Rango(r.Desde, r.Hasta)}",
            $"Generado: {FechaHora(r.GeneradoEn)}");

        var fila = 5;
        Subtitulo(ws, fila++, "Indicadores");
        fila = Tabla(ws, fila, ["Indicador", "Valor"],
        [
            ["Negocios que ingresaron en el rango", r.NegociosRegistrados],
            ["Negocios activos en la plataforma (hoy)", r.NegociosActivosTotal],
            ["Repartidores registrados en el rango", r.RepartidoresRegistrados],
            ["Pedidos creados en el rango", r.TotalPedidos],
            ["Pedidos entregados", r.PedidosEntregados],
            ["Valor total entregado", r.ValorEntregado]
        ], [null, null]);
        ws.Cell(fila - 2, 2).Style.NumberFormat.Format = FormatoMoneda;

        Subtitulo(ws, fila++, "Negocios nuevos por mes");
        fila = Tabla(ws, fila, ["Mes", "Negocios"],
            r.NegociosPorMes.Select(m => new object?[] { m.Mes, m.Total }).ToList(), [null, null]);

        Subtitulo(ws, fila++, "Negocios nuevos por estado de cuenta");
        fila = Tabla(ws, fila, ["Estado", "Cantidad", "Porcentaje"],
            r.NegociosPorEstado.Select(e => new object?[] { e.Etiqueta, e.Cantidad, e.Porcentaje }).ToList(),
            [null, null, "0.0\"%\""]);

        Subtitulo(ws, fila++, "Negocios nuevos por tipo de actividad");
        fila = Tabla(ws, fila, ["Actividad", "Cantidad", "Porcentaje"],
            r.NegociosPorActividad.Select(e => new object?[] { e.Etiqueta, e.Cantidad, e.Porcentaje }).ToList(),
            [null, null, "0.0\"%\""]);

        Subtitulo(ws, fila++, "Pedidos de la plataforma por estado");
        fila = Tabla(ws, fila, ["Estado", "Cantidad", "Porcentaje"],
            r.PedidosPorEstado.Select(e => new object?[] { e.Estado, e.Cantidad, e.Porcentaje }).ToList(),
            [null, null, "0.0\"%\""]);

        Subtitulo(ws, fila++, "Top 10 negocios con más pedidos");
        Tabla(ws, fila, ["Negocio", "Pedidos", "Entregados", "Valor entregado"],
            r.TopNegocios.Select(t => new object?[] { t.Nombre, t.Pedidos, t.Entregados, t.ValorEntregado }).ToList(),
            [null, null, null, FormatoMoneda]);

        double[] anchos = [42, 14, 14, 20];
        for (var i = 0; i < anchos.Length; i++) ws.Column(i + 1).Width = anchos[i];

        // Detalle de los negocios que ingresaron
        var wn = wb.Worksheets.Add("Negocios nuevos");
        Tabla(wn, 1, ["Negocio", "Actividad", "NIT / CC", "Correo", "Fecha de registro", "Estado"],
            r.Negocios.Select(n => new object?[] { n.Nombre, n.Actividad, n.Documento, n.Correo, n.FechaRegistro, n.Estado }).ToList(),
            [null, null, null, null, FormatoFechaHora, null]);
        double[] anchosN = [30, 28, 16, 32, 18, 24];
        for (var i = 0; i < anchosN.Length; i++) wn.Column(i + 1).Width = anchosN[i];
        wn.SheetView.FreezeRows(1);

        return Guardar(wb);
    }

    // =====================================================================
    //  CSV (CU-22)
    // =====================================================================

    private static string Csv(string valor)
    {
        // Evita que Excel interprete el texto como una fórmula
        if (valor.Length > 0 && "=+-@".Contains(valor[0])) valor = "'" + valor;
        return "\"" + valor.Replace("\"", "\"\"") + "\"";
    }

    public byte[] HistorialCsv(HistorialExportDto h)
    {
        var sb = new StringBuilder();
        // Separador ";" para que Excel en español lo abra en columnas
        sb.AppendLine("Código;Cliente;Fecha;Estado final;Repartidor;Valor total");
        foreach (var f in h.Filas)
        {
            sb.AppendLine(string.Join(';',
                Csv(f.Codigo),
                Csv(f.Cliente),
                Csv(f.Fecha.ToString("yyyy-MM-dd HH:mm", CultureInfo.InvariantCulture)),
                Csv(f.Estado),
                Csv(f.Repartidor),
                f.ValorTotal.ToString("0.##", CultureInfo.InvariantCulture)));
        }

        var bom = new UTF8Encoding(true).GetPreamble();   // para que se vean bien las tildes
        var cuerpo = Encoding.UTF8.GetBytes(sb.ToString());
        return [.. bom, .. cuerpo];
    }

    // =====================================================================
    //  PDF
    // =====================================================================

    private static IContainer CeldaCab(IContainer c) => c.Background(AzulHex).Padding(4);
    private static IContainer Celda(IContainer c) => c.BorderBottom(0.5f).BorderColor("#dee2e6").Padding(4);

    private static void Cabecera(PageDescriptor page, string titulo, params string[] lineas)
    {
        page.Header().Column(col =>
        {
            col.Item().Row(row =>
            {
                row.RelativeItem().Text("GTrack").FontSize(20).Bold().FontColor(AzulHex);
                row.RelativeItem().AlignRight().AlignMiddle().Text(titulo).FontSize(13).SemiBold();
            });
            foreach (var l in lineas)
                col.Item().Text(l).FontSize(9).FontColor("#495057");
            col.Item().PaddingTop(6).LineHorizontal(1).LineColor(AzulHex);
        });
    }

    private static void Pie(PageDescriptor page)
    {
        page.Footer().AlignCenter().DefaultTextStyle(x => x.FontSize(8).FontColor("#6c757d")).Text(t =>
        {
            t.Span("GTrack · Página ");
            t.CurrentPageNumber();
            t.Span(" de ");
            t.TotalPages();
        });
    }

    private static void Seccion(ColumnDescriptor col, string titulo)
    {
        col.Item().PaddingTop(14).PaddingBottom(4).Text(titulo).FontSize(12).SemiBold().FontColor(AzulHex);
    }

    private static void Indicadores(ColumnDescriptor col, params (string Etiqueta, string Valor)[] kpis)
    {
        col.Item().PaddingTop(10).Row(row =>
        {
            row.Spacing(8);
            foreach (var k in kpis)
            {
                row.RelativeItem().Border(1).BorderColor("#dee2e6").Padding(8).Column(c =>
                {
                    c.Item().Text(k.Etiqueta).FontSize(8).FontColor("#6c757d");
                    c.Item().Text(k.Valor).FontSize(14).SemiBold();
                });
            }
        });
    }

    // Gráfica de barras horizontales hecha con cajas de color
    private static void Barras(ColumnDescriptor col, List<(string Etiqueta, int Cantidad, string Color, string Detalle)> items)
    {
        var max = items.Count == 0 ? 0 : items.Max(i => i.Cantidad);
        foreach (var it in items)
        {
            col.Item().PaddingVertical(2).Row(row =>
            {
                row.ConstantItem(120).AlignMiddle().Text(it.Etiqueta).FontSize(9);
                row.RelativeItem().AlignMiddle().Row(barra =>
                {
                    var p = max == 0 ? 0f : it.Cantidad * 100f / max;
                    if (p > 0) barra.RelativeItem(p).Height(12).Background(it.Color);
                    if (p < 100) barra.RelativeItem(100f - p).Height(12);
                });
                row.ConstantItem(80).AlignRight().AlignMiddle().Text(it.Detalle).FontSize(9);
            });
        }
    }

    private static void TablaSimple(ColumnDescriptor col, string[] cabeceras, float[] anchos, List<string[]> filas, int[]? alineadasDerecha = null)
    {
        col.Item().Table(t =>
        {
            t.ColumnsDefinition(c => { foreach (var a in anchos) c.RelativeColumn(a); });

            t.Header(h =>
            {
                for (var i = 0; i < cabeceras.Length; i++)
                {
                    var cel = h.Cell().Element(CeldaCab);
                    if (alineadasDerecha?.Contains(i) == true) cel = cel.AlignRight();
                    cel.Text(cabeceras[i]).FontColor("#ffffff").SemiBold().FontSize(9);
                }
            });

            foreach (var fila in filas)
            {
                for (var i = 0; i < fila.Length; i++)
                {
                    var cel = t.Cell().Element(Celda);
                    if (alineadasDerecha?.Contains(i) == true) cel = cel.AlignRight();
                    cel.Text(fila[i]).FontSize(9);
                }
            }
        });
    }

    private static void TablaPedidos(ColumnDescriptor col, List<FilaPedidoReporte> filas, string tituloEstado)
    {
        TablaSimple(col,
            ["Código", "Cliente", "Fecha", tituloEstado, "Repartidor", "Valor total"],
            [1.2f, 2.4f, 1.9f, 1.7f, 2.2f, 1.6f],
            filas.Select(f => new[] { f.Codigo, f.Cliente, FechaHora(f.Fecha), f.Estado, f.Repartidor, Moneda(f.ValorTotal) }).ToList(),
            [5]);
    }

    private static void SinDatos(ColumnDescriptor col, string mensaje)
    {
        col.Item().PaddingVertical(6).Text(mensaje).FontSize(9).Italic().FontColor("#6c757d");
    }

    private static byte[] CrearPdf(Action<PageDescriptor> configurar) =>
        Document.Create(doc =>
        {
            doc.Page(page =>
            {
                page.Size(PageSizes.A4);
                page.Margin(28);
                page.DefaultTextStyle(x => x.FontSize(10));
                configurar(page);
                Pie(page);
            });
        }).GeneratePdf();

    public byte[] ReporteNegocioPdf(ReporteNegocioDto r) => CrearPdf(page =>
    {
        Cabecera(page, "Reporte de pedidos",
            $"Negocio: {r.NombreNegocio}",
            $"Rango: {Rango(r.Desde, r.Hasta)}   ·   Generado: {FechaHora(r.GeneradoEn)}");

        page.Content().Column(col =>
        {
            Indicadores(col,
                ("Total de pedidos", r.TotalPedidos.ToString(Es)),
                ("Entregados", r.Entregados.ToString(Es)),
                ("Cancelados", r.Cancelados.ToString(Es)),
                ("Tasa de entrega", r.TasaEntrega.ToString("0.0", Es) + " %"),
                ("Valor entregado", Moneda(r.ValorEntregado)));

            Seccion(col, "Pedidos por estado");
            Barras(col, r.PorEstado
                .Select(e => (e.Estado, e.Cantidad, e.Color, $"{e.Cantidad} ({e.Porcentaje.ToString("0.0", Es)} %)"))
                .ToList());

            Seccion(col, "Pedidos por mes");
            var meses = r.PorMes
                .Select(m => new[] { m.Mes, m.Total.ToString(Es), m.Entregados.ToString(Es), m.Cancelados.ToString(Es), Moneda(m.ValorEntregado) })
                .ToList();
            meses.Add(["TOTAL", r.PorMes.Sum(m => m.Total).ToString(Es), r.PorMes.Sum(m => m.Entregados).ToString(Es),
                       r.PorMes.Sum(m => m.Cancelados).ToString(Es), Moneda(r.PorMes.Sum(m => m.ValorEntregado))]);
            TablaSimple(col, ["Mes", "Pedidos", "Entregados", "Cancelados", "Valor entregado"],
                [2.4f, 1f, 1.2f, 1.2f, 2f], meses, [1, 2, 3, 4]);

            Seccion(col, "Detalle de pedidos");
            if (r.Pedidos.Count == 0) SinDatos(col, "No hay pedidos en el rango seleccionado.");
            else TablaPedidos(col, r.Pedidos, "Estado");
        });
    });

    public byte[] HistorialPdf(HistorialExportDto h) => CrearPdf(page =>
    {
        Cabecera(page, "Historial de pedidos",
            $"Negocio: {h.NombreNegocio}",
            $"Rango: {Rango(h.Desde, h.Hasta)}   ·   Generado: {FechaHora(h.GeneradoEn)}");

        page.Content().Column(col =>
        {
            var entregados = h.Filas.Count(f => f.Estado == EstadoPedidoInfo.Nombre((int)EstadoPedido.Entregado));
            Indicadores(col,
                ("Pedidos finalizados", h.Filas.Count.ToString(Es)),
                ("Entregados", entregados.ToString(Es)),
                ("Cancelados", (h.Filas.Count - entregados).ToString(Es)));

            Seccion(col, "Pedidos finalizados");
            if (h.Filas.Count == 0) SinDatos(col, "No hay pedidos finalizados en el rango seleccionado.");
            else TablaPedidos(col, h.Filas, "Estado final");
        });
    });

    public byte[] ReporteAdminPdf(ReporteAdminDto r) => CrearPdf(page =>
    {
        Cabecera(page, "Reporte general de la plataforma",
            $"Rango: {Rango(r.Desde, r.Hasta)}   ·   Generado: {FechaHora(r.GeneradoEn)}");

        page.Content().Column(col =>
        {
            Indicadores(col,
                ("Negocios nuevos", r.NegociosRegistrados.ToString(Es)),
                ("Negocios activos (hoy)", r.NegociosActivosTotal.ToString(Es)),
                ("Repartidores nuevos", r.RepartidoresRegistrados.ToString(Es)));
            Indicadores(col,
                ("Pedidos creados", r.TotalPedidos.ToString(Es)),
                ("Pedidos entregados", r.PedidosEntregados.ToString(Es)),
                ("Valor entregado", Moneda(r.ValorEntregado)));

            Seccion(col, "Negocios nuevos por mes");
            Barras(col, r.NegociosPorMes.Select(m => (m.Mes, m.Total, AzulHex, m.Total.ToString(Es))).ToList());

            Seccion(col, "Negocios nuevos por estado de cuenta");
            if (r.NegociosPorEstado.Count == 0) SinDatos(col, "Ningún negocio ingresó en el rango.");
            else Barras(col, r.NegociosPorEstado
                .Select(e => (e.Etiqueta, e.Cantidad, e.Color, $"{e.Cantidad} ({e.Porcentaje.ToString("0.0", Es)} %)"))
                .ToList());

            Seccion(col, "Negocios nuevos por tipo de actividad");
            if (r.NegociosPorActividad.Count == 0) SinDatos(col, "Ningún negocio ingresó en el rango.");
            else Barras(col, r.NegociosPorActividad
                .Select(e => (e.Etiqueta, e.Cantidad, e.Color, $"{e.Cantidad} ({e.Porcentaje.ToString("0.0", Es)} %)"))
                .ToList());

            Seccion(col, "Pedidos de la plataforma por estado");
            Barras(col, r.PedidosPorEstado
                .Select(e => (e.Estado, e.Cantidad, e.Color, $"{e.Cantidad} ({e.Porcentaje.ToString("0.0", Es)} %)"))
                .ToList());

            Seccion(col, "Top 10 negocios con más pedidos");
            if (r.TopNegocios.Count == 0) SinDatos(col, "No hay pedidos en el rango seleccionado.");
            else TablaSimple(col, ["Negocio", "Pedidos", "Entregados", "Valor entregado"], [3f, 1f, 1.2f, 2f],
                r.TopNegocios.Select(t => new[] { t.Nombre, t.Pedidos.ToString(Es), t.Entregados.ToString(Es), Moneda(t.ValorEntregado) }).ToList(),
                [1, 2, 3]);

            Seccion(col, "Negocios que ingresaron en el rango");
            if (r.Negocios.Count == 0) SinDatos(col, "Ningún negocio ingresó en el rango.");
            else TablaSimple(col, ["Negocio", "Actividad", "NIT / CC", "Registro", "Estado"], [2.4f, 2f, 1.5f, 1.6f, 1.8f],
                r.Negocios.Select(n => new[] { n.Nombre, n.Actividad, n.Documento, Fecha(n.FechaRegistro), n.Estado }).ToList());
        });
    });
}
