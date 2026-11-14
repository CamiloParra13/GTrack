using Microsoft.EntityFrameworkCore;

public interface IRepartidorService
{
    // CU-09: registra al repartidor sin contraseña y le envía el correo para activar su cuenta
    Task<ResultadoRegistro> RegistrarAsync(int usuarioNegocioId, RegistroRepartidorDto dto, Func<string, string> construirEnlace);

    // Vuelve a enviar el correo de activación a un repartidor que aún no activa su cuenta
    Task<(bool Ok, string Mensaje)> ReenviarActivacionAsync(int usuarioNegocioId, int repartidorId, Func<string, string> construirEnlace);

    Task<List<Repartidor>> ListarAsync(int usuarioNegocioId);
}

public class RepartidorService(
    IRepartidorRepository repartidores,
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    IActivacionCuentaService activacion,
    ILogger<RepartidorService> logger) : IRepartidorService
{
    // Evita que el repartidor reciba una ráfaga de correos de activación
    private const int MaxCorreosActivacionPorHora = 3;

    public async Task<List<Repartidor>> ListarAsync(int usuarioNegocioId)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        return negocio is null ? [] : await repartidores.ListarPorNegocioAsync(negocio.Id);
    }

    public async Task<ResultadoRegistro> RegistrarAsync(int usuarioNegocioId, RegistroRepartidorDto dto, Func<string, string> construirEnlace)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return new(false, "No fue posible identificar tu negocio", false, null);

        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        // RN-1-CU09: documento, correo y teléfono únicos (FA-09-CU09)
        if (await negocios.ExisteDocumentoAsync(documento))
            return new(false, "Este número de documento ya se encuentra registrado.", false, null, nameof(dto.Documento));
        if (await usuarios.ObtenerPorCorreoAsync(correo) is not null)
            return new(false, "Este correo electrónico ya se encuentra registrado.", false, null, nameof(dto.Correo));
        if (await repartidores.TelefonoEnUsoAsync(telefono))
            return new(false, "Este teléfono ya se encuentra registrado.", false, null, nameof(dto.Telefono));

        var conPlaca = dto.Vehiculo is TipoVehiculo.Moto or TipoVehiculo.Carro;

        // La cuenta nace sin contraseña: el repartidor la crea cuando activa su cuenta desde el correo
        var usuario = new Usuario
        {
            Correo = correo,
            Documento = documento,
            PasswordHash = "",
            Rol = RolUsuario.Repartidor,
            Estado = EstadoCuenta.PendienteActivacion
        };

        var repartidor = new Repartidor
        {
            NegocioId = negocio.Id,          // RN-2-CU09
            NombreCompleto = dto.NombreCompleto.Trim(),
            Telefono = telefono,
            Vehiculo = dto.Vehiculo!.Value,
            Placa = conPlaca ? ReglasValidacion.NormalizarPlaca(dto.Placa) : null
        };

        try
        {
            await repartidores.RegistrarRepartidorAsync(usuario, repartidor);
        }
        catch (DbUpdateException ex)
        {
            logger.LogError(ex, "No se pudo guardar el repartidor {Correo}", correo);
            return new(false, "No fue posible registrar al repartidor. Intenta nuevamente", false, null);
        }

        // FE-21-CU09: si falla el correo, el repartidor queda registrado igual y el negocio puede reenviarlo
        var enviado = await activacion.EnviarEnlaceAsync(usuario, repartidor.NombreCompleto, negocio.Nombre, construirEnlace);
        return new(true, null, enviado, null);
    }

    public async Task<(bool Ok, string Mensaje)> ReenviarActivacionAsync(int usuarioNegocioId, int repartidorId, Func<string, string> construirEnlace)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return (false, "No fue posible identificar tu negocio");

        var repartidor = await repartidores.ObtenerDeNegocioAsync(negocio.Id, repartidorId);
        if (repartidor?.Usuario is null) return (false, "El repartidor no existe o no pertenece a tu negocio.");

        var usuario = repartidor.Usuario;
        if (usuario.Estado != EstadoCuenta.PendienteActivacion)
            return (false, $"{repartidor.NombreCompleto} ya activó su cuenta.");

        if (await activacion.EnviosUltimaHoraAsync(usuario.Id) >= MaxCorreosActivacionPorHora)
            return (false, "Ya enviaste varios correos de activación a este repartidor en la última hora. Intenta más tarde.");

        var enviado = await activacion.EnviarEnlaceAsync(usuario, repartidor.NombreCompleto, negocio.Nombre, construirEnlace);
        return enviado
            ? (true, $"Reenviamos el correo de activación a {usuario.Correo}.")
            : (false, "No fue posible enviar el correo de activación. Intenta nuevamente.");
    }
}
