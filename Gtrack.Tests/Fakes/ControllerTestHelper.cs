using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Text.Json;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.Extensions.DependencyInjection;
using NSubstitute;

public static class ControllerTestHelper
{
    // Prepara un controlador para probarlo sin servidor: usuario autenticado (opcional),
    // TempData, Url simulado y un IAuthenticationService simulado para SignIn/SignOut.
    public static TController Preparar<TController>(
        this TController controller,
        int? usuarioId = null,
        string? rol = null,
        IAuthenticationService? autenticacion = null) where TController : Controller
    {
        var http = new DefaultHttpContext();

        if (usuarioId.HasValue)
        {
            var claims = new List<Claim> { new(ClaimTypes.NameIdentifier, usuarioId.Value.ToString()) };
            if (rol is not null) claims.Add(new Claim(ClaimTypes.Role, rol));
            http.User = new ClaimsPrincipal(new ClaimsIdentity(claims, "Prueba"));
        }

        var servicios = new ServiceCollection();
        servicios.AddSingleton(autenticacion ?? Substitute.For<IAuthenticationService>());
        http.RequestServices = servicios.BuildServiceProvider();

        controller.ControllerContext = new ControllerContext { HttpContext = http };
        controller.TempData = new TempDataDictionary(http, Substitute.For<ITempDataProvider>());

        // CAMBIO 1: evita el error "No service for type IUrlHelperFactory"
        controller.Url = Substitute.For<IUrlHelper>();

        return controller;
    }

    // CAMBIO 2: sin escapar caracteres como la ñ (si no, queda "contrase\u00f1a")
    public static string AJson(this JsonResult resultado) =>
        JsonSerializer.Serialize(resultado.Value, new JsonSerializerOptions
        {
            Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping
        });
}