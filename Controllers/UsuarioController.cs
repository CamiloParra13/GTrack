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
        await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
            new ClaimsPrincipal(identity));

        // TODO: cuando existan los paneles, redirigir según el rol (PE-5-CU02)
        return RedirectToAction("Index", "Home");
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Logout()
    {
        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        return RedirectToAction(nameof(Login));
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