using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;

public class NegocioControllerTests
{
    private sealed class Escenario
    {
        public INegocioService Servicio { get; } = Substitute.For<INegocioService>();
        public IAuthenticationService Autenticacion { get; } = Substitute.For<IAuthenticationService>();
        public NegocioController Controlador { get; }

        public Escenario(bool autenticado = true)
        {
            Controlador = new NegocioController(Servicio).Preparar(
                usuarioId: autenticado ? 1 : null,
                rol: autenticado ? "Negocio" : null,
                autenticacion: Autenticacion);
        }
    }

    private static Task<(bool Ok, string? Error)> Res(bool ok, string? error = null) => Task.FromResult((ok, error));
    private static Task<(bool Ok, string? Error, bool CorreoEnviado)> Reg(bool ok, string? error, bool correo) =>
        Task.FromResult((ok, error, correo));

    private static void AssertRedirige(IActionResult r, string accion, string? controlador = null)
    {
        var redir = Assert.IsType<RedirectToActionResult>(r);
        Assert.Equal(accion, redir.ActionName);
        Assert.Equal(controlador, redir.ControllerName);
    }

    // ===== Registrar (CU-01) =====

    [Fact]
    public void Registrar_Get_SinSesion_RetornaVista()
    {
        var e = new Escenario(autenticado: false);

        Assert.IsType<RegistroNegocioDto>(Assert.IsType<ViewResult>(e.Controlador.Registrar()).Model);
    }

    [Fact]
    public void Registrar_Get_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario();

