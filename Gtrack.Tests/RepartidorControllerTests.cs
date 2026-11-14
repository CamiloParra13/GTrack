using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;

public class RepartidorControllerTests
{
    private sealed class Escenario
    {
        public RepartidorRepositoryFalso Repartidores { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public IPedidoService Pedidos { get; } = Substitute.For<IPedidoService>();
        public IUbicacionService Ubicaciones { get; } = Substitute.For<IUbicacionService>();
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();
        public RepartidorController Controlador { get; }

        public Escenario(int usuarioId = 1, string rol = "Negocio")
        {
            Controlador = new RepartidorController(
                Repartidores, Negocios, Substitute.For<IWebHostEnvironment>(), Contexto,
                Pedidos, Ubicaciones, NullLogger<RepartidorController>.Instance)
                .Preparar(usuarioId: usuarioId, rol: rol);
        }

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
            return this;
        }

        public async Task AgregarRepartidorAsync(
            int repartidorId = 5, int usuarioId = 2, int negocioId = 10, EstadoCuenta estado = EstadoCuenta.Activo)
        {
            Contexto.Usuarios.Add(new Usuario
            {
                Id = usuarioId,
                Correo = $"u{usuarioId}@gtrack.local",
                Documento = $"{usuarioId}00000",
                Rol = RolUsuario.Repartidor,
                Estado = estado
            });
            Contexto.Repartidores.Add(new Repartidor { Id = repartidorId, UsuarioId = usuarioId, NegocioId = negocioId });
            await Contexto.SaveChangesAsync();
        }
    }

    private static Task<(bool Ok, string? Error)> Res(bool ok, string? error = null) =>
        Task.FromResult((ok, error));

    private static RegistroRepartidorDto Dto() => new()
    {
        NombreCompleto = "Juan Pérez",
        Documento = "987654",
        Telefono = "3101234567",
        Correo = "juan@gtrack.local",
        Vehiculo = TipoVehiculo.Moto,
        Placa = "ABC12D"
    };

    // ===== Index =====

