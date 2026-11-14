using Microsoft.Extensions.Logging.Abstractions;

public class NegocioServiceTests
{
    private static NegocioService Crear(
        NegocioRepositoryFalso negocios,
        UsuarioRepositoryFalso usuarios,
        CodigoVerificacionRepositoryFalso codigos,
        EmailServiceFalso email) =>
        new(negocios, usuarios, codigos, new PasswordHasherFalso(), email, NullLogger<NegocioService>.Instance);

    private static RegistroNegocioDto DtoValido() => new()
    {
        Nombre = "Mi Negocio",
        TipoActividad = "Restaurante",
        Documento = "123456",
        Correo = "nuevo@gtrack.local",
        Telefono = "3001234567",
        Direccion = "Calle 1 # 2-3",
        Password = "Clave123",
        ConfirmarPassword = "Clave123"
    };

    // ===== CU-01 Registrar negocio =====

    [Fact]
    public async Task Registrar_DocumentoYaExiste_RetornaError()
    {
        var negocios = new NegocioRepositoryFalso();
        negocios.DocumentosExistentes.Add("123456");
        var servicio = Crear(negocios, new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(DtoValido());

        Assert.False(ok);
        Assert.Contains("ya está registrado", error);
    }

    [Fact]
    public async Task Registrar_CorreoYaExiste_RetornaError()
    {
        var usuarios = new UsuarioRepositoryFalso();
        usuarios.Usuarios.Add(new Usuario { Correo = "nuevo@gtrack.local" });
        var servicio = Crear(new NegocioRepositoryFalso(), usuarios, new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(DtoValido());

        Assert.False(ok);
        Assert.Contains("ya está registrado", error);
    }

    [Fact]
    public async Task Registrar_TelefonoYaExiste_RetornaError()
    {
        var negocios = new NegocioRepositoryFalso();
        negocios.TelefonosExistentes.Add("3001234567");
        var servicio = Crear(negocios, new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(DtoValido());

        Assert.False(ok);
        Assert.Equal("El teléfono ya está registrado", error);
    }

    [Theory]
    [InlineData("Clave123", "Distinta123")] // no coinciden
    [InlineData("abcdef", "abcdef")]        // sin dígito
    public async Task Registrar_PasswordInvalida_RetornaError(string password, string confirmar)
    {
        var dto = DtoValido();
        dto.Password = password;
        dto.ConfirmarPassword = confirmar;
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(dto);

        Assert.False(ok);
        Assert.Contains("contraseñas", error);
    }

    [Fact]
    public async Task Registrar_DatosValidos_RegistraYEnviaCorreo()
    {
        var negocios = new NegocioRepositoryFalso();
        var servicio = Crear(negocios, new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, correoEnviado) = await servicio.RegistrarAsync(DtoValido());

        Assert.True(ok);
        Assert.Null(error);
        Assert.True(correoEnviado);
        Assert.True(negocios.SeLlamoRegistrar);
    }

    [Fact]
    public async Task Registrar_FallaEnvioCorreo_IgualRegistraPeroSinCorreo()
    {
        var email = new EmailServiceFalso { DebeFallar = true };
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), email);

        var (ok, error, correoEnviado) = await servicio.RegistrarAsync(DtoValido());

        Assert.True(ok);
        Assert.Null(error);
        Assert.False(correoEnviado);
    }

    // ===== CU-13 Solicitar código =====

    [Fact]
    public async Task SolicitarCodigo_UsuarioNoExiste_RetornaError()
    {
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error) = await servicio.SolicitarCodigoAsync(1);

        Assert.False(ok);
        Assert.Equal("No fue posible enviar el código. Intenta nuevamente", error);
    }

