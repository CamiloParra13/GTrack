namespace Gtrack.Tests;

// CU-24 reporte del negocio, CU-22 historial y reporte del administrador
public class ReporteServiceTests
{
    private sealed class Escenario
    {
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public ReporteService Servicio => new(Contexto, Negocios);

        // Rango que incluye "ahora" sin importar la zona horaria del equipo
        public DateTime Desde { get; } = DateTime.Today.AddDays(-1);
        public DateTime Hasta { get; } = DateTime.Today.AddDays(1);

        public Escenario ConNegocio(int id = 10, int usuarioId = 1, string nombre = "Comidas Rápidas")
        {
            Negocios.Negocios.Add(new Negocio { Id = id, UsuarioId = usuarioId, Nombre = nombre });
            return this;
        }

        // Todo pedido tiene cliente: ClienteId es obligatorio en el modelo (igual que la llave foránea en SQL Server)
        public void AgregarPedido(int id, int negocioId, EstadoPedido estado, decimal precio,
            string cliente = "Ana Pérez", string? repartidor = null, DateTime? fecha = null)
        {
            var pedido = new Pedido
            {
                Id = id,
                Codigo = $"PED{id:00000}",
                NegocioId = negocioId,
                ClienteId = id,
                EstadoPedidoId = (int)estado,
                FechaCreacion = fecha ?? DateTime.UtcNow,
                Items = [new ItemPedido { Descripcion = "Producto", Cantidad = 2, PrecioUnitario = precio }],
                Cliente = new Cliente { Id = id, NombreCompleto = cliente, Telefono = "3001234567", NegocioId = negocioId }
            };
            if (repartidor is not null)
                pedido.Repartidor = new Repartidor { Id = 100 + id, UsuarioId = 100 + id, NegocioId = negocioId, NombreCompleto = repartidor };

            Contexto.Pedidos.Add(pedido);
        }

        public Task GuardarAsync() => Contexto.SaveChangesAsync();
    }

    // ===== RangoReporte =====

    [Fact]
    public void RangoReporte_FechasValidas_RetornaNull()
    {
        Assert.Null(RangoReporte.Validar(new DateTime(2026, 1, 1), new DateTime(2026, 6, 30)));
    }

    [Fact]
    public void RangoReporte_FaltaUnaFecha_RetornaMensaje()
    {
        Assert.Equal(RangoReporte.MensajeInvalido, RangoReporte.Validar(null, new DateTime(2026, 6, 30)));
        Assert.Equal(RangoReporte.MensajeInvalido, RangoReporte.Validar(new DateTime(2026, 6, 30), null));
    }

    [Fact]
    public void RangoReporte_DesdeMayorQueHasta_RetornaMensaje()
    {
        Assert.Equal(RangoReporte.MensajeInvalido, RangoReporte.Validar(new DateTime(2026, 6, 30), new DateTime(2026, 1, 1)));
    }

    [Fact]
    public void RangoReporte_MasDeDoceMeses_RetornaMensaje()
    {
        Assert.Equal(RangoReporte.MensajeInvalido, RangoReporte.Validar(new DateTime(2025, 1, 1), new DateTime(2026, 1, 1)));
    }

    // ===== CU-24 =====

    [Fact]
    public async Task GenerarReporteNegocio_NegocioNoExiste_RetornaNull()
    {
        var e = new Escenario();

        Assert.Null(await e.Servicio.GenerarReporteNegocioAsync(1, e.Desde, e.Hasta));
    }

    [Fact]
    public async Task GenerarReporteNegocio_SinPedidos_RetornaReporteVacio()
    {
        var e = new Escenario().ConNegocio();

        var reporte = await e.Servicio.GenerarReporteNegocioAsync(1, e.Desde, e.Hasta);

        Assert.NotNull(reporte);
        Assert.Equal("Comidas Rápidas", reporte.NombreNegocio);
        Assert.Equal(0, reporte.TotalPedidos);
        Assert.Equal(0m, reporte.TasaEntrega);
        Assert.Empty(reporte.Pedidos);
        Assert.NotEmpty(reporte.PorMes);
        Assert.All(reporte.PorEstado, f => Assert.Equal(0, f.Cantidad));
    }

    [Fact]
    public async Task GenerarReporteNegocio_ConPedidos_CalculaIndicadores()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(1, 10, EstadoPedido.Entregado, 10000m, repartidor: "Juan Gómez");
        e.AgregarPedido(2, 10, EstadoPedido.Entregado, 5000m);
        e.AgregarPedido(3, 10, EstadoPedido.Cancelado, 7000m);
        e.AgregarPedido(4, 10, EstadoPedido.Recibido, 3000m, cliente: "Luis Rojas");
        e.AgregarPedido(5, 99, EstadoPedido.Entregado, 50000m);   // de otro negocio
        await e.GuardarAsync();

        var reporte = await e.Servicio.GenerarReporteNegocioAsync(1, e.Desde, e.Hasta);

