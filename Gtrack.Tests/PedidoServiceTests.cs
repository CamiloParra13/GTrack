using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;

public class PedidoServiceTests
{
    private sealed class Escenario
    {
        public PedidoRepositoryFalso Pedidos { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public AppDbContext Contexto { get; set; } = ContextoFactory.Crear();
        public EmailServiceFalso Email { get; } = new();

        public PedidoService Servicio => new(Pedidos, Negocios, Contexto, Email, NullLogger<PedidoService>.Instance);


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

        // Pedido guardado en el contexto (lo usan CancelarPorCliente y RegistrarNovedad, que leen directo de la BD)
        public async Task AgregarPedidoEnContextoAsync(
            string codigo = "ABC12345", EstadoPedido estado = EstadoPedido.Recibido, int? repartidorId = null, int id = 1)
        {
            Contexto.Usuarios.Add(new Usuario { Id = 1, Correo = "n@gtrack.local", Documento = "100000", Rol = RolUsuario.Negocio });
            Contexto.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Mi Negocio" });
            Contexto.Set<Cliente>().Add(new Cliente { Id = 1, NombreCompleto = "Carlos", Telefono = "3001112233", NegocioId = 10 });
            Contexto.Pedidos.Add(new Pedido
            {
                Id = id,
                Codigo = codigo,
                NegocioId = 10,
                ClienteId = 1,
                EstadoPedidoId = (int)estado,
                RepartidorId = repartidorId
            });
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

    [Theory]
    [InlineData("nombre")]
    [InlineData("telefono")]
    [InlineData("direccion")]
    [InlineData("pago")]
    public async Task Registrar_FaltaUnCampoObligatorio_RetornaErrorYNoCreaNada(string campo)
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        switch (campo)
        {
            case "nombre": dto.ClienteNombre = "  "; break;
            case "telefono": dto.ClienteTelefono = ""; break;
            case "direccion": dto.DireccionEntrega = " "; break;
            case "pago": dto.MetodoPago = null; break;
        }

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.False(ok);
        Assert.Equal(PedidoService.MensajeCamposObligatorios, error);
        Assert.Null(codigo);
        Assert.Equal(0, await e.Contexto.Set<Cliente>().CountAsync());
        Assert.Empty(e.Pedidos.Pedidos);
    }

    [Theory]
    [InlineData(0, 1000)]
    [InlineData(1, 0)]
    public async Task Registrar_CantidadOPrecioInvalidos_RetornaError(int cantidad, decimal precio)
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Productos = [new ItemPedidoDto { Descripcion = "Pizza", Cantidad = cantidad, PrecioUnitario = precio }];

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.False(ok);
        Assert.Equal("La cantidad y el precio de cada producto deben ser mayores que cero", error);
    }

    [Fact]
    public async Task Registrar_FallaGuardarCliente_RetornaErrorYNoRegistraElPedido()
    {
        var e = new Escenario { Contexto = ContextoFactory.CrearQueFallaAlGuardar() }.ConNegocio();

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible registrar el pedido. Intenta nuevamente", error);
        Assert.Null(codigo);
        Assert.Empty(e.Pedidos.Pedidos);
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
        Assert.Equal("Un pedido no puede saltarse estados: de \"Recibido\" primero debe pasar a \"En preparación\"", error);
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
    public async Task ActualizarEstado_NegocioRetrocedeDeEstado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Contains("no puede volver a un estado anterior", error);
    }

    [Fact]
    public async Task ActualizarEstado_EstadoInexistente_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, 99);

