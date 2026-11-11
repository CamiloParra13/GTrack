using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize]
public class RepartidorController(
    IRepartidorRepository repartidorRepo,
    INegocioRepository negocioRepo,
    IWebHostEnvironment env,
    AppDbContext context,
    IPedidoService pedidos,
    IUbicacionService ubicacionService,
    ILogger<RepartidorController> logger) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

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

        // 1. Validar si el correo ya existe en la base de datos
        var correoExiste = await context.Usuarios.AnyAsync(u => u.Correo == dto.Correo);
        if (correoExiste)
        {
            ModelState.AddModelError("Correo", "Este correo electrónico ya se encuentra registrado.");
            return View(dto);
        }

        // 2. Validar si el documento ya existe en la base de datos (en la tabla Usuario)
        var documentoExiste = await context.Usuarios.AnyAsync(u => u.Documento == dto.Documento);
        if (documentoExiste)
        {
            ModelState.AddModelError("Documento", "Este número de documento ya se encuentra registrado.");
            return View(dto);
        }

        var negocio = await negocioRepo.ObtenerPorUsuarioIdAsync(UsuarioId);
        if (negocio == null) return NotFound();

        // 3. Creamos la cuenta de usuario base para el repartidor
        var nuevoUsuario = new Usuario
        {
            Correo = dto.Correo,
            Documento = dto.Documento,
            Rol = RolUsuario.Repartidor,
            Estado = EstadoCuenta.Activo
        };

        context.Usuarios.Add(nuevoUsuario);
        await context.SaveChangesAsync(); // Genera el Id del usuario

        // 4. Creamos el repartidor vinculado al negocio y al usuario (sin la propiedad Documento si no la tiene el modelo)
        var repartidor = new Repartidor
        {
            NombreCompleto = dto.NombreCompleto,
            Telefono = dto.Telefono,
            Vehiculo = dto.Vehiculo ?? TipoVehiculo.Moto, // Conversión segura si es nullable
            Placa = dto.Placa,
            NegocioId = negocio.Id,
            UsuarioId = nuevoUsuario.Id
        };

        context.Repartidores.Add(repartidor);
        await context.SaveChangesAsync();

        TempData["Mensaje"] = "¡El repartidor ha sido registrado exitosamente!";
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
}