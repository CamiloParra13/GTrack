using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[Authorize(Roles = "Administrador")]
public class AdminController(IAdministracionService admin, IWebHostEnvironment env) : Controller
{
    // ----- Validación de negocios (versión mínima de CU-18 para poder activar cuentas nuevas) -----
    [HttpGet]
    public async Task<IActionResult> Negocios() => View(await admin.ListarNegociosAsync());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> AprobarNegocio(int id)
    {
        if (await admin.AprobarNegocioAsync(id)) TempData["Mensaje"] = "Negocio validado correctamente";
        else TempData["Aviso"] = "No fue posible validar el negocio";
        return RedirectToAction(nameof(Negocios));
    }

    // ----- CU-26 Registrar administrador -----
    [HttpGet]
    public async Task<IActionResult> Administradores() => View(await admin.ListarAdministradoresAsync());

    [HttpGet]
    public IActionResult RegistrarAdministrador() => View(new RegistroAdministradorDto());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> RegistrarAdministrador(RegistroAdministradorDto dto)
    {
        if (!ModelState.IsValid)
        {
            // FE-63-CU26
            if (ModelState.Values.SelectMany(v => v.Errors).Any(e => e.ErrorMessage == RegistroNegocioDto.Obligatorio))
                ModelState.AddModelError("", "Debes completar todos los campos obligatorios");
            return View(dto);
        }

        var r = await admin.RegistrarAdministradorAsync(dto);
        if (!r.Ok)
        {
            ModelState.AddModelError("", r.Error!);
            return View(dto);
        }

        TempData["Mensaje"] = "Administrador registrado exitosamente";
        if (!r.CorreoEnviado) // FE-64-CU26
            TempData["Aviso"] = "No fue posible enviar las credenciales por correo. Puedes enviarlas manualmente";
        if (!r.CorreoEnviado || env.IsDevelopment())
            TempData["Credenciales"] = $"Usuario: {dto.Correo.Trim()} — Contraseña temporal: {r.PasswordTemporal}";

        return RedirectToAction(nameof(Administradores));
    }
}