using Microsoft.Extensions.Logging.Abstractions;

namespace Gtrack.Tests;

public class NegocioServicePerfilYEdicionTests
{
    private sealed class Escenario
    {
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public CodigoVerificacionRepositoryFalso Codigos { get; } = new();
        public EmailServiceFalso Email { get; } = new();

        public NegocioService Servicio => new(
            Negocios, Usuarios, Codigos, new PasswordHasherFalso(), Email,
            NullLogger<NegocioService>.Instance);

        public Usuario AgregarUsuario(int id = 1, string correo = "negocio@gtrack.local")
        {
            var u = new Usuario
            {
                Id = id,
                Correo = correo,
                Documento = "123456",
                PasswordHash = "HASH:Clave123",
                Rol = RolUsuario.Negocio,
                Estado = EstadoCuenta.Activo
            };
            Usuarios.Usuarios.Add(u);
            return u;
        }

        public Negocio AgregarNegocio(int id = 10, int usuarioId = 1)
        {
            var n = new Negocio
            {
                Id = id,
                UsuarioId = usuarioId,
                Nombre = "Mi Negocio",
                TipoActividad = "Restaurante",
                Telefono = "3001234567",
                Direccion = "Calle 1 # 2-3"
            };
            Negocios.Negocios.Add(n);
            return n;
        }

        public CodigoVerificacion AgregarCodigoAutorizado(int usuarioId = 1)
        {
            var c = new CodigoVerificacion
            {
                UsuarioId = usuarioId,
                Verificado = true,
                Usado = false,
                Expira = DateTime.UtcNow.AddMinutes(5)
            };
            Codigos.Codigos.Add(c);
            return c;
        }
    }

    private static EditarNegocioDto DtoEditar() => new()
    {
        Nombre = "Nuevo Nombre",
        TipoActividad = "Cafetería",
        Correo = "nuevo@gtrack.local",
        Telefono = "3009999999",
        Direccion = "Carrera 5 # 6-7"
    };

    // ===== Perfil =====

    [Fact]
    public async Task ObtenerPerfil_NoExiste_RetornaNull()
    {
        var e = new Escenario();

        var perfil = await e.Servicio.ObtenerPerfilAsync(1);

        Assert.Null(perfil);
    }

    [Fact]
    public async Task ObtenerPerfil_Existe_RetornaDatosDeUsuarioYNegocio()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarNegocio();

        var perfil = await e.Servicio.ObtenerPerfilAsync(1);

