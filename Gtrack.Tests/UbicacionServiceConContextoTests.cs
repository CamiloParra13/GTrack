using Microsoft.Extensions.Logging.Abstractions;

public class UbicacionServiceConContextoTests
{
    private sealed class Escenario
    {
        public PedidoRepositoryFalso Pedidos { get; } = new();
        public UbicacionRepositoryFalso Ubicaciones { get; } = new();
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();

        public UbicacionService Servicio => new(
            Ubicaciones, Pedidos, Contexto, NullLogger<UbicacionService>.Instance);

        public async Task PrepararAsync(bool conRepartidor = true, int repartidorDelPedido = 5)
        {
            if (conRepartidor)
            {
                Contexto.Repartidores.Add(new Repartidor { Id = 5, UsuarioId = 2, NegocioId = 10 });
                await Contexto.SaveChangesAsync();
            }

            Pedidos.Pedidos.Add(new Pedido
            {
                Id = 1,
                Codigo = "ABC12345",
                EstadoPedidoId = (int)EstadoPedido.EnCamino,
                RepartidorId = repartidorDelPedido
            });
        }
    }

    [Fact]
    public async Task Actualizar_RepartidorNoExiste_RetornaError()
    {
        var e = new Escenario();
        await e.PrepararAsync(conRepartidor: false);

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no pertenece al repartidor.", error);
    }

    [Fact]
    public async Task Actualizar_PedidoDeOtroRepartidor_RetornaError()
    {
        var e = new Escenario();
        await e.PrepararAsync(repartidorDelPedido: 99);

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no pertenece al repartidor.", error);
    }

    [Fact]
    public async Task Actualizar_DatosValidos_GuardaLaUbicacion()
    {
        var e = new Escenario();
        await e.PrepararAsync();

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(4.7m, e.Ubicaciones.Ubicaciones[1].Latitud);
        Assert.Equal(-74.1m, e.Ubicaciones.Ubicaciones[1].Longitud);
    }

    [Fact]
    public async Task Actualizar_UltimoGuardadoHaceMenosDeTresSegundos_IgnoraSinError()
    {
        var e = new Escenario();
        await e.PrepararAsync();
        e.Ubicaciones.Ubicaciones[1] = new UbicacionPedido
        {
            PedidoId = 1,
            Latitud = 1m,
            Longitud = 1m,
            FechaActualizacion = DateTime.UtcNow
        };

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(1m, e.Ubicaciones.Ubicaciones[1].Latitud);   // no se sobrescribió
    }

    [Fact]
    public async Task Actualizar_UltimoGuardadoHaceMasDeTresSegundos_ActualizaLaUbicacion()
    {
        var e = new Escenario();
        await e.PrepararAsync();
        e.Ubicaciones.Ubicaciones[1] = new UbicacionPedido
        {
            PedidoId = 1,
            Latitud = 1m,
            Longitud = 1m,
            FechaActualizacion = DateTime.UtcNow.AddSeconds(-10)
        };

        var (ok, _) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.True(ok);
        Assert.Equal(4.7m, e.Ubicaciones.Ubicaciones[1].Latitud);
    }

    [Fact]
    public async Task Actualizar_FallaAlGuardar_RetornaError()
    {
        var e = new Escenario();
        await e.PrepararAsync();
        e.Ubicaciones.DebeFallarAlGuardar = true;

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("No fue posible actualizar la ubicación.", error);
    }
}