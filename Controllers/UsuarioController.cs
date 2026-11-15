using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

public class UsuarioController(
    IAuthService auth,
    IRecuperacionService recuperacion,
    IActivacionCuentaService activacion) : Controller
{
    // ---------- CU-02 Iniciar sesión ----------
    // "rol" abre el formulario con un perfil ya elegido (p. ej. después de activar la cuenta).
    // "returnUrl" es la página a la que se vuelve después de ingresar (p. ej. el botón "Revisar solicitud"
    // del correo que reciben los administradores); solo se aceptan direcciones de este mismo sitio.
    [HttpGet]
    public IActionResult Login(string? rol = null, string? returnUrl = null)
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");

        var dto = new LoginDto();
        var volverA = Url.IsLocalUrl(returnUrl) ? returnUrl : null;

        if (Enum.TryParse<RolUsuario>(rol, true, out var perfil) && Enum.IsDefined(perfil))
            dto.Rol = perfil;
        else if (volverA?.StartsWith("/Admin", StringComparison.OrdinalIgnoreCase) == true)
            dto.Rol = RolUsuario.Administrador;

        if (TempData["Identificador"] is string identificador) dto.Identificador = identificador;
        ViewData["ReturnUrl"] = volverA;
        return View(dto);
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginDto dto, string? returnUrl = null)
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");

        var volverA = Url.IsLocalUrl(returnUrl) ? returnUrl : null;
        ViewData["ReturnUrl"] = volverA;
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

        // Si venía de un enlace a una página del sitio, vuelve a esa página
        if (volverA is not null) return LocalRedirect(volverA);

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

    // ---------- CU-09 / CU-26 Activar la cuenta (repartidor o administrador) desde el enlace del correo ----------
    [HttpGet]
    public async Task<IActionResult> ActivarCuenta(string? token)
    {
        var info = await activacion.ConsultarAsync(token);
        if (info.Estado != EstadoEnlaceActivacion.Valido) return View("EnlaceActivacionInvalido", info);

        return View(ConDatos(new ActivarCuentaDto { Token = token! }, info));
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> ActivarCuenta(ActivarCuentaDto dto)
    {
        if (!ModelState.IsValid)
        {
            var datos = await activacion.ConsultarAsync(dto.Token);
            if (datos.Estado != EstadoEnlaceActivacion.Valido) return View("EnlaceActivacionInvalido", datos);
            return View(ConDatos(dto, datos));
        }

        var (ok, error, info) = await activacion.ActivarAsync(dto.Token, dto.NuevaPassword, dto.ConfirmarPassword, UrlLogin);

        if (ok)
        {
            var perfil = info.Rol ?? RolUsuario.Repartidor;
            var nombrePerfil = perfil == RolUsuario.Administrador ? "administrador" : "repartidor";
            TempData["Mensaje"] = $"¡Tu cuenta fue activada! Ya puedes iniciar sesión como {nombrePerfil}.";
            TempData["Identificador"] = info.Correo;
            return RedirectToAction(nameof(Login), new { rol = perfil.ToString() });
        }

        if (info.Estado != EstadoEnlaceActivacion.Valido) return View("EnlaceActivacionInvalido", info);

        ModelState.AddModelError("", error!);
        return View(ConDatos(dto, info));
    }

    private static ActivarCuentaDto ConDatos(ActivarCuentaDto dto, InfoActivacion info)
    {
        dto.Nombre = info.Nombre;
        dto.Correo = info.Correo;
        dto.Negocio = info.Negocio;
        dto.Rol = info.Rol ?? RolUsuario.Repartidor;
        return dto;
    }

    // Inicio de sesión con el perfil ya elegido (va en el correo de confirmación de la activación)
    private string UrlLogin(RolUsuario rol) =>
        Url.Action(nameof(Login), "Usuario", new { rol = rol.ToString() }, Request.Scheme)!;
}