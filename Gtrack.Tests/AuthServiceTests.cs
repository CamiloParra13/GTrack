namespace Gtrack.Tests;

public class AuthServiceTests
{
    private static Usuario UsuarioActivo(int intentos = 0, DateTime? bloqueadoHasta = null) => new()
    {
        Id = 1,
        Correo = "negocio@gtrack.local",
        Documento = "123",
        Rol = RolUsuario.Negocio,
        Estado = EstadoCuenta.Activo,
        PasswordHash = "HASH:Clave123",
        IntentosFallidos = intentos,
        BloqueadoHasta = bloqueadoHasta
    };

    [Fact]
    public async Task IniciarSesion_UsuarioNoExiste_RetornaErrorGenerico()
    {
        var repo = new UsuarioRepositoryFalso();
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "no-existe", Password = "x", Rol = RolUsuario.Negocio });

        Assert.Null(usuario);
        Assert.Equal("Usuario o contraseña incorrectos", error);
    }

    [Fact]
    public async Task IniciarSesion_CuentaBloqueadaVigente_RetornaMinutosRestantes()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo(bloqueadoHasta: DateTime.UtcNow.AddMinutes(10)));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "Clave123", Rol = RolUsuario.Negocio });

        Assert.Null(usuario);
        Assert.Contains("bloqueada temporalmente", error);
    }

    [Fact]
    public async Task IniciarSesion_PasswordIncorrecta_IncrementaIntentos()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo(intentos: 2));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "mala", Rol = RolUsuario.Negocio });

        Assert.Null(usuario);
        Assert.Equal("Usuario o contraseña incorrectos", error);
        Assert.True(repo.SeLlamoActualizar);
    }

    [Fact]
    public async Task IniciarSesion_QuintoIntentoFallido_BloqueaCuenta()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo(intentos: 4));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (_, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "mala", Rol = RolUsuario.Negocio });

        Assert.Contains("quedó bloqueada durante 15 minutos", error);
    }

    [Fact]
    public async Task IniciarSesion_CredencialesCorrectas_CuentaActiva_RetornaUsuario()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo());
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "Clave123", Rol = RolUsuario.Negocio });

        Assert.Null(error);
        Assert.NotNull(usuario);
    }

    [Theory]
    [InlineData(EstadoCuenta.PendienteValidacion, "aún no ha sido validada")]
    [InlineData(EstadoCuenta.Suspendido, "se encuentra suspendida")]
    public async Task IniciarSesion_CuentaNoActiva_RetornaMensajeSegunEstado(EstadoCuenta estado, string esperado)
    {
        var repo = new UsuarioRepositoryFalso();
        var usuario = UsuarioActivo();
        usuario.Estado = estado;
        repo.Usuarios.Add(usuario);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (resultado, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "Clave123", Rol = RolUsuario.Negocio });

        Assert.Null(resultado);
        Assert.Contains(esperado, error);
    }
}