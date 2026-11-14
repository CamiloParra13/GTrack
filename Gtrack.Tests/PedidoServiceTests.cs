using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;

public class PedidoServiceTests
{
    private sealed class Escenario
    {
        public PedidoRepositoryFalso Pedidos { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public AppDbContext Contexto { get; set; } = ContextoFactory.Crear();

        public PedidoService Servicio => new(Pedidos, Negocios, Contexto, NullLogger<PedidoService>.Instance);

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Mi Negocio" });
            return this;
        }

        public Pedido AgregarPedido(EstadoPedido estado, int? repartidorId = null, int negocioId = 10, int id = 1)
        {
            var p = new Pedido
            {
                Id = id,
                Codigo = $"PED{id:00000}",
                NegocioId = negocioId,
                EstadoPedidoId = (int)estado,
                RepartidorId = repartidorId
            };
            Pedidos.Pedidos.Add(p);
            return p;
        }

        public async Task AgregarRepartidorAsync(int id = 5, int usuarioId = 2)
        {
            Contexto.Repartidores.Add(new Repartidor { Id = id, UsuarioId = usuarioId, NegocioId = 10 });
            await Contexto.SaveChangesAsync();
        }

        public async Task SuspenderAsync(int repartidorId = 5)
        {
            Contexto.SuspensionRepartidor.Add(new SuspensionRepartidor
            {
                RepartidorId = repartidorId,
                AdministradorId = 1,
                Motivo = "Prueba",
                FechaSuspension = DateTime.UtcNow
            });
            await Contexto.SaveChangesAsync();
        }
    }

    private static RegistrarPedidoDto DtoValido() => new()
    {
        ClienteNombre = "Carlos Ruiz",
        ClienteTelefono = "3001112233",
        DireccionEntrega = " Calle 5 # 6-7 ",
        MetodoPago = MetodoPago.Efectivo,
        Productos =
        [
            new ItemPedidoDto { Descripcion = " Pizza ", Cantidad = 2, PrecioUnitario = 15000m },
            new ItemPedidoDto { Descripcion = "   " }
        ]
    };

    // ===== BuscarClienteFrecuente =====

    [Fact]
    public async Task BuscarCliente_NegocioNoExiste_RetornaNull()
    {
        var e = new Escenario();

        Assert.Null(await e.Servicio.BuscarClienteFrecuenteAsync(1, "3001112233"));
    }

    [Fact]
    public async Task BuscarCliente_SinPedidosPrevios_RetornaNull()
    {
        var e = new Escenario().ConNegocio();

        Assert.Null(await e.Servicio.BuscarClienteFrecuenteAsync(1, "3001112233"));
    }

