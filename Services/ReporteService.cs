using Microsoft.EntityFrameworkCore;
using System.Globalization;

namespace Gtrack;

public class ReporteService(AppDbContext db, INegocioRepository negocios) : IReporteService
{
    private static readonly CultureInfo Es = new("es-CO");

    private static readonly string[] Paleta =
        ["#1f5eff", "#198754", "#fd7e14", "#6f42c1", "#0dcaf0", "#dc3545", "#f0ad00", "#6c757d"];

    // ---------- Utilidades ----------

    // Las fechas se guardan en UTC; el usuario elige días en su hora local.
    private static DateTime InicioDiaUtc(DateTime diaLocal) =>
        TimeZoneInfo.ConvertTimeToUtc(
            DateTime.SpecifyKind(diaLocal.Date, DateTimeKind.Unspecified), TimeZoneInfo.Local);

    private static DateTime ALocal(DateTime fechaBd) =>
        DateTime.SpecifyKind(fechaBd, DateTimeKind.Utc).ToLocalTime();

    private static decimal Pct(int parte, int total) =>
        total == 0 ? 0 : Math.Round(parte * 100m / total, 1);

    private static string NombreMes(DateTime f)
    {
        var mes = Es.DateTimeFormat.GetMonthName(f.Month);
        return char.ToUpper(mes[0], Es) + mes[1..] + " " + f.Year;
    }

    // Todos los meses que toca el rango, incluso los que no tienen datos
    private static List<DateTime> MesesDelRango(DateTime desde, DateTime hasta)
    {
        var meses = new List<DateTime>();
        var actual = new DateTime(desde.Year, desde.Month, 1);
        var fin = new DateTime(hasta.Year, hasta.Month, 1);
        while (actual <= fin)
        {
            meses.Add(actual);
            actual = actual.AddMonths(1);
        }
        return meses;
    }

    private static List<FilaEstadoReporte> ContarPorEstado(List<int> estados)
    {
        var total = estados.Count;
        return Enum.GetValues<EstadoPedido>()
            .Select(e =>
            {
                var cantidad = estados.Count(x => x == (int)e);
                return new FilaEstadoReporte
                {
                    EstadoId = (int)e,
                    Estado = EstadoPedidoInfo.Nombre((int)e),
                    Color = EstadoPedidoInfo.Color((int)e),
                    Cantidad = cantidad,
                    Porcentaje = Pct(cantidad, total)
                };
            })
            .ToList();
    }

    // ---------- CU-24 ----------

    public async Task<ReporteNegocioDto?> GenerarReporteNegocioAsync(int usuarioNegocioId, DateTime desde, DateTime hasta)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return null;

        var desdeUtc = InicioDiaUtc(desde);
        var hastaUtc = InicioDiaUtc(hasta.Date.AddDays(1));

        // RN-2-CU24: se basa en la fecha de creación del pedido
        var filas = await db.Pedidos.AsNoTracking()
            .Where(p => p.NegocioId == negocio.Id && p.FechaCreacion >= desdeUtc && p.FechaCreacion < hastaUtc)
            .OrderByDescending(p => p.FechaCreacion)
            .Select(p => new
            {
                p.Id,
                p.Codigo,
                p.ClienteId,
                p.FechaCreacion,
                p.EstadoPedidoId,
                Cliente = p.Cliente != null ? p.Cliente.NombreCompleto : null,
                Repartidor = p.Repartidor != null ? p.Repartidor.NombreCompleto : null,
                Total = p.Items.Sum(i => i.Cantidad * i.PrecioUnitario)
            })
            .ToListAsync();

        var entregados = filas.Where(f => f.EstadoPedidoId == (int)EstadoPedido.Entregado).ToList();
        var cancelados = filas.Count(f => f.EstadoPedidoId == (int)EstadoPedido.Cancelado);

        var reporte = new ReporteNegocioDto
        {
            NombreNegocio = negocio.Nombre,
            Desde = desde.Date,
            Hasta = hasta.Date,
            GeneradoEn = DateTime.Now,
            TotalPedidos = filas.Count,
            Entregados = entregados.Count,
            Cancelados = cancelados,
            TasaEntrega = Pct(entregados.Count, filas.Count),
            ValorEntregado = entregados.Sum(f => f.Total),
            PorEstado = ContarPorEstado(filas.Select(f => f.EstadoPedidoId).ToList()),
            Pedidos = filas.Select(f => new FilaPedidoReporte
            {
                Codigo = f.Codigo,
                Cliente = f.Cliente ?? $"Cliente #{f.ClienteId}",
                Fecha = ALocal(f.FechaCreacion),
                Estado = EstadoPedidoInfo.Nombre(f.EstadoPedidoId),
                Repartidor = f.Repartidor ?? "Sin asignar",
                ValorTotal = f.Total
            }).ToList()
        };

