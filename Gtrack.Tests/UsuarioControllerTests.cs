using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using NSubstitute;

public class UsuarioControllerTests
{
    private sealed class Escenario
    {
        public IAuthService Auth { get; } = Substitute.For<IAuthService>();
        public IRecuperacionService Recuperacion { get; } = Substitute.For<IRecuperacionService>();
        public IActivacionCuentaService Activacion { get; } = Substitute.For<IActivacionCuentaService>();
        public IAuthenticationService Autenticacion { get; } = Substitute.For<IAuthenticationService>();
        public UsuarioController Controlador { get; }

        public Escenario(bool autenticado = false)
        {
            Controlador = new UsuarioController(Auth, Recuperacion, Activacion).Preparar(
                usuarioId: autenticado ? 1 : null,
                rol: autenticado ? "Negocio" : null,
                autenticacion: Autenticacion);
        }
    }
    private static Task<(Usuario? Usuario, string? Error)> Login(Usuario? u, string? error) => Task.FromResult((u, error));
    private static Task<(bool Ok, string? Error)> Resultado(bool ok, string? error = null) => Task.FromResult((ok, error));

    private static LoginDto LoginDto() => new() { Identificador = "negocio@gtrack.local", Password = "Clave123" };

    private static void AssertRedirigeAlHome(IActionResult r)
    {
        var redir = Assert.IsType<RedirectToActionResult>(r);
        Assert.Equal("Index", redir.ActionName);
        Assert.Equal("Home", redir.ControllerName);
    }

    // ===== Login =====

    [Fact]
    public void Login_Get_SinSesion_RetornaVista()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(e.Controlador.Login());

