using System.Security.Cryptography;
using Microsoft.AspNetCore.Identity;

public class NegocioService(
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    ICodigoVerificacionRepository codigos,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    ILogger<NegocioService> logger) : INegocioService
{
    public const string MensajeSinVerificacion = "Debes verificar tu identidad para editar tu perfil";

    private const int MaxIntentosCodigo = 3;        // RN-1-CU13
    private const int MinutosBloqueo = 15;          // FE-31-CU13
    private const int MinutosVigenciaCodigo = 10;
    private const int MinutosVentanaEdicion = 10;   // tiempo para guardar después de validar el código

    private const string MensajeErrorEnvio = "No fue posible enviar el código. Intenta nuevamente";        // FE-32
    private const string MensajeErrorGuardado = "No fue posible actualizar la información. Intenta Nuevamente"; // FE-33
    private const string MensajeCodigoExpirado = "El código expiró o ya no es válido. Solicita uno nuevo";

    // ================= CU-01 Registrar negocio =================
    public async Task<(bool Ok, string? Error, bool CorreoEnviado)> RegistrarAsync(RegistroNegocioDto dto)
    {
        var nombre = dto.Nombre.Trim();
        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        // Validación en cascada (paso 6): obligatorios (DTO) → documento → correo → teléfono → contraseña
        if (await negocios.ExisteDocumentoAsync(documento) || await usuarios.ObtenerPorCorreoAsync(correo) is not null)
            return (false, "El documento o correo ya está registrado. Inicia sesión o recupera tu contraseña", false); // FA-01

        if (await negocios.ExisteTelefonoAsync(telefono))
            return (false, "El teléfono ya está registrado", false);

        if (dto.Password != dto.ConfirmarPassword || !ValidadorPassword.EsValida(dto.Password))
            return (false, "Las contraseñas no coinciden o no cumplen el formato requerido", false);

        var usuario = new Usuario
        {
            Correo = correo,
            Documento = documento,
            Rol = RolUsuario.Negocio,
            Estado = EstadoCuenta.PendienteValidacion // RN-4-CU01
        };
        usuario.PasswordHash = hasher.HashPassword(usuario, dto.Password);

        var negocio = new Negocio
        {
            Nombre = nombre,
            TipoActividad = dto.TipoActividad.Trim(),
            Telefono = telefono,
            Direccion = dto.Direccion.Trim(),
            FechaRegistro = DateTime.UtcNow
        };

        await negocios.RegistrarAsync(usuario, negocio);

        // FE-3-CU01: si falla el correo, el registro se mantiene
        try
        {
            await email.EnviarAsync(correo, "Bienvenido a Gtrack",
                $"Hola {nombre}, recibimos el registro de tu negocio en Gtrack. " +
                "Tu cuenta será validada por un administrador y te avisaremos cuando esté activa.");
            return (true, null, true);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el correo de confirmación de registro a {Correo}", correo);
            return (true, null, false);
        }
    }

    // ================= Perfil =================
    public async Task<PerfilNegocioDto?> ObtenerPerfilAsync(int usuarioId)
    {
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
        if (usuario is null || negocio is null) return null;

        return new PerfilNegocioDto
        {
            Id = negocio.Id,
            Nombre = negocio.Nombre,
            TipoActividad = negocio.TipoActividad,
            Documento = usuario.Documento,
            Correo = usuario.Correo,
            Telefono = negocio.Telefono,
            Direccion = negocio.Direccion,
            FechaRegistro = negocio.FechaRegistro,
            Estado = usuario.Estado
        };
    }

    // ================= CU-25 Ver perfil público =================
    public async Task<PerfilPublicoNegocioDto?> ObtenerPerfilPublicoAsync(int negocioId)
    {
        var negocio = await negocios.BuscarPorIdAsync(negocioId);
        if (negocio is null) return null;

        return new PerfilPublicoNegocioDto
        {
            Nombre = negocio.Nombre,
            TipoActividad = negocio.TipoActividad,
            Direccion = negocio.Direccion,
            Telefono = negocio.Telefono,
            FechaRegistro = negocio.FechaRegistro
        };
    }

    // ================= CU-13 Editar negocio =================
    public async Task<(bool Ok, string? Error)> SolicitarCodigoAsync(int usuarioId)
    {
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, MensajeErrorEnvio);

        // Si la solicitud de edición está bloqueada, no se envía otro código
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

            await email.EnviarAsync(usuario.Correo, "Código de verificación de Gtrack",
                $"Tu código para editar el perfil de tu negocio es: {codigo}\n" +
                $"Es válido por {MinutosVigenciaCodigo} minutos. Si no fuiste tú, ignora este mensaje.");
            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el código de verificación al usuario {UsuarioId}", usuarioId);
            return (false, MensajeErrorEnvio); // FE-32-CU13
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
            var error = "Código incorrecto, intenta nuevamente"; // FE-31-CU13

            if (actual.Intentos >= MaxIntentosCodigo) // RN-1-CU13
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

    public async Task<EditarNegocioDto?> ObtenerParaEditarAsync(int usuarioId)
    {
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
        if (usuario is null || negocio is null) return null;

        return new EditarNegocioDto
        {
            Nombre = negocio.Nombre,
            TipoActividad = negocio.TipoActividad,
            Correo = usuario.Correo,
            Telefono = negocio.Telefono,
            Direccion = negocio.Direccion
        };
    }

    public async Task<(bool Ok, string? Error)> EditarAsync(int usuarioId, EditarNegocioDto dto)
    {
        if (!await EdicionAutorizadaAsync(usuarioId)) return (false, MensajeSinVerificacion);

        try
        {
            var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
            var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
            if (usuario is null || negocio is null) return (false, MensajeErrorGuardado);

            var correo = dto.Correo.Trim();
            var telefono = dto.Telefono.Trim();

            var otroConCorreo = await usuarios.ObtenerPorCorreoAsync(correo);
            if (otroConCorreo is not null && otroConCorreo.Id != usuario.Id)
                return (false, "El correo ya está registrado en otra cuenta");

            if (await negocios.ExisteTelefonoAsync(telefono, negocio.Id))
                return (false, "El teléfono ya está registrado en otro negocio");

            negocio.Nombre = dto.Nombre.Trim();
            negocio.TipoActividad = dto.TipoActividad.Trim();
            negocio.Telefono = telefono;
            negocio.Direccion = dto.Direccion.Trim();
            usuario.Correo = correo;

            await negocios.ActualizarAsync(negocio);
            await usuarios.ActualizarAsync(usuario);

            // El código solo sirve para una edición
            var codigo = await codigos.ObtenerUltimoAsync(usuarioId);
            if (codigo is not null)
            {
                codigo.Usado = true;
                await codigos.ActualizarAsync(codigo);
            }

            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al actualizar el perfil del usuario {UsuarioId}", usuarioId);
            return (false, MensajeErrorGuardado); // FE-33-CU13
        }
    }

    // ================= CU-11 Eliminar negocio =================
    public async Task<(bool Ok, string? Error)> ValidarEliminacionAsync(int usuarioId, string password)
    {
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, "No fue posible validar tu cuenta");

        if (hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, password) == PasswordVerificationResult.Failed)
            return (false, "Contraseña incorrecta"); // FE-25-CU11

        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
        if (negocio is null) return (false, "No fue posible validar tu cuenta");

        if (await negocios.TienePedidosActivosAsync(negocio.Id)) // RN-1-CU11
            return (false, "No puedes eliminar tu cuenta mientras tengas pedidos en curso"); // FE-24-CU11

        if (await negocios.TieneRepartidoresVinculadosAsync(negocio.Id))
            return (false, "Debes gestionar tus repartidores vinculados antes de eliminar la cuenta"); // FE-26-CU11

        return (true, null);
    }

    public async Task<(bool Ok, string? Error)> EliminarCuentaAsync(int usuarioId, string password)
    {
        // Se valida de nuevo: entre el primer modal y el segundo pudo cambiar algo
        var (ok, error) = await ValidarEliminacionAsync(usuarioId, password);
        if (!ok) return (false, error);

        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, "No fue posible validar tu cuenta");

        // Baja lógica: se conservan pedidos y transacciones (PE-22-CU11)
        usuario.Estado = EstadoCuenta.Eliminado;
        await usuarios.ActualizarAsync(usuario);
        return (true, null);
    }

    private static string MensajeBloqueo(DateTime hasta)
    {
        var minutos = Math.Max(1, (int)Math.Ceiling((hasta - DateTime.UtcNow).TotalMinutes));
        return $"La edición de tu perfil está bloqueada por intentos fallidos. Intenta de nuevo en {minutos} minuto(s).";
    }
}