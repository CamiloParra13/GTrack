using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
public class RepartidorController(
    IRepartidorRepository repartidorRepo,
    INegocioRepository negocioRepo,
    IRepartidorService repartidorService,
    IWebHostEnvironment env,
    AppDbContext context,
    IPedidoService pedidos,
    IUbicacionService ubicacionService,
    IPerfilRepartidorService perfilService,
    ILogger<RepartidorController> logger) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    // Enlace absoluto que llega al correo del repartidor para activar su cuenta
    private string EnlaceActivacion(string token) =>
        Url.Action("ActivarCuenta", "Usuario", new { token }, Request.Scheme)!;

    [HttpGet]
    [Authorize(Roles = "Negocio")]
    public async Task<IActionResult> Index()
    {
        var negocio = await negocioRepo.ObtenerPorUsuarioIdAsync(UsuarioId);
        if (negocio == null) return View(new List<Repartidor>());

        var repartidores = await repartidorRepo.ListarPorNegocioAsync(negocio.Id);
        return View(repartidores);
    }

    [HttpGet]
    [Authorize(Roles = "Negocio")]
    public IActionResult Registrar()
    {
        return View(new RegistroRepartidorDto());
    }

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Negocio")]
    public async Task<IActionResult> Registrar(RegistroRepartidorDto dto)
    {
        if (!ModelState.IsValid)
        {
            return View(dto);
        }

        // La cuenta queda "pendiente de activación": el repartidor crea su contraseña desde el correo
        var resultado = await repartidorService.RegistrarAsync(UsuarioId, dto, EnlaceActivacion);
        if (!resultado.Ok)
        {
            ModelState.AddModelError(resultado.Campo ?? string.Empty, resultado.Error!);
            return View(dto);
        }

        var correo = dto.Correo.Trim();
        if (resultado.CorreoEnviado)
            TempData["Mensaje"] = $"¡Repartidor registrado! Le enviamos un correo a {correo} para que active su cuenta y cree su contraseña.";
        else // FE-21-CU09
            TempData["Aviso"] = $"El repartidor quedó registrado, pero no pudimos enviar el correo de activación a {correo}. Usa \"Reenviar correo\" para intentarlo de nuevo.";

        return RedirectToAction(nameof(Index));
    }

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Negocio")]
    public async Task<IActionResult> ReenviarActivacion(int id)
    {
        var (ok, mensaje) = await repartidorService.ReenviarActivacionAsync(UsuarioId, id, EnlaceActivacion);
        TempData[ok ? "Mensaje" : "Error"] = mensaje;
        return RedirectToAction(nameof(Index));
    }

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Negocio")]
    public async Task<IActionResult> CambiarEstado(int id)
    {
        var negocio = await negocioRepo.ObtenerPorUsuarioIdAsync(UsuarioId);
        if (negocio == null) return NotFound();

        var repartidor = await context.Set<Repartidor>()
            .Include(r => r.Usuario)
            .FirstOrDefaultAsync(r => r.Id == id && r.NegocioId == negocio.Id);

        if (repartidor == null || repartidor.Usuario == null)
        {
            TempData["Error"] = "El repartidor no existe o no pertenece a tu negocio.";
            return RedirectToAction(nameof(Index));
        }

        // Solo el repartidor puede activar su cuenta (creando su contraseña desde el correo)
        if (repartidor.Usuario.Estado == EstadoCuenta.PendienteActivacion)
        {
            TempData["Error"] = $"{repartidor.NombreCompleto} aún no ha activado su cuenta. Puedes reenviarle el correo de activación.";
            return RedirectToAction(nameof(Index));
        }

        // Repartidor registrado antes de la activación por correo, sin contraseña: en lugar de quedar
        // activo pasa a "pendiente de activación" y se le envía el correo para que cree su contraseña.
        if (repartidor.Usuario.Estado != EstadoCuenta.Activo && string.IsNullOrEmpty(repartidor.Usuario.PasswordHash))
        {
            repartidor.Usuario.Estado = EstadoCuenta.PendienteActivacion;
            await context.SaveChangesAsync();

            var (enviado, _) = await repartidorService.ReenviarActivacionAsync(UsuarioId, repartidor.Id, EnlaceActivacion);
            if (enviado)
                TempData["Mensaje"] = $"{repartidor.NombreCompleto} aún no tenía contraseña: le enviamos un correo para que active su cuenta.";
            else
                TempData["Aviso"] = $"{repartidor.NombreCompleto} aún no tiene contraseña y no pudimos enviarle el correo de activación. Usa \"Reenviar correo\".";
            return RedirectToAction(nameof(Index));
        }

        repartidor.Usuario.Estado = repartidor.Usuario.Estado == EstadoCuenta.Activo
            ? EstadoCuenta.Suspendido
            : EstadoCuenta.Activo;

        context.Entry(repartidor.Usuario).State = EntityState.Modified;

        await context.SaveChangesAsync();

        TempData["Mensaje"] = "El estado del repartidor ha sido actualizado correctamente.";
        return RedirectToAction(nameof(Index));
    }

    [HttpGet]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> MisPedidos()
    {
        try
        {
            var repartidor = await context.Repartidores
                .AsNoTracking()
                .FirstOrDefaultAsync(r => r.UsuarioId == UsuarioId);

            if (repartidor == null)
            {
                TempData["Error"] = "No se encontró el perfil de repartidor para tu cuenta.";
                return View(new List<Pedido>());
            }

            var misPedidos = await context.Pedidos
                .AsNoTracking()
                .Include(p => p.Items)
                .Include(p => p.Cliente)
                .Where(p => p.RepartidorId == repartidor.Id &&
                           (p.EstadoPedidoId == (int)EstadoPedido.Asignado || p.EstadoPedidoId == (int)EstadoPedido.EnCamino))
                .OrderByDescending(p => p.FechaCreacion)
                .ToListAsync();

            return View(misPedidos);
        }
        catch (Exception ex)
        {
            // FE-23-CU10: plataforma no disponible; se registra el error para soporte
            logger.LogError(ex, "Error al cargar los pedidos del repartidor (usuario {UsuarioId})", UsuarioId);
            return View((List<Pedido>?)null); // la vista muestra "No fue posible cargar tus pedidos. Intenta Nuevamente"
        }
    }

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> ActualizarEstado(int id, int nuevoEstadoId)
    {
        // CU-08: el repartidor solo puede pasar a "En camino" o "Entregado"
        if (nuevoEstadoId != (int)EstadoPedido.EnCamino && nuevoEstadoId != (int)EstadoPedido.Entregado)
        {
            TempData["Error"] = "Este pedido ya no se puede actualizar";
            return RedirectToAction(nameof(MisPedidos));
        }

        try
        {
            var (ok, error) = await pedidos.ActualizarEstadoAsync(UsuarioId, id, nuevoEstadoId);
            if (!ok)
            {
                TempData["Error"] = error ?? "Este pedido ya no se puede actualizar";
            }
            else
            {
                TempData["Mensaje"] = nuevoEstadoId == (int)EstadoPedido.EnCamino
                    ? "Entrega iniciada: el pedido ahora está en camino."
                    : "Entrega registrada exitosamente";
            }
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al actualizar el estado del pedido {PedidoId}", id);
            TempData["Error"] = "No fue posible actualizar el estado del pedido. Intenta nuevamente.";
        }

        return RedirectToAction(nameof(MisPedidos));
    }

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> IniciarEntrega(int id) =>
        await ActualizarEstado(id, (int)EstadoPedido.EnCamino);

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> MarcarEntregado(int id) =>
        await ActualizarEstado(id, (int)EstadoPedido.Entregado);

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> ActualizarUbicacion(int pedidoId, decimal lat, decimal lng)
    {
        var (ok, error) = await ubicacionService.ActualizarAsync(UsuarioId, pedidoId, lat, lng);
        return Json(new { ok, error });
    }

    // =====================================================================
    // Perfil del repartidor (CU-12 y CU-14 arrancan aquí)
    // =====================================================================
    [HttpGet]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> Perfil()
    {
        var perfil = await perfilService.ObtenerPerfilAsync(UsuarioId);
        if (perfil is null) return NotFound();
        return View(perfil);
    }

    // ---------- CU-14 Editar repartidor ----------
    // Paso 2: valida que pueda editar (RN-1 y RN-2-CU14) y envía el código al correo
    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> EnviarCodigo()
    {
        var (ok, error) = await perfilService.SolicitarCodigoAsync(UsuarioId);
        if (!ok)
        {
            TempData["Error"] = error;
            // FE-35-CU14: con pedidos asignados se redirige a la página principal
            return error == PerfilRepartidorService.MensajeConPedidos
                ? RedirectToAction("Index", "Home")
                : RedirectToAction(nameof(Perfil));
        }

        TempData["Mensaje"] = "Te enviamos un código de verificación a tu correo";
        return RedirectToAction(nameof(VerificarCodigo));
    }

    [HttpGet]
    [Authorize(Roles = "Repartidor")]
    public IActionResult VerificarCodigo() => View(new VerificarCodigoDto());

    // Pasos 3 y 4: valida el código (máximo 3 intentos)
    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> VerificarCodigo(VerificarCodigoDto dto)
    {
        if (!ModelState.IsValid) return View(dto);

        var (ok, error) = await perfilService.VerificarCodigoAsync(UsuarioId, dto.Codigo);
        if (!ok)
        {
            ModelState.AddModelError("", error!);
            return View(dto);
        }

        return RedirectToAction(nameof(Editar));
    }

    [HttpGet]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> Editar()
    {
        if (!await perfilService.EdicionAutorizadaAsync(UsuarioId))
        {
            TempData["Error"] = PerfilRepartidorService.MensajeSinVerificacion;
            return RedirectToAction(nameof(Perfil));
        }

        var dto = await perfilService.ObtenerParaEditarAsync(UsuarioId);
        if (dto is null) return NotFound();
        return View(dto);
    }

    // Pasos 5 y 6: guarda los cambios
    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> Editar(EditarRepartidorDto dto)
    {
        if (!ModelState.IsValid) return View(dto); // FE-34-CU14

        var (ok, error) = await perfilService.EditarAsync(UsuarioId, dto);
        if (!ok)
        {
            if (error == PerfilRepartidorService.MensajeSinVerificacion || error == PerfilRepartidorService.MensajeSuspendido)
            {
                TempData["Error"] = error;
                return RedirectToAction(nameof(Perfil));
            }
            if (error == PerfilRepartidorService.MensajeConPedidos)
            {
                TempData["Error"] = error;
                return RedirectToAction("Index", "Home");
            }

            ModelState.AddModelError("", error!);
            return View(dto);
        }

        TempData["Mensaje"] = "Los cambios han sido guardados exitosamente";
        return RedirectToAction(nameof(Perfil));
    }

    // ---------- CU-12 Eliminar repartidor (el propio repartidor) ----------
    // Paso 4: valida que no tenga entregas pendientes. Responde JSON para mostrar el campo de contraseña.
    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> VerificarEliminacion()
    {
        var (ok, error) = await perfilService.ValidarEliminacionPropiaAsync(UsuarioId);
        return Json(new { ok, error });
    }

    // Pasos 5 y 6: "Confirmar eliminación" con la contraseña
    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Repartidor")]
    public async Task<IActionResult> EliminarCuenta(EliminarCuentaDto dto)
    {
        if (!ModelState.IsValid)
        {
            TempData["Error"] = "Ingresa tu contraseña";
            return RedirectToAction(nameof(Perfil));
        }

        var (ok, error) = await perfilService.EliminarCuentaPropiaAsync(UsuarioId, dto.Password);
        if (!ok)
        {
            TempData["Error"] = error;
            return RedirectToAction(nameof(Perfil));
        }

        await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
        TempData["Mensaje"] = "Tu cuenta ha sido eliminada";
        return RedirectToAction("Index", "Home");
    }

    // ---------- FA-13-CU12 Eliminación gestionada por el negocio ----------
    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Negocio")]
    public async Task<IActionResult> VerificarEliminacionRepartidor(int id)
    {
        var (ok, error) = await perfilService.ValidarEliminacionPorNegocioAsync(UsuarioId, id);
        return Json(new { ok, error });
    }

    [HttpPost, ValidateAntiForgeryToken]
    [Authorize(Roles = "Negocio")]
    public async Task<IActionResult> EliminarRepartidor(int id, EliminarCuentaDto dto)
    {
        if (!ModelState.IsValid)
        {
            TempData["Error"] = "Ingresa tu contraseña para confirmar la eliminación";
            return RedirectToAction(nameof(Index));
        }

        var (ok, error, nombre) = await perfilService.EliminarPorNegocioAsync(UsuarioId, id, dto.Password);
        TempData[ok ? "Mensaje" : "Error"] = ok ? $"El repartidor {nombre} fue eliminado" : error;
        return RedirectToAction(nameof(Index));
    }
}
