using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;

public class AdminControllerTests
{
    private sealed class Escenario
    {
        public IAdministracionService Admin { get; } = Substitute.For<IAdministracionService>();
        public IReporteService Reportes { get; } = Substitute.For<IReporteService>();
        public IExportadorReportes Exportador { get; } = Substitute.For<IExportadorReportes>();
        public AdminController Controlador { get; }

        public Escenario()
        {
            Controlador = new AdminController(Admin, Reportes, Exportador, NullLogger<AdminController>.Instance)
                .Preparar(usuarioId: 1, rol: "Administrador");
        }
    }

    private static RegistroAdministradorDto Dto() => new()
    {
        NombreCompleto = "Ana Gómez",
        Documento = "1122334",
        Correo = " ana@gtrack.local ",
        Telefono = "3201234567"
    };

    [Fact]
    public async Task Negocios_RetornaVistaConLaLista()
    {
        var e = new Escenario();
        var lista = new List<NegocioAdminDto> { new() { Id = 1, Nombre = "Mi Negocio" } };
        e.Admin.ListarNegociosAsync().Returns(lista);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Negocios());

        Assert.Same(lista, vista.Model);
    }

    [Fact]
    public async Task AprobarNegocio_Exitoso_GuardaMensajeYRedirige()
    {
        var e = new Escenario();
        e.Admin.AprobarNegocioAsync(5, Arg.Any<string>()).Returns((true, true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.AprobarNegocio(5));

        Assert.Equal("Negocios", r.ActionName);
        Assert.StartsWith("Negocio validado correctamente", (string)e.Controlador.TempData["Mensaje"]!);
    }

    [Fact]
    public async Task AprobarNegocio_Falla_GuardaAviso()
    {
        var e = new Escenario();
        e.Admin.AprobarNegocioAsync(5, Arg.Any<string>()).Returns((false, false));

        await e.Controlador.AprobarNegocio(5);

        Assert.Equal("No fue posible validar el negocio", e.Controlador.TempData["Aviso"]);
    }

    [Fact]
    public async Task Administradores_RetornaVistaConLaLista()
    {
        var e = new Escenario();
        var lista = new List<AdministradorDto> { new() { NombreCompleto = "Ana" } };
        e.Admin.ListarAdministradoresAsync().Returns(lista);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Administradores());

        Assert.Same(lista, vista.Model);
    }

    [Fact]
    public void RegistrarAdministrador_Get_RetornaVistaConDtoVacio()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(e.Controlador.RegistrarAdministrador());

        Assert.IsType<RegistroAdministradorDto>(vista.Model);
    }

    [Fact]
    public async Task RegistrarAdministrador_CampoObligatorioVacio_AgregaMensajeGeneral()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("NombreCompleto", RegistroNegocioDto.Obligatorio);

        var r = await e.Controlador.RegistrarAdministrador(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "Debes completar todos los campos obligatorios");
    }

    [Fact]
    public async Task RegistrarAdministrador_OtroErrorDeValidacion_NoAgregaMensajeGeneral()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Correo", "Correo no válido");

        var r = await e.Controlador.RegistrarAdministrador(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.False(e.Controlador.ModelState.ContainsKey(""));
    }

    [Fact]
    public async Task RegistrarAdministrador_ServicioFalla_MuestraElErrorEnLaVista()
    {
        var e = new Escenario();
        e.Admin.RegistrarAdministradorAsync(Arg.Any<RegistroAdministradorDto>(), Arg.Any<Func<string, string>>())
            .Returns(new ResultadoRegistro(false, "Este documento o correo ya se encuentra registrado", false, null));

        var r = await e.Controlador.RegistrarAdministrador(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "Este documento o correo ya se encuentra registrado");
    }

    [Fact]
    public async Task RegistrarAdministrador_ConCorreo_RedirigeALaLista()
    {
        var e = new Escenario();
        e.Admin.RegistrarAdministradorAsync(Arg.Any<RegistroAdministradorDto>(), Arg.Any<Func<string, string>>())
            .Returns(new ResultadoRegistro(true, null, true, null));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.RegistrarAdministrador(Dto()));

        Assert.Equal("Administradores", r.ActionName);
        Assert.False(e.Controlador.TempData.ContainsKey("Aviso"));
    }

    [Fact]
    public async Task RegistrarAdministrador_CorreoNoEnviado_Avisa()
    {
        var e = new Escenario();
        e.Admin.RegistrarAdministradorAsync(Arg.Any<RegistroAdministradorDto>(), Arg.Any<Func<string, string>>())
            .Returns(new ResultadoRegistro(true, null, false, null));

        await e.Controlador.RegistrarAdministrador(Dto());

        Assert.NotNull(e.Controlador.TempData["Aviso"]);
    }
}