using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.Security.Cryptography;

// CU-12 Eliminar Repartidor y CU-14 Editar Repartidor
public interface IPerfilRepartidorService
{
    Task<PerfilRepartidorDto?> ObtenerPerfilAsync(int usuarioId);

    // ----- CU-14 Editar repartidor -----
    Task<(bool Ok, string? Error)> SolicitarCodigoAsync(int usuarioId);
    Task<(bool Ok, string? Error)> VerificarCodigoAsync(int usuarioId, string codigo);
    Task<bool> EdicionAutorizadaAsync(int usuarioId);
    Task<EditarRepartidorDto?> ObtenerParaEditarAsync(int usuarioId);
    Task<(bool Ok, string? Error)> EditarAsync(int usuarioId, EditarRepartidorDto dto);

    // Motivo por el que el repartidor no puede editar su perfil (null = sí puede)
    Task<string?> MotivoNoEditableAsync(int usuarioId);

    // ----- CU-12 Eliminar repartidor (el propio repartidor) -----
    Task<(bool Ok, string? Error)> ValidarEliminacionPropiaAsync(int usuarioId);
    Task<(bool Ok, string? Error)> EliminarCuentaPropiaAsync(int usuarioId, string password);

    // ----- FA-13-CU12 Eliminación gestionada por el negocio -----
    Task<(bool Ok, string? Error)> ValidarEliminacionPorNegocioAsync(int usuarioNegocioId, int repartidorId);
    Task<(bool Ok, string? Error, string? Nombre)> EliminarPorNegocioAsync(int usuarioNegocioId, int repartidorId, string password);
}

