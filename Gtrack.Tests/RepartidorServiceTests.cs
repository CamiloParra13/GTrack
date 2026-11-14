using Microsoft.Extensions.Logging.Abstractions;

public class RepartidorServiceTests
{
    private sealed class Escenario
    {
        public RepartidorRepositoryFalso Repartidores { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public EmailServiceFalso Email { get; } = new();

        public RepartidorService Servicio => new(
            Repartidores, Negocios, Usuarios, new PasswordHasherFalso(), Email,
            NullLogger<RepartidorService>.Instance);

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Mi Negocio" });
            return this;
        }
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

        var r = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("No fue posible identificar tu negocio", r.Error);
    }

    [Fact]
    public async Task Registrar_DocumentoYaRegistrado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Negocios.DocumentosExistentes.Add("987654");

        var r = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("Este repartidor ya se encuentra registrado", r.Error);
    }

    [Fact]
    public async Task Registrar_CorreoYaRegistrado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Usuarios.Usuarios.Add(new Usuario { Correo = "juan@gtrack.local" });

        var r = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("El correo ya está registrado en el sistema", r.Error);
    }

    [Fact]
    public async Task Registrar_TelefonoEnUso_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Repartidores.TelefonosEnUso.Add("3101234567");

        var r = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(r.Ok);
        Assert.Equal("El teléfono ya está registrado en el sistema", r.Error);
    }

    [Fact]
    public async Task Registrar_Moto_NormalizaLaPlaca()
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Placa = " abc-12d ";

        var r = await e.Servicio.RegistrarAsync(1, dto);

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

        var r = await e.Servicio.RegistrarAsync(1, dto);

        Assert.True(r.Ok);
        Assert.Null(e.Repartidores.Repartidores[0].Placa);
    }

    [Fact]
    public async Task Registrar_DatosValidos_CreaCuentaConPasswordTemporalYEnviaCorreo()
    {
        var e = new Escenario().ConNegocio();

        var r = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(r.Ok);
        Assert.Null(r.Error);
        Assert.True(r.CorreoEnviado);
        Assert.True(ValidadorPassword.EsValida(r.PasswordTemporal));

        var usuario = e.Repartidores.UsuarioRegistrado!;
        Assert.Equal(RolUsuario.Repartidor, usuario.Rol);
        Assert.Equal(EstadoCuenta.Activo, usuario.Estado);
        Assert.Equal($"HASH:{r.PasswordTemporal}", usuario.PasswordHash);
        Assert.Equal(10, e.Repartidores.Repartidores[0].NegocioId);
        Assert.Single(e.Email.Enviados);
    }

    [Fact]
    public async Task Registrar_FallaEnvioCorreo_IgualRegistraAlRepartidor()
    {
        var e = new Escenario().ConNegocio();
        e.Email.DebeFallar = true;

        var r = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(r.Ok);
        Assert.False(r.CorreoEnviado);
        Assert.NotNull(r.PasswordTemporal);
        Assert.True(e.Repartidores.SeLlamoRegistrar);
    }
}