    [Fact]
    public async Task Index_SinNegocio_RetornaListaVacia()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index());

        Assert.Empty(Assert.IsType<List<Repartidor>>(vista.Model));
    }

    [Fact]
    public async Task Index_ConNegocio_RetornaSusRepartidores()
    {
        var e = new Escenario().ConNegocio();
        e.Repartidores.Repartidores.Add(new Repartidor { Id = 1, NegocioId = 10 });
        e.Repartidores.Repartidores.Add(new Repartidor { Id = 2, NegocioId = 99 });

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index());

        Assert.Single(Assert.IsType<List<Repartidor>>(vista.Model));
    }

    // ===== Registrar =====

    [Fact]
    public void Registrar_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<RegistroRepartidorDto>(Assert.IsType<ViewResult>(e.Controlador.Registrar()).Model);
    }

    [Fact]
    public async Task Registrar_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario().ConNegocio();
        e.Controlador.ModelState.AddModelError("Correo", "Correo no válido");

        Assert.IsType<ViewResult>(await e.Controlador.Registrar(Dto()));
        Assert.Equal(0, await e.Contexto.Repartidores.CountAsync());
    }

    [Fact]
    public async Task Registrar_Post_CorreoYaExiste_MuestraErrorEnElCampo()
    {
        var e = new Escenario().ConNegocio();
        e.Contexto.Usuarios.Add(new Usuario { Id = 9, Correo = "juan@gtrack.local", Documento = "111111" });
        await e.Contexto.SaveChangesAsync();

        var r = await e.Controlador.Registrar(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState["Correo"]!.Errors,
            err => err.ErrorMessage == "Este correo electrónico ya se encuentra registrado.");
    }

    [Fact]
    public async Task Registrar_Post_DocumentoYaExiste_MuestraErrorEnElCampo()
    {
        var e = new Escenario().ConNegocio();
        e.Contexto.Usuarios.Add(new Usuario { Id = 9, Correo = "otro@gtrack.local", Documento = "987654" });
        await e.Contexto.SaveChangesAsync();

        var r = await e.Controlador.Registrar(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState["Documento"]!.Errors,
            err => err.ErrorMessage == "Este número de documento ya se encuentra registrado.");
    }

    [Fact]
    public async Task Registrar_Post_NegocioNoExiste_RetornaNotFound()
    {
        var e = new Escenario();

        Assert.IsType<NotFoundResult>(await e.Controlador.Registrar(Dto()));
    }

    [Theory]
    [InlineData(null, TipoVehiculo.Moto)]            // sin vehículo se asume moto
    [InlineData(TipoVehiculo.Carro, TipoVehiculo.Carro)]
    public async Task Registrar_Post_Exitoso_CreaUsuarioYRepartidor(TipoVehiculo? vehiculo, TipoVehiculo esperado)
    {
        var e = new Escenario().ConNegocio();
        var dto = Dto();
        dto.Vehiculo = vehiculo;

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.Registrar(dto));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal("¡El repartidor ha sido registrado exitosamente!", e.Controlador.TempData["Mensaje"]);

        var usuario = await e.Contexto.Usuarios.SingleAsync();
        Assert.Equal(RolUsuario.Repartidor, usuario.Rol);
        Assert.Equal(EstadoCuenta.Activo, usuario.Estado);

        var repartidor = await e.Contexto.Repartidores.SingleAsync();
        Assert.Equal(10, repartidor.NegocioId);
        Assert.Equal(usuario.Id, repartidor.UsuarioId);
        Assert.Equal(esperado, repartidor.Vehiculo);
    }

    // ===== CambiarEstado =====

    [Fact]
    public async Task CambiarEstado_SinNegocio_RetornaNotFound()
    {
        var e = new Escenario();

        Assert.IsType<NotFoundResult>(await e.Controlador.CambiarEstado(5));
    }

    [Fact]
    public async Task CambiarEstado_RepartidorNoExiste_GuardaError()
    {
        var e = new Escenario().ConNegocio();

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.CambiarEstado(5));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal("El repartidor no existe o no pertenece a tu negocio.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task CambiarEstado_RepartidorDeOtroNegocio_GuardaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync(negocioId: 99);

        await e.Controlador.CambiarEstado(5);

        Assert.Equal("El repartidor no existe o no pertenece a tu negocio.", e.Controlador.TempData["Error"]);
    }

    [Theory]
    [InlineData(EstadoCuenta.Activo, EstadoCuenta.Suspendido)]
    [InlineData(EstadoCuenta.Suspendido, EstadoCuenta.Activo)]
    public async Task CambiarEstado_AlternaEntreActivoYSuspendido(EstadoCuenta inicial, EstadoCuenta esperado)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync(estado: inicial);

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.CambiarEstado(5));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal("El estado del repartidor ha sido actualizado correctamente.", e.Controlador.TempData["Mensaje"]);
        var usuario = await e.Contexto.Usuarios.AsNoTracking().SingleAsync();
        Assert.Equal(esperado, usuario.Estado);
    }

    // ===== MisPedidos =====

    [Fact]
    public async Task MisPedidos_SinPerfilDeRepartidor_GuardaErrorYRetornaListaVacia()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");

        var vista = Assert.IsType<ViewResult>(await e.Controlador.MisPedidos());

        Assert.Empty(Assert.IsType<List<Pedido>>(vista.Model));
        Assert.Equal("No se encontró el perfil de repartidor para tu cuenta.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task MisPedidos_RetornaSoloAsignadosYEnCamino_DelMasNuevoAlMasViejo()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        await e.AgregarRepartidorAsync();
        e.Contexto.Set<Cliente>().Add(new Cliente { Id = 1, NombreCompleto = "Cliente Prueba", Telefono = "3000000000", NegocioId = 10 });
        e.Contexto.Pedidos.AddRange(
            new Pedido { Id = 1, Codigo = "PED00001", ClienteId = 1, RepartidorId = 5, EstadoPedidoId = (int)EstadoPedido.Asignado, FechaCreacion = new DateTime(2026, 11, 1) },
            new Pedido { Id = 2, Codigo = "PED00002", ClienteId = 1, RepartidorId = 5, EstadoPedidoId = (int)EstadoPedido.EnCamino, FechaCreacion = new DateTime(2026, 11, 2) },
            new Pedido { Id = 3, Codigo = "PED00003", ClienteId = 1, RepartidorId = 5, EstadoPedidoId = (int)EstadoPedido.Entregado },
            new Pedido { Id = 4, Codigo = "PED00004", ClienteId = 1, RepartidorId = 99, EstadoPedidoId = (int)EstadoPedido.Asignado });
        await e.Contexto.SaveChangesAsync();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.MisPedidos());

        var pedidos = Assert.IsType<List<Pedido>>(vista.Model);
        Assert.Equal(new[] { 2, 1 }, pedidos.Select(p => p.Id));
    }

    [Fact]
    public async Task MisPedidos_FallaLaBaseDeDatos_RetornaVistaConModeloNulo()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Contexto.Dispose();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.MisPedidos());

        Assert.Null(vista.Model);
    }

    // ===== ActualizarEstado / IniciarEntrega / MarcarEntregado =====

    [Theory]
    [InlineData(EstadoPedido.Recibido)]
    [InlineData(EstadoPedido.Asignado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task ActualizarEstado_EstadoNoPermitido_GuardaErrorSinLlamarAlServicio(EstadoPedido estado)
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(10, (int)estado));

        Assert.Equal("MisPedidos", r.ActionName);
        Assert.Equal("Este pedido ya no se puede actualizar", e.Controlador.TempData["Error"]);
        await e.Pedidos.DidNotReceiveWithAnyArgs().ActualizarEstadoAsync(default, default, default, default);
    }

    [Fact]
    public async Task ActualizarEstado_ServicioFallaConMensaje_GuardaElMensaje()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, "Tu cuenta de repartidor se encuentra actualmente suspendida."));

        await e.Controlador.ActualizarEstado(10, (int)EstadoPedido.EnCamino);

        Assert.Equal("Tu cuenta de repartidor se encuentra actualmente suspendida.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task ActualizarEstado_ServicioFallaSinMensaje_GuardaMensajePorDefecto()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, null));

        await e.Controlador.ActualizarEstado(10, (int)EstadoPedido.Entregado);

        Assert.Equal("Este pedido ya no se puede actualizar", e.Controlador.TempData["Error"]);
    }

    [Theory]
    [InlineData(EstadoPedido.EnCamino, "Entrega iniciada: el pedido ahora está en camino.")]
    [InlineData(EstadoPedido.Entregado, "Entrega registrada exitosamente")]
    public async Task ActualizarEstado_Exitoso_GuardaMensajeSegunElEstado(EstadoPedido estado, string mensaje)
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(10, (int)estado));

        Assert.Equal("MisPedidos", r.ActionName);
        Assert.Equal(mensaje, e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task ActualizarEstado_ElServicioLanzaExcepcion_GuardaErrorGeneral()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Task.FromException<(bool Ok, string? Error)>(new InvalidOperationException("fallo")));

        await e.Controlador.ActualizarEstado(10, (int)EstadoPedido.EnCamino);

        Assert.Equal("No fue posible actualizar el estado del pedido. Intenta nuevamente.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task IniciarEntrega_PideAlServicioPasarAEnCamino()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        await e.Controlador.IniciarEntrega(10);

        await e.Pedidos.Received(1).ActualizarEstadoAsync(2, 10, (int)EstadoPedido.EnCamino, null);
    }

    [Fact]
    public async Task MarcarEntregado_PideAlServicioPasarAEntregado()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        await e.Controlador.MarcarEntregado(10);

        await e.Pedidos.Received(1).ActualizarEstadoAsync(2, 10, (int)EstadoPedido.Entregado, null);
    }

    // ===== ActualizarUbicacion =====

    [Fact]
    public async Task ActualizarUbicacion_RetornaJsonConElResultadoDelServicio()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Ubicaciones.ActualizarAsync(2, 10, 4.7m, -74.1m).Returns(Res(true));

        var json = Assert.IsType<JsonResult>(await e.Controlador.ActualizarUbicacion(10, 4.7m, -74.1m)).AJson();

        Assert.Contains("\"ok\":true", json);
    }

    [Fact]
    public async Task ActualizarUbicacion_ServicioFalla_RetornaJsonConElError()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Ubicaciones.ActualizarAsync(2, 10, 4.7m, -74.1m).Returns(Res(false, "El pedido no se encuentra en camino."));

        var json = Assert.IsType<JsonResult>(await e.Controlador.ActualizarUbicacion(10, 4.7m, -74.1m)).AJson();

        Assert.Contains("\"ok\":false", json);
        Assert.Contains("El pedido no se encuentra en camino.", json);
    }
}