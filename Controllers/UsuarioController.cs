using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;

public class UsuarioController(IAuthService auth, IRecuperacionService recuperacion) : Controller
{
    // ---------- CU-02 Iniciar sesión ----------
    [HttpGet]
    public IActionResult Login()
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");
        return View(new LoginDto());
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginDto dto)
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");
        if (!ModelState.IsValid) return View(dto);

        var (usuario, error) = await auth.IniciarSesionAsync(dto);
        if (usuario is null)
        {
            ModelState.AddModelError("", error!);
            return View(dto);
        }

        var claims = new List<Claim>
        {
            new(ClaimTypes.NameIdentifier, usuario.Id.ToString()),
            new(ClaimTypes.Email, usuario.Correo),
            new(ClaimTypes.Role, usuario.Rol.ToString())
        };
        var identity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);

        // Cookie de sesión (no persistente): se descarta al cerrar el navegador.
        // Además caduca tras 30 minutos sin actividad (ver Program.cs).
        var propiedades = new AuthenticationProperties { IsPersistent = false };
        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
            new ClaimsPrincipal(identity), propiedades);

        // PE-5-CU02: el usuario entra al Home, donde elige a qué sección ir según su rol
        return RedirectToAction("Index", "Home");
    }

    // ---------- CU-28 Cerrar sesión ----------
    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        try
        {
            await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        }
        catch (Exception)
        {
            // FE-68-CU28: la sesión permanece activa
            TempData["Error"] = "No fue posible cerrar la sesión. Intenta nuevamente";
            return RedirectToAction("Index", "Home");
        }

        // Paso 4: redirige a la página principal con el mensaje de éxito
        TempData["Mensaje"] = "Tu sesión ha sido cerrada exitosamente";
        return RedirectToAction("Index", "Home");
    }

    // ---------- CU-20 Recuperar contraseña ----------
    [HttpGet]
    public IActionResult RecuperarContrasena()
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");
        return View(new RecuperarDto());
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> RecuperarContrasena(RecuperarDto dto)
    {
        if (!ModelState.IsValid) return View(dto);

        var resultado = await recuperacion.SolicitarAsync(dto.Correo,
            token => Url.Action(nameof(RestablecerContrasena), "Usuario", new { token }, Request.Scheme)!);

        if (resultado == ResultadoSolicitud.LimiteSuperado)
        {
            ModelState.AddModelError("", "Has superado el número de solicitudes permitidas. Intenta mas tarde");
            return View(dto);
        }

        TempData["Mensaje"] = "Si el correo está registrado, recibirá un enlace para restablecer tu contraseña";
        return RedirectToAction(nameof(Login));
    }

    [HttpGet]
    public async Task<IActionResult> RestablecerContrasena(string token)
    {
        if (!await recuperacion.TokenVigenteAsync(token)) return View("TokenInvalido");
        return View(new RestablecerDto { Token = token });
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> RestablecerContrasena(RestablecerDto dto)
    {
        var (ok, error) = await recuperacion.RestablecerAsync(dto.Token, dto.NuevaPassword, dto.ConfirmarPassword);

        if (ok)
        {
            TempData["Mensaje"] = "Tu contraseña ha sido restablecida exitosamente";
            return RedirectToAction(nameof(Login));
        }

        if (error == RecuperacionService.MensajeTokenInvalido) return View("TokenInvalido");

        ModelState.AddModelError("", error!);
        return View(dto);
    }
}