        Assert.NotNull(reporte);
        Assert.Equal(4, reporte.TotalPedidos);
        Assert.Equal(2, reporte.Entregados);
        Assert.Equal(1, reporte.Cancelados);
        Assert.Equal(50m, reporte.TasaEntrega);
        Assert.Equal(30000m, reporte.ValorEntregado);   // (10000 + 5000) x 2 unidades
        Assert.Equal(2, reporte.PorEstado.Single(f => f.EstadoId == (int)EstadoPedido.Entregado).Cantidad);
        Assert.Equal(4, reporte.PorMes.Sum(m => m.Total));
        Assert.Contains(reporte.Pedidos, p => p.Repartidor == "Juan Gómez");
        Assert.Contains(reporte.Pedidos, p => p.Repartidor == "Sin asignar");
        Assert.Contains(reporte.Pedidos, p => p.Cliente == "Luis Rojas");
    }

    [Fact]
    public async Task GenerarReporteNegocio_PedidoFueraDelRango_NoSeCuenta()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(1, 10, EstadoPedido.Entregado, 10000m, fecha: DateTime.UtcNow.AddDays(-40));
        await e.GuardarAsync();

        var reporte = await e.Servicio.GenerarReporteNegocioAsync(1, e.Desde, e.Hasta);

        Assert.NotNull(reporte);
        Assert.Equal(0, reporte.TotalPedidos);
    }

    // ===== CU-22 =====

    [Fact]
    public async Task ObtenerHistorial_NegocioNoExiste_RetornaNull()
    {
        var e = new Escenario();

        Assert.Null(await e.Servicio.ObtenerHistorialAsync(1, e.Desde, e.Hasta));
    }

    [Fact]
    public async Task ObtenerHistorial_SoloIncluyePedidosEntregadosOCancelados()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(1, 10, EstadoPedido.Entregado, 10000m, repartidor: "Juan Gómez");
        e.AgregarPedido(2, 10, EstadoPedido.Cancelado, 5000m, cliente: "Luis Rojas");
        e.AgregarPedido(3, 10, EstadoPedido.EnCamino, 7000m);
        await e.GuardarAsync();

        var historial = await e.Servicio.ObtenerHistorialAsync(1, e.Desde, e.Hasta);

        Assert.NotNull(historial);
        Assert.Equal("Comidas Rápidas", historial.NombreNegocio);
        Assert.Equal(2, historial.Filas.Count);
        Assert.DoesNotContain(historial.Filas, f => f.Codigo == "PED00003");
        Assert.Contains(historial.Filas, f => f.Cliente == "Luis Rojas" && f.Repartidor == "Sin asignar");
        Assert.Contains(historial.Filas, f => f.Repartidor == "Juan Gómez" && f.ValorTotal == 20000m);
    }

    // ===== Reporte del administrador =====

    [Fact]
    public async Task GenerarReporteAdmin_SinDatos_RetornaReporteVacio()
    {
        var e = new Escenario();

        var reporte = await e.Servicio.GenerarReporteAdminAsync(e.Desde, e.Hasta);

        Assert.Equal(0, reporte.NegociosRegistrados);
        Assert.Equal(0, reporte.TotalPedidos);
        Assert.Empty(reporte.TopNegocios);
        Assert.Empty(reporte.NegociosPorEstado);
        Assert.Empty(reporte.NegociosPorActividad);
        Assert.NotEmpty(reporte.NegociosPorMes);
    }

    [Fact]
    public async Task GenerarReporteAdmin_ConDatos_AgrupaNegociosYPedidos()
    {
        var e = new Escenario();
        e.Contexto.Usuarios.AddRange(
            new Usuario { Id = 1, Correo = "a@gtrack.local", Documento = "111", Rol = RolUsuario.Negocio, Estado = EstadoCuenta.Activo },
            new Usuario { Id = 2, Correo = "b@gtrack.local", Documento = "222", Rol = RolUsuario.Negocio, Estado = EstadoCuenta.PendienteValidacion },
            new Usuario { Id = 3, Correo = "c@gtrack.local", Documento = "333", Rol = RolUsuario.Negocio, Estado = EstadoCuenta.Activo });
        e.Contexto.Negocios.AddRange(
            new Negocio { Id = 10, UsuarioId = 1, Nombre = "Comidas Rápidas", TipoActividad = "Restaurante" },
            new Negocio { Id = 11, UsuarioId = 2, Nombre = "Floristería Sol", TipoActividad = "" },
            new Negocio
            {
                Id = 12,
                UsuarioId = 3,
                Nombre = "Negocio Antiguo",
                TipoActividad = "Comercio",
                FechaRegistro = DateTime.UtcNow.AddDays(-60)
            });
        e.Contexto.Repartidores.Add(new Repartidor { Id = 50, UsuarioId = 50, NegocioId = 10, NombreCompleto = "Juan Gómez" });
        e.AgregarPedido(1, 10, EstadoPedido.Entregado, 10000m);
        e.AgregarPedido(2, 10, EstadoPedido.Cancelado, 5000m);
        e.AgregarPedido(3, 11, EstadoPedido.Entregado, 4000m);
        e.AgregarPedido(4, 77, EstadoPedido.Recibido, 1000m);   // negocio que no existe
        await e.GuardarAsync();

        var reporte = await e.Servicio.GenerarReporteAdminAsync(e.Desde, e.Hasta);

        Assert.Equal(2, reporte.NegociosRegistrados);           // el antiguo queda fuera del rango
        Assert.Equal(2, reporte.NegociosActivosTotal);
        Assert.Equal(4, reporte.TotalPedidos);
        Assert.Equal(2, reporte.PedidosEntregados);
        Assert.Equal(28000m, reporte.ValorEntregado);
        Assert.Contains(reporte.NegociosPorActividad, f => f.Etiqueta == "Sin actividad");
        Assert.Contains(reporte.NegociosPorActividad, f => f.Etiqueta == "Restaurante");
        Assert.Equal(2, reporte.NegociosPorEstado.Sum(f => f.Cantidad));
        Assert.Equal("Comidas Rápidas", reporte.TopNegocios[0].Nombre);
        Assert.Equal(2, reporte.TopNegocios[0].Pedidos);
        Assert.Contains(reporte.TopNegocios, t => t.Nombre == "Negocio #77");
        Assert.Equal(2, reporte.Negocios.Count);
    }
}
