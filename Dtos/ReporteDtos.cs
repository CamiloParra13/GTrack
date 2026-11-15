namespace Gtrack;

// ---------- Filas reutilizables ----------
public class FilaEstadoReporte
{
    public int EstadoId { get; set; }
    public string Estado { get; set; } = "";
    public string Color { get; set; } = "#6c757d";
    public int Cantidad { get; set; }
    public decimal Porcentaje { get; set; }
}

public class FilaMesReporte
{
    public string Mes { get; set; } = "";          // "Noviembre 2026"
    public int Total { get; set; }
    public int Entregados { get; set; }
    public int Cancelados { get; set; }
    public decimal ValorEntregado { get; set; }
}

public class FilaPedidoReporte
{
    public string Codigo { get; set; } = "";
    public string Cliente { get; set; } = "";
    public DateTime Fecha { get; set; }            // hora local
    public string Estado { get; set; } = "";
    public string Repartidor { get; set; } = "";
    public decimal ValorTotal { get; set; }
}

// ---------- CU-24 Reporte de pedidos del negocio ----------
public class ReporteNegocioDto
{
    public string NombreNegocio { get; set; } = "";
    public DateTime Desde { get; set; }
    public DateTime Hasta { get; set; }
    public DateTime GeneradoEn { get; set; }

    public int TotalPedidos { get; set; }
    public int Entregados { get; set; }
    public int Cancelados { get; set; }
    public decimal TasaEntrega { get; set; }       // % de entregados sobre el total
    public decimal ValorEntregado { get; set; }    // suma de pedidos entregados

    public List<FilaEstadoReporte> PorEstado { get; set; } = [];
    public List<FilaMesReporte> PorMes { get; set; } = [];
    public List<FilaPedidoReporte> Pedidos { get; set; } = [];
}

// ---------- CU-22 Exportar historial ----------
public class HistorialExportDto
{
    public string NombreNegocio { get; set; } = "";
    public DateTime Desde { get; set; }
    public DateTime Hasta { get; set; }
    public DateTime GeneradoEn { get; set; }
    public List<FilaPedidoReporte> Filas { get; set; } = [];
}

// ---------- Reporte del administrador ----------
public class FilaConteoReporte
{
    public string Etiqueta { get; set; } = "";
    public string Color { get; set; } = "#1f5eff";
    public int Cantidad { get; set; }
    public decimal Porcentaje { get; set; }
}

public class FilaNegocioReporte
{
    public string Nombre { get; set; } = "";
    public string Actividad { get; set; } = "";
    public string Documento { get; set; } = "";
    public string Correo { get; set; } = "";
    public DateTime FechaRegistro { get; set; }    // hora local
    public string Estado { get; set; } = "";
}

public class FilaTopNegocioReporte
{
    public string Nombre { get; set; } = "";
    public int Pedidos { get; set; }
    public int Entregados { get; set; }
    public decimal ValorEntregado { get; set; }
}

public class ReporteAdminDto
{
    public DateTime Desde { get; set; }
    public DateTime Hasta { get; set; }
    public DateTime GeneradoEn { get; set; }

    // Negocios que ingresaron a la plataforma dentro del rango
    public int NegociosRegistrados { get; set; }
    public int NegociosActivosTotal { get; set; }          // en toda la plataforma, a hoy
    public int RepartidoresRegistrados { get; set; }
    public int TotalPedidos { get; set; }
    public int PedidosEntregados { get; set; }
    public decimal ValorEntregado { get; set; }

    public List<FilaMesReporte> NegociosPorMes { get; set; } = [];   // solo usa Mes y Total
    public List<FilaConteoReporte> NegociosPorEstado { get; set; } = [];
    public List<FilaConteoReporte> NegociosPorActividad { get; set; } = [];
    public List<FilaEstadoReporte> PedidosPorEstado { get; set; } = [];
    public List<FilaTopNegocioReporte> TopNegocios { get; set; } = [];
    public List<FilaNegocioReporte> Negocios { get; set; } = [];
}

// ---------- Modelos de las vistas ----------
public class ReporteNegocioVista
{
    public DateTime Desde { get; set; }
    public DateTime Hasta { get; set; }
    public ReporteNegocioDto? Reporte { get; set; }
    public string? Error { get; set; }
    public string? Aviso { get; set; }
}

public class ReporteAdminVista
{
    public DateTime Desde { get; set; }
    public DateTime Hasta { get; set; }
    public ReporteAdminDto? Reporte { get; set; }
    public string? Error { get; set; }
    public string? Aviso { get; set; }
}

// Una barra de las gráficas que se dibujan en pantalla
public record BarraGrafica(string Etiqueta, int Cantidad, string Color);