        Assert.NotNull(perfil);
        Assert.Equal("Mi Negocio", perfil!.Nombre);
        Assert.Equal("negocio@gtrack.local", perfil.Correo);
        Assert.Equal("123456", perfil.Documento);
        Assert.Equal(EstadoCuenta.Activo, perfil.Estado);
    }

    [Fact]
    public async Task ObtenerPerfilPublico_NoExiste_RetornaNull()
    {
        var e = new Escenario();

        var perfil = await e.Servicio.ObtenerPerfilPublicoAsync(99);

        Assert.Null(perfil);
    }

    [Fact]
    public async Task ObtenerPerfilPublico_Existe_RetornaDatosPublicos()
    {
        var e = new Escenario();
        e.AgregarNegocio(id: 10);

        var perfil = await e.Servicio.ObtenerPerfilPublicoAsync(10);

        Assert.NotNull(perfil);
        Assert.Equal("Mi Negocio", perfil!.Nombre);
        Assert.Equal("3001234567", perfil.Telefono);
    }

    // ===== Solicitar y verificar código =====

    [Fact]
    public async Task SolicitarCodigo_FallaEnvioCorreo_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.Email.DebeFallar = true;

        var (ok, error) = await e.Servicio.SolicitarCodigoAsync(1);

        Assert.False(ok);
        Assert.Equal("No fue posible enviar el código. Intenta nuevamente", error);
    }

    [Fact]
    public async Task VerificarCodigo_BloqueadoVigente_RetornaMensajeDeBloqueo()
    {
        var e = new Escenario();
        e.Codigos.Codigos.Add(new CodigoVerificacion
        {
            UsuarioId = 1,
            Expira = DateTime.UtcNow.AddMinutes(10),
            BloqueadoHasta = DateTime.UtcNow.AddMinutes(5)
        });

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(1, "111111");

        Assert.False(ok);
        Assert.Contains("bloqueada por intentos fallidos", error);
    }

    [Theory]
    [InlineData(true, false, 10)]   // ya verificado
    [InlineData(false, true, 10)]   // ya usado
    [InlineData(false, false, -1)]  // vencido
    public async Task VerificarCodigo_VerificadoUsadoOVencido_RetornaExpirado(bool verificado, bool usado, int minutos)
    {
        var e = new Escenario();
        e.Codigos.Codigos.Add(new CodigoVerificacion
        {
            UsuarioId = 1,
            CodigoHash = TokenUtil.Hash("111111"),
            Verificado = verificado,
            Usado = usado,
            Expira = DateTime.UtcNow.AddMinutes(minutos)
        });

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(1, "111111");

        Assert.False(ok);
        Assert.Equal("El código expiró o ya no es válido. Solicita uno nuevo", error);
    }

    [Fact]
    public async Task VerificarCodigo_TercerIntentoFallido_BloqueaEdicion()
    {
        var e = new Escenario();
        var codigo = new CodigoVerificacion
        {
            UsuarioId = 1,
            CodigoHash = TokenUtil.Hash("111111"),
            Intentos = 2,
            Expira = DateTime.UtcNow.AddMinutes(10)
        };
        e.Codigos.Codigos.Add(codigo);

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(1, "999999");

        Assert.False(ok);
        Assert.Contains("Superaste 3 intentos fallidos", error);
        Assert.NotNull(codigo.BloqueadoHasta);
    }

    // ===== Edición autorizada =====

    [Theory]
    [InlineData(true, false, 5, true)]
    [InlineData(false, false, 5, false)]  // sin verificar
    [InlineData(true, true, 5, false)]    // ya usado
    [InlineData(true, false, -1, false)]  // vencido
    public async Task EdicionAutorizada_SegunEstadoDelCodigo(bool verificado, bool usado, int minutos, bool esperado)
    {
        var e = new Escenario();
        e.Codigos.Codigos.Add(new CodigoVerificacion
        {
            UsuarioId = 1,
            Verificado = verificado,
            Usado = usado,
            Expira = DateTime.UtcNow.AddMinutes(minutos)
        });

        var autorizada = await e.Servicio.EdicionAutorizadaAsync(1);

        Assert.Equal(esperado, autorizada);
    }

    [Fact]
    public async Task EdicionAutorizada_SinCodigo_RetornaFalse()
    {
        var e = new Escenario();

        Assert.False(await e.Servicio.EdicionAutorizadaAsync(1));
    }

    // ===== Obtener para editar =====

    [Fact]
    public async Task ObtenerParaEditar_NoExiste_RetornaNull()
    {
        var e = new Escenario();

        Assert.Null(await e.Servicio.ObtenerParaEditarAsync(1));
    }

    [Fact]
    public async Task ObtenerParaEditar_Existe_RetornaDto()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarNegocio();

        var dto = await e.Servicio.ObtenerParaEditarAsync(1);

        Assert.NotNull(dto);
        Assert.Equal("Mi Negocio", dto!.Nombre);
        Assert.Equal("negocio@gtrack.local", dto.Correo);
    }

    // ===== Editar =====

    [Fact]
    public async Task Editar_SinVerificacion_RetornaMensajeSinVerificacion()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarNegocio();

        var (ok, error) = await e.Servicio.EditarAsync(1, DtoEditar());

        Assert.False(ok);
        Assert.Equal(NegocioService.MensajeSinVerificacion, error);
    }

    [Fact]
    public async Task Editar_NegocioNoExiste_RetornaErrorDeGuardado()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarCodigoAutorizado();

        var (ok, error) = await e.Servicio.EditarAsync(1, DtoEditar());

        Assert.False(ok);
        Assert.Equal("No fue posible actualizar la información. Intenta Nuevamente", error);
    }

    [Fact]
    public async Task Editar_CorreoDeOtraCuenta_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario(id: 1);
        e.AgregarUsuario(id: 2, correo: "nuevo@gtrack.local");
        e.AgregarNegocio();
        e.AgregarCodigoAutorizado();

        var (ok, error) = await e.Servicio.EditarAsync(1, DtoEditar());

        Assert.False(ok);
        Assert.Equal("El correo ya está registrado en otra cuenta", error);
    }

    [Fact]
    public async Task Editar_TelefonoDeOtroNegocio_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarNegocio();
        e.AgregarCodigoAutorizado();
        e.Negocios.TelefonosExistentes.Add("3009999999");

        var (ok, error) = await e.Servicio.EditarAsync(1, DtoEditar());

        Assert.False(ok);
        Assert.Equal("El teléfono ya está registrado en otro negocio", error);
    }

    [Fact]
    public async Task Editar_DatosValidos_ActualizaYMarcaCodigoComoUsado()
    {
        var e = new Escenario();
        var usuario = e.AgregarUsuario();
        var negocio = e.AgregarNegocio();
        var codigo = e.AgregarCodigoAutorizado();

        var (ok, error) = await e.Servicio.EditarAsync(1, DtoEditar());

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal("Nuevo Nombre", negocio.Nombre);
        Assert.Equal("nuevo@gtrack.local", usuario.Correo);
        Assert.True(codigo.Usado);
        Assert.True(e.Negocios.SeLlamoActualizar);
        Assert.True(e.Usuarios.SeLlamoActualizar);
    }

    // ===== Eliminar negocio =====

    [Fact]
    public async Task ValidarEliminacion_UsuarioNoExiste_RetornaError()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.ValidarEliminacionAsync(1, "Clave123");

        Assert.False(ok);
        Assert.Equal("No fue posible validar tu cuenta", error);
    }

    [Fact]
    public async Task ValidarEliminacion_PasswordIncorrecta_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarNegocio();

        var (ok, error) = await e.Servicio.ValidarEliminacionAsync(1, "otraClave1");

        Assert.False(ok);
        Assert.Equal("Contraseña incorrecta", error);
    }

    [Fact]
    public async Task ValidarEliminacion_SinNegocio_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();

        var (ok, error) = await e.Servicio.ValidarEliminacionAsync(1, "Clave123");

        Assert.False(ok);
        Assert.Equal("No fue posible validar tu cuenta", error);
    }

    [Fact]
    public async Task ValidarEliminacion_TieneRepartidoresVinculados_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarNegocio();
        e.Negocios.TieneRepartidoresVinculados = true;

        var (ok, error) = await e.Servicio.ValidarEliminacionAsync(1, "Clave123");

        Assert.False(ok);
        Assert.Contains("repartidores vinculados", error);
    }

    [Fact]
    public async Task EliminarCuenta_Valida_MarcaUsuarioComoEliminado()
    {
        var e = new Escenario();
        var usuario = e.AgregarUsuario();
        e.AgregarNegocio();

        var (ok, error) = await e.Servicio.EliminarCuentaAsync(1, "Clave123");

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(EstadoCuenta.Eliminado, usuario.Estado);
        Assert.True(e.Usuarios.SeLlamoActualizar);
    }

    [Fact]
    public async Task EliminarCuenta_ValidacionFalla_NoCambiaEstado()
    {
        var e = new Escenario();
        var usuario = e.AgregarUsuario();
        e.AgregarNegocio();

        var (ok, error) = await e.Servicio.EliminarCuentaAsync(1, "otraClave1");

        Assert.False(ok);
        Assert.Equal("Contraseña incorrecta", error);
        Assert.Equal(EstadoCuenta.Activo, usuario.Estado);
    }
}