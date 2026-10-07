using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

// CU-03: Controlador para la gestión de pedidos
[Authorize(Roles = "Negocio")]
public class PedidoController(IPedidoService pedidos) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet]
    public IActionResult Registrar() => View(new RegistrarPedidoDto());

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Registrar(RegistrarPedidoDto dto)
    {
        if (!ModelState.IsValid) return View(dto);

        var (ok, error, codigo) = await pedidos.RegistrarAsync(UsuarioId, dto);
        if (!ok)
        {
            ModelState.AddModelError("", error!);
            return View(dto);
        }

        TempData["Mensaje"] = $"Pedido registrado con el código {codigo}";
        return RedirectToAction(nameof(Activos));
    }

    [HttpGet]
    public async Task<IActionResult> BuscarCliente(string telefono)
    {
        var cliente = await pedidos.BuscarClienteFrecuenteAsync(UsuarioId, telefono);
        return Json(cliente);
    }

    [HttpGet]
    public IActionResult Activos() => View();
}

