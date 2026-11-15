using Microsoft.Extensions.Logging.Abstractions;

namespace Gtrack.Tests;

// CU-09 y CU-26: activación de la cuenta de repartidores y administradores por correo
public class ActivacionCuentaServiceTests
{
    private const string Token = "token-de-prueba";

    private sealed class Escenario
    {
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public TokenRecuperacionRepositoryFalso Tokens { get; } = new();
        public RepartidorRepositoryFalso Repartidores { get; } = new();
        public AdministracionRepositoryFalso Administradores { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public EmailServiceFalso Email { get; } = new();

        public ActivacionCuentaService Servicio => new(
            Usuarios, Tokens, Repartidores, Administradores, Negocios,
            new PasswordHasherFalso(), Email, NullLogger<ActivacionCuentaService>.Instance);

        public Usuario AgregarRepartidor(EstadoCuenta estado = EstadoCuenta.PendienteActivacion, bool conNegocio = true)
        {
            var usuario = new Usuario { Id = 2, Correo = "rep@gtrack.local", Documento = "1010", Rol = RolUsuario.Repartidor, Estado = estado };
            Usuarios.Usuarios.Add(usuario);
            Repartidores.Repartidores.Add(new Repartidor { Id = 5, UsuarioId = 2, NegocioId = 10, NombreCompleto = "Juan Gómez" });
            if (conNegocio) Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Comidas Rápidas" });
            return usuario;
        }

        public Usuario AgregarAdministrador(EstadoCuenta estado = EstadoCuenta.PendienteActivacion)
        {
            var usuario = new Usuario { Id = 3, Correo = "admin@gtrack.local", Documento = "2020", Rol = RolUsuario.Administrador, Estado = estado };
            Usuarios.Usuarios.Add(usuario);
            Administradores.Administradores.Add(new Administrador { Id = 7, UsuarioId = 3, NombreCompleto = "Ana Gómez" });
            return usuario;
        }

        public TokenRecuperacion AgregarToken(int usuarioId, bool usado = false, int horas = 24)
        {
            var t = new TokenRecuperacion
            {
                UsuarioId = usuarioId,
                TokenHash = TokenUtil.Hash(Token),
                Expira = DateTime.UtcNow.AddHours(horas),
                Usado = usado
            };
            Tokens.Tokens.Add(t);
            return t;
        }
    }

    private static string UrlLogin(RolUsuario rol) => $"https://gtrack.local/login?rol={rol}";

    // ===== Envío del enlace =====

    [Fact]
    public async Task EnviarEnlace_Repartidor_GuardaElTokenYEnviaElCorreo()
    {
        var e = new Escenario();
        var usuario = e.AgregarRepartidor();
        string? tokenEnviado = null;

        var ok = await e.Servicio.EnviarEnlaceAsync(usuario, "Juan Gómez", "Comidas Rápidas", t => { tokenEnviado = t; return $"https://x/{t}"; });

        Assert.True(ok);
        var guardado = Assert.Single(e.Tokens.Tokens);
        Assert.Equal(TokenUtil.Hash(tokenEnviado!), guardado.TokenHash);
        Assert.True(guardado.Expira > DateTime.UtcNow.AddHours(ActivacionCuentaService.HorasVigencia - 1));
        var correo = Assert.Single(e.Email.EnviadosHtml);
        Assert.Equal("rep@gtrack.local", correo.Para);
        Assert.Contains("repartidor", correo.Asunto);
        Assert.Contains("Comidas Rápidas", correo.Correo.Texto);
    }

    [Fact]
    public async Task EnviarEnlace_Administrador_UsaElCorreoDeAdministrador()
    {
        var e = new Escenario();
        var usuario = e.AgregarAdministrador();

        var ok = await e.Servicio.EnviarEnlaceAsync(usuario, "Ana Gómez", null, t => $"https://x/{t}");

        Assert.True(ok);
        Assert.Contains("administrador", Assert.Single(e.Email.EnviadosHtml).Asunto);
    }

    [Fact]
    public async Task EnviarEnlace_FallaElCorreo_RetornaFalse()
    {
        var e = new Escenario();
        var usuario = e.AgregarRepartidor();
        e.Email.DebeFallar = true;

        Assert.False(await e.Servicio.EnviarEnlaceAsync(usuario, "Juan Gómez", "Comidas Rápidas", t => t));
    }

    [Fact]
    public async Task EnviosUltimaHora_CuentaLosEnlacesRecientes()
    {
        var e = new Escenario();
        e.AgregarToken(2);
        e.AgregarToken(2);
        e.Tokens.Tokens.Add(new TokenRecuperacion { UsuarioId = 2, FechaCreacion = DateTime.UtcNow.AddHours(-3) });

        Assert.Equal(2, await e.Servicio.EnviosUltimaHoraAsync(2));
    }

    // ===== Consulta del enlace =====

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    public async Task Consultar_TokenVacio_EsInvalido(string? token)
    {
        var e = new Escenario();

        Assert.Equal(EstadoEnlaceActivacion.Invalido, (await e.Servicio.ConsultarAsync(token)).Estado);
    }

    [Fact]
    public async Task Consultar_TokenQueNoExiste_EsInvalido()
    {
        var e = new Escenario();

        Assert.Equal(EstadoEnlaceActivacion.Invalido, (await e.Servicio.ConsultarAsync("otro-token")).Estado);
    }

    [Fact]
    public async Task Consultar_UsuarioNoExiste_EsInvalido()
    {
        var e = new Escenario();
        e.AgregarToken(99);

        Assert.Equal(EstadoEnlaceActivacion.Invalido, (await e.Servicio.ConsultarAsync(Token)).Estado);
    }