        // Pedidos por mes (todos los meses del rango)
        var locales = filas.Select(f => new { Fecha = ALocal(f.FechaCreacion), f.EstadoPedidoId, f.Total }).ToList();
        foreach (var mes in MesesDelRango(desde, hasta))
        {
            var delMes = locales.Where(f => f.Fecha.Year == mes.Year && f.Fecha.Month == mes.Month).ToList();
            reporte.PorMes.Add(new FilaMesReporte
            {
                Mes = NombreMes(mes),
                Total = delMes.Count,
                Entregados = delMes.Count(f => f.EstadoPedidoId == (int)EstadoPedido.Entregado),
                Cancelados = delMes.Count(f => f.EstadoPedidoId == (int)EstadoPedido.Cancelado),
                ValorEntregado = delMes.Where(f => f.EstadoPedidoId == (int)EstadoPedido.Entregado).Sum(f => f.Total)
            });
        }

        return reporte;
    }

    // ---------- CU-22 ----------

    public async Task<HistorialExportDto?> ObtenerHistorialAsync(int usuarioNegocioId, DateTime desde, DateTime hasta)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return null;

        var desdeUtc = InicioDiaUtc(desde);
        var hastaUtc = InicioDiaUtc(hasta.Date.AddDays(1));
        var entregado = (int)EstadoPedido.Entregado;
        var cancelado = (int)EstadoPedido.Cancelado;

        // RN-1-CU22: solo pedidos en estado Entregado o Cancelado
        var filas = await db.Pedidos.AsNoTracking()
            .Where(p => p.NegocioId == negocio.Id
                        && p.FechaCreacion >= desdeUtc && p.FechaCreacion < hastaUtc
                        && (p.EstadoPedidoId == entregado || p.EstadoPedidoId == cancelado))
            .OrderByDescending(p => p.FechaCreacion)
            .Select(p => new
            {
                p.Codigo,
                p.ClienteId,
                p.FechaCreacion,
                p.EstadoPedidoId,
                Cliente = p.Cliente != null ? p.Cliente.NombreCompleto : null,
                Repartidor = p.Repartidor != null ? p.Repartidor.NombreCompleto : null,
                Total = p.Items.Sum(i => i.Cantidad * i.PrecioUnitario)
            })
            .ToListAsync();

        return new HistorialExportDto
        {
            NombreNegocio = negocio.Nombre,
            Desde = desde.Date,
            Hasta = hasta.Date,
            GeneradoEn = DateTime.Now,
            Filas = filas.Select(f => new FilaPedidoReporte
            {
                Codigo = f.Codigo,
                Cliente = f.Cliente ?? $"Cliente #{f.ClienteId}",
                Fecha = ALocal(f.FechaCreacion),
                Estado = EstadoPedidoInfo.Nombre(f.EstadoPedidoId),
                Repartidor = f.Repartidor ?? "Sin asignar",
                ValorTotal = f.Total
            }).ToList()
        };
    }

    // ---------- Reporte del administrador ----------

    public async Task<ReporteAdminDto> GenerarReporteAdminAsync(DateTime desde, DateTime hasta)
    {
        var desdeUtc = InicioDiaUtc(desde);
        var hastaUtc = InicioDiaUtc(hasta.Date.AddDays(1));

        // Negocios que ingresaron a la plataforma en el rango
        var negociosRango = await db.Negocios.AsNoTracking()
            .Where(n => n.FechaRegistro >= desdeUtc && n.FechaRegistro < hastaUtc)
            .OrderByDescending(n => n.FechaRegistro)
            .Select(n => new
            {
                n.Nombre,
                n.TipoActividad,
                Documento = n.Usuario!.Documento,
                Correo = n.Usuario.Correo,
                n.FechaRegistro,
                Estado = n.Usuario.Estado
            })
            .ToListAsync();

        var activosTotal = await db.Negocios.CountAsync(n => n.Usuario!.Estado == EstadoCuenta.Activo);
        var repartidores = await db.Repartidores
            .CountAsync(r => r.FechaRegistro >= desdeUtc && r.FechaRegistro < hastaUtc);

        // Pedidos de toda la plataforma en el rango
        var pedidos = await db.Pedidos.AsNoTracking()
            .Where(p => p.FechaCreacion >= desdeUtc && p.FechaCreacion < hastaUtc)
            .Select(p => new
            {
                p.NegocioId,
                p.EstadoPedidoId,
                Total = p.Items.Sum(i => i.Cantidad * i.PrecioUnitario)
            })
            .ToListAsync();

        var entregadosPedidos = pedidos.Where(p => p.EstadoPedidoId == (int)EstadoPedido.Entregado).ToList();

        var reporte = new ReporteAdminDto
        {
            Desde = desde.Date,
            Hasta = hasta.Date,
            GeneradoEn = DateTime.Now,
            NegociosRegistrados = negociosRango.Count,
            NegociosActivosTotal = activosTotal,
            RepartidoresRegistrados = repartidores,
            TotalPedidos = pedidos.Count,
            PedidosEntregados = entregadosPedidos.Count,
            ValorEntregado = entregadosPedidos.Sum(p => p.Total),
            PedidosPorEstado = ContarPorEstado(pedidos.Select(p => p.EstadoPedidoId).ToList()),
            Negocios = negociosRango.Select(n => new FilaNegocioReporte
            {
                Nombre = n.Nombre,
                Actividad = n.TipoActividad,
                Documento = n.Documento,
                Correo = n.Correo,
                FechaRegistro = ALocal(n.FechaRegistro),
                Estado = EstadoPedidoInfo.NombreCuenta(n.Estado)
            }).ToList()
        };

        // Negocios nuevos por mes
        var fechasLocales = negociosRango.Select(n => ALocal(n.FechaRegistro)).ToList();
        foreach (var mes in MesesDelRango(desde, hasta))
        {
            reporte.NegociosPorMes.Add(new FilaMesReporte
            {
                Mes = NombreMes(mes),
                Total = fechasLocales.Count(f => f.Year == mes.Year && f.Month == mes.Month)
            });
        }

        // Negocios nuevos por estado de cuenta actual
        reporte.NegociosPorEstado = Enum.GetValues<EstadoCuenta>()
            .Select(e =>
            {
                var cantidad = negociosRango.Count(n => n.Estado == e);
                return new FilaConteoReporte
                {
                    Etiqueta = EstadoPedidoInfo.NombreCuenta(e),
                    Color = EstadoPedidoInfo.ColorCuenta(e),
                    Cantidad = cantidad,
                    Porcentaje = Pct(cantidad, negociosRango.Count)
                };
            })
            .Where(f => f.Cantidad > 0)
            .ToList();

        // Negocios nuevos por tipo de actividad
        reporte.NegociosPorActividad = negociosRango
            .GroupBy(n => string.IsNullOrWhiteSpace(n.TipoActividad) ? "Sin actividad" : n.TipoActividad)
            .OrderByDescending(g => g.Count())
            .ThenBy(g => g.Key)
            .Select((g, i) => new FilaConteoReporte
            {
                Etiqueta = g.Key,
                Color = Paleta[i % Paleta.Length],
                Cantidad = g.Count(),
                Porcentaje = Pct(g.Count(), negociosRango.Count)
            })
            .ToList();

        // Top 10 negocios con más pedidos en el rango
        var top = pedidos
            .GroupBy(p => p.NegocioId)
            .Select(g => new
            {
                NegocioId = g.Key,
                Pedidos = g.Count(),
                Entregados = g.Count(p => p.EstadoPedidoId == (int)EstadoPedido.Entregado),
                Valor = g.Where(p => p.EstadoPedidoId == (int)EstadoPedido.Entregado).Sum(p => p.Total)
            })
            .OrderByDescending(x => x.Pedidos)
            .ThenBy(x => x.NegocioId)
            .Take(10)
            .ToList();

        if (top.Count > 0)
        {
            var ids = top.Select(t => t.NegocioId).ToList();
            var nombres = await db.Negocios.AsNoTracking()
                .Where(n => ids.Contains(n.Id))
                .ToDictionaryAsync(n => n.Id, n => n.Nombre);

            reporte.TopNegocios = top.Select(t => new FilaTopNegocioReporte
            {
                Nombre = nombres.GetValueOrDefault(t.NegocioId, $"Negocio #{t.NegocioId}"),
                Pedidos = t.Pedidos,
                Entregados = t.Entregados,
                ValorEntregado = t.Valor
            }).ToList();
        }

        return reporte;
    }
}
