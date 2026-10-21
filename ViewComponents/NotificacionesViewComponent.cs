using System.Security.Claims;
using Microsoft.AspNetCore.Mvc;

public class NotificacionesViewComponent(
    INotificacionService notificaciones,
    ILogger<NotificacionesViewComponent> logger) : ViewComponent
{
    public async Task<IViewComponentResult> InvokeAsync()
    {
        var cantidad = 0;
        try
        {
            var id = UserClaimsPrincipal.FindFirstValue(ClaimTypes.NameIdentifier);
            if (id is not null) cantidad = await notificaciones.ContarNoLeidasAsync(int.Parse(id));
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo contar las notificaciones sin leer");
        }
        return View(cantidad);
    }
}
