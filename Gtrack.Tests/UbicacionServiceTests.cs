using Microsoft.Extensions.Logging.Abstractions;

public class UbicacionServiceTests
{
    // Se pasa null en AppDbContext porque estas pruebas no llegan al paso que consulta
    // la tabla de repartidores (eso se prueba después con EF Core InMemory).
    private static UbicacionService Crear(PedidoRepositoryFalso pedidos, UbicacionRepositoryFalso ubicaciones) =>
        new(ubicaciones, pedidos, null!, NullLogger<UbicacionService>.Instance);

    private static Pedido PedidoEnEstado(EstadoPedido estado) => new()
    {
        Id = 1,
        Codigo = "ABC12345",
        EstadoPedidoId = (int)estado
    };

    // ===== ActualizarAsync =====

    [Theory]
    [InlineData(91, 0)]
    [InlineData(-91, 0)]
    [InlineData(0, 181)]
    [InlineData(0, -181)]
    public async Task Actualizar_CoordenadasFueraDeRango_RetornaError(int lat, int lng)
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error) = await servicio.ActualizarAsync(1, 1, lat, lng);

        Assert.False(ok);
        Assert.Contains("Coordenadas inválidas", error);
    }

    [Fact]
    public async Task Actualizar_PedidoNoExiste_RetornaError()
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error) = await servicio.ActualizarAsync(1, 99, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado.", error);
    }

    [Fact]
    public async Task Actualizar_PedidoNoEstaEnCamino_RetornaError()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.Asignado));
        var servicio = Crear(pedidos, new UbicacionRepositoryFalso());

        var (ok, error) = await servicio.ActualizarAsync(1, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no se encuentra en camino.", error);
    }

    // ===== ObtenerPorCodigoAsync =====

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    public async Task ObtenerPorCodigo_CodigoVacio_RetornaError(string codigo)
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error, _, _, _, _) = await servicio.ObtenerPorCodigoAsync(codigo);

        Assert.False(ok);
        Assert.Equal("El código del pedido es requerido.", error);
    }

    [Fact]
    public async Task ObtenerPorCodigo_PedidoNoExiste_RetornaError()
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error, _, _, _, _) = await servicio.ObtenerPorCodigoAsync("NOEXISTE");

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado.", error);
    }

    [Fact]
    public async Task ObtenerPorCodigo_PedidoNoEstaEnCamino_NoHayUbicacion()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.Entregado));
        var servicio = Crear(pedidos, new UbicacionRepositoryFalso());

        var (ok, error, lat, _, _, estado) = await servicio.ObtenerPorCodigoAsync("ABC12345");

        Assert.False(ok);
        Assert.Equal("No hay ubicación disponible para este pedido.", error);
        Assert.Null(lat);
        Assert.Equal("Entregado", estado);
    }

    [Fact]
    public async Task ObtenerPorCodigo_EnCaminoSinUbicacion_RetornaError()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.EnCamino));
        var servicio = Crear(pedidos, new UbicacionRepositoryFalso());

        var (ok, error, _, _, _, estado) = await servicio.ObtenerPorCodigoAsync("ABC12345");

        Assert.False(ok);
        Assert.Equal("No hay ubicación registrada para este pedido.", error);
        Assert.Equal("EnCamino", estado);
    }

    [Fact]
    public async Task ObtenerPorCodigo_EnCaminoConUbicacion_RetornaCoordenadas()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.EnCamino));
        var ubicaciones = new UbicacionRepositoryFalso();
        ubicaciones.Ubicaciones[1] = new UbicacionPedido
        {
            PedidoId = 1,
            Latitud = 4.7m,
            Longitud = -74.1m,
            FechaActualizacion = DateTime.UtcNow
        };
        var servicio = Crear(pedidos, ubicaciones);

        var (ok, error, lat, lng, fecha, estado) = await servicio.ObtenerPorCodigoAsync(" ABC12345 ");

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(4.7m, lat);
        Assert.Equal(-74.1m, lng);
        Assert.Equal(DateTimeKind.Utc, fecha!.Value.Kind);
        Assert.Equal("EnCamino", estado);
    }
}