    [Fact]
    public async Task Consultar_CuentaDeNegocio_EsInvalido()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Add(new Usuario { Id = 1, Rol = RolUsuario.Negocio, Estado = EstadoCuenta.PendienteActivacion });
        e.AgregarToken(1);

        Assert.Equal(EstadoEnlaceActivacion.Invalido, (await e.Servicio.ConsultarAsync(Token)).Estado);
    }

    [Fact]
    public async Task Consultar_CuentaYaActiva_LoIndica()
    {
        var e = new Escenario();
        e.AgregarRepartidor(EstadoCuenta.Activo);
        e.AgregarToken(2);

        Assert.Equal(EstadoEnlaceActivacion.CuentaYaActiva, (await e.Servicio.ConsultarAsync(Token)).Estado);
    }

    [Fact]
    public async Task Consultar_EnlaceUsado_EsInvalido()
    {
        var e = new Escenario();
        e.AgregarRepartidor();
        e.AgregarToken(2, usado: true);

        Assert.Equal(EstadoEnlaceActivacion.Invalido, (await e.Servicio.ConsultarAsync(Token)).Estado);
    }

    [Fact]
    public async Task Consultar_EnlaceVencido_LoIndica()
    {
        var e = new Escenario();
        e.AgregarRepartidor();
        e.AgregarToken(2, horas: -1);

        Assert.Equal(EstadoEnlaceActivacion.Vencido, (await e.Servicio.ConsultarAsync(Token)).Estado);
    }

    [Fact]
    public async Task Consultar_EnlaceValidoDeRepartidor_IncluyeNombreYNegocio()
    {
        var e = new Escenario();
        e.AgregarRepartidor();
        e.AgregarToken(2);

        var info = await e.Servicio.ConsultarAsync(Token);

        Assert.Equal(EstadoEnlaceActivacion.Valido, info.Estado);
        Assert.Equal(RolUsuario.Repartidor, info.Rol);
        Assert.Equal("Juan Gómez", info.Nombre);
        Assert.Equal("Comidas Rápidas", info.Negocio);
    }

    [Fact]
    public async Task Consultar_EnlaceValidoDeAdministrador_IncluyeElNombre()
    {
        var e = new Escenario();
        e.AgregarAdministrador();
        e.AgregarToken(3);

        var info = await e.Servicio.ConsultarAsync(Token);

        Assert.Equal(EstadoEnlaceActivacion.Valido, info.Estado);
        Assert.Equal(RolUsuario.Administrador, info.Rol);
        Assert.Equal("Ana Gómez", info.Nombre);
    }

    // ===== Activación =====

    [Fact]
    public async Task Activar_EnlaceInvalido_NoActiva()
    {
        var e = new Escenario();

        var (ok, error, info) = await e.Servicio.ActivarAsync("otro-token", "Clave123", "Clave123", UrlLogin);

        Assert.False(ok);
        Assert.Null(error);
        Assert.Equal(EstadoEnlaceActivacion.Invalido, info.Estado);
    }

    [Theory]
    [InlineData("", "", "Escribe y confirma la contraseña que quieres usar")]
    [InlineData("Clave123", "Clave999", "Las contraseñas no coinciden")]
    [InlineData("abc", "abc", "La contraseña debe tener mínimo 6 caracteres, con al menos un número y una letra")]
    public async Task Activar_ContrasenaInvalida_RetornaElError(string password, string confirmacion, string esperado)
    {
        var e = new Escenario();
        var usuario = e.AgregarRepartidor();
        e.AgregarToken(2);

        var (ok, error, _) = await e.Servicio.ActivarAsync(Token, password, confirmacion, UrlLogin);

        Assert.False(ok);
        Assert.Equal(esperado, error);
        Assert.Equal(EstadoCuenta.PendienteActivacion, usuario.Estado);
    }

    [Fact]
    public async Task Activar_DatosValidos_ActivaLaCuentaYAnulaElEnlace()
    {
        var e = new Escenario();
        var usuario = e.AgregarRepartidor();
        var token = e.AgregarToken(2);

        var (ok, error, _) = await e.Servicio.ActivarAsync(Token, "Clave123", "Clave123", UrlLogin);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(EstadoCuenta.Activo, usuario.Estado);
        Assert.Equal("HASH:Clave123", usuario.PasswordHash);
        Assert.True(e.Usuarios.SeLlamoActualizar);
        Assert.True(token.Usado);
        Assert.Equal("Tu cuenta de GTrack está activa", Assert.Single(e.Email.EnviadosHtml).Asunto);
    }

    [Fact]
    public async Task Activar_AdministradorSinCorreo_IgualQuedaActivo()
    {
        var e = new Escenario();
        var usuario = e.AgregarAdministrador();
        e.AgregarToken(3);
        e.Email.DebeFallar = true;

        var (ok, _, _) = await e.Servicio.ActivarAsync(Token, "Clave123", "Clave123", UrlLogin);

        Assert.True(ok);
        Assert.Equal(EstadoCuenta.Activo, usuario.Estado);
    }

    [Fact]
    public async Task Activar_RepartidorSinNegocio_EnviaLaConfirmacion()
    {
        var e = new Escenario();
        e.AgregarRepartidor(conNegocio: false);
        e.AgregarToken(2);

        var (ok, _, info) = await e.Servicio.ActivarAsync(Token, "Clave123", "Clave123", UrlLogin);

        Assert.True(ok);
        Assert.Equal("", info.Negocio);
        Assert.Single(e.Email.EnviadosHtml);
    }
}
