using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[Authorize(Roles = "Negocio")]
public class RepartidorController(IRepartidorService repartidores, IWebHostEnvironment env) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet]
    public async Task<IActionResult> Index() => View(await repartidores.ListarAsync(UsuarioId));

    [HttpGet]
    public IActionResult Registrar() => View(new RegistroRepartidorDto());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Registrar(RegistroRepartidorDto dto)
    {
        if (!ModelState.IsValid)
        {
            // FE-20-CU09
            if (ModelState.Values.SelectMany(v => v.Errors).Any(e => e.ErrorMessage == RegistroNegocioDto.Obligatorio))
                ModelState.AddModelError("", "Debes completar todos los campos obligatorios");
            return View(dto);
        }

        var r = await repartidores.RegistrarAsync(UsuarioId, dto);
        if (!r.Ok)
        {
            ModelState.AddModelError("", r.Error!);
            return View(dto);
        }

        TempData["Mensaje"] = "Repartidor registrado exitosamente";
        if (!r.CorreoEnviado) // FE-21-CU09
            TempData["Aviso"] = "No fue posible enviar las credenciales por correo. Puedes enviarlas manualmente";
        if (!r.CorreoEnviado || env.IsDevelopment())
            TempData["Credenciales"] = $"Usuario: {dto.Correo.Trim()} — Contraseña temporal: {r.PasswordTemporal}";

        return RedirectToAction(nameof(Index));
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> CambiarEstado(int id)
    {
        // Alterna el estado del repartidor validando que pertenezca al negocio actual
        var r = await repartidores.CambiarEstadoAsync(UsuarioId, id);

        if (!r.Ok)
        {
            TempData["Error"] = r.Error ?? "No se pudo actualizar el estado del repartidor.";
        }
        else
        {
            TempData["Mensaje"] = "El estado del repartidor ha sido actualizado con éxito.";
        }

        return RedirectToAction(nameof(Index));
    }
}