        AssertRedirige(e.Controlador.Registrar(), "Index", "Home");
    }

    [Fact]
    public async Task Registrar_Post_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario();

        AssertRedirige(await e.Controlador.Registrar(new RegistroNegocioDto()), "Index", "Home");
    }

    [Fact]
    public async Task Registrar_Post_CampoObligatorioVacio_AgregaMensajeGeneral()
    {
        var e = new Escenario(autenticado: false);
        e.Controlador.ModelState.AddModelError("Nombre", RegistroNegocioDto.Obligatorio);

        var r = await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "Todos los campos son obligatorios");
    }

    [Fact]
    public async Task Registrar_Post_OtroErrorDeValidacion_NoAgregaMensajeGeneral()
    {
        var e = new Escenario(autenticado: false);
        e.Controlador.ModelState.AddModelError("Correo", "Correo no válido");

        await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.False(e.Controlador.ModelState.ContainsKey(""));
    }

    [Fact]
    public async Task Registrar_Post_ServicioFalla_MuestraElError()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.RegistrarAsync(Arg.Any<RegistroNegocioDto>(), Arg.Any<string>()).Returns(Reg(false, "El teléfono ya está registrado", false));

        var r = await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "El teléfono ya está registrado");
    }

    [Fact]
    public async Task Registrar_Post_Exitoso_RedirigeAlLogin()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.RegistrarAsync(Arg.Any<RegistroNegocioDto>(), Arg.Any<string>()).Returns(Reg(true, null, true));

        var r = await e.Controlador.Registrar(new RegistroNegocioDto());

        AssertRedirige(r, "Login", "Usuario");
        Assert.Equal("Registro exitoso. Tu cuenta será validada por un administrador", e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task Registrar_Post_ExitosoSinCorreo_AgregaAvisoAlMensaje()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.RegistrarAsync(Arg.Any<RegistroNegocioDto>(), Arg.Any<string>()).Returns(Reg(true, null, false));

        await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.Contains("no pudimos enviarte el correo", (string)e.Controlador.TempData["Mensaje"]!);
    }

    // ===== Perfil =====

    [Fact]
    public async Task Perfil_NoExiste_RetornaNotFound()
    {
        var e = new Escenario();
        e.Servicio.ObtenerPerfilAsync(1).Returns((PerfilNegocioDto?)null);

        Assert.IsType<NotFoundResult>(await e.Controlador.Perfil());
    }

    [Fact]
    public async Task Perfil_Existe_RetornaVistaConElPerfil()
    {
        var e = new Escenario();
        var perfil = new PerfilNegocioDto { Nombre = "Mi Negocio" };
        e.Servicio.ObtenerPerfilAsync(1).Returns(perfil);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Perfil());

        Assert.Same(perfil, vista.Model);
    }

    // ===== Enviar y verificar código (CU-13) =====

    [Fact]
    public async Task EnviarCodigo_Falla_GuardaErrorYVuelveAlPerfil()
    {
        var e = new Escenario();
        e.Servicio.SolicitarCodigoAsync(1).Returns(Res(false, "No fue posible enviar el código. Intenta nuevamente"));

        AssertRedirige(await e.Controlador.EnviarCodigo(), "Perfil");
        Assert.Equal("No fue posible enviar el código. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task EnviarCodigo_Exitoso_VaALaVerificacion()
    {
        var e = new Escenario();
        e.Servicio.SolicitarCodigoAsync(1).Returns(Res(true));

        AssertRedirige(await e.Controlador.EnviarCodigo(), "VerificarCodigo");
        Assert.NotNull(e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public void VerificarCodigo_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<VerificarCodigoDto>(Assert.IsType<ViewResult>(e.Controlador.VerificarCodigo()).Model);
    }

    [Fact]
    public async Task VerificarCodigo_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Codigo", "El código tiene 6 dígitos");

        Assert.IsType<ViewResult>(await e.Controlador.VerificarCodigo(new VerificarCodigoDto { Codigo = "12" }));
        await e.Servicio.DidNotReceive().VerificarCodigoAsync(Arg.Any<int>(), Arg.Any<string>());
    }

    [Fact]
    public async Task VerificarCodigo_Post_CodigoIncorrecto_MuestraError()
    {
        var e = new Escenario();
        e.Servicio.VerificarCodigoAsync(1, "111111").Returns(Res(false, "Código incorrecto, intenta nuevamente"));

        var r = await e.Controlador.VerificarCodigo(new VerificarCodigoDto { Codigo = "111111" });

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "Código incorrecto, intenta nuevamente");
    }

    [Fact]
    public async Task VerificarCodigo_Post_CodigoCorrecto_VaAEditar()
    {
        var e = new Escenario();
        e.Servicio.VerificarCodigoAsync(1, "111111").Returns(Res(true));

        AssertRedirige(await e.Controlador.VerificarCodigo(new VerificarCodigoDto { Codigo = "111111" }), "Editar");
    }

    // ===== Editar =====

    [Fact]
    public async Task Editar_Get_SinAutorizacion_VuelveAlPerfil()
    {
        var e = new Escenario();
        e.Servicio.EdicionAutorizadaAsync(1).Returns(false);

        AssertRedirige(await e.Controlador.Editar(), "Perfil");
        Assert.Equal(NegocioService.MensajeSinVerificacion, e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task Editar_Get_AutorizadoPeroSinDatos_RetornaNotFound()
    {
        var e = new Escenario();
        e.Servicio.EdicionAutorizadaAsync(1).Returns(true);
        e.Servicio.ObtenerParaEditarAsync(1).Returns((EditarNegocioDto?)null);

        Assert.IsType<NotFoundResult>(await e.Controlador.Editar());
    }

    [Fact]
    public async Task Editar_Get_Autorizado_RetornaVistaConLosDatos()
    {
        var e = new Escenario();
        var dto = new EditarNegocioDto { Nombre = "Mi Negocio" };
        e.Servicio.EdicionAutorizadaAsync(1).Returns(true);
        e.Servicio.ObtenerParaEditarAsync(1).Returns(dto);

        Assert.Same(dto, Assert.IsType<ViewResult>(await e.Controlador.Editar()).Model);
    }

    [Fact]
    public async Task Editar_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Nombre", "Campo obligatorio");

        Assert.IsType<ViewResult>(await e.Controlador.Editar(new EditarNegocioDto()));
        await e.Servicio.DidNotReceive().EditarAsync(Arg.Any<int>(), Arg.Any<EditarNegocioDto>());
    }

    [Fact]
    public async Task Editar_Post_SinVerificacion_VuelveAlPerfil()
    {
        var e = new Escenario();
        e.Servicio.EditarAsync(1, Arg.Any<EditarNegocioDto>()).Returns(Res(false, NegocioService.MensajeSinVerificacion));

        AssertRedirige(await e.Controlador.Editar(new EditarNegocioDto()), "Perfil");
        Assert.Equal(NegocioService.MensajeSinVerificacion, e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task Editar_Post_OtroError_MuestraElErrorEnLaVista()
    {
        var e = new Escenario();
        e.Servicio.EditarAsync(1, Arg.Any<EditarNegocioDto>()).Returns(Res(false, "El correo ya está registrado en otra cuenta"));

        var r = await e.Controlador.Editar(new EditarNegocioDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "El correo ya está registrado en otra cuenta");
    }

    [Fact]
    public async Task Editar_Post_Exitoso_VuelveAlPerfilConMensaje()
    {
        var e = new Escenario();
        e.Servicio.EditarAsync(1, Arg.Any<EditarNegocioDto>()).Returns(Res(true));

        AssertRedirige(await e.Controlador.Editar(new EditarNegocioDto()), "Perfil");
        Assert.Equal("Los cambios han sido guardados exitosamente", e.Controlador.TempData["Mensaje"]);
    }

    // ===== Eliminar negocio (CU-11) =====

    [Fact]
    public async Task VerificarEliminacion_ModeloInvalido_RetornaJsonConError()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Password", "Ingresa tu contraseña");

        var json = Assert.IsType<JsonResult>(await e.Controlador.VerificarEliminacion(new EliminarCuentaDto())).AJson();

        Assert.Contains("\"ok\":false", json);
        Assert.Contains("Ingresa tu contraseña", json);
    }

    [Fact]
    public async Task VerificarEliminacion_ServicioResponde_RetornaJsonConElResultado()
    {
        var e = new Escenario();
        e.Servicio.ValidarEliminacionAsync(1, "Clave123").Returns(Res(true));

        var json = Assert.IsType<JsonResult>(
            await e.Controlador.VerificarEliminacion(new EliminarCuentaDto { Password = "Clave123" })).AJson();

        Assert.Contains("\"ok\":true", json);
    }

    [Fact]
    public async Task EliminarCuenta_ModeloInvalido_VuelveAlPerfil()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Password", "Ingresa tu contraseña");

        AssertRedirige(await e.Controlador.EliminarCuenta(new EliminarCuentaDto()), "Perfil");
        Assert.Equal("Ingresa tu contraseña", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task EliminarCuenta_ServicioFalla_VuelveAlPerfilConError()
    {
        var e = new Escenario();
        e.Servicio.EliminarCuentaAsync(1, "mala1").Returns(Res(false, "Contraseña incorrecta"));

        AssertRedirige(await e.Controlador.EliminarCuenta(new EliminarCuentaDto { Password = "mala1" }), "Perfil");
        Assert.Equal("Contraseña incorrecta", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task EliminarCuenta_Exitoso_CierraSesionYVaAlHome()
    {
        var e = new Escenario();
        e.Servicio.EliminarCuentaAsync(1, "Clave123").Returns(Res(true));

        var r = await e.Controlador.EliminarCuenta(new EliminarCuentaDto { Password = "Clave123" });

        AssertRedirige(r, "Index", "Home");
        Assert.Equal("Tu cuenta ha sido eliminada", e.Controlador.TempData["Mensaje"]);
        await e.Autenticacion.Received(1).SignOutAsync(Arg.Any<HttpContext>(), Arg.Any<string>(), Arg.Any<AuthenticationProperties>());
    }

    // ===== Perfil público (CU-25) =====

    [Fact]
    public async Task Publico_NoExiste_RetornaNotFound()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.ObtenerPerfilPublicoAsync(9).Returns((PerfilPublicoNegocioDto?)null);

        Assert.IsType<NotFoundResult>(await e.Controlador.Publico(9));
    }

    [Fact]
    public async Task Publico_Existe_RetornaVistaConElPerfil()
    {
        var e = new Escenario(autenticado: false);
        var perfil = new PerfilPublicoNegocioDto { Nombre = "Mi Negocio" };
        e.Servicio.ObtenerPerfilPublicoAsync(9).Returns(perfil);

        Assert.Same(perfil, Assert.IsType<ViewResult>(await e.Controlador.Publico(9)).Model);
    }
}