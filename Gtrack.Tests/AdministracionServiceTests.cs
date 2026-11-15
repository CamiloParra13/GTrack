using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;

public class AdministracionServiceTests
{
    private const string UrlLogin = "https://prueba/login";
    private static string Enlace(string token) => $"https://prueba/activar?t={token}";

    private sealed class Escenario
    {
        public AdministracionRepositoryFalso Admins { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public IActivacionCuentaService Activacion { get; } = Substitute.For<IActivacionCuentaService>();
        public EmailServiceFalso Email { get; } = new();
        public AdministracionService Servicio { get; }

        public Escenario()
        {
            Servicio = new AdministracionService(
                Admins, Negocios, Usuarios, Activacion, Email,
                NullLogger<AdministracionService>.Instance);
        }

        public void ActivacionEnvia(bool resultado) =>
            Activacion.EnviarEnlaceAsync(
                    Arg.Any<Usuario>(), Arg.Any<string>(), Arg.Any<string?>(), Arg.Any<Func<string, string>>())
                .Returns(resultado);
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

    // ===== Aprobar negocio (CU-18) =====

    [Fact]
    public async Task AprobarNegocio_RepositorioRechaza_RetornaFalsoFalso()
    {
        var e = new Escenario();
        e.Admins.ResultadoAprobar = false;

        var (ok, correoEnviado) = await e.Servicio.AprobarNegocioAsync(7, UrlLogin);

        Assert.False(ok);
        Assert.False(correoEnviado);
        Assert.Equal(7, e.Admins.UltimoNegocioAprobado);
    }

    [Fact]
    public async Task AprobarNegocio_AprobadoPeroNegocioNoEncontrado_RetornaOkSinCorreo()
    {
        var e = new Escenario();
        e.Admins.ResultadoAprobar = true;   // los fakes de Negocios/Usuarios están vacíos

        var (ok, correoEnviado) = await e.Servicio.AprobarNegocioAsync(7, UrlLogin);

        Assert.True(ok);
        Assert.False(correoEnviado);
        Assert.Empty(e.Email.Enviados);
    }

    // ===== Registrar administrador (CU-26) =====

    [Fact]
    public async Task RegistrarAdministrador_DocumentoYaExiste_RetornaError()
    {
        var e = new Escenario();
        e.Negocios.DocumentosExistentes.Add("1122334");

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este documento o correo ya se encuentra registrado", r.Error);
    }

    [Fact]
    public async Task RegistrarAdministrador_CorreoYaExiste_RetornaError()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario { Correo = "ana@gtrack.local" });

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este documento o correo ya se encuentra registrado", r.Error);
    }

    [Fact]
    public async Task RegistrarAdministrador_TelefonoEnUso_RetornaError()
    {
        var e = new Escenario();
        e.Admins.TelefonosEnUso.Add("3201234567");

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("El teléfono ya está registrado en el sistema", r.Error);
    }

    [Fact]
    public async Task RegistrarAdministrador_DatosValidos_CreaCuentaPendienteYEnviaEnlace()
    {
        var e = new Escenario();
        e.ActivacionEnvia(true);

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido(), Enlace);

        Assert.True(r.Ok);
        Assert.True(r.CorreoEnviado);
        Assert.Null(r.PasswordTemporal);
        Assert.Equal(RolUsuario.Administrador, e.Admins.UsuarioRegistrado!.Rol);
        Assert.Equal(EstadoCuenta.PendienteActivacion, e.Admins.UsuarioRegistrado.Estado);
        Assert.Equal("", e.Admins.UsuarioRegistrado.PasswordHash);
        await e.Activacion.Received(1).EnviarEnlaceAsync(
            e.Admins.UsuarioRegistrado, "Ana Gómez", Arg.Any<string?>(), Arg.Any<Func<string, string>>());
    }

    [Fact]
    public async Task RegistrarAdministrador_FallaCorreo_IgualRegistra()
    {
        var e = new Escenario();
        e.ActivacionEnvia(false);

        var r = await e.Servicio.RegistrarAdministradorAsync(DtoValido(), Enlace);

        Assert.True(r.Ok);
        Assert.False(r.CorreoEnviado);
        Assert.Single(e.Admins.Administradores);
    }

    // ===== Reenviar activación =====

    [Fact]
    public async Task ReenviarActivacion_UsuarioNoExiste_RetornaError()
    {
        var e = new Escenario();

        var (ok, mensaje) = await e.Servicio.ReenviarActivacionAsync(99, Enlace);

        Assert.False(ok);
        Assert.Equal("El administrador no existe.", mensaje);
    }

    [Fact]
    public async Task ReenviarActivacion_UsuarioNoEsAdministrador_RetornaError()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario { Id = 5, Rol = RolUsuario.Negocio, Correo = "n@gtrack.local" });

        var (ok, mensaje) = await e.Servicio.ReenviarActivacionAsync(5, Enlace);

        Assert.False(ok);
        Assert.Equal("El administrador no existe.", mensaje);
    }

    [Fact]
    public async Task ReenviarActivacion_YaActivo_RetornaError()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario
        {
            Id = 5,
            Rol = RolUsuario.Administrador,
            Estado = EstadoCuenta.Activo,
            Correo = "ana@gtrack.local"
        });

        var (ok, mensaje) = await e.Servicio.ReenviarActivacionAsync(5, Enlace);

        Assert.False(ok);
        Assert.Contains("ya activó su cuenta", mensaje);
        await e.Activacion.DidNotReceiveWithAnyArgs().EnviarEnlaceAsync(default!, default!, default, default!);
    }

    [Fact]
    public async Task ReenviarActivacion_LimiteDeEnviosPorHora_RetornaError()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario
        {
            Id = 5,
            Rol = RolUsuario.Administrador,
            Estado = EstadoCuenta.PendienteActivacion,
            Correo = "ana@gtrack.local"
        });
        e.Activacion.EnviosUltimaHoraAsync(5).Returns(3);

        var (ok, mensaje) = await e.Servicio.ReenviarActivacionAsync(5, Enlace);

        Assert.False(ok);
        Assert.Contains("última hora", mensaje);
    }

    [Theory]
    [InlineData(true)]
    [InlineData(false)]
    public async Task ReenviarActivacion_Pendiente_RetornaSegunElEnvio(bool enviado)
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario
        {
            Id = 5,
            Rol = RolUsuario.Administrador,
            Estado = EstadoCuenta.PendienteActivacion,
            Correo = "ana@gtrack.local"
        });
        e.Activacion.EnviosUltimaHoraAsync(5).Returns(0);
        e.ActivacionEnvia(enviado);

        var (ok, mensaje) = await e.Servicio.ReenviarActivacionAsync(5, Enlace);

        Assert.Equal(enviado, ok);
        if (enviado) Assert.Contains("ana@gtrack.local", mensaje);
    }
}