    [Fact]
    public async Task SolicitarCodigo_BloqueadoVigente_RetornaMensajeDeBloqueo()
    {
        var usuarios = new UsuarioRepositoryFalso();
        usuarios.Usuarios.Add(new Usuario { Id = 1, Correo = "n@gtrack.local" });
        var codigos = new CodigoVerificacionRepositoryFalso();
        codigos.Codigos.Add(new CodigoVerificacion { UsuarioId = 1, BloqueadoHasta = DateTime.UtcNow.AddMinutes(5) });
        var servicio = Crear(new NegocioRepositoryFalso(), usuarios, codigos, new EmailServiceFalso());

        var (ok, error) = await servicio.SolicitarCodigoAsync(1);

        Assert.False(ok);
        Assert.Contains("bloqueada por intentos fallidos", error);
    }

    [Fact]
    public async Task SolicitarCodigo_Exitoso_GeneraYEnviaCodigo()
    {
        var usuarios = new UsuarioRepositoryFalso();
        usuarios.Usuarios.Add(new Usuario { Id = 1, Correo = "n@gtrack.local" });
        var codigos = new CodigoVerificacionRepositoryFalso();
        var email = new EmailServiceFalso();
        var servicio = Crear(new NegocioRepositoryFalso(), usuarios, codigos, email);

        var (ok, error) = await servicio.SolicitarCodigoAsync(1);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Single(codigos.Codigos);
        Assert.Single(email.Enviados);
    }

    // ===== CU-13 Verificar código =====

    [Fact]
    public async Task VerificarCodigo_NoHayCodigo_RetornaExpirado()
    {
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error) = await servicio.VerificarCodigoAsync(1, "123456");

        Assert.False(ok);
        Assert.Equal("El código expiró o ya no es válido. Solicita uno nuevo", error);
    }

    [Fact]
    public async Task VerificarCodigo_Incorrecto_IncrementaIntentos()
    {
        var codigos = new CodigoVerificacionRepositoryFalso();
        codigos.Codigos.Add(new CodigoVerificacion
        {
            UsuarioId = 1,
            CodigoHash = TokenUtil.Hash("111111"),
            Expira = DateTime.UtcNow.AddMinutes(10)
        });
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), codigos, new EmailServiceFalso());

        var (ok, error) = await servicio.VerificarCodigoAsync(1, "999999");

        Assert.False(ok);
        Assert.Equal("Código incorrecto, intenta nuevamente", error);
        Assert.Equal(1, codigos.Codigos[0].Intentos);
    }

    [Fact]
    public async Task VerificarCodigo_Correcto_MarcaVerificado()
    {
        var codigos = new CodigoVerificacionRepositoryFalso();
        codigos.Codigos.Add(new CodigoVerificacion
        {
            UsuarioId = 1,
            CodigoHash = TokenUtil.Hash("111111"),
            Expira = DateTime.UtcNow.AddMinutes(10)
        });
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), codigos, new EmailServiceFalso());

        var (ok, error) = await servicio.VerificarCodigoAsync(1, "111111");

        Assert.True(ok);
        Assert.Null(error);
        Assert.True(codigos.Codigos[0].Verificado);
    }

    // ===== CU-11 Eliminar negocio =====

    [Fact]
    public async Task ValidarEliminacion_TienePedidosActivos_RetornaError()
    {
        var usuarios = new UsuarioRepositoryFalso();
        var usuario = new Usuario { Id = 1, PasswordHash = "HASH:Clave123" };
        usuarios.Usuarios.Add(usuario);
        var negocios = new NegocioRepositoryFalso();
        negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
        negocios.TienePedidosActivos = true;
        var servicio = Crear(negocios, usuarios, new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error) = await servicio.ValidarEliminacionAsync(1, "Clave123");

        Assert.False(ok);
        Assert.Contains("pedidos en curso", error);
    }

    [Fact]
    public async Task ValidarEliminacion_SinPendientes_Permite()
    {
        var usuarios = new UsuarioRepositoryFalso();
        usuarios.Usuarios.Add(new Usuario { Id = 1, PasswordHash = "HASH:Clave123" });
        var negocios = new NegocioRepositoryFalso();
        negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
        var servicio = Crear(negocios, usuarios, new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error) = await servicio.ValidarEliminacionAsync(1, "Clave123");

        Assert.True(ok);
        Assert.Null(error);
    }
}