        Assert.IsType<LoginDto>(vista.Model);
    }

    [Fact]
    public void Login_Get_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(e.Controlador.Login());
    }

    [Fact]
    public async Task Login_Post_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(await e.Controlador.Login(LoginDto()));
    }

    [Fact]
    public async Task Login_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Password", "Todos los campos son obligatorios");

        Assert.IsType<ViewResult>(await e.Controlador.Login(LoginDto()));
        await e.Auth.DidNotReceive().IniciarSesionAsync(Arg.Any<LoginDto>());
    }

    [Fact]
    public async Task Login_Post_CredencialesIncorrectas_MuestraError()
    {
        var e = new Escenario();
        e.Auth.IniciarSesionAsync(Arg.Any<LoginDto>()).Returns(Login(null, "Usuario o contraseña incorrectos"));

        var r = await e.Controlador.Login(LoginDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "Usuario o contraseña incorrectos");
    }

    [Fact]
    public async Task Login_Post_Exitoso_InicaSesionConLosClaimsDelUsuario()
    {
        var e = new Escenario();
        var usuario = new Usuario { Id = 7, Correo = "negocio@gtrack.local", Rol = RolUsuario.Negocio };
        e.Auth.IniciarSesionAsync(Arg.Any<LoginDto>()).Returns(Login(usuario, null));

        var r = await e.Controlador.Login(LoginDto());

        AssertRedirigeAlHome(r);
        await e.Autenticacion.Received(1).SignInAsync(
            Arg.Any<HttpContext>(),
            CookieAuthenticationDefaults.AuthenticationScheme,
            Arg.Is<ClaimsPrincipal>(p =>
                p.FindFirst(ClaimTypes.NameIdentifier)!.Value == "7" &&
                p.FindFirst(ClaimTypes.Role)!.Value == "Negocio"),
            Arg.Any<AuthenticationProperties>());
    }

    // ===== Logout =====

    [Fact]
    public async Task Logout_Exitoso_GuardaMensajeYRedirige()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(await e.Controlador.Logout());

        Assert.Equal("Tu sesión ha sido cerrada exitosamente", e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task Logout_Falla_GuardaMensajeDeError()
    {
        var e = new Escenario(autenticado: true);
        e.Autenticacion.SignOutAsync(Arg.Any<HttpContext>(), Arg.Any<string>(), Arg.Any<AuthenticationProperties>())
            .Returns(Task.FromException(new InvalidOperationException("fallo")));

        AssertRedirigeAlHome(await e.Controlador.Logout());

        Assert.Equal("No fue posible cerrar la sesión. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }

    // ===== Recuperar contraseña =====

    [Fact]
    public void RecuperarContrasena_Get_SinSesion_RetornaVista()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(e.Controlador.RecuperarContrasena());

        Assert.IsType<RecuperarDto>(vista.Model);
    }

    [Fact]
    public void RecuperarContrasena_Get_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(e.Controlador.RecuperarContrasena());
    }

    [Fact]
    public async Task RecuperarContrasena_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Correo", "Correo no válido");

        Assert.IsType<ViewResult>(await e.Controlador.RecuperarContrasena(new RecuperarDto { Correo = "x" }));
    }

    [Fact]
    public async Task RecuperarContrasena_Post_LimiteSuperado_MuestraError()
    {
        var e = new Escenario();
        e.Recuperacion.SolicitarAsync(Arg.Any<string>(), Arg.Any<Func<string, string>>())
            .Returns(ResultadoSolicitud.LimiteSuperado);

        var r = await e.Controlador.RecuperarContrasena(new RecuperarDto { Correo = "a@gtrack.local" });

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage.Contains("superado"));
    }

    [Fact]
    public async Task RecuperarContrasena_Post_Procesada_RedirigeAlLoginYConstruyeElEnlace()
    {
        var e = new Escenario();
        var url = Substitute.For<IUrlHelper>();
        url.Action(Arg.Any<UrlActionContext>()).Returns("https://gtrack.local/Usuario/RestablecerContrasena?token=tok");
        e.Controlador.Url = url;

        string? enlace = null;
        e.Recuperacion.SolicitarAsync(Arg.Any<string>(), Arg.Any<Func<string, string>>())
            .Returns(ci =>
            {
                enlace = ci.ArgAt<Func<string, string>>(1)("tok");
                return ResultadoSolicitud.Procesada;
            });

        var r = Assert.IsType<RedirectToActionResult>(
            await e.Controlador.RecuperarContrasena(new RecuperarDto { Correo = "a@gtrack.local" }));

        Assert.Equal("Login", r.ActionName);
        Assert.Contains("token=tok", enlace);
        Assert.NotNull(e.Controlador.TempData["Mensaje"]);
    }

    // ===== Restablecer contraseña =====

    [Fact]
    public async Task RestablecerContrasena_Get_TokenVigente_RetornaVistaConToken()
    {
        var e = new Escenario();
        e.Recuperacion.TokenVigenteAsync("tok").Returns(true);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena("tok"));

        Assert.Equal("tok", Assert.IsType<RestablecerDto>(vista.Model).Token);
    }

    [Fact]
    public async Task RestablecerContrasena_Get_TokenNoVigente_MuestraTokenInvalido()
    {
        var e = new Escenario();
        e.Recuperacion.TokenVigenteAsync("tok").Returns(false);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena("tok"));

        Assert.Equal("TokenInvalido", vista.ViewName);
    }

    [Fact]
    public async Task RestablecerContrasena_Post_Exitoso_RedirigeAlLogin()
    {
        var e = new Escenario();
        e.Recuperacion.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1").Returns(Resultado(true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.RestablecerContrasena(
            new RestablecerDto { Token = "tok", NuevaPassword = "NuevaClave1", ConfirmarPassword = "NuevaClave1" }));

        Assert.Equal("Login", r.ActionName);
        Assert.Equal("Tu contraseña ha sido restablecida exitosamente", e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task RestablecerContrasena_Post_TokenInvalido_MuestraVistaTokenInvalido()
    {
        var e = new Escenario();
        e.Recuperacion.RestablecerAsync(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>())
            .Returns(Resultado(false, RecuperacionService.MensajeTokenInvalido));

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena(new RestablecerDto { Token = "tok" }));

        Assert.Equal("TokenInvalido", vista.ViewName);
    }

    [Fact]
    public async Task RestablecerContrasena_Post_OtroError_MuestraElErrorEnLaVista()
    {
        var e = new Escenario();
        e.Recuperacion.RestablecerAsync(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>())
            .Returns(Resultado(false, "La nueva contraseña no puede ser igual a la anterior"));

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena(new RestablecerDto { Token = "tok" }));

        Assert.IsType<RestablecerDto>(vista.Model);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "La nueva contraseña no puede ser igual a la anterior");
    }
}