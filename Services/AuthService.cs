using Microsoft.AspNetCore.Identity;

public class AuthService(IUsuarioRepository repo, IPasswordHasher<Usuario> hasher) : IAuthService
{
    private const int MaxIntentos = 5;
    private const int MinutosBloqueo = 15;
    private const string MsgGenerico = "Usuario o contraseña incorrectos";

    public async Task<(Usuario? Usuario, string? Error)> IniciarSesionAsync(LoginDto dto)
    {
        // 1) campos no vacíos: ya lo valida el DTO
        // 2) usuario existe según el rol
        var usuario = await repo.ObtenerPorIdentificadorYRolAsync(dto.Identificador.Trim(), dto.Rol);
        if (usuario is null) return (null, MsgGenerico);

        // Bloqueo vigente (RN-1-CU02)
        var ahora = DateTime.UtcNow;
        if (usuario.BloqueadoHasta is { } hasta)
        {
            if (hasta > ahora)
            {
                var minutos = (int)Math.Ceiling((hasta - ahora).TotalMinutes);
                return (null, $"Tu cuenta está bloqueada temporalmente por intentos fallidos. Intenta de nuevo en {minutos} minuto(s).");
            }
            usuario.BloqueadoHasta = null;
            usuario.IntentosFallidos = 0;
        }

        // 3) contraseña coincide (RN-2-CU02: mensaje genérico)
        var resultado = hasher.VerifyHashedPassword(usuario, usuario.PasswordHash, dto.Password);
        if (resultado == PasswordVerificationResult.Failed)
        {
            usuario.IntentosFallidos++;
            string error = MsgGenerico;

            if (usuario.IntentosFallidos >= MaxIntentos)
            {
                usuario.BloqueadoHasta = ahora.AddMinutes(MinutosBloqueo);
                usuario.IntentosFallidos = 0;
                error = $"Superaste {MaxIntentos} intentos fallidos. Tu cuenta quedó bloqueada durante {MinutosBloqueo} minutos.";
            }

            await repo.ActualizarAsync(usuario);
            return (null, error);
        }

        // Credenciales correctas: reiniciar contador
        if (usuario.IntentosFallidos != 0 || usuario.BloqueadoHasta is not null)
        {
            usuario.IntentosFallidos = 0;
            usuario.BloqueadoHasta = null;
            await repo.ActualizarAsync(usuario);
        }

        // 4) cuenta activa (FA-02 y FE-7)
        return usuario.Estado switch
        {
            EstadoCuenta.Activo => (usuario, null),
            EstadoCuenta.PendienteValidacion => (null, "Tu cuenta aún no ha sido validada por un administrador"),
            EstadoCuenta.Suspendido => (null, "Tu cuenta se encuentra suspendida"),
            EstadoCuenta.Rechazado => (null, $"Tu solicitud de registro ha sido rechazada. Motivo: {usuario.MotivoRechazo}"),
            _ => (null, MsgGenerico)
        };
    }
}