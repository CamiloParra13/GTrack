using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging.Abstractions;

namespace Gtrack.Tests;

public class RecuperacionServiceTests
{
    private sealed class HasherConHashInvalido : IPasswordHasher<Usuario>
    {
        public string HashPassword(Usuario user, string password) => $"HASH:{password}";

        public PasswordVerificationResult VerifyHashedPassword(Usuario user, string hashedPassword, string providedPassword) =>
            throw new FormatException("Hash inválido");
    }

    private sealed class Escenario
    {
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public TokenRecuperacionRepositoryFalso Tokens { get; } = new();
        public EmailServiceFalso Email { get; } = new();
        public IPasswordHasher<Usuario> Hasher { get; set; } = new PasswordHasherFalso();

        public RecuperacionService Servicio => new(
            Usuarios, Tokens, Hasher, Email, NullLogger<RecuperacionService>.Instance);

        public Usuario AgregarUsuario()
        {
            var u = new Usuario
            {
                Id = 1,
                Correo = "negocio@gtrack.local",
                PasswordHash = "HASH:Clave123",
                Estado = EstadoCuenta.Activo
            };
            Usuarios.Usuarios.Add(u);
            return u;
        }

        public TokenRecuperacion AgregarToken(string token, bool usado = false, int minutos = 15)
        {
            var t = new TokenRecuperacion
            {
                UsuarioId = 1,
                TokenHash = TokenUtil.Hash(token),
                Usado = usado,
                Expira = DateTime.UtcNow.AddMinutes(minutos)
            };
            Tokens.Tokens.Add(t);
            return t;
        }
    }

    // ===== SolicitarAsync =====

    [Fact]
    public async Task Solicitar_CorreoNoExiste_ResponderProcesadaSinEnviarNada()
    {
        var e = new Escenario();

        var r = await e.Servicio.SolicitarAsync("nadie@gtrack.local", t => t);

        Assert.Equal(ResultadoSolicitud.Procesada, r);
        Assert.Empty(e.Tokens.Tokens);
        Assert.Empty(e.Email.Enviados);
    }

    [Fact]
    public async Task Solicitar_TresSolicitudesEnUnaHora_RetornaLimiteSuperado()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        for (var i = 0; i < 3; i++)
            e.Tokens.Tokens.Add(new TokenRecuperacion { UsuarioId = 1, TokenHash = $"h{i}", Expira = DateTime.UtcNow.AddMinutes(5) });

        var r = await e.Servicio.SolicitarAsync("negocio@gtrack.local", t => t);

        Assert.Equal(ResultadoSolicitud.LimiteSuperado, r);
        Assert.Empty(e.Email.Enviados);
    }

    [Fact]
    public async Task Solicitar_CorreoValido_GuardaTokenYEnviaEnlace()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        string? enlaceGenerado = null;

        var r = await e.Servicio.SolicitarAsync(" negocio@gtrack.local ", t =>
        {
            enlaceGenerado = "https://gtrack.local/restablecer?token=" + t;
            return enlaceGenerado;
        });

        Assert.Equal(ResultadoSolicitud.Procesada, r);
        Assert.Single(e.Tokens.Tokens);
        Assert.Single(e.Email.EnviadosHtml);
        Assert.StartsWith("https://gtrack.local/restablecer?token=", enlaceGenerado);
        Assert.Equal("negocio@gtrack.local", e.Email.EnviadosHtml[0].Para);
    }

    // ===== TokenVigenteAsync =====

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    [InlineData("no-existe")]
    public async Task TokenVigente_VacioOInexistente_RetornaFalse(string token)
    {
        var e = new Escenario();

        Assert.False(await e.Servicio.TokenVigenteAsync(token));
    }

    [Fact]
    public async Task TokenVigente_Usado_RetornaFalse()
    {
        var e = new Escenario();
        e.AgregarToken("tok", usado: true);

        Assert.False(await e.Servicio.TokenVigenteAsync("tok"));
    }

    [Fact]
    public async Task TokenVigente_Vencido_RetornaFalse()
    {
        var e = new Escenario();
        e.AgregarToken("tok", minutos: -1);

        Assert.False(await e.Servicio.TokenVigenteAsync("tok"));
    }

    [Fact]
    public async Task TokenVigente_Valido_RetornaTrue()
    {
        var e = new Escenario();
        e.AgregarToken("tok");

        Assert.True(await e.Servicio.TokenVigenteAsync("tok"));
    }

    // ===== RestablecerAsync =====

    [Fact]
    public async Task Restablecer_TokenVacio_RetornaTokenInvalido()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.RestablecerAsync("", "NuevaClave1", "NuevaClave1");

        Assert.False(ok);
        Assert.Equal(RecuperacionService.MensajeTokenInvalido, error);
    }

    [Theory]
    [InlineData(true, 15)]   // ya usado
    [InlineData(false, -1)]  // vencido
    public async Task Restablecer_TokenUsadoOVencido_RetornaTokenInvalido(bool usado, int minutos)
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarToken("tok", usado, minutos);

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1");

        Assert.False(ok);
        Assert.Equal(RecuperacionService.MensajeTokenInvalido, error);
    }

    [Theory]
    [InlineData("NuevaClave1", "Distinta1")]  // no coinciden
    [InlineData("abcdef", "abcdef")]          // sin número
    public async Task Restablecer_PasswordInvalida_RetornaError(string nueva, string confirmacion)
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarToken("tok");

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", nueva, confirmacion);

        Assert.False(ok);
        Assert.Equal("Las contraseñas no coinciden o no cumplen el formato requerido", error);
    }

    [Fact]
    public async Task Restablecer_UsuarioNoExiste_RetornaTokenInvalido()
    {
        var e = new Escenario();
        e.AgregarToken("tok");

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1");

        Assert.False(ok);
        Assert.Equal(RecuperacionService.MensajeTokenInvalido, error);
    }

    [Fact]
    public async Task Restablecer_MismaContrasenaAnterior_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarToken("tok");

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", "Clave123", "Clave123");

        Assert.False(ok);
        Assert.Equal("La nueva contraseña no puede ser igual a la anterior", error);
    }

    [Fact]
    public async Task Restablecer_DatosValidos_CambiaPasswordMarcaTokenYEnviaCorreo()
    {
        var e = new Escenario();
        var usuario = e.AgregarUsuario();
        var token = e.AgregarToken("tok");

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1");

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal("HASH:NuevaClave1", usuario.PasswordHash);
        Assert.True(token.Usado);
        Assert.Single(e.Email.EnviadosHtml);
    }

    [Fact]
    public async Task Restablecer_FallaCorreoDeConfirmacion_IgualRestablece()
    {
        var e = new Escenario();
        var usuario = e.AgregarUsuario();
        e.AgregarToken("tok");
        e.Email.DebeFallar = true;

        var (ok, _) = await e.Servicio.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1");

        Assert.True(ok);
        Assert.Equal("HASH:NuevaClave1", usuario.PasswordHash);
    }

    [Fact]
    public async Task Restablecer_HashAnteriorInvalido_PermiteElCambio()
    {
        var e = new Escenario { Hasher = new HasherConHashInvalido() };
        e.AgregarUsuario();
        e.AgregarToken("tok");

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1");

        Assert.True(ok);
        Assert.Null(error);
    }
}