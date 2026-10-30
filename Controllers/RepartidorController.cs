using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Authorize(Roles = "Negocio")]
public class RepartidorController(
    IRepartidorRepository repartidorRepo,
    INegocioRepository negocioRepo,
    IWebHostEnvironment env,
    AppDbContext context) : Controller
{
    private int UsuarioId => int.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet]
    public async Task<IActionResult> Index()
    {
        var negocio = await negocioRepo.ObtenerPorUsuarioIdAsync(UsuarioId);
        if (negocio == null) return View(new List<Repartidor>());

        var repartidores = await repartidorRepo.ListarPorNegocioAsync(negocio.Id);
        return View(repartidores);
    }

    [HttpGet]
    public IActionResult Registrar()
    {
        return View(new RegistroRepartidorDto());
    }

    [HttpPost, ValidateAntiForgeryToken]
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
}