    [Fact]
    public async Task BuscarCliente_PedidoSinCliente_RetornaNull()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);

        Assert.Null(await e.Servicio.BuscarClienteFrecuenteAsync(1, "3001112233"));
    }

    [Fact]
    public async Task BuscarCliente_ConPedidoPrevio_RetornaNombreYDireccion()
    {
        var e = new Escenario().ConNegocio();
        var pedido = e.AgregarPedido(EstadoPedido.Entregado);
        pedido.DireccionEntrega = "Calle 9";
        pedido.Cliente = new Cliente { Telefono = "3001112233", NombreCompleto = "Carlos" };

        var dto = await e.Servicio.BuscarClienteFrecuenteAsync(1, " 3001112233 ");

        Assert.NotNull(dto);
        Assert.Equal("Carlos", dto!.Nombre);
        Assert.Equal("Calle 9", dto.Direccion);
    }

    // ===== RegistrarAsync =====

    [Fact]
    public async Task Registrar_NegocioNoExiste_RetornaError()
    {
        var e = new Escenario();

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible identificar tu negocio", error);
    }

    [Fact]
    public async Task Registrar_SinProductosValidos_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Productos = [new ItemPedidoDto { Descripcion = "  " }];

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.False(ok);
        Assert.Equal("Debes completar todos los campos obligatorios del pedido", error);
    }

    [Fact]
    public async Task Registrar_ClienteNuevo_CreaClienteYPedido()
    {
        var e = new Escenario().ConNegocio();

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(8, codigo!.Length);

        var cliente = await e.Contexto.Set<Cliente>().SingleAsync();
        Assert.Equal("Carlos Ruiz", cliente.NombreCompleto);

        var pedido = Assert.Single(e.Pedidos.Pedidos);
        Assert.Equal(codigo, pedido.Codigo);
        Assert.Equal(cliente.Id, pedido.ClienteId);
        Assert.Equal("Calle 5 # 6-7", pedido.DireccionEntrega);
        Assert.Equal((int)EstadoPedido.Recibido, pedido.EstadoPedidoId);
        Assert.Equal("Pizza", Assert.Single(pedido.Items).Descripcion);
    }

    [Fact]
    public async Task Registrar_ClienteExistente_ActualizaNombreYDireccion()
    {
        var e = new Escenario().ConNegocio();
        e.Contexto.Set<Cliente>().Add(new Cliente
        {
            Id = 7,
            Telefono = "3001112233",
            NombreCompleto = "Nombre viejo",
            DireccionPredeterminada = "Dirección vieja",
            NegocioId = 10
        });
        await e.Contexto.SaveChangesAsync();

        var (ok, _, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(ok);
        var cliente = await e.Contexto.Set<Cliente>().SingleAsync();
        Assert.Equal("Carlos Ruiz", cliente.NombreCompleto);
        Assert.Equal("Calle 5 # 6-7", cliente.DireccionPredeterminada);
        Assert.Equal(7, e.Pedidos.Pedidos[0].ClienteId);
    }

    [Fact]
    public async Task Registrar_SinTelefono_UsaClientePorDefectoSinCrearCliente()
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.ClienteTelefono = "";

        var (ok, _, _) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.True(ok);
        Assert.Equal(0, await e.Contexto.Set<Cliente>().CountAsync());
        Assert.Equal(1, e.Pedidos.Pedidos[0].ClienteId);
    }

    [Fact]
    public async Task Registrar_FallaGuardarCliente_ContinuaConClientePorDefecto()
    {
        var e = new Escenario { Contexto = ContextoFactory.CrearQueFallaAlGuardar() }.ConNegocio();

        var (ok, _, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(ok);
        Assert.Equal(1, e.Pedidos.Pedidos[0].ClienteId);
    }

    [Fact]
    public async Task Registrar_CodigoNuncaEsUnico_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Pedidos.CodigosSiempreExisten = true;

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible registrar el pedido. Intenta nuevamente", error);
        Assert.Null(codigo);
    }

    [Fact]
    public async Task Registrar_FallaAlGuardarPedido_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Pedidos.DebeFallarAlAgregar = true;

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible registrar el pedido. Intenta nuevamente", error);
    }

    // ===== ActualizarEstadoAsync: flujo del negocio =====

    [Fact]
    public async Task ActualizarEstado_PedidoNoExiste_RetornaError()
    {
        var e = new Escenario().ConNegocio();

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 99, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no pertenece a tu negocio", error);
    }

    [Fact]
    public async Task ActualizarEstado_PedidoDeOtroNegocio_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido, negocioId: 99);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no pertenece a tu negocio", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Entregado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task ActualizarEstado_PedidoFinalizado_NoSePuedeModificar(EstadoPedido estado)
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(estado);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("Este pedido ya se encuentra finalizado y no puede ser modificado.", error);
    }

    [Fact]
    public async Task ActualizarEstado_EntregadoSinHaberSidoAsignado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Entregado);

        Assert.False(ok);
        Assert.Equal("El pedido debe ser asignado y despachado antes de poder marcarse como entregado.", error);
    }

    [Fact]
    public async Task ActualizarEstado_AsignarSinRepartidor_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.ListoParaEntrega);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Asignado);

        Assert.False(ok);
        Assert.Equal("Debes seleccionar un repartidor antes de pasar el pedido a este estado.", error);
    }

    [Fact]
    public async Task ActualizarEstado_AsignarRepartidorSuspendido_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.ListoParaEntrega);
        await e.SuspenderAsync(5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Asignado, 5);

        Assert.False(ok);
        Assert.Contains("suspendido", error);
    }

    [Fact]
    public async Task ActualizarEstado_AsignarConRepartidorValido_GuardaRepartidorYEstado()
    {
        var e = new Escenario().ConNegocio();
        var pedido = e.AgregarPedido(EstadoPedido.ListoParaEntrega);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Asignado, 5);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(5, pedido.RepartidorId);
        Assert.Equal((int)EstadoPedido.Asignado, pedido.EstadoPedidoId);
    }

    [Fact]
    public async Task ActualizarEstado_PedidoYaTieneRepartidor_NoRequiereUnoNuevo()
    {
        var e = new Escenario().ConNegocio();
        var pedido = e.AgregarPedido(EstadoPedido.Asignado, repartidorId: 5);

        var (ok, _) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnCamino);

        Assert.True(ok);
        Assert.Equal((int)EstadoPedido.EnCamino, pedido.EstadoPedidoId);
    }

    [Fact]
    public async Task ActualizarEstado_EstadoSinRepartidor_ActualizaCorrectamente()
    {
        var e = new Escenario().ConNegocio();
        var pedido = e.AgregarPedido(EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal((int)EstadoPedido.EnPreparacion, pedido.EstadoPedidoId);
    }

    [Fact]
    public async Task ActualizarEstado_FallaAlGuardar_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);
        e.Pedidos.DebeFallarAlActualizar = true;

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("No fue posible actualizar el estado del pedido. Intenta nuevamente", error);
    }

    // ===== ActualizarEstadoAsync: flujo del repartidor =====

    [Fact]
    public async Task ActualizarEstado_UsuarioDesconocido_RetornaError()
    {
        var e = new Escenario().ConNegocio();

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(99, 1, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("No fue posible identificar tu negocio o usuario", error);
    }

    [Fact]
    public async Task ActualizarEstado_RepartidorSuspendido_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        await e.SuspenderAsync();

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("Tu cuenta de repartidor se encuentra actualmente suspendida.", error);
    }

    [Theory]
    [InlineData(99, 99)]  // el pedido no existe
    [InlineData(1, 77)]   // el pedido es de otro repartidor
    public async Task ActualizarEstado_RepartidorSinElPedidoAsignado_RetornaError(int pedidoId, int repartidorDelPedido)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: repartidorDelPedido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, pedidoId, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no está asignado a tu cuenta.", error);
    }

    [Fact]
    public async Task ActualizarEstado_RepartidorTransicionInvalida_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)EstadoPedido.Entregado);

        Assert.False(ok);
        Assert.Equal("Este pedido ya no se puede actualizar", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Asignado, EstadoPedido.EnCamino)]
    [InlineData(EstadoPedido.EnCamino, EstadoPedido.Entregado)]
    public async Task ActualizarEstado_RepartidorTransicionValida_Actualiza(EstadoPedido actual, EstadoPedido nuevo)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        var pedido = e.AgregarPedido(actual, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)nuevo);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal((int)nuevo, pedido.EstadoPedidoId);
    }

    [Fact]
    public async Task ActualizarEstado_RepartidorFallaAlGuardar_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: 5);
        e.Pedidos.DebeFallarAlActualizar = true;

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("No fue posible actualizar el estado del pedido. Intenta nuevamente", error);
    }

    // ===== Listados =====

    [Fact]
    public async Task Listados_NegocioNoExiste_RetornanVacio()
    {
        var e = new Escenario();

        Assert.Empty(await e.Servicio.ObtenerPedidosActivosAsync(1));
        Assert.Empty(await e.Servicio.ObtenerHistorialPedidosAsync(1));
    }

    [Fact]
    public async Task Listados_SeparanActivosDeHistorial()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido, id: 1);
        e.AgregarPedido(EstadoPedido.EnCamino, id: 2);
        e.AgregarPedido(EstadoPedido.Entregado, id: 3);
        e.AgregarPedido(EstadoPedido.Cancelado, id: 4);

        var activos = await e.Servicio.ObtenerPedidosActivosAsync(1);
        var historial = await e.Servicio.ObtenerHistorialPedidosAsync(1);

        Assert.Equal(2, activos.Count);
        Assert.All(activos, p => Assert.True(p.EstadoPedidoId < (int)EstadoPedido.Entregado));
        Assert.Equal(2, historial.Count);
        Assert.All(historial, p => Assert.True(p.EstadoPedidoId >= (int)EstadoPedido.Entregado));
    }
}