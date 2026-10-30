using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

[Authorize(Roles = "Negocio")]
public class PedidoController(
    IPedidoService pedidos,
    INegocioRepository negocios,
    AppDbContext context) : Controller
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
    public async Task<IActionResult> Activos()
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(UsuarioId);
        var pedidosActivos = await pedidos.ObtenerPedidosActivosAsync(UsuarioId);

        List<Repartidor> listaRepartidores = [];
        if (negocio != null)
        {
            listaRepartidores = await context.Set<Repartidor>()
                .Where(r => r.NegocioId == negocio.Id)
                .ToListAsync();
        }

        ViewBag.Repartidores = listaRepartidores;
        return View(pedidosActivos);
    }

    [HttpGet]
    public async Task<IActionResult> Historial()
    {
        var historialPedidos = await pedidos.ObtenerHistorialPedidosAsync(UsuarioId);
        return View(historialPedidos);
    }

    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> ActualizarEstado(int id, int nuevoEstadoId, int? repartidorId)
    {
        var (okActualizacion, errorMsg) = await pedidos.ActualizarEstadoAsync(UsuarioId, id, nuevoEstadoId, repartidorId);

        if (!okActualizacion)
        {
            TempData["Error"] = errorMsg ?? "No fue posible actualizar el estado.";
        }
        else
        {
            TempData["Mensaje"] = "¡El estado del pedido se ha actualizado correctamente!";
        }

        return RedirectToAction(nameof(Activos));
    }

    // ==========================================
    // NUEVAS ACCIONES PARA EL CU-05: CONSULTAR PEDIDO
    // ==========================================

    [AllowAnonymous]
    [HttpGet]
    public IActionResult Consultar()
    {
        return View();
    }

    [AllowAnonymous]
    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Consultar(string codigo)
    {
        if (string.IsNullOrWhiteSpace(codigo))
        {
            ModelState.AddModelError("", "Por favor, ingresa el código del pedido.");
            return View();
        }

        // Consultamos directamente incluyendo las relaciones necesarias para mostrarlas en la vista
        var pedido = await context.Pedidos
            .Include(p => p.Items)
            .Include(p => p.Negocio)
            .Include(p => p.Repartidor)
            .FirstOrDefaultAsync(p => p.Codigo == codigo.Trim());

        if (pedido == null)
        {
            ModelState.AddModelError("", "No se encontró ningún pedido con el código ingresado.");
            return View();
        }

        return View(pedido);
    }
}