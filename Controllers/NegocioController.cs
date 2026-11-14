using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[Authorize(Roles = "Negocio")]
public class NegocioController(INegocioService negocios) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    // ---------- CU-01 Registrar negocio ----------
    [AllowAnonymous, HttpGet]
    public IActionResult Registrar()
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");
        return View(new RegistroNegocioDto());
    }

    [AllowAnonymous, HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Registrar(RegistroNegocioDto dto)
    {
        if (User.Identity?.IsAuthenticated == true) return RedirectToAction("Index", "Home");

        if (!ModelState.IsValid)
        {
            // FE-2-CU01
            if (ModelState.Values.SelectMany(v => v.Errors).Any(e => e.ErrorMessage == RegistroNegocioDto.Obligatorio))
                ModelState.AddModelError("", "Todos los campos son obligatorios");
            return View(dto);
        }

        var urlRevision = Url.Action("Negocios", "Admin", null, Request.Scheme)!;
        var (ok, error, correoEnviado) = await negocios.RegistrarAsync(dto, urlRevision);
        if (!ok)
        {
            ModelState.AddModelError("", error!);
            return View(dto);
        }

        var mensaje = "Registro exitoso. Tu cuenta será validada por un administrador";
        if (!correoEnviado) // FE-3-CU01
            mensaje += ". Tu cuenta fue creada, pero no pudimos enviarte el correo de confirmación";

        TempData["Mensaje"] = mensaje;
        return RedirectToAction("Login", "Usuario");
    }

    // ---------- Perfil (CU-11 y CU-13 arrancan aquí) ----------
    [HttpGet]
    public async Task<IActionResult> Perfil()
    {
        var perfil = await negocios.ObtenerPerfilAsync(UsuarioId);
        if (perfil is null) return NotFound();
        return View(perfil);
    }

    // ---------- CU-13 Editar negocio ----------
    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> EnviarCodigo()
    {
        var (ok, error) = await negocios.SolicitarCodigoAsync(UsuarioId);
        if (!ok)
        {
            TempData["Error"] = error;
            return RedirectToAction(nameof(Perfil));
        }

        TempData["Mensaje"] = "Te enviamos un código de verificación a tu correo";
        return RedirectToAction(nameof(VerificarCodigo));
    }

    [HttpGet]
    public IActionResult VerificarCodigo() => View(new VerificarCodigoDto());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> VerificarCodigo(VerificarCodigoDto dto)
    {
        if (!ModelState.IsValid) return View(dto);

        var (ok, error) = await negocios.VerificarCodigoAsync(UsuarioId, dto.Codigo);
        if (!ok)
        {
            ModelState.AddModelError("", error!);
            return View(dto);
        }

        return RedirectToAction(nameof(Editar));
    }

    [HttpGet]
    public async Task<IActionResult> Editar()
    {
        if (!await negocios.EdicionAutorizadaAsync(UsuarioId))
        {
            TempData["Error"] = NegocioService.MensajeSinVerificacion;
            return RedirectToAction(nameof(Perfil));
        }

        var dto = await negocios.ObtenerParaEditarAsync(UsuarioId);
        if (dto is null) return NotFound();
        return View(dto);
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Editar(EditarNegocioDto dto)
    {
        if (!ModelState.IsValid) return View(dto); // FE-30-CU13

        var (ok, error) = await negocios.EditarAsync(UsuarioId, dto);
        if (!ok)
        {
            if (error == NegocioService.MensajeSinVerificacion)
            {
                TempData["Error"] = error;
                return RedirectToAction(nameof(Perfil));
            }

            ModelState.AddModelError("", error!);
            return View(dto);
        }

        TempData["Mensaje"] = "Los cambios han sido guardados exitosamente";
        return RedirectToAction(nameof(Perfil));
    }

    // ---------- CU-11 Eliminar negocio ----------
    // Primer modal: valida contraseña y precondiciones. Responde JSON para abrir el segundo modal.
    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> VerificarEliminacion(EliminarCuentaDto dto)
    {
        if (!ModelState.IsValid) return Json(new { ok = false, error = "Ingresa tu contraseña" });

        var (ok, error) = await negocios.ValidarEliminacionAsync(UsuarioId, dto.Password);
        return Json(new { ok, error });
    }

    // Segundo modal: "Sí, eliminar cuenta"
    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> EliminarCuenta(EliminarCuentaDto dto)
    {
        if (!ModelState.IsValid)
        {
            TempData["Error"] = "Ingresa tu contraseña";
            return RedirectToAction(nameof(Perfil));
        }

        var (ok, error) = await negocios.EliminarCuentaAsync(UsuarioId, dto.Password);
        if (!ok)
        {
            TempData["Error"] = error;
            return RedirectToAction(nameof(Perfil));
        }

        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        TempData["Mensaje"] = "Tu cuenta ha sido eliminada";
        return RedirectToAction("Index", "Home");
    }

    // ---------- CU-25 Ver perfil del negocio (público, sin sesión) ----------
    [AllowAnonymous, HttpGet]
    public async Task<IActionResult> Publico(int id)
    {
        var perfil = await negocios.ObtenerPerfilPublicoAsync(id);
        if (perfil is null) return NotFound();
        return View(perfil);
    }
}
