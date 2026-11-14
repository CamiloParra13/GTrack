using System.Security.Cryptography;
using Microsoft.AspNetCore.Identity;

public class NegocioService(
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    ICodigoVerificacionRepository codigos,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    INotificacionService avisos,
    ILogger<NegocioService> logger) : INegocioService
{
    public const string MensajeSinVerificacion = "Debes verificar tu identidad para editar tu perfil";

    private const int MaxIntentosCodigo = 3;
    private const int MinutosBloqueo = 15;
    private const int MinutosVigenciaCodigo = 10;
    private const int MinutosVentanaEdicion = 10;

    private const string MensajeErrorEnvio = "No fue posible enviar el código. Intenta nuevamente";
    private const string MensajeErrorGuardado = "No fue posible actualizar la información. Intenta Nuevamente";
    private const string MensajeErrorEnvio = "No fue posible enviar el código. Intenta nuevamente";        // FE-32
    private const string MensajeErrorGuardado = "No fue posible actualizar la información. Intenta Nuevamente"; // FE-33
    private const string MensajeCodigoExpirado = "El código expiró o ya no es válido. Solicita uno nuevo";

    // ================= CU-01 Registrar negocio =================
    public async Task<(bool Ok, string? Error, bool CorreoEnviado)> RegistrarAsync(RegistroNegocioDto dto, string urlRevision)
    public async Task<(bool Ok, string? Error, bool CorreoEnviado)> RegistrarAsync(RegistroNegocioDto dto)
    {
        var nombre = dto.Nombre.Trim();
        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        if (await negocios.ExisteDocumentoAsync(documento) || await usuarios.ObtenerPorCorreoAsync(correo) is not null)
            return (false, "El documento o correo ya está registrado. Inicia sesión o recupera tu contraseña", false);

        if (await negocios.ExisteTelefonoAsync(telefono))
            return (false, "El teléfono ya está registrado", false);

        if (dto.Password != dto.ConfirmarPassword || !ValidadorPassword.EsValida(dto.Password))
            return (false, "Las contraseñas no coinciden o no cumplen el formato requerido", false);

        var usuario = new Usuario
        {
            Correo = correo,
            Documento = documento,
            Rol = RolUsuario.Negocio,
            Estado = EstadoCuenta.PendienteValidacion
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

        // Aviso a los administradores: hay un negocio nuevo esperando validación (si falla, el registro se mantiene)
        await AvisarAdministradoresAsync(negocio, documento, correo, urlRevision);

        // FE-3-CU01: si falla el correo, el registro se mantiene
        await avisos.NegocioPendienteAsync(nombre, documento, correo);

        try
        {
            await email.EnviarAsync(correo, "Bienvenido a GTrack", PlantillaCorreo.Crear(
                etiqueta: "Registro recibido",
                titulo: "¡Bienvenido a GTrack!",
                saludo: $"Hola, {nombre}",
                parrafos:
                [
                    "Recibimos el registro de tu negocio en GTrack.",
                    "Tu cuenta será validada por un administrador y te avisaremos cuando esté activa."
                ],
                datos: [("Negocio", nombre), ("Documento", documento), ("Correo", correo), ("Estado", "Pendiente de validación")],
                nota: "Mientras tu cuenta no sea validada no podrás iniciar sesión.",
                tipoNota: TipoNota.Info));
            await email.EnviarAsync(correo, "Bienvenido a GTrack", PlantillaCorreo.Crear(
                titulo: "¡Recibimos el registro de tu negocio!",
                saludo: $"Hola, {nombre}",
                parrafos:
                [
                    "Gracias por unirte a GTrack. Tu solicitud ya está en revisión.",
                    "Un administrador validará la información de tu negocio y te avisaremos por este mismo medio cuando tu cuenta esté activa."
                ],
                datos: [("Negocio", nombre), ("Documento", documento), ("Correo", correo)],
                nota: "Mientras tu cuenta esté en revisión no podrás iniciar sesión."));
            return (true, null, true);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el correo de confirmación de registro a {Correo}", correo);
            return (true, null, false);
        }
    }

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

    public async Task<(bool Ok, string? Error)> SolicitarCodigoAsync(int usuarioId)
    {
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
                parrafos: ["Usa este código para continuar con la edición del perfil de tu negocio:"],
                codigo: codigo,
                nota: $"El código es válido por {MinutosVigenciaCodigo} minutos. Si no fuiste tú, ignora este mensaje: sin el código nadie puede editar tu perfil.",
                tipoNota: TipoNota.Aviso,
                resumen: $"Tu código de verificación es {codigo}. Vence en {MinutosVigenciaCodigo} minutos."));
            var negocioActual = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
            await email.EnviarAsync(usuario.Correo, "Tu código de verificación de GTrack", PlantillaCorreo.Crear(
                titulo: "Tu código de verificación",
                saludo: negocioActual is null ? "Hola" : $"Hola, {negocioActual.Nombre}",
                parrafos: ["Usa este código para confirmar tu identidad y poder editar el perfil de tu negocio en GTrack."],
                codigo: codigo,
                nota: $"El código es válido por {MinutosVigenciaCodigo} minutos. Si no fuiste tú, ignora este mensaje y no compartas este código con nadie."));
            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el código de verificación al usuario {UsuarioId}", usuarioId);
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
            return (false, MensajeErrorGuardado);
        }
    }

    public async Task<(bool Ok, string? Error)> ValidarEliminacionAsync(int usuarioId, string password)
    {
        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, "No fue posible validar tu cuenta");

        if (hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, password) == PasswordVerificationResult.Failed)
            return (false, "Contraseña incorrecta");

        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
        if (negocio is null) return (false, "No fue posible validar tu cuenta");

        if (await negocios.TienePedidosActivosAsync(negocio.Id))
            return (false, "No puedes eliminar tu cuenta mientras tengas pedidos en curso");

        if (await negocios.TieneRepartidoresVinculadosAsync(negocio.Id))
            return (false, "Debes gestionar tus repartidores vinculados antes de eliminar la cuenta");

        return (true, null);
    }

    public async Task<(bool Ok, string? Error)> EliminarCuentaAsync(int usuarioId, string password)
    {
        var (ok, error) = await ValidarEliminacionAsync(usuarioId, password);
        if (!ok) return (false, error);

        var usuario = await usuarios.ObtenerPorIdAsync(usuarioId);
        if (usuario is null) return (false, "No fue posible validar tu cuenta");

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