public class PerfilRepartidorService(
    AppDbContext db,
    IRepartidorRepository repartidores,
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    ICodigoVerificacionRepository codigos,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    ILogger<PerfilRepartidorService> logger) : IPerfilRepartidorService
{
    public const string MensajeSinVerificacion = "Debes verificar tu identidad para editar tu perfil";
    public const string MensajeConPedidos = "No puedes editar tu perfil mientras tengas pedidos asignados";          // FE-35-CU14
    public const string MensajeSuspendido = "Tu cuenta está suspendida: no puedes editar tu información";            // RN-2-CU14
    public const string MensajeSinPermisos = "No tienes permisos para realizar esta acción";                        // FE-29-CU12

    private const string MensajeEntregasPendientes = "No es posible eliminar la cuenta mientras tengas entregas pendientes"; // FE-27-CU12
    private const string MensajeEntregasPendientesNegocio = "No es posible eliminar a este repartidor mientras tenga entregas pendientes";
    private const string MensajePasswordIncorrecta = "Contraseña incorrecta";                                        // FE-28-CU12

    // Mismas reglas del código de verificación de CU-13
    private const int MaxIntentosCodigo = 3;
    private const int MinutosBloqueo = 15;
    private const int MinutosVigenciaCodigo = 10;
    private const int MinutosVentanaEdicion = 10;

    private const string MensajeErrorEnvio = "No fue posible enviar el código. Intenta nuevamente";
    private const string MensajeErrorGuardado = "No fue posible actualizar la información. Intenta Nuevamente";
    private const string MensajeCodigoExpirado = "El código expiró o ya no es válido. Solicita uno nuevo";

    // ================= Perfil =================
    public async Task<PerfilRepartidorDto?> ObtenerPerfilAsync(int usuarioId)
    {
        var rep = await db.Repartidores
            .AsNoTracking()
            .Include(r => r.Usuario)
            .FirstOrDefaultAsync(r => r.UsuarioId == usuarioId);
        if (rep?.Usuario is null) return null;

        var negocio = await negocios.BuscarPorIdAsync(rep.NegocioId);

        return new PerfilRepartidorDto
        {
            NombreCompleto = rep.NombreCompleto,
            Documento = rep.Usuario.Documento,
            Telefono = rep.Telefono,
            Correo = rep.Usuario.Correo,
            Vehiculo = rep.Vehiculo,
            Placa = rep.Placa,
            Negocio = negocio?.Nombre ?? "",
            FechaRegistro = rep.FechaRegistro,
            Estado = rep.Usuario.Estado,
            PedidosPendientes = await ContarPedidosPendientesAsync(rep.Id)
        };
    }

    // Pedidos que el repartidor todavía tiene que entregar
    private Task<int> ContarPedidosPendientesAsync(int repartidorId) =>
        db.Pedidos.CountAsync(p => p.RepartidorId == repartidorId &&
            (p.EstadoPedidoId == (int)EstadoPedido.Asignado || p.EstadoPedidoId == (int)EstadoPedido.EnCamino));

    // ================= CU-14 Editar repartidor =================
    public async Task<string?> MotivoNoEditableAsync(int usuarioId)
    {
        var rep = await repartidores.ObtenerPorUsuarioIdAsync(usuarioId);
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (rep is null || usuario is null) return MensajeSinPermisos;

        if (usuario.Estado == EstadoCuenta.Suspendido) return MensajeSuspendido;               // RN-2-CU14
        if (await ContarPedidosPendientesAsync(rep.Id) > 0) return MensajeConPedidos;          // RN-1-CU14
        return null;
    }

    public async Task<(bool Ok, string? Error)> SolicitarCodigoAsync(int usuarioId)
    {
        // FE-35-CU14: se revisa antes de enviar el código (paso 2)
        var motivo = await MotivoNoEditableAsync(usuarioId);
        if (motivo is not null) return (false, motivo);

        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, MensajeErrorEnvio);

        var ultimo = await codigos.ObtenerUltimoAsync(usuarioId);
        if (ultimo?.BloqueadoHasta is { } hasta && hasta > DateTime.UtcNow)
            return (false, MensajeBloqueo(hasta));

        var codigo = RandomNumberGenerator.GetInt32(100000, 1000000).ToString();

        try
        {
            await codigos.AgregarAsync(new CodigoVerificacion
            {
                UsuarioId = usuarioId,
                CodigoHash = TokenUtil.Hash(codigo),
                Expira = DateTime.UtcNow.AddMinutes(MinutosVigenciaCodigo)
            });

            await email.EnviarAsync(usuario.Correo, "Tu código de verificación de GTrack", PlantillaCorreo.Crear(
                etiqueta: "Verificación de identidad",
                titulo: "Confirma que eres tú",
                saludo: "Hola,",
                parrafos: ["Usa este código para continuar con la edición de tu perfil de repartidor:"],
                codigo: codigo,
                nota: $"El código es válido por {MinutosVigenciaCodigo} minutos. Si no fuiste tú, ignora este mensaje: sin el código nadie puede editar tu perfil.",
                tipoNota: TipoNota.Aviso,
                resumen: $"Tu código de verificación es {codigo}. Vence en {MinutosVigenciaCodigo} minutos."));
            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el código de verificación al repartidor (usuario {UsuarioId})", usuarioId);
            return (false, MensajeErrorEnvio);
        }
    }

    public async Task<(bool Ok, string? Error)> VerificarCodigoAsync(int usuarioId, string codigo)
    {
        var actual = await codigos.ObtenerUltimoAsync(usuarioId);
        var ahora = DateTime.UtcNow;

        if (actual is null) return (false, MensajeCodigoExpirado);

        if (actual.BloqueadoHasta is { } hasta && hasta > ahora)
            return (false, MensajeBloqueo(hasta));

        if (actual.Verificado || actual.Usado || actual.Expira <= ahora)
            return (false, MensajeCodigoExpirado);

        if (actual.CodigoHash != TokenUtil.Hash(codigo.Trim()))
        {
            actual.Intentos++;
            var error = "Código incorrecto, intenta nuevamente";

            if (actual.Intentos >= MaxIntentosCodigo)
            {
                actual.BloqueadoHasta = ahora.AddMinutes(MinutosBloqueo);
                error = $"Superaste {MaxIntentosCodigo} intentos fallidos. La edición de tu perfil quedó bloqueada durante {MinutosBloqueo} minutos.";
            }

            await codigos.ActualizarAsync(actual);
            return (false, error);
        }

        actual.Verificado = true;
        actual.Expira = ahora.AddMinutes(MinutosVentanaEdicion);
        await codigos.ActualizarAsync(actual);
        return (true, null);
    }

    public async Task<bool> EdicionAutorizadaAsync(int usuarioId)
    {
        var c = await codigos.ObtenerUltimoAsync(usuarioId);
        return c is { Verificado: true, Usado: false } && c.Expira > DateTime.UtcNow;
    }

    public async Task<EditarRepartidorDto?> ObtenerParaEditarAsync(int usuarioId)
    {
        var rep = await db.Repartidores
            .AsNoTracking()
            .Include(r => r.Usuario)
            .FirstOrDefaultAsync(r => r.UsuarioId == usuarioId);
        if (rep?.Usuario is null) return null;

        return new EditarRepartidorDto
        {
            NombreCompleto = rep.NombreCompleto,
            Telefono = rep.Telefono,
            Correo = rep.Usuario.Correo,
            Vehiculo = rep.Vehiculo,
            Placa = rep.Placa
        };
    }

    public async Task<(bool Ok, string? Error)> EditarAsync(int usuarioId, EditarRepartidorDto dto)
    {
        if (!await EdicionAutorizadaAsync(usuarioId)) return (false, MensajeSinVerificacion);

        // Entre la verificación y el guardado le pudieron asignar un pedido
        var motivo = await MotivoNoEditableAsync(usuarioId);
        if (motivo is not null) return (false, motivo);

        try
        {
            var rep = await db.Repartidores
                .Include(r => r.Usuario)
                .FirstOrDefaultAsync(r => r.UsuarioId == usuarioId);
            if (rep?.Usuario is null) return (false, MensajeErrorGuardado);

            var correo = dto.Correo.Trim();
            var telefono = dto.Telefono.Trim();

            var otroConCorreo = await db.Usuarios.AnyAsync(u => u.Correo == correo && u.Id != usuarioId);
            if (otroConCorreo)
                return (false, "El correo ya está registrado en otra cuenta");

            var telefonoEnUso =
                await db.Negocios.AnyAsync(n => n.Telefono == telefono) ||
                await db.Repartidores.AnyAsync(r => r.Telefono == telefono && r.Id != rep.Id
                    && r.Usuario!.Estado != EstadoCuenta.Eliminado) ||
                await db.Administradores.AnyAsync(a => a.Telefono == telefono);
            if (telefonoEnUso)
                return (false, "El teléfono ya está registrado en otra cuenta");

            var conPlaca = dto.Vehiculo is TipoVehiculo.Moto or TipoVehiculo.Carro;

            rep.NombreCompleto = dto.NombreCompleto.Trim();
            rep.Telefono = telefono;
            rep.Vehiculo = dto.Vehiculo!.Value;
            rep.Placa = conPlaca ? ReglasValidacion.NormalizarPlaca(dto.Placa) : null;
            rep.Usuario.Correo = correo;

            // El código solo sirve para una edición
            var codigo = await codigos.ObtenerUltimoAsync(usuarioId);
            if (codigo is not null) codigo.Usado = true;

            await db.SaveChangesAsync();
            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al actualizar el perfil del repartidor (usuario {UsuarioId})", usuarioId);
            return (false, MensajeErrorGuardado);
        }
    }

    // ================= CU-12 Eliminar repartidor =================
    // Paso 4: el repartidor no puede tener entregas pendientes (RN-1-CU12)
    public async Task<(bool Ok, string? Error)> ValidarEliminacionPropiaAsync(int usuarioId)
    {
        var rep = await repartidores.ObtenerPorUsuarioIdAsync(usuarioId);
        if (rep is null) return (false, MensajeSinPermisos);

        if (await ContarPedidosPendientesAsync(rep.Id) > 0)
            return (false, MensajeEntregasPendientes); // FE-27-CU12

        return (true, null);
    }

    // Paso 6: valida la contraseña y da de baja la cuenta
    public async Task<(bool Ok, string? Error)> EliminarCuentaPropiaAsync(int usuarioId, string password)
    {
        // Se valida de nuevo: entre el paso 4 y el 6 le pudieron asignar un pedido
        var (ok, error) = await ValidarEliminacionPropiaAsync(usuarioId);
        if (!ok) return (false, error);

        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, MensajeSinPermisos);

        if (!PasswordCorrecta(usuario, password))
            return (false, MensajePasswordIncorrecta); // FE-28-CU12

        return await DarDeBajaAsync(usuario);
    }

    // FA-13-CU12: el negocio solo puede eliminar repartidores vinculados a él
    public async Task<(bool Ok, string? Error)> ValidarEliminacionPorNegocioAsync(int usuarioNegocioId, int repartidorId)
    {
        var rep = await RepartidorDelNegocioAsync(usuarioNegocioId, repartidorId);
        if (rep is null) return (false, MensajeSinPermisos); // FE-29-CU12

        if (await ContarPedidosPendientesAsync(rep.Id) > 0)
            return (false, MensajeEntregasPendientesNegocio);

        return (true, null);
    }

    // El negocio confirma con su propia contraseña (es quien tiene la sesión activa)
    public async Task<(bool Ok, string? Error, string? Nombre)> EliminarPorNegocioAsync(int usuarioNegocioId, int repartidorId, string password)
    {
        var (ok, error) = await ValidarEliminacionPorNegocioAsync(usuarioNegocioId, repartidorId);
        if (!ok) return (false, error, null);

        var usuarioNegocio = await usuarios.ObtenerPorIdAsync(usuarioNegocioId);
        if (usuarioNegocio is null) return (false, MensajeSinPermisos, null);

        if (!PasswordCorrecta(usuarioNegocio, password))
            return (false, MensajePasswordIncorrecta, null);

        var rep = await RepartidorDelNegocioAsync(usuarioNegocioId, repartidorId);
        if (rep?.Usuario is null) return (false, MensajeSinPermisos, null);

        var (eliminado, errorBaja) = await DarDeBajaAsync(rep.Usuario);
        return (eliminado, errorBaja, rep.NombreCompleto);
    }

    private async Task<Repartidor?> RepartidorDelNegocioAsync(int usuarioNegocioId, int repartidorId)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return null;

        var rep = await repartidores.ObtenerDeNegocioAsync(negocio.Id, repartidorId);
        return rep?.Usuario is null || rep.Usuario.Estado == EstadoCuenta.Eliminado ? null : rep;
    }

    // Baja lógica: se conserva el historial de pedidos pasados (paso 6 del CU-12).
    // Con estado "Eliminado" no puede volver a iniciar sesión y deja de contar como repartidor
    // vinculado del negocio (FE-26-CU11).
    private async Task<(bool Ok, string? Error)> DarDeBajaAsync(Usuario usuario)
    {
        try
        {
            usuario.Estado = EstadoCuenta.Eliminado;
            // Libera correo y documento para que se puedan registrar de nuevo
            usuario.LiberarIdentificadores();
            await usuarios.ActualizarAsync(usuario);
            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al eliminar la cuenta del repartidor (usuario {UsuarioId})", usuario.Id);
            return (false, "No fue posible eliminar la cuenta. Intenta nuevamente");
        }
    }

    private bool PasswordCorrecta(Usuario usuario, string password)
    {
        if (string.IsNullOrEmpty(usuario.PasswordHash) || string.IsNullOrEmpty(password)) return false;
        try
        {
            return hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, password) != PasswordVerificationResult.Failed;
        }
        catch (FormatException)
        {
            return false;
        }
    }

    private static string MensajeBloqueo(DateTime hasta)
    {
        var minutos = Math.Max(1, (int)Math.Ceiling((hasta - DateTime.UtcNow).TotalMinutes));
        return $"La edición de tu perfil está bloqueada por intentos fallidos. Intenta de nuevo en {minutos} minuto(s).";
    }
}
