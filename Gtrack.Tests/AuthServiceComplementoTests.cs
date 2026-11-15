namespace Gtrack.Tests;

public class AuthServiceComplementoTests
{
    private static Usuario Usuario(EstadoCuenta estado = EstadoCuenta.Activo, int intentos = 0, DateTime? bloqueadoHasta = null) => new()
    {
        Id = 1,
        Correo = "negocio@gtrack.local",
        Documento = "123",
        Rol = RolUsuario.Negocio,
        Estado = estado,
        PasswordHash = "HASH:Clave123",
        IntentosFallidos = intentos,
        BloqueadoHasta = bloqueadoHasta
    };

    private static LoginDto Login(string password = "Clave123") =>
        new() { Identificador = "negocio@gtrack.local", Password = password, Rol = RolUsuario.Negocio };

    [Fact]
    public async Task IniciarSesion_BloqueoVencido_LimpiaBloqueoYPermiteEntrar()
    {
        var repo = new UsuarioRepositoryFalso();
        var u = Usuario(intentos: 3, bloqueadoHasta: DateTime.UtcNow.AddMinutes(-1));
        repo.Usuarios.Add(u);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(Login());

        Assert.NotNull(usuario);
        Assert.Null(error);
        Assert.Null(u.BloqueadoHasta);
        Assert.Equal(0, u.IntentosFallidos);
        Assert.True(repo.SeLlamoActualizar);
    }

    [Fact]
    public async Task IniciarSesion_CredencialesCorrectasConIntentosPrevios_ReiniciaContador()
    {
        var repo = new UsuarioRepositoryFalso();
        var u = Usuario(intentos: 2);
        repo.Usuarios.Add(u);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, _) = await servicio.IniciarSesionAsync(Login());

        Assert.NotNull(usuario);
        Assert.Equal(0, u.IntentosFallidos);
        Assert.True(repo.SeLlamoActualizar);
    }

    [Fact]
    public async Task IniciarSesion_CuentaRechazada_IncluyeElMotivo()
    {
        var repo = new UsuarioRepositoryFalso();
        var u = Usuario(EstadoCuenta.Rechazado);
        u.MotivoRechazo = "Documento ilegible";
        repo.Usuarios.Add(u);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(Login());

        Assert.Null(usuario);
        Assert.Contains("Documento ilegible", error);
    }

    [Fact]
    public async Task IniciarSesion_CuentaEliminada_RetornaErrorGenerico()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(Usuario(EstadoCuenta.Eliminado));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(Login());

        Assert.Null(usuario);
        Assert.Equal("Usuario o contraseña incorrectos", error);
    }
}