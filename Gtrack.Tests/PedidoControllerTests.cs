using Microsoft.AspNetCore.Mvc;
using NSubstitute;

namespace Gtrack.Tests;

using UbicacionResultado = (bool Ok, string? Error, decimal? Latitud, decimal? Longitud, System.DateTime? FechaUtc, string? Estado);

public class PedidoControllerTests
{
    private sealed class Escenario
    {
        public IPedidoService Pedidos { get; } = Substitute.For<IPedidoService>();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public IUbicacionService Ubicaciones { get; } = Substitute.For<IUbicacionService>();
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();
        public PedidoController Controlador { get; }

        public Escenario()
        {
            Controlador = new PedidoController(Pedidos, Negocios, Contexto, Ubicaciones)
                .Preparar(usuarioId: 1, rol: "Negocio");
        }

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
            return this;
        }
    }

    private static Task<(bool Ok, string? Error, string? Codigo)> Reg(bool ok, string? error, string? codigo) =>
        Task.FromResult((ok, error, codigo));

    private static Task<(bool Ok, string? Error)> Res(bool ok, string? error = null) =>
        Task.FromResult((ok, error));

    private static Task<UbicacionResultado> Ubi(bool ok, string? error, decimal? lat, decimal? lng, DateTime? fecha, string? estado) =>
        Task.FromResult<UbicacionResultado>((ok, error, lat, lng, fecha, estado));

    // ===== Registrar =====

    [Fact]
    public void Registrar_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<RegistrarPedidoDto>(Assert.IsType<ViewResult>(e.Controlador.Registrar()).Model);
    }

    [Fact]
    public async Task Registrar_Post_ModeloInvalido_RetornaVistaSinLlamarAlServicio()
    {
        var e = new Escenario();
        var dto = new RegistrarPedidoDto();
        e.Controlador.ModelState.AddModelError("DireccionEntrega", "Campo obligatorio");

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Registrar(dto));

        Assert.Same(dto, vista.Model);
        await e.Pedidos.DidNotReceive().RegistrarAsync(Arg.Any<int>(), Arg.Any<RegistrarPedidoDto>());
    }

    [Fact]
    public async Task Registrar_Post_ServicioFalla_MuestraElError()
    {
        var e = new Escenario();
        e.Pedidos.RegistrarAsync(1, Arg.Any<RegistrarPedidoDto>())
            .Returns(Reg(false, "No fue posible registrar el pedido. Intenta nuevamente", null));

        var r = await e.Controlador.Registrar(new RegistrarPedidoDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "No fue posible registrar el pedido. Intenta nuevamente");
    }

    [Fact]
    public async Task Registrar_Post_Exitoso_GuardaElCodigoYVaAActivos()
    {
        var e = new Escenario();
        e.Pedidos.RegistrarAsync(1, Arg.Any<RegistrarPedidoDto>()).Returns(Reg(true, null, "ABC12345"));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.Registrar(new RegistrarPedidoDto()));

        Assert.Equal("Activos", r.ActionName);
        Assert.Contains("ABC12345", (string)e.Controlador.TempData["Mensaje"]!);
    }

    // ===== BuscarCliente =====

    [Fact]
    public async Task BuscarCliente_RetornaJsonConElCliente()
    {
        var e = new Escenario();
        var cliente = new ClienteAutocompletarDto { Nombre = "Carlos", Direccion = "Calle 9" };
        e.Pedidos.BuscarClienteFrecuenteAsync(1, "3001112233").Returns(cliente);

        var json = Assert.IsType<JsonResult>(await e.Controlador.BuscarCliente("3001112233"));

        Assert.Same(cliente, json.Value);
    }

    [Fact]
    public async Task BuscarCliente_SinCoincidencia_RetornaJsonNulo()
    {
        var e = new Escenario();
        e.Pedidos.BuscarClienteFrecuenteAsync(1, "3000000000").Returns((ClienteAutocompletarDto?)null);

        var json = Assert.IsType<JsonResult>(await e.Controlador.BuscarCliente("3000000000"));

        Assert.Null(json.Value);
    }

    // ===== Activos e Historial =====

    [Fact]
    public async Task Activos_SinNegocio_RetornaPedidosYRepartidoresVacios()
    {
        var e = new Escenario();
        var lista = new List<Pedido>();
        e.Pedidos.ObtenerPedidosActivosAsync(1).Returns(lista);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Activos());

        Assert.Same(lista, vista.Model);
        Assert.Empty(Assert.IsType<List<Repartidor>>(vista.ViewData["Repartidores"]));
    }

    [Fact]
    public async Task Activos_ConNegocio_ListaSoloLosRepartidoresActivosDeSuNegocio()
    {
        var e = new Escenario().ConNegocio();
        e.Pedidos.ObtenerPedidosActivosAsync(1).Returns(new List<Pedido>());
        e.Contexto.Usuarios.AddRange(
            new Usuario { Id = 2, Correo = "a@gtrack.local", Documento = "200000", Rol = RolUsuario.Repartidor, Estado = EstadoCuenta.Activo },
            new Usuario { Id = 3, Correo = "b@gtrack.local", Documento = "300000", Rol = RolUsuario.Repartidor, Estado = EstadoCuenta.Suspendido });
        e.Contexto.Repartidores.AddRange(
            new Repartidor { Id = 5, UsuarioId = 2, NegocioId = 10 },   // activo, de este negocio
            new Repartidor { Id = 6, UsuarioId = 3, NegocioId = 10 },   // suspendido
            new Repartidor { Id = 7, UsuarioId = 2, NegocioId = 99 });  // de otro negocio
        await e.Contexto.SaveChangesAsync();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Activos());

        var repartidores = Assert.IsType<List<Repartidor>>(vista.ViewData["Repartidores"]);
        Assert.Equal(5, Assert.Single(repartidores).Id);
    }

    [Fact]
    public async Task Historial_RetornaVistaConElHistorial()
    {
        var e = new Escenario();
        var lista = new List<Pedido> { new() { Id = 1 } };
        e.Pedidos.ObtenerHistorialPedidosAsync(1).Returns(lista);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Historial());

        Assert.Same(lista, vista.Model);
    }

    // ===== ActualizarEstado =====

    [Fact]
    public async Task ActualizarEstado_Falla_GuardaElMensajeDelServicio()
    {
        var e = new Escenario();
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, "Este pedido ya se encuentra finalizado y no puede ser modificado."));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(1, 3, null));

        Assert.Equal("Activos", r.ActionName);
        Assert.Equal("Este pedido ya se encuentra finalizado y no puede ser modificado.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task ActualizarEstado_FallaSinMensaje_GuardaMensajePorDefecto()
    {
        var e = new Escenario();
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, null));

        await e.Controlador.ActualizarEstado(1, 3, null);

        Assert.Equal("No fue posible actualizar el estado.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task ActualizarEstado_Exitoso_GuardaMensajeDeExito()
    {
        var e = new Escenario();
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(1, 3, 5));

        Assert.Equal("Activos", r.ActionName);
        Assert.Equal("¡El estado del pedido se ha actualizado correctamente!", e.Controlador.TempData["Mensaje"]);
    }

    // ===== Consultar (CU-05) =====

    [Fact]
    public void Consultar_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<ViewResult>(e.Controlador.Consultar());
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("ABC")]
    [InlineData("ABC-1234")]
    [InlineData("ABCDEFGHI")]
    public async Task Consultar_Post_CodigoConFormatoInvalido_MuestraCodigoNoEncontrado(string? codigo)
    {
        var e = new Escenario();

        var r = await e.Controlador.Consultar(codigo!);

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "Código no encontrado, verifica e intenta nuevamente");
    }

    [Fact]
    public async Task Consultar_Post_PedidoNoExiste_MuestraCodigoNoEncontrado()
    {
        var e = new Escenario();

        var r = await e.Controlador.Consultar("ABC12345");

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "Código no encontrado, verifica e intenta nuevamente");
    }

    [Fact]
    public async Task Consultar_Post_PedidoExisteSinSqlReal_MuestraErrorDeCarga()
    {
        // La línea de tiempo usa SQL crudo (SqlQuery), que EF InMemory no soporta:
        // esto ejercita el camino de error FE-14-CU05.
        var e = new Escenario();
        e.Contexto.Usuarios.Add(new Usuario { Id = 1, Correo = "n@gtrack.local", Documento = "100000", Rol = RolUsuario.Negocio });
        e.Contexto.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
        e.Contexto.Pedidos.Add(new Pedido { Id = 1, Codigo = "ABC12345", NegocioId = 10, ClienteId = 1 });
        await e.Contexto.SaveChangesAsync();

        var r = await e.Controlador.Consultar(" abc12345 ");

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "No fue posible cargar la información. Intenta nuevamente");
    }

    // ===== Ubicacion =====

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    [InlineData("ABC")]
    [InlineData("ABC-1234")]
    public async Task Ubicacion_CodigoInvalido_RetornaNoDisponible(string codigo)
    {
        var e = new Escenario();

        var json = Assert.IsType<JsonResult>(await e.Controlador.Ubicacion(codigo)).AJson();

        Assert.Contains("\"disponible\":false", json);
        await e.Ubicaciones.DidNotReceive().ObtenerPorCodigoAsync(Arg.Any<string>());
    }

    [Fact]
    public async Task Ubicacion_ConUbicacion_RetornaCoordenadasYEstado()
    {
        var e = new Escenario();
        var fecha = new DateTime(2026, 11, 14, 12, 0, 0, DateTimeKind.Utc);
        e.Ubicaciones.ObtenerPorCodigoAsync("ABC12345").Returns(Ubi(true, null, 4.7m, -74.1m, fecha, "EnCamino"));

        var json = Assert.IsType<JsonResult>(await e.Controlador.Ubicacion(" abc12345 ")).AJson();

        Assert.Contains("\"disponible\":true", json);
        Assert.Contains("\"lat\":4.7", json);
        Assert.Contains("\"lng\":-74.1", json);
        Assert.Contains("\"fechaUtc\":\"2026-11-14T12:00:00Z\"", json);
        Assert.Contains("\"estado\":\"EnCamino\"", json);
    }

    [Fact]
    public async Task Ubicacion_SinUbicacion_RetornaNoDisponibleConEstado()
    {
        var e = new Escenario();
        e.Ubicaciones.ObtenerPorCodigoAsync("ABC12345")
            .Returns(Ubi(false, "No hay ubicación disponible para este pedido.", null, null, null, "Entregado"));

        var json = Assert.IsType<JsonResult>(await e.Controlador.Ubicacion("ABC12345")).AJson();

        Assert.Contains("\"disponible\":false", json);
        Assert.Contains("\"estado\":\"Entregado\"", json);
    }
}