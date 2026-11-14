using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[Authorize]
public class NotificacionesController(INotificacionService notificaciones) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet]
    public async Task<IActionResult> Index() => View(await notificaciones.ListarAsync(UsuarioId));

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Abrir(int id)
    {
        var enlace = await notificaciones.AbrirAsync(UsuarioId, id);
        if (!string.IsNullOrEmpty(enlace) && Url.IsLocalUrl(enlace)) return LocalRedirect(enlace);
        return RedirectToAction(nameof(Index));
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> MarcarTodas()
    {
        await notificaciones.MarcarTodasLeidasAsync(UsuarioId);
        return RedirectToAction(nameof(Index));
    }
}