        Assert.False(ok);
        Assert.Equal("El estado seleccionado no es válido", error);
    }

    // El guardado del estado usa ExecuteUpdateAsync, que EF InMemory no soporta (en SQL Server real sí).
    // Por eso estas pruebas verifican que el cambio PASA todas las validaciones y llega al guardado:
    // el único error posible es el de la base de datos, nunca uno de regla de negocio.
    private const string ErrorDeGuardado = "No fue posible actualizar el estado del pedido. Intenta nuevamente";

    [Theory]
    [InlineData(EstadoPedido.Recibido, EstadoPedido.EnPreparacion, null, null)]
    [InlineData(EstadoPedido.EnPreparacion, EstadoPedido.ListoParaEntrega, null, null)]
    [InlineData(EstadoPedido.ListoParaEntrega, EstadoPedido.Asignado, 5, null)]   // repartidor elegido
    [InlineData(EstadoPedido.Asignado, EstadoPedido.EnCamino, null, 5)]            // el pedido ya tenía repartidor
    [InlineData(EstadoPedido.Asignado, EstadoPedido.Asignado, 6, 5)]               // cambio de repartidor
    [InlineData(EstadoPedido.Recibido, EstadoPedido.Cancelado, null, null)]        // cancelar siempre se permite
    public async Task ActualizarEstado_NegocioCambioPermitido_LlegaAlGuardado(
        EstadoPedido actual, EstadoPedido nuevo, int? repartidorElegido, int? repartidorDelPedido)
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(actual, repartidorId: repartidorDelPedido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)nuevo, repartidorElegido);

        Assert.False(ok);
        Assert.Equal(ErrorDeGuardado, error);
    }

    // ===== Regla de estados (ValidarCambioEstado) =====

    [Theory]
    [InlineData(0, 1)]
    [InlineData(1, 2)]
    [InlineData(2, 3)]
    [InlineData(3, 4)]
    [InlineData(4, 5)]
    [InlineData(3, 3)]   // mismo estado (cambiar repartidor)
    [InlineData(0, 6)]   // cancelar
    [InlineData(4, 6)]
    public void ValidarCambioEstado_CambioPermitido_RetornaNull(int actual, int nuevo)
    {
        Assert.Null(PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    [Theory]
    [InlineData(0, 2)]
    [InlineData(1, 4)]
    [InlineData(2, 5)]
    public void ValidarCambioEstado_SaltarseEstados_RetornaError(int actual, int nuevo)
    {
        Assert.Contains("no puede saltarse estados", PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    [Theory]
    [InlineData(3, 1)]
    [InlineData(4, 0)]
    public void ValidarCambioEstado_Retroceder_RetornaError(int actual, int nuevo)
    {
        Assert.Contains("no puede volver a un estado anterior", PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    [Theory]
    [InlineData(0, -1)]
    [InlineData(0, 7)]
    public void ValidarCambioEstado_EstadoFueraDeRango_RetornaError(int actual, int nuevo)
    {
        Assert.Equal("El estado seleccionado no es válido", PedidoService.ValidarCambioEstado(actual, nuevo));
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

    // Igual que arriba: ExecuteUpdateAsync no existe en InMemory, así que se comprueba que la transición
    // pasa la validación y llega al guardado.
    [Theory]
    [InlineData(EstadoPedido.Asignado, EstadoPedido.EnCamino)]
    [InlineData(EstadoPedido.EnCamino, EstadoPedido.Entregado)]
    public async Task ActualizarEstado_RepartidorTransicionValida_LlegaAlGuardado(EstadoPedido actual, EstadoPedido nuevo)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(actual, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)nuevo);

        Assert.False(ok);
        Assert.Equal(ErrorDeGuardado, error);
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

    // ===== CU-17: cancelar pedido (cliente) =====

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("ABC")]
    [InlineData("ABC-1234")]
    public async Task Cancelar_CodigoConFormatoInvalido_RetornaCodigoNoEncontrado(string? codigo)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync(codigo, "Me equivoqué");

        Assert.False(ok);
        Assert.Equal(PedidoService.MensajeCodigoNoEncontrado, error);
    }

    [Theory]
    [InlineData(null)]
    [InlineData("   ")]
    public async Task Cancelar_SinMotivo_RetornaError(string? motivo)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", motivo);

        Assert.False(ok);
        Assert.Equal("Escribe el motivo de la cancelación", error);
    }

    [Fact]
    public async Task Cancelar_MotivoDemasiadoLargo_RetornaError()
    {
        var e = new Escenario();
        var motivo = new string('a', PedidoService.MaxCaracteresMotivo + 1);

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", motivo);

        Assert.False(ok);
        Assert.Equal($"El motivo puede tener máximo {PedidoService.MaxCaracteresMotivo} caracteres", error);
    }

    [Fact]
    public async Task Cancelar_PedidoNoExiste_RetornaCodigoNoEncontrado()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("abc12345", "Me equivoqué");

        Assert.False(ok);
        Assert.Equal(PedidoService.MensajeCodigoNoEncontrado, error);
    }

    [Fact]
    public async Task Cancelar_YaExisteSolicitud_RetornaError()
    {
        var e = new Escenario();
        await e.AgregarPedidoEnContextoAsync();
        e.Contexto.SolicitudesCancelacion.Add(new SolicitudCancelacion
        {
            PedidoId = 1,
            Motivo = "Antes",
            FechaSolicitud = DateTime.UtcNow
        });
        await e.Contexto.SaveChangesAsync();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", "Otra vez");

        Assert.False(ok);
        Assert.Equal("Ya existe una solicitud de cancelación para este pedido", error);
    }

    [Theory]
    [InlineData(EstadoPedido.EnCamino)]
    [InlineData(EstadoPedido.Entregado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task Cancelar_PedidoYaNoCancelable_RetornaError(EstadoPedido estado)
    {
        var e = new Escenario();
        await e.AgregarPedidoEnContextoAsync(estado: estado);

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", "Me equivoqué");

        Assert.False(ok);
        Assert.Equal("Este pedido ya no puede ser cancelado", error);
    }

    [Fact]
    public async Task Cancelar_PedidoCancelable_LlegaAlGuardado()
    {
        // La cancelación usa transacción y ExecuteUpdateAsync, que EF InMemory no soporta:
        // se comprueba que pasa todas las validaciones y llega al guardado.
        var e = new Escenario();
        await e.AgregarPedidoEnContextoAsync(estado: EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", "Me equivoqué");

        Assert.False(ok);
        Assert.Equal("No fue posible cancelar el pedido. Intenta nuevamente", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Recibido, true)]
    [InlineData(EstadoPedido.EnPreparacion, true)]
    [InlineData(EstadoPedido.ListoParaEntrega, true)]
    [InlineData(EstadoPedido.Asignado, true)]
    [InlineData(EstadoPedido.EnCamino, false)]
    [InlineData(EstadoPedido.Entregado, false)]
    [InlineData(EstadoPedido.Cancelado, false)]
    public void EsCancelablePorCliente_SegunElEstado(EstadoPedido estado, bool esperado)
    {
        Assert.Equal(esperado, PedidoService.EsCancelablePorCliente((int)estado));
    }

    // ===== CU-16: novedad de pedido (repartidor) =====

    private static readonly int TipoNovedadValido = (int)Enum.GetValues<TipoNovedad>().First();

    [Theory]
    [InlineData(null)]
    [InlineData(999)]
    public async Task Novedad_TipoInvalido_RetornaError(int? tipo)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, tipo, null);

        Assert.False(ok);
        Assert.Equal("Debes seleccionar un tipo de novedad", error);
    }

    [Fact]
    public async Task Novedad_ObservacionesDemasiadoLargas_RetornaError()
    {
        var e = new Escenario();
        var texto = new string('a', PedidoService.MaxCaracteresObservaciones + 1);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, texto);

        Assert.False(ok);
        Assert.Equal($"Las observaciones pueden tener máximo {PedidoService.MaxCaracteresObservaciones} caracteres", error);
    }

    [Fact]
    public async Task Novedad_SinPerfilDeRepartidor_RetornaError()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, null);

        Assert.False(ok);
        Assert.Equal("No se encontró el perfil de repartidor para tu cuenta.", error);
    }

    [Fact]
    public async Task Novedad_PedidoNoAsignadoAlRepartidor_RetornaError()
    {
        var e = new Escenario();
        await e.AgregarRepartidorAsync();
        await e.AgregarPedidoEnContextoAsync(repartidorId: 77);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, null);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no está asignado a tu cuenta.", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Entregado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task Novedad_PedidoFinalizado_RetornaError(EstadoPedido estado)
    {
        var e = new Escenario();
        await e.AgregarRepartidorAsync();
        await e.AgregarPedidoEnContextoAsync(estado: estado, repartidorId: 5);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, null);

        Assert.False(ok);
        Assert.Equal("No se pueden reportar novedades sobre este pedido", error);
    }

    [Theory]
    [InlineData(" Llanta ponchada ", "Llanta ponchada")]
    [InlineData("   ", null)]
    [InlineData(null, null)]
    public async Task Novedad_PedidoActivo_RegistraLaNovedadSinCambiarElEstado(string? observaciones, string? guardada)
    {
        var e = new Escenario();
        await e.AgregarRepartidorAsync();
        await e.AgregarPedidoEnContextoAsync(estado: EstadoPedido.EnCamino, repartidorId: 5);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, observaciones);

        Assert.True(ok);
        Assert.Null(error);
        var novedad = await e.Contexto.NovedadesPedido.SingleAsync();
        Assert.Equal(1, novedad.PedidoId);
        Assert.Equal(guardada, novedad.Observaciones);
        var pedido = await e.Contexto.Pedidos.AsNoTracking().SingleAsync();
        Assert.Equal((int)EstadoPedido.EnCamino, pedido.EstadoPedidoId);
    }
}