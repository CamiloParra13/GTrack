using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

[Authorize(Roles = "Negocio")]
public class PedidoController(
    IPedidoService pedidos,
    INegocioRepository negocios,
    AppDbContext context,
    IUbicacionService ubicaciones) : Controller
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
                .Include(r => r.Usuario)
                .Where(r => r.NegocioId == negocio.Id && r.Usuario.Estado == EstadoCuenta.Activo)
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
    public Task<IActionResult> Consultar(string codigo) => MostrarPedidoAsync(codigo);

    // ---------- CU-17 Cancelar pedido (cliente, sin sesión) ----------
    // Pasos 7 y 8: el cliente envía el motivo desde la consulta del pedido
    [AllowAnonymous]
    [HttpPost, ValidateAntiForgeryToken]
    public async Task<IActionResult> Cancelar(string codigo, string? motivo)
    {
        var (ok, error) = await pedidos.CancelarPorClienteAsync(codigo, motivo);

        if (!ok && error == PedidoService.MensajeCodigoNoEncontrado)
        {
            ModelState.AddModelError("", error); // FE-43-CU17
            return View(nameof(Consultar));
        }

        if (ok)
            ViewBag.MensajeCancelacion = "Pedido cancelado exitosamente";
        else
            ModelState.AddModelError("", error!); // FE-42, FE-44 o FE-45

        // Se vuelve a mostrar el pedido con su estado actualizado
        return await MostrarPedidoAsync(codigo);
    }

    // CU-05: busca el pedido por su código y arma la vista de consulta
    private async Task<IActionResult> MostrarPedidoAsync(string? codigo)
    {
        const string CodigoNoEncontrado = "Código no encontrado, verifica e intenta nuevamente";

        // RN-1-CU05: el código debe cumplir el formato definido (8 caracteres alfanuméricos)
        var codigoLimpio = codigo?.Trim().ToUpperInvariant() ?? "";
        if (!System.Text.RegularExpressions.Regex.IsMatch(codigoLimpio, "^[A-Z0-9]{8}$"))
        {
            ModelState.AddModelError("", CodigoNoEncontrado);
            return View(nameof(Consultar));
        }

        try
        {
            var pedido = await context.Pedidos
                .AsNoTracking()
                .Include(p => p.Items)
                .Include(p => p.Negocio).ThenInclude(n => n!.Usuario)
                .Include(p => p.Repartidor)
                .FirstOrDefaultAsync(p => p.Codigo == codigoLimpio);

            if (pedido == null)
            {
                ModelState.AddModelError("", CodigoNoEncontrado);
                return View(nameof(Consultar));
            }

            // Línea de tiempo: cada cambio de estado con su fecha/hora (UTC)
            ViewBag.Historial = await context.Database
                .SqlQuery<HistorialEstadoItem>($"SELECT EstadoPedidoId, FechaCambio FROM dbo.HistorialEstadoPedido WHERE PedidoId = {pedido.Id} ORDER BY FechaCambio")
                .ToListAsync();

            // CU-17: motivo y fecha de la cancelación hecha por el cliente (si existe).
            // Va aparte para que la consulta siga funcionando aunque falte la tabla SolicitudCancelacion.
            if (pedido.EstadoPedidoId == (int)EstadoPedido.Cancelado)
            {
                try
                {
                    ViewBag.Cancelacion = await context.SolicitudesCancelacion
                        .AsNoTracking()
                        .FirstOrDefaultAsync(s => s.PedidoId == pedido.Id);
                }
                catch (Exception)
                {
                    ViewBag.Cancelacion = null;
                }
            }

            return View(nameof(Consultar), pedido);
        }
        catch (Exception)
        {
            // FE-14-CU05: plataforma no disponible
            ModelState.AddModelError("", "No fue posible cargar la información. Intenta nuevamente");
            return View(nameof(Consultar));
        }
    }

    [AllowAnonymous]
    [HttpGet]
    public async Task<IActionResult> Ubicacion(string codigo)
    {
        if (string.IsNullOrWhiteSpace(codigo) || !System.Text.RegularExpressions.Regex.IsMatch(codigo.Trim(), "^[A-Za-z0-9]{8}$"))
        {
            return Json(new { disponible = false });
        }

        var (ok, _, lat, lng, fechaUtc, estado) = await ubicaciones.ObtenerPorCodigoAsync(codigo.Trim().ToUpperInvariant());

        if (ok && lat.HasValue && lng.HasValue && fechaUtc.HasValue)
        {
            return Json(new
            {
                disponible = true,
                lat = lat.Value,
                lng = lng.Value,
                fechaUtc = fechaUtc.Value.ToString("yyyy-MM-ddTHH:mm:ss'Z'"),
                estado
            });
        }

        return Json(new
        {
            disponible = false,
            estado
        });
    }
}

// Fila de HistorialEstadoPedido usada por la línea de tiempo del CU-05
public class HistorialEstadoItem
{
    public int EstadoPedidoId { get; set; }
    public DateTime FechaCambio { get; set; }
}