using Microsoft.Extensions.Logging.Abstractions;

public class AdministracionServiceTests
{
    private sealed class Escenario
    {
        public AdministracionRepositoryFalso Admins { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public EmailServiceFalso Email { get; } = new();

        public AdministracionService Servicio => new(
            Admins, Negocios, Usuarios, new PasswordHasherFalso(), Email,
            NullLogger<AdministracionService>.Instance);
    }

    private static RegistroAdministradorDto DtoValido() => new()
    {
        NombreCompleto = "Ana Gómez",
        Documento = "1122334",
        Correo = "ana@gtrack.local",
        Telefono = "3201234567"
    };

    [Fact]
    public async Task ListarNegocios_RetornaLoQueDevuelveElRepositorio()
    {
        var e = new Escenario();
        e.Admins.Negocios.Add(new NegocioAdminDto { Id = 1, Nombre = "Mi Negocio" });

        var lista = await e.Servicio.ListarNegociosAsync();

        Assert.Single(lista);
        Assert.Equal("Mi Negocio", lista[0].Nombre);
    }

    [Fact]
    public async Task ListarAdministradores_RetornaLoQueDevuelveElRepositorio()
    {
        var e = new Escenario();
        e.Admins.AdministradoresListados.Add(new AdministradorDto { NombreCompleto = "Ana Gómez" });

        var lista = await e.Servicio.ListarAdministradoresAsync();

        Assert.Single(lista);
    }

    [Theory]
    [InlineData(true)]
    [InlineData(false)]
    public async Task AprobarNegocio_DevuelveElResultadoDelRepositorio(bool resultado)
    {
        var e = new Escenario();
        e.Admins.ResultadoAprobar = resultado;

        var ok = await e.Servicio.AprobarNegocioAsync(7);

        Assert.Equal(resultado, ok);
        Assert.Equal(7, e.Admins.UltimoNegocioAprobado);
    }

    [Fact]
    public async Task RegistrarAdministrador_DocumentoYaExiste_RetornaError()
    {
        var e = new Escenario();
        e.Negocios.DocumentosExistentes.Add("1122334");

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("Este documento o correo ya se encuentra registrado", r.Error);
    }

    [Fact]
    public async Task RegistrarAdministrador_CorreoYaExiste_RetornaError()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario { Correo = "ana@gtrack.local" });

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("Este documento o correo ya se encuentra registrado", r.Error);
    }

    [Fact]
    public async Task RegistrarAdministrador_TelefonoEnUso_RetornaError()
    {
        var e = new Escenario();
        e.Admins.TelefonosEnUso.Add("3201234567");

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("El teléfono ya está registrado en el sistema", r.Error);
    }

    [Fact]
    public async Task RegistrarAdministrador_DatosValidos_CreaCuentaYEnviaCredenciales()
    {
        var e = new Escenario();

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido());

        Assert.True(r.Ok);
        Assert.True(r.CorreoEnviado);
        Assert.True(ValidadorPassword.EsValida(r.PasswordTemporal));
        Assert.Equal(RolUsuario.Administrador, e.Admins.UsuarioRegistrado!.Rol);
        Assert.Equal(EstadoCuenta.Activo, e.Admins.UsuarioRegistrado.Estado);
        Assert.Equal($"HASH:{r.PasswordTemporal}", e.Admins.UsuarioRegistrado.PasswordHash);
        Assert.Single(e.Email.Enviados);
    }

    [Fact]
    public async Task RegistrarAdministrador_FallaCorreo_IgualRegistra()
    {
        var e = new Escenario();
        e.Email.DebeFallar = true;

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido());

        Assert.True(r.Ok);
        Assert.False(r.CorreoEnviado);
        Assert.Single(e.Admins.Administradores);
    }
}