using Microsoft.Extensions.Logging.Abstractions;

namespace Gtrack.Tests;

public class UtilidadesTests
{
    // ===== ValidadorPassword =====

    [Theory]
    [InlineData("Clave123", true)]
    [InlineData("abc12d", true)]
    [InlineData("abc1", false)]     // muy corta
    [InlineData("abcdef", false)]   // sin número
    [InlineData("123456", false)]   // sin letra
    [InlineData("", false)]
    [InlineData(null, false)]
    public void ValidadorPassword_SegunLasReglas(string? password, bool esperado)
    {
        Assert.Equal(esperado, ValidadorPassword.EsValida(password));
    }

    // ===== GeneradorPassword =====

    [Theory]
    [InlineData(6)]
    [InlineData(10)]
    [InlineData(24)]
    public void GeneradorPassword_GeneraPasswordValidaDelLargoPedido(int largo)
    {
        for (var i = 0; i < 50; i++)
        {
            var p = GeneradorPassword.Temporal(largo);

            Assert.Equal(largo, p.Length);
            Assert.True(ValidadorPassword.EsValida(p));
        }
    }

    // ===== TokenUtil =====

    [Fact]
    public void TokenUtil_Generar_RetornaTokensNoVaciosYDistintos()
    {
        var a = TokenUtil.Generar();
        var b = TokenUtil.Generar();

        Assert.False(string.IsNullOrWhiteSpace(a));
        Assert.NotEqual(a, b);
    }

    [Fact]
    public void TokenUtil_Hash_EsDeterministaYDe64Caracteres()
    {
        var h1 = TokenUtil.Hash("abc");
        var h2 = TokenUtil.Hash("abc");
        var h3 = TokenUtil.Hash("abd");

        Assert.Equal(h1, h2);
        Assert.NotEqual(h1, h3);
        Assert.Equal(64, h1.Length);
    }

    // ===== EmailDesarrolloService =====

    [Fact]
    public async Task EmailDesarrollo_Enviar_NoLanzaExcepcion()
    {
        var servicio = new EmailDesarrolloService(NullLogger<EmailDesarrolloService>.Instance);

        var ex = await Record.ExceptionAsync(() => servicio.EnviarAsync("a@gtrack.local", "Asunto", "Cuerpo"));

        Assert.Null(ex);
    }
}