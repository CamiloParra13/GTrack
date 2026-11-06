using Microsoft.AspNetCore.Identity;

public interface IRepartidorService
{
    Task<ResultadoRegistro> RegistrarAsync(int usuarioNegocioId, RegistroRepartidorDto dto);
    Task<List<Repartidor>> ListarAsync(int usuarioNegocioId);
}

public class RepartidorService(
    IRepartidorRepository repartidores,
    INegocioRepository negocios,
    IUsuarioRepository usuarios,
    IPasswordHasher<Usuario> hasher,
    IEmailService email,
    ILogger<RepartidorService> logger) : IRepartidorService
{
    public async Task<List<Repartidor>> ListarAsync(int usuarioNegocioId)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        return negocio is null ? [] : await repartidores.ListarPorNegocioAsync(negocio.Id);
    }

    public async Task<ResultadoRegistro> RegistrarAsync(int usuarioNegocioId, RegistroRepartidorDto dto)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return new(false, "No fue posible identificar tu negocio", false, null);

        var documento = dto.Documento.Trim();
        var correo = dto.Correo.Trim();
        var telefono = dto.Telefono.Trim();

        // RN-1-CU09: documento, correo y teléfono únicos
        if (await negocios.ExisteDocumentoAsync(documento))
            return new(false, "Este repartidor ya se encuentra registrado", false, null);   // FA-09-CU09
        if (await usuarios.ObtenerPorCorreoAsync(correo) is not null)
            return new(false, "El correo ya está registrado en el sistema", false, null);
        if (await repartidores.TelefonoEnUsoAsync(telefono))
            return new(false, "El teléfono ya está registrado en el sistema", false, null);

        var conPlaca = dto.Vehiculo is TipoVehiculo.Moto or TipoVehiculo.Carro;
        var password = GeneradorPassword.Temporal();

        var usuario = new Usuario
        {
            Correo = correo,
            Documento = documento,
            Rol = RolUsuario.Repartidor,
            Estado = EstadoCuenta.Activo
        };
        usuario.PasswordHash = hasher.HashPassword(usuario, password);

        var repartidor = new Repartidor
        {
            NegocioId = negocio.Id,          // RN-2-CU09
            NombreCompleto = dto.NombreCompleto.Trim(),
            Telefono = telefono,
            Vehiculo = dto.Vehiculo!.Value,
            Placa = conPlaca ? dto.Placa!.Trim().Replace("-", "").ToUpperInvariant() : null
        };

        await repartidores.RegistrarRepartidorAsync(usuario, repartidor);

        // FE-21-CU09: si falla el correo, el repartidor queda registrado igual
        try
        {
            await email.EnviarAsync(correo, "Tus credenciales de acceso a GTrack",
                $"Hola {repartidor.NombreCompleto}, el negocio {negocio.Nombre} te registró como repartidor en GTrack.\n" +
                $"Usuario: {correo} (o tu número de documento)\nContraseña temporal: {password}");
            return new(true, null, true, password);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudieron enviar las credenciales al repartidor {Correo}", correo);
            return new(true, null, false, password);
        }
    }
}