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
    INotificacionService avisos,
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

        if (await negocios.ExisteDocumentoAsync(documento))
            return new(false, "Este repartidor ya se encuentra registrado", false, null);
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
            NegocioId = negocio.Id,
            NombreCompleto = dto.NombreCompleto.Trim(),
            Telefono = telefono,
            Vehiculo = dto.Vehiculo!.Value,
            Placa = conPlaca ? dto.Placa!.Trim().Replace("-", "").ToUpperInvariant() : null
        };

        await repartidores.RegistrarRepartidorAsync(usuario, repartidor);

        await avisos.RepartidorRegistradoAsync(usuarioNegocioId, repartidor.NombreCompleto);

        try
        {
            await email.EnviarAsync(correo, "Tus credenciales de acceso a GTrack", PlantillaCorreo.Crear(
                titulo: "Tu cuenta de repartidor está lista",
                saludo: $"Hola, {repartidor.NombreCompleto}",
                parrafos: [$"El negocio {negocio.Nombre} te registró como repartidor en GTrack. Estas son tus credenciales de acceso:"],
                datos: [("Usuario", correo), ("O tu documento", documento), ("Contraseña temporal", password)],
                nota: "Guarda esta información en un lugar seguro y no la compartas con nadie."));
            return new(true, null, true, password);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudieron enviar las credenciales al repartidor {Correo}", correo);
            return new(true, null, false, password);
        }
    }
}