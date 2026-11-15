using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;

namespace Gtrack.Tests;

public class RepartidorServiceTests
{
    private static string Enlace(string token) => $"https://prueba/activar?t={token}";

    private sealed class Escenario
    {
        public RepartidorRepositoryFalso Repartidores { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public IActivacionCuentaService Activacion { get; } = Substitute.For<IActivacionCuentaService>();

        public RepartidorService Servicio => new(
            Repartidores, Negocios, Usuarios, Activacion,
            NullLogger<RepartidorService>.Instance);

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Mi Negocio" });
            return this;
        }

        // Simula que el correo de activación sale (true) o falla (false)
        public void ActivacionEnvia(bool resultado) =>
            Activacion.EnviarEnlaceAsync(
                    Arg.Any<Usuario>(), Arg.Any<string>(), Arg.Any<string?>(), Arg.Any<Func<string, string>>())
                .Returns(resultado);
    }

    private static RegistroRepartidorDto DtoValido() => new()
    {
        NombreCompleto = "Juan Pérez",
        Documento = "987654",
        Telefono = "3101234567",
        Correo = "juan@gtrack.local",
        Vehiculo = TipoVehiculo.Moto,
        Placa = "abc-12d"
    };

    // ===== Listar =====

    [Fact]
    public async Task Listar_NegocioNoExiste_RetornaListaVacia()
    {
        var e = new Escenario();

        var lista = await e.Servicio.ListarAsync(1);

        Assert.Empty(lista);
    }

    [Fact]
    public async Task Listar_NegocioExiste_RetornaSoloSusRepartidores()
    {
        var e = new Escenario().ConNegocio();
        e.Repartidores.Repartidores.Add(new Repartidor { Id = 1, NegocioId = 10 });
        e.Repartidores.Repartidores.Add(new Repartidor { Id = 2, NegocioId = 99 });

        var lista = await e.Servicio.ListarAsync(1);

        Assert.Single(lista);
        Assert.Equal(1, lista[0].Id);
    }

    // ===== Registrar =====

    [Fact]
    public async Task Registrar_NegocioNoIdentificado_RetornaError()
    {
        var e = new Escenario();

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("No fue posible identificar tu negocio", r.Error);
    }

    [Fact]
    public async Task Registrar_DocumentoYaRegistrado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Negocios.DocumentosExistentes.Add("987654");

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este número de documento ya se encuentra registrado.", r.Error);
    }

    [Fact]
    public async Task Registrar_CorreoYaRegistrado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Usuarios.Usuarios.Add(new Usuario { Correo = "juan@gtrack.local" });

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este correo electrónico ya se encuentra registrado.", r.Error);
    }

    [Fact]
    public async Task Registrar_TelefonoEnUso_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Repartidores.TelefonosEnUso.Add("3101234567");

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este teléfono ya se encuentra registrado.", r.Error);
    }

    [Fact]
    public async Task Registrar_Moto_NormalizaLaPlaca()
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Placa = " abc-12d ";

        var r = await e.Servicio.RegistrarAsync(1, dto, Enlace);

        Assert.True(r.Ok);
        Assert.Equal("ABC12D", e.Repartidores.Repartidores[0].Placa);
    }

    [Fact]
    public async Task Registrar_Bicicleta_NoGuardaPlaca()
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Vehiculo = TipoVehiculo.Bicicleta;
        dto.Placa = "XYZ123";

        var r = await e.Servicio.RegistrarAsync(1, dto, Enlace);

        Assert.True(r.Ok);
        Assert.Null(e.Repartidores.Repartidores[0].Placa);
    }

    [Fact]
    public async Task Registrar_DatosValidos_CreaCuentaPendienteYEnviaEnlace()
    {
        var e = new Escenario().ConNegocio();
        e.ActivacionEnvia(true);

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.True(r.Ok);
        Assert.Null(r.Error);
        Assert.True(r.CorreoEnviado);
        Assert.Null(r.PasswordTemporal);

        var usuario = e.Repartidores.UsuarioRegistrado!;
        Assert.Equal(RolUsuario.Repartidor, usuario.Rol);
        Assert.Equal(EstadoCuenta.PendienteActivacion, usuario.Estado);
        Assert.Equal("", usuario.PasswordHash);
        Assert.Equal(10, e.Repartidores.Repartidores[0].NegocioId);
        await e.Activacion.Received(1).EnviarEnlaceAsync(
            usuario, "Juan Pérez", "Mi Negocio", Arg.Any<Func<string, string>>());
    }

    [Fact]
    public async Task Registrar_FallaEnvioCorreo_IgualRegistraAlRepartidor()
    {
        var e = new Escenario().ConNegocio();
        e.ActivacionEnvia(false);

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.True(r.Ok);
        Assert.False(r.CorreoEnviado);
        Assert.Null(r.PasswordTemporal);
        Assert.True(e.Repartidores.SeLlamoRegistrar);
    }
}