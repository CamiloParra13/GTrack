using Gtrack.Controllers;
using Microsoft.AspNetCore.Mvc;

public class HomeControllerTests
{
    [Fact]
    public void Index_RetornaVista()
    {
        var controlador = new HomeController().Preparar();

        Assert.IsType<ViewResult>(controlador.Index());
    }

    [Fact]
    public void Privacy_RetornaVista()
    {
        var controlador = new HomeController().Preparar();

        Assert.IsType<ViewResult>(controlador.Privacy());
    }

    [Fact]
    public void Error_RetornaVistaConCodigo500()
    {
        var controlador = new HomeController().Preparar();

        var vista = Assert.IsType<ViewResult>(controlador.Error());

        Assert.Equal(500, controlador.Response.StatusCode);
        Assert.Equal(500, vista.ViewData["Codigo"]);
        var modelo = Assert.IsType<ErrorViewModel>(vista.Model);
        Assert.False(string.IsNullOrEmpty(modelo.RequestId));
    }

    [Theory]
    [InlineData(404)]
    [InlineData(403)]
    public void StatusCode_RetornaVistaErrorConElCodigoRecibido(int codigo)
    {
        var controlador = new HomeController().Preparar();

        var vista = Assert.IsType<ViewResult>(controlador.StatusCode(codigo));

        Assert.Equal("Error", vista.ViewName);
        Assert.Equal(codigo, controlador.Response.StatusCode);
        Assert.Equal(codigo, vista.ViewData["Codigo"]);
    }
}