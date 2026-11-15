œ+
`C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\AdminControllerTests.cs’*using Microsoft.AspNetCore.Mvc;
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
        NombreCompleto = "Ana G√≥mez",
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
        e.Controlador.ModelState.AddModelError("Correo", "Correo no v√°lido");

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
}ParseOptions.0.jsonûA
fC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\AdministracionServiceTests.csû@using Microsoft.Extensions.Logging.Abstractions;
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
        NombreCompleto = "Ana G√≥mez",
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
        e.Admins.AdministradoresListados.Add(new AdministradorDto { NombreCompleto = "Ana G√≥mez" });

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
        e.Admins.ResultadoAprobar = true;   // los fakes de Negocios/Usuarios est√°n vac√≠os

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
        Assert.Equal("El tel√©fono ya est√° registrado en el sistema", r.Error);
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
            e.Admins.UsuarioRegistrado, "Ana G√≥mez", Arg.Any<string?>(), Arg.Any<Func<string, string>>());
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

    // ===== Reenviar activaci√≥n =====

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
        Assert.Contains("ya activ√≥ su cuenta", mensaje);
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
        Assert.Contains("√∫ltima hora", mensaje);
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
}ParseOptions.0.json⁄
gC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\AuthServiceComplementoTests.csŸpublic class AuthServiceComplementoTests
{
    private static Usuario Usuario(EstadoCuenta estado = EstadoCuenta.Activo, int intentos = 0, DateTime? bloqueadoHasta = null) => new()
    {
        Id = 1,
        Correo = "negocio@gtrack.local",
        Documento = "123",
        Rol = RolUsuario.Negocio,
        Estado = estado,
        PasswordHash = "HASH:Clave123",
        IntentosFallidos = intentos,
        BloqueadoHasta = bloqueadoHasta
    };

    private static LoginDto Login(string password = "Clave123") =>
        new() { Identificador = "negocio@gtrack.local", Password = password, Rol = RolUsuario.Negocio };

    [Fact]
    public async Task IniciarSesion_BloqueoVencido_LimpiaBloqueoYPermiteEntrar()
    {
        var repo = new UsuarioRepositoryFalso();
        var u = Usuario(intentos: 3, bloqueadoHasta: DateTime.UtcNow.AddMinutes(-1));
        repo.Usuarios.Add(u);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(Login());

        Assert.NotNull(usuario);
        Assert.Null(error);
        Assert.Null(u.BloqueadoHasta);
        Assert.Equal(0, u.IntentosFallidos);
        Assert.True(repo.SeLlamoActualizar);
    }

    [Fact]
    public async Task IniciarSesion_CredencialesCorrectasConIntentosPrevios_ReiniciaContador()
    {
        var repo = new UsuarioRepositoryFalso();
        var u = Usuario(intentos: 2);
        repo.Usuarios.Add(u);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, _) = await servicio.IniciarSesionAsync(Login());

        Assert.NotNull(usuario);
        Assert.Equal(0, u.IntentosFallidos);
        Assert.True(repo.SeLlamoActualizar);
    }

    [Fact]
    public async Task IniciarSesion_CuentaRechazada_IncluyeElMotivo()
    {
        var repo = new UsuarioRepositoryFalso();
        var u = Usuario(EstadoCuenta.Rechazado);
        u.MotivoRechazo = "Documento ilegible";
        repo.Usuarios.Add(u);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(Login());

        Assert.Null(usuario);
        Assert.Contains("Documento ilegible", error);
    }

    [Fact]
    public async Task IniciarSesion_CuentaEliminada_RetornaErrorGenerico()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(Usuario(EstadoCuenta.Eliminado));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(Login());

        Assert.Null(usuario);
        Assert.Equal("Usuario o contrase√±a incorrectos", error);
    }
}ParseOptions.0.json∏ 
\C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\AuthServiceTests.cs¬public class AuthServiceTests
{
    private static Usuario UsuarioActivo(int intentos = 0, DateTime? bloqueadoHasta = null) => new()
    {
        Id = 1,
        Correo = "negocio@gtrack.local",
        Documento = "123",
        Rol = RolUsuario.Negocio,
        Estado = EstadoCuenta.Activo,
        PasswordHash = "HASH:Clave123",
        IntentosFallidos = intentos,
        BloqueadoHasta = bloqueadoHasta
    };

    [Fact]
    public async Task IniciarSesion_UsuarioNoExiste_RetornaErrorGenerico()
    {
        var repo = new UsuarioRepositoryFalso();
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "no-existe", Password = "x", Rol = RolUsuario.Negocio });

        Assert.Null(usuario);
        Assert.Equal("Usuario o contrase√±a incorrectos", error);
    }

    [Fact]
    public async Task IniciarSesion_CuentaBloqueadaVigente_RetornaMinutosRestantes()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo(bloqueadoHasta: DateTime.UtcNow.AddMinutes(10)));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "Clave123", Rol = RolUsuario.Negocio });

        Assert.Null(usuario);
        Assert.Contains("bloqueada temporalmente", error);
    }

    [Fact]
    public async Task IniciarSesion_PasswordIncorrecta_IncrementaIntentos()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo(intentos: 2));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "mala", Rol = RolUsuario.Negocio });

        Assert.Null(usuario);
        Assert.Equal("Usuario o contrase√±a incorrectos", error);
        Assert.True(repo.SeLlamoActualizar);
    }

    [Fact]
    public async Task IniciarSesion_QuintoIntentoFallido_BloqueaCuenta()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo(intentos: 4));
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (_, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "mala", Rol = RolUsuario.Negocio });

        Assert.Contains("qued√≥ bloqueada durante 15 minutos", error);
    }

    [Fact]
    public async Task IniciarSesion_CredencialesCorrectas_CuentaActiva_RetornaUsuario()
    {
        var repo = new UsuarioRepositoryFalso();
        repo.Usuarios.Add(UsuarioActivo());
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (usuario, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "Clave123", Rol = RolUsuario.Negocio });

        Assert.Null(error);
        Assert.NotNull(usuario);
    }

    [Theory]
    [InlineData(EstadoCuenta.PendienteValidacion, "a√∫n no ha sido validada")]
    [InlineData(EstadoCuenta.Suspendido, "se encuentra suspendida")]
    public async Task IniciarSesion_CuentaNoActiva_RetornaMensajeSegunEstado(EstadoCuenta estado, string esperado)
    {
        var repo = new UsuarioRepositoryFalso();
        var usuario = UsuarioActivo();
        usuario.Estado = estado;
        repo.Usuarios.Add(usuario);
        var servicio = new AuthService(repo, new PasswordHasherFalso());

        var (resultado, error) = await servicio.IniciarSesionAsync(
            new LoginDto { Identificador = "negocio@gtrack.local", Password = "Clave123", Rol = RolUsuario.Negocio });

        Assert.Null(resultado);
        Assert.Contains(esperado, error);
    }
}ParseOptions.0.json≤
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\EstadoPedidoInfoTests.cs∑public class EstadoPedidoInfoTests
{
    [Theory]
    [InlineData(EstadoPedido.Recibido, "Recibido", "#6c757d")]
    [InlineData(EstadoPedido.EnPreparacion, "En preparaci√≥n", "#f0ad00")]
    [InlineData(EstadoPedido.ListoParaEntrega, "Listo para entrega", "#0dcaf0")]
    [InlineData(EstadoPedido.Asignado, "Asignado", "#6f42c1")]
    [InlineData(EstadoPedido.EnCamino, "En camino", "#fd7e14")]
    [InlineData(EstadoPedido.Entregado, "Entregado", "#198754")]
    [InlineData(EstadoPedido.Cancelado, "Cancelado", "#dc3545")]
    public void Pedido_NombreYColorSegunElEstado(EstadoPedido estado, string nombre, string color)
    {
        Assert.Equal(nombre, EstadoPedidoInfo.Nombre((int)estado));
        Assert.Equal(color, EstadoPedidoInfo.Color((int)estado));
    }

    [Fact]
    public void Pedido_EstadoDesconocido_UsaValoresPorDefecto()
    {
        Assert.Equal("Desconocido", EstadoPedidoInfo.Nombre(99));
        Assert.Equal("#adb5bd", EstadoPedidoInfo.Color(99));
    }

    [Theory]
    [InlineData(EstadoCuenta.Activo, "Activo", "#198754")]
    [InlineData(EstadoCuenta.PendienteValidacion, "Pendiente de validaci√≥n", "#f0ad00")]
    [InlineData(EstadoCuenta.Suspendido, "Suspendido", "#6c757d")]
    [InlineData(EstadoCuenta.Rechazado, "Rechazado", "#dc3545")]
    [InlineData(EstadoCuenta.PendienteActivacion, "Pendiente de activaci√≥n", "#fd7e14")]
    [InlineData(EstadoCuenta.Eliminado, "Eliminado", "#343a40")]
    public void Cuenta_NombreYColorSegunElEstado(EstadoCuenta estado, string nombre, string color)
    {
        Assert.Equal(nombre, EstadoPedidoInfo.NombreCuenta(estado));
        Assert.Equal(color, EstadoPedidoInfo.ColorCuenta(estado));
    }
}ParseOptions.0.jsonô
oC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\AdministracionRepositoryFalso.csêpublic class AdministracionRepositoryFalso : IAdministracionRepository
{
    public List<Administrador> Administradores { get; } = new();
    public Usuario? UsuarioRegistrado { get; private set; }
    public HashSet<string> TelefonosEnUso { get; } = new();
    public List<NegocioAdminDto> Negocios { get; } = new();
    public List<AdministradorDto> AdministradoresListados { get; } = new();
    public bool ResultadoAprobar { get; set; } = true;
    public int? UltimoNegocioAprobado { get; private set; }

    public Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador)
    {
        UsuarioRegistrado = usuario;
        administrador.Usuario = usuario;
        Administradores.Add(administrador);
        return Task.CompletedTask;
    }

    public Task<List<AdministradorDto>> ListarAdministradoresAsync() => Task.FromResult(AdministradoresListados);

    public Task<List<NegocioAdminDto>> ListarNegociosAsync() => Task.FromResult(Negocios);

    public Task<bool> AprobarNegocioAsync(int negocioId)
    {
        UltimoNegocioAprobado = negocioId;
        return Task.FromResult(ResultadoAprobar);
    }

    public Task<bool> TelefonoEnUsoAsync(string telefono) => Task.FromResult(TelefonosEnUso.Contains(telefono));

    // Devuelve null si no hay coincidencia, como el real
    public Task<Administrador?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(Administradores.FirstOrDefault(a =>
            a.UsuarioId == usuarioId || a.Usuario?.Id == usuarioId));
}ParseOptions.0.jsonî
sC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\CodigoVerificacionRepositoryFalso.csápublic class CodigoVerificacionRepositoryFalso : ICodigoVerificacionRepository
{
    public List<CodigoVerificacion> Codigos { get; } = new();

    public Task AgregarAsync(CodigoVerificacion codigo)
    {
        Codigos.Add(codigo);
        return Task.CompletedTask;
    }

    public Task<CodigoVerificacion?> ObtenerUltimoAsync(int usuarioId) =>
        Task.FromResult(Codigos.Where(c => c.UsuarioId == usuarioId)
            .OrderByDescending(c => c.FechaCreacion)
            .ThenByDescending(c => c.Id)
            .FirstOrDefault());

    public Task ActualizarAsync(CodigoVerificacion codigo) => Task.CompletedTask;
}ParseOptions.0.json‚
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\ContextoFactory.csÁusing Microsoft.EntityFrameworkCore;

public class AppDbContextQueFallaAlGuardar(DbContextOptions<AppDbContext> options) : AppDbContext(options)
{
    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default) =>
        throw new InvalidOperationException("Fallo simulado al guardar");
}

public static class ContextoFactory
{
    private static DbContextOptions<AppDbContext> Opciones() =>
        new DbContextOptionsBuilder<AppDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;

    public static AppDbContext Crear() => new(Opciones());

    public static AppDbContext CrearQueFallaAlGuardar() => new AppDbContextQueFallaAlGuardar(Opciones());
}ParseOptions.0.json®
fC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\ControllerTestHelper.cs®using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Text.Json;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.Extensions.DependencyInjection;
using NSubstitute;

public static class ControllerTestHelper
{
    // Prepara un controlador para probarlo sin servidor: usuario autenticado (opcional),
    // TempData, Url simulado y un IAuthenticationService simulado para SignIn/SignOut.
    public static TController Preparar<TController>(
        this TController controller,
        int? usuarioId = null,
        string? rol = null,
        IAuthenticationService? autenticacion = null) where TController : Controller
    {
        var http = new DefaultHttpContext();

        if (usuarioId.HasValue)
        {
            var claims = new List<Claim> { new(ClaimTypes.NameIdentifier, usuarioId.Value.ToString()) };
            if (rol is not null) claims.Add(new Claim(ClaimTypes.Role, rol));
            http.User = new ClaimsPrincipal(new ClaimsIdentity(claims, "Prueba"));
        }

        var servicios = new ServiceCollection();
        servicios.AddSingleton(autenticacion ?? Substitute.For<IAuthenticationService>());
        http.RequestServices = servicios.BuildServiceProvider();

        controller.ControllerContext = new ControllerContext { HttpContext = http };
        controller.TempData = new TempDataDictionary(http, Substitute.For<ITempDataProvider>());

        // CAMBIO 1: evita el error "No service for type IUrlHelperFactory"
        controller.Url = Substitute.For<IUrlHelper>();

        return controller;
    }

    // CAMBIO 2: sin escapar caracteres como la √± (si no, queda "contrase\u00f1a")
    public static string AJson(this JsonResult resultado) =>
        JsonSerializer.Serialize(resultado.Value, new JsonSerializerOptions
        {
            Encoder = JavaScriptEncoder.UnsafeRelaxedJsonEscaping
        });
}ParseOptions.0.jsonõ
cC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\EmailServiceFalso.csûpublic class EmailServiceFalso : IEmailService
{
    public List<(string Para, string Asunto, string Cuerpo)> Enviados { get; } = new();
    public List<(string Para, string Asunto, CorreoHtml Correo)> EnviadosHtml { get; } = new();
    public bool DebeFallar { get; set; }

    public Task EnviarAsync(string para, string asunto, string cuerpo)
    {
        if (DebeFallar) throw new Exception("Fallo simulado de env√≠o de correo");
        Enviados.Add((para, asunto, cuerpo));
        return Task.CompletedTask;
    }

    public Task EnviarAsync(string para, string asunto, CorreoHtml correo)
    {
        if (DebeFallar) throw new Exception("Fallo simulado de env√≠o de correo");
        EnviadosHtml.Add((para, asunto, correo));
        return Task.CompletedTask;
    }
}ParseOptions.0.json·
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\NegocioRepositoryFalso.csﬂpublic class NegocioRepositoryFalso : INegocioRepository
{
    public List<Negocio> Negocios { get; } = new();
    public HashSet<string> DocumentosExistentes { get; } = new();
    public HashSet<string> TelefonosExistentes { get; } = new();
    public bool TienePedidosActivos { get; set; }
    public bool TieneRepartidoresVinculados { get; set; }
    public bool SeLlamoActualizar { get; private set; }
    public bool SeLlamoRegistrar { get; private set; }

    public Task<Negocio?> BuscarPorIdAsync(int id) =>
        Task.FromResult(Negocios.FirstOrDefault(n => n.Id == id));

    public Task<Negocio?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(Negocios.FirstOrDefault(n => n.UsuarioId == usuarioId));

    public Task<bool> ExisteDocumentoAsync(string documento) =>
        Task.FromResult(DocumentosExistentes.Contains(documento));

    public Task<bool> ExisteTelefonoAsync(string telefono, int? excluirNegocioId = null) =>
        Task.FromResult(TelefonosExistentes.Contains(telefono));

    public Task RegistrarAsync(Usuario usuario, Negocio negocio)
    {
        SeLlamoRegistrar = true;
        negocio.Usuario = usuario;
        Negocios.Add(negocio);
        return Task.CompletedTask;
    }

    public Task ActualizarAsync(Negocio negocio)
    {
        SeLlamoActualizar = true;
        return Task.CompletedTask;
    }

    public Task<bool> TienePedidosActivosAsync(int negocioId) => Task.FromResult(TienePedidosActivos);

    public Task<bool> TieneRepartidoresVinculadosAsync(int negocioId) => Task.FromResult(TieneRepartidoresVinculados);
}ParseOptions.0.json◊
eC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\PasswordHasherFalso.csÿusing Microsoft.AspNetCore.Identity;

public class PasswordHasherFalso : IPasswordHasher<Usuario>
{
    public string HashPassword(Usuario user, string password) => $"HASH:{password}";

    public PasswordVerificationResult VerifyHashedPassword(Usuario user, string hashedPassword, string providedPassword) =>
        hashedPassword == $"HASH:{providedPassword}"
            ? PasswordVerificationResult.Success
            : PasswordVerificationResult.Failed;
}ParseOptions.0.jsonÿ
gC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\PedidoRepositoryFalso.cs◊public class PedidoRepositoryFalso : IPedidoRepository
{
    public List<Pedido> Pedidos { get; } = new();
    public bool DebeFallarAlAgregar { get; set; }
    public bool DebeFallarAlActualizar { get; set; }

    public Task<Pedido?> ObtenerPorIdAsync(int id) =>
        Task.FromResult(Pedidos.FirstOrDefault(p => p.Id == id));

    public Task<Pedido?> ObtenerPorCodigoAsync(string codigo) =>
        Task.FromResult(Pedidos.FirstOrDefault(p => p.Codigo == codigo));

    public Task<Pedido?> ObtenerUltimoPorTelefonoAsync(int negocioId, string telefono) =>
        Task.FromResult(Pedidos
            .Where(p => p.NegocioId == negocioId && p.Cliente != null && p.Cliente.Telefono == telefono)
            .OrderByDescending(p => p.FechaCreacion)
            .FirstOrDefault());

    public bool CodigosSiempreExisten { get; set; }

    public Task<bool> ExisteCodigoAsync(string codigo) =>
        Task.FromResult(CodigosSiempreExisten || Pedidos.Any(p => p.Codigo == codigo));

    public Task AgregarAsync(Pedido pedido)
    {
        if (DebeFallarAlAgregar) throw new Exception("Fallo simulado al agregar");
        if (pedido.Id == 0) pedido.Id = Pedidos.Count + 1;
        Pedidos.Add(pedido);
        return Task.CompletedTask;
    }

    public Task ActualizarAsync(Pedido pedido)
    {
        if (DebeFallarAlActualizar) throw new Exception("Fallo simulado al actualizar");
        return Task.CompletedTask;
    }

    public Task<List<Pedido>> ObtenerPorNegocioAsync(int negocioId) =>
        Task.FromResult(Pedidos.Where(p => p.NegocioId == negocioId).ToList());
}ParseOptions.0.json≠
kC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\RepartidorRepositoryFalso.cs®public class RepartidorRepositoryFalso : IRepartidorRepository
{
    public List<Repartidor> Repartidores { get; } = new();
    public HashSet<string> TelefonosEnUso { get; } = new();
    public bool SeLlamoRegistrar { get; private set; }
    public Usuario? UsuarioRegistrado { get; private set; }
    public Repartidor? UltimoReactivado { get; private set; }

    public Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor)
    {
        SeLlamoRegistrar = true;
        UsuarioRegistrado = usuario;
        repartidor.Usuario = usuario;
        Repartidores.Add(repartidor);
        return Task.CompletedTask;
    }

    public Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId) =>
        Task.FromResult(Repartidores.Where(r => r.NegocioId == negocioId).ToList());

    public Task<bool> TelefonoEnUsoAsync(string telefono) =>
        Task.FromResult(TelefonosEnUso.Contains(telefono));

    public Task<Repartidor?> ObtenerDeNegocioAsync(int negocioId, int repartidorId) =>
        Task.FromResult(Repartidores.FirstOrDefault(r => r.Id == repartidorId && r.NegocioId == negocioId));

    public Task<Repartidor?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(Repartidores.FirstOrDefault(r => r.UsuarioId == usuarioId));

    public Task<Repartidor?> BuscarEliminadoAsync(string correo, string documento) =>
        Task.FromResult(Repartidores
            .Where(r => r.Usuario is { Estado: EstadoCuenta.Eliminado } &&
                        (r.Usuario.Correo == correo || r.Usuario.Correo == $"eliminado.{r.UsuarioId}.{correo}" ||
                         r.Usuario.Documento == documento || r.Usuario.Documento == $"X{r.UsuarioId}-{documento}"))
            .OrderByDescending(r => r.Id)
            .FirstOrDefault());

    public Task ReactivarAsync(Repartidor repartidor)
    {
        UltimoReactivado = repartidor;
        return Task.CompletedTask;
    }
}ParseOptions.0.jsonÓ
rC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\TokenRecuperacionRepositoryFalso.cs‚public class TokenRecuperacionRepositoryFalso : ITokenRecuperacionRepository
{
    public List<TokenRecuperacion> Tokens { get; } = new();

    public Task AgregarAsync(TokenRecuperacion token)
    {
        Tokens.Add(token);
        return Task.CompletedTask;
    }

    public Task<TokenRecuperacion?> ObtenerPorHashAsync(string hash) =>
        Task.FromResult(Tokens.FirstOrDefault(t => t.TokenHash == hash));

    public Task<int> ContarDesdeAsync(int usuarioId, DateTime desde) =>
        Task.FromResult(Tokens.Count(t => t.UsuarioId == usuarioId && t.FechaCreacion >= desde));

    public Task ActualizarAsync(TokenRecuperacion token) => Task.CompletedTask;

    // Igual que el real: marca como usados solo los tokens pendientes de ese usuario
    public Task InvalidarPendientesAsync(int usuarioId)
    {
        foreach (var t in Tokens.Where(t => t.UsuarioId == usuarioId && !t.Usado))
            t.Usado = true;
        return Task.CompletedTask;
    }
}ParseOptions.0.jsonÒ
jC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\UbicacionRepositoryFalso.csÌpublic class UbicacionRepositoryFalso : IUbicacionRepository
{
    public Dictionary<int, UbicacionPedido> Ubicaciones { get; } = new();
    public bool DebeFallarAlGuardar { get; set; }

    public Task<UbicacionPedido?> ObtenerAsync(int pedidoId) =>
        Task.FromResult(Ubicaciones.GetValueOrDefault(pedidoId));

    public Task GuardarAsync(int pedidoId, decimal lat, decimal lng)
    {
        if (DebeFallarAlGuardar) throw new Exception("Fallo simulado al guardar");
        Ubicaciones[pedidoId] = new UbicacionPedido
        {
            PedidoId = pedidoId,
            Latitud = lat,
            Longitud = lng,
            FechaActualizacion = DateTime.UtcNow
        };
        return Task.CompletedTask;
    }
}ParseOptions.0.jsonÙ
hC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\Fakes\UsuarioRepositoryFalso.csÚpublic class UsuarioRepositoryFalso : IUsuarioRepository
{
    public List<Usuario> Usuarios { get; } = new();
    public bool SeLlamoActualizar { get; private set; }
    public bool SeLlamoLiberarEliminados { get; private set; }

    public Task<Usuario?> ObtenerPorIdentificadorYRolAsync(string identificador, RolUsuario rol) =>
        Task.FromResult(Usuarios.FirstOrDefault(u =>
            u.Rol == rol && (u.Correo == identificador || u.Documento == identificador)));

    public Task<Usuario?> ObtenerPorCorreoAsync(string correo) =>
        Task.FromResult(Usuarios.FirstOrDefault(u => u.Correo == correo));

    public Task<Usuario?> ObtenerPorIdAsync(int id) =>
        Task.FromResult(Usuarios.FirstOrDefault(u => u.Id == id));

    public Task ActualizarAsync(Usuario usuario)
    {
        SeLlamoActualizar = true;
        return Task.CompletedTask;
    }

    public Task<List<string>> CorreosAdministradoresActivosAsync() =>
        Task.FromResult(Usuarios
            .Where(u => u.Rol == RolUsuario.Administrador && u.Estado == EstadoCuenta.Activo)
            .Select(u => u.Correo)
            .ToList());

    public Task LiberarEliminadosAsync(string correo, string documento)
    {
        SeLlamoLiberarEliminados = true;
        foreach (var u in Usuarios.Where(u =>
                     u.Estado == EstadoCuenta.Eliminado && (u.Correo == correo || u.Documento == documento)))
            u.LiberarIdentificadores();
        return Task.CompletedTask;
    }
}ParseOptions.0.jsonÍ
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\HomeControllerTests.csÒ
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
}ParseOptions.0.jsoníj
bC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\NegocioControllerTests.csñiusing Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using NSubstitute;

public class NegocioControllerTests
{
    private sealed class Escenario
    {
        public INegocioService Servicio { get; } = Substitute.For<INegocioService>();
        public IAuthenticationService Autenticacion { get; } = Substitute.For<IAuthenticationService>();
        public NegocioController Controlador { get; }

        public Escenario(bool autenticado = true)
        {
            Controlador = new NegocioController(Servicio).Preparar(
                usuarioId: autenticado ? 1 : null,
                rol: autenticado ? "Negocio" : null,
                autenticacion: Autenticacion);
        }
    }

    private static Task<(bool Ok, string? Error)> Res(bool ok, string? error = null) => Task.FromResult((ok, error));
    private static Task<(bool Ok, string? Error, bool CorreoEnviado)> Reg(bool ok, string? error, bool correo) =>
        Task.FromResult((ok, error, correo));

    private static void AssertRedirige(IActionResult r, string accion, string? controlador = null)
    {
        var redir = Assert.IsType<RedirectToActionResult>(r);
        Assert.Equal(accion, redir.ActionName);
        Assert.Equal(controlador, redir.ControllerName);
    }

    // ===== Registrar (CU-01) =====

    [Fact]
    public void Registrar_Get_SinSesion_RetornaVista()
    {
        var e = new Escenario(autenticado: false);

        Assert.IsType<RegistroNegocioDto>(Assert.IsType<ViewResult>(e.Controlador.Registrar()).Model);
    }

    [Fact]
    public void Registrar_Get_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario();

        AssertRedirige(e.Controlador.Registrar(), "Index", "Home");
    }

    [Fact]
    public async Task Registrar_Post_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario();

        AssertRedirige(await e.Controlador.Registrar(new RegistroNegocioDto()), "Index", "Home");
    }

    [Fact]
    public async Task Registrar_Post_CampoObligatorioVacio_AgregaMensajeGeneral()
    {
        var e = new Escenario(autenticado: false);
        e.Controlador.ModelState.AddModelError("Nombre", RegistroNegocioDto.Obligatorio);

        var r = await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "Todos los campos son obligatorios");
    }

    [Fact]
    public async Task Registrar_Post_OtroErrorDeValidacion_NoAgregaMensajeGeneral()
    {
        var e = new Escenario(autenticado: false);
        e.Controlador.ModelState.AddModelError("Correo", "Correo no v√°lido");

        await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.False(e.Controlador.ModelState.ContainsKey(""));
    }

    [Fact]
    public async Task Registrar_Post_ServicioFalla_MuestraElError()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.RegistrarAsync(Arg.Any<RegistroNegocioDto>(), Arg.Any<string>()).Returns(Reg(false, "El tel√©fono ya est√° registrado", false));

        var r = await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "El tel√©fono ya est√° registrado");
    }

    [Fact]
    public async Task Registrar_Post_Exitoso_RedirigeAlLogin()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.RegistrarAsync(Arg.Any<RegistroNegocioDto>(), Arg.Any<string>()).Returns(Reg(true, null, true));

        var r = await e.Controlador.Registrar(new RegistroNegocioDto());

        AssertRedirige(r, "Login", "Usuario");
        Assert.Equal("Registro exitoso. Tu cuenta ser√° validada por un administrador", e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task Registrar_Post_ExitosoSinCorreo_AgregaAvisoAlMensaje()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.RegistrarAsync(Arg.Any<RegistroNegocioDto>(), Arg.Any<string>()).Returns(Reg(true, null, false));

        await e.Controlador.Registrar(new RegistroNegocioDto());

        Assert.Contains("no pudimos enviarte el correo", (string)e.Controlador.TempData["Mensaje"]!);
    }

    // ===== Perfil =====

    [Fact]
    public async Task Perfil_NoExiste_RetornaNotFound()
    {
        var e = new Escenario();
        e.Servicio.ObtenerPerfilAsync(1).Returns((PerfilNegocioDto?)null);

        Assert.IsType<NotFoundResult>(await e.Controlador.Perfil());
    }

    [Fact]
    public async Task Perfil_Existe_RetornaVistaConElPerfil()
    {
        var e = new Escenario();
        var perfil = new PerfilNegocioDto { Nombre = "Mi Negocio" };
        e.Servicio.ObtenerPerfilAsync(1).Returns(perfil);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Perfil());

        Assert.Same(perfil, vista.Model);
    }

    // ===== Enviar y verificar c√≥digo (CU-13) =====

    [Fact]
    public async Task EnviarCodigo_Falla_GuardaErrorYVuelveAlPerfil()
    {
        var e = new Escenario();
        e.Servicio.SolicitarCodigoAsync(1).Returns(Res(false, "No fue posible enviar el c√≥digo. Intenta nuevamente"));

        AssertRedirige(await e.Controlador.EnviarCodigo(), "Perfil");
        Assert.Equal("No fue posible enviar el c√≥digo. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task EnviarCodigo_Exitoso_VaALaVerificacion()
    {
        var e = new Escenario();
        e.Servicio.SolicitarCodigoAsync(1).Returns(Res(true));

        AssertRedirige(await e.Controlador.EnviarCodigo(), "VerificarCodigo");
        Assert.NotNull(e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public void VerificarCodigo_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<VerificarCodigoDto>(Assert.IsType<ViewResult>(e.Controlador.VerificarCodigo()).Model);
    }

    [Fact]
    public async Task VerificarCodigo_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Codigo", "El c√≥digo tiene 6 d√≠gitos");

        Assert.IsType<ViewResult>(await e.Controlador.VerificarCodigo(new VerificarCodigoDto { Codigo = "12" }));
        await e.Servicio.DidNotReceive().VerificarCodigoAsync(Arg.Any<int>(), Arg.Any<string>());
    }

    [Fact]
    public async Task VerificarCodigo_Post_CodigoIncorrecto_MuestraError()
    {
        var e = new Escenario();
        e.Servicio.VerificarCodigoAsync(1, "111111").Returns(Res(false, "C√≥digo incorrecto, intenta nuevamente"));

        var r = await e.Controlador.VerificarCodigo(new VerificarCodigoDto { Codigo = "111111" });

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "C√≥digo incorrecto, intenta nuevamente");
    }

    [Fact]
    public async Task VerificarCodigo_Post_CodigoCorrecto_VaAEditar()
    {
        var e = new Escenario();
        e.Servicio.VerificarCodigoAsync(1, "111111").Returns(Res(true));

        AssertRedirige(await e.Controlador.VerificarCodigo(new VerificarCodigoDto { Codigo = "111111" }), "Editar");
    }

    // ===== Editar =====

    [Fact]
    public async Task Editar_Get_SinAutorizacion_VuelveAlPerfil()
    {
        var e = new Escenario();
        e.Servicio.EdicionAutorizadaAsync(1).Returns(false);

        AssertRedirige(await e.Controlador.Editar(), "Perfil");
        Assert.Equal(NegocioService.MensajeSinVerificacion, e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task Editar_Get_AutorizadoPeroSinDatos_RetornaNotFound()
    {
        var e = new Escenario();
        e.Servicio.EdicionAutorizadaAsync(1).Returns(true);
        e.Servicio.ObtenerParaEditarAsync(1).Returns((EditarNegocioDto?)null);

        Assert.IsType<NotFoundResult>(await e.Controlador.Editar());
    }

    [Fact]
    public async Task Editar_Get_Autorizado_RetornaVistaConLosDatos()
    {
        var e = new Escenario();
        var dto = new EditarNegocioDto { Nombre = "Mi Negocio" };
        e.Servicio.EdicionAutorizadaAsync(1).Returns(true);
        e.Servicio.ObtenerParaEditarAsync(1).Returns(dto);

        Assert.Same(dto, Assert.IsType<ViewResult>(await e.Controlador.Editar()).Model);
    }

    [Fact]
    public async Task Editar_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Nombre", "Campo obligatorio");

        Assert.IsType<ViewResult>(await e.Controlador.Editar(new EditarNegocioDto()));
        await e.Servicio.DidNotReceive().EditarAsync(Arg.Any<int>(), Arg.Any<EditarNegocioDto>());
    }

    [Fact]
    public async Task Editar_Post_SinVerificacion_VuelveAlPerfil()
    {
        var e = new Escenario();
        e.Servicio.EditarAsync(1, Arg.Any<EditarNegocioDto>()).Returns(Res(false, NegocioService.MensajeSinVerificacion));

        AssertRedirige(await e.Controlador.Editar(new EditarNegocioDto()), "Perfil");
        Assert.Equal(NegocioService.MensajeSinVerificacion, e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task Editar_Post_OtroError_MuestraElErrorEnLaVista()
    {
        var e = new Escenario();
        e.Servicio.EditarAsync(1, Arg.Any<EditarNegocioDto>()).Returns(Res(false, "El correo ya est√° registrado en otra cuenta"));

        var r = await e.Controlador.Editar(new EditarNegocioDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "El correo ya est√° registrado en otra cuenta");
    }

    [Fact]
    public async Task Editar_Post_Exitoso_VuelveAlPerfilConMensaje()
    {
        var e = new Escenario();
        e.Servicio.EditarAsync(1, Arg.Any<EditarNegocioDto>()).Returns(Res(true));

        AssertRedirige(await e.Controlador.Editar(new EditarNegocioDto()), "Perfil");
        Assert.Equal("Los cambios han sido guardados exitosamente", e.Controlador.TempData["Mensaje"]);
    }

    // ===== Eliminar negocio (CU-11) =====

    [Fact]
    public async Task VerificarEliminacion_ModeloInvalido_RetornaJsonConError()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Password", "Ingresa tu contrase√±a");

        var json = Assert.IsType<JsonResult>(await e.Controlador.VerificarEliminacion(new EliminarCuentaDto())).AJson();

        Assert.Contains("\"ok\":false", json);
        Assert.Contains("Ingresa tu contrase√±a", json);
    }

    [Fact]
    public async Task VerificarEliminacion_ServicioResponde_RetornaJsonConElResultado()
    {
        var e = new Escenario();
        e.Servicio.ValidarEliminacionAsync(1, "Clave123").Returns(Res(true));

        var json = Assert.IsType<JsonResult>(
            await e.Controlador.VerificarEliminacion(new EliminarCuentaDto { Password = "Clave123" })).AJson();

        Assert.Contains("\"ok\":true", json);
    }

    [Fact]
    public async Task EliminarCuenta_ModeloInvalido_VuelveAlPerfil()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Password", "Ingresa tu contrase√±a");

        AssertRedirige(await e.Controlador.EliminarCuenta(new EliminarCuentaDto()), "Perfil");
        Assert.Equal("Ingresa tu contrase√±a", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task EliminarCuenta_ServicioFalla_VuelveAlPerfilConError()
    {
        var e = new Escenario();
        e.Servicio.EliminarCuentaAsync(1, "mala1").Returns(Res(false, "Contrase√±a incorrecta"));

        AssertRedirige(await e.Controlador.EliminarCuenta(new EliminarCuentaDto { Password = "mala1" }), "Perfil");
        Assert.Equal("Contrase√±a incorrecta", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task EliminarCuenta_Exitoso_CierraSesionYVaAlHome()
    {
        var e = new Escenario();
        e.Servicio.EliminarCuentaAsync(1, "Clave123").Returns(Res(true));

        var r = await e.Controlador.EliminarCuenta(new EliminarCuentaDto { Password = "Clave123" });

        AssertRedirige(r, "Index", "Home");
        Assert.Equal("Tu cuenta ha sido eliminada", e.Controlador.TempData["Mensaje"]);
        await e.Autenticacion.Received(1).SignOutAsync(Arg.Any<HttpContext>(), Arg.Any<string>(), Arg.Any<AuthenticationProperties>());
    }

    // ===== Perfil p√∫blico (CU-25) =====

    [Fact]
    public async Task Publico_NoExiste_RetornaNotFound()
    {
        var e = new Escenario(autenticado: false);
        e.Servicio.ObtenerPerfilPublicoAsync(9).Returns((PerfilPublicoNegocioDto?)null);

        Assert.IsType<NotFoundResult>(await e.Controlador.Publico(9));
    }

    [Fact]
    public async Task Publico_Existe_RetornaVistaConElPerfil()
    {
        var e = new Escenario(autenticado: false);
        var perfil = new PerfilPublicoNegocioDto { Nombre = "Mi Negocio" };
        e.Servicio.ObtenerPerfilPublicoAsync(9).Returns(perfil);

        Assert.Same(perfil, Assert.IsType<ViewResult>(await e.Controlador.Publico(9)).Model);
    }
}ParseOptions.0.jsonÜb
mC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\NegocioServicePerfilYEdicionTests.csˇ`using Microsoft.Extensions.Logging.Abstractions;

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
        TipoActividad = "Cafeter√≠a",
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

    // ===== Solicitar y verificar c√≥digo =====

    [Fact]
    public async Task SolicitarCodigo_FallaEnvioCorreo_RetornaError()
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.Email.DebeFallar = true;

        var (ok, error) = await e.Servicio.SolicitarCodigoAsync(1);

        Assert.False(ok);
        Assert.Equal("No fue posible enviar el c√≥digo. Intenta nuevamente", error);
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
        Assert.Equal("El c√≥digo expir√≥ o ya no es v√°lido. Solicita uno nuevo", error);
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

    // ===== Edici√≥n autorizada =====

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
        Assert.Equal("No fue posible actualizar la informaci√≥n. Intenta Nuevamente", error);
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
        Assert.Equal("El correo ya est√° registrado en otra cuenta", error);
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
        Assert.Equal("El tel√©fono ya est√° registrado en otro negocio", error);
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
        Assert.Equal("Contrase√±a incorrecta", error);
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
        Assert.Equal("Contrase√±a incorrecta", error);
        Assert.Equal(EstadoCuenta.Activo, usuario.Estado);
    }
}ParseOptions.0.jsonÊI
_C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\NegocioServiceTests.csÌHusing Microsoft.Extensions.Logging.Abstractions;

public class NegocioServiceTests
{
    private const string UrlRevision = "https://prueba/revision";

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

        var (ok, error, _) = await servicio.RegistrarAsync(DtoValido(), UrlRevision);

        Assert.False(ok);
        Assert.Contains("ya est√° registrado", error);
    }

    [Fact]
    public async Task Registrar_CorreoYaExiste_RetornaError()
    {
        var usuarios = new UsuarioRepositoryFalso();
        usuarios.Usuarios.Add(new Usuario { Correo = "nuevo@gtrack.local" });
        var servicio = Crear(new NegocioRepositoryFalso(), usuarios, new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(DtoValido(), UrlRevision);

        Assert.False(ok);
        Assert.Contains("ya est√° registrado", error);
    }

    [Fact]
    public async Task Registrar_TelefonoYaExiste_RetornaError()
    {
        var negocios = new NegocioRepositoryFalso();
        negocios.TelefonosExistentes.Add("3001234567");
        var servicio = Crear(negocios, new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(DtoValido(), UrlRevision);

        Assert.False(ok);
        Assert.Equal("El tel√©fono ya est√° registrado", error);
    }

    [Theory]
    [InlineData("Clave123", "Distinta123")] // no coinciden
    [InlineData("abcdef", "abcdef")]        // sin d√≠gito
    public async Task Registrar_PasswordInvalida_RetornaError(string password, string confirmar)
    {
        var dto = DtoValido();
        dto.Password = password;
        dto.ConfirmarPassword = confirmar;
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, _) = await servicio.RegistrarAsync(dto, UrlRevision);

        Assert.False(ok);
        Assert.Contains("contrase√±as", error);
    }

    [Fact]
    public async Task Registrar_DatosValidos_RegistraYEnviaCorreo()
    {
        var negocios = new NegocioRepositoryFalso();
        var servicio = Crear(negocios, new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error, correoEnviado) = await servicio.RegistrarAsync(DtoValido(), UrlRevision);

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

        var (ok, error, correoEnviado) = await servicio.RegistrarAsync(DtoValido(), UrlRevision);

        Assert.True(ok);
        Assert.Null(error);
        Assert.False(correoEnviado);
    }

    // ===== CU-13 Solicitar c√≥digo =====

    [Fact]
    public async Task SolicitarCodigo_UsuarioNoExiste_RetornaError()
    {
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error) = await servicio.SolicitarCodigoAsync(1);

        Assert.False(ok);
        Assert.Equal("No fue posible enviar el c√≥digo. Intenta nuevamente", error);
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
        Assert.Single(email.EnviadosHtml);
    }

    // ===== CU-13 Verificar c√≥digo =====

    [Fact]
    public async Task VerificarCodigo_NoHayCodigo_RetornaExpirado()
    {
        var servicio = Crear(new NegocioRepositoryFalso(), new UsuarioRepositoryFalso(), new CodigoVerificacionRepositoryFalso(), new EmailServiceFalso());

        var (ok, error) = await servicio.VerificarCodigoAsync(1, "123456");

        Assert.False(ok);
        Assert.Equal("El c√≥digo expir√≥ o ya no es v√°lido. Solicita uno nuevo", error);
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
        Assert.Equal("C√≥digo incorrecto, intenta nuevamente", error);
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
}ParseOptions.0.jsonî]
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\PedidoControllerTests.csô\using Microsoft.AspNetCore.Mvc;
using NSubstitute;
using UbicacionResultado = (bool Ok, string? Error, decimal? Latitud, decimal? Longitud, System.DateTime? FechaUtc, string? Estado);

public class PedidoControllerTests
{
    private sealed class Escenario
    {
        public IPedidoService Pedidos { get; } = Substitute.For<IPedidoService>();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public IUbicacionService Ubicaciones { get; } = Substitute.For<IUbicacionService>();
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();
        public PedidoController Controlador { get; }

        public Escenario()
        {
            Controlador = new PedidoController(Pedidos, Negocios, Contexto, Ubicaciones)
                .Preparar(usuarioId: 1, rol: "Negocio");
        }

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
            return this;
        }
    }

    private static Task<(bool Ok, string? Error, string? Codigo)> Reg(bool ok, string? error, string? codigo) =>
        Task.FromResult((ok, error, codigo));

    private static Task<(bool Ok, string? Error)> Res(bool ok, string? error = null) =>
        Task.FromResult((ok, error));

    private static Task<UbicacionResultado> Ubi(bool ok, string? error, decimal? lat, decimal? lng, DateTime? fecha, string? estado) =>
        Task.FromResult<UbicacionResultado>((ok, error, lat, lng, fecha, estado));

    // ===== Registrar =====

    [Fact]
    public void Registrar_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<RegistrarPedidoDto>(Assert.IsType<ViewResult>(e.Controlador.Registrar()).Model);
    }

    [Fact]
    public async Task Registrar_Post_ModeloInvalido_RetornaVistaSinLlamarAlServicio()
    {
        var e = new Escenario();
        var dto = new RegistrarPedidoDto();
        e.Controlador.ModelState.AddModelError("DireccionEntrega", "Campo obligatorio");

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Registrar(dto));

        Assert.Same(dto, vista.Model);
        await e.Pedidos.DidNotReceive().RegistrarAsync(Arg.Any<int>(), Arg.Any<RegistrarPedidoDto>());
    }

    [Fact]
    public async Task Registrar_Post_ServicioFalla_MuestraElError()
    {
        var e = new Escenario();
        e.Pedidos.RegistrarAsync(1, Arg.Any<RegistrarPedidoDto>())
            .Returns(Reg(false, "No fue posible registrar el pedido. Intenta nuevamente", null));

        var r = await e.Controlador.Registrar(new RegistrarPedidoDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "No fue posible registrar el pedido. Intenta nuevamente");
    }

    [Fact]
    public async Task Registrar_Post_Exitoso_GuardaElCodigoYVaAActivos()
    {
        var e = new Escenario();
        e.Pedidos.RegistrarAsync(1, Arg.Any<RegistrarPedidoDto>()).Returns(Reg(true, null, "ABC12345"));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.Registrar(new RegistrarPedidoDto()));

        Assert.Equal("Activos", r.ActionName);
        Assert.Contains("ABC12345", (string)e.Controlador.TempData["Mensaje"]!);
    }

    // ===== BuscarCliente =====

    [Fact]
    public async Task BuscarCliente_RetornaJsonConElCliente()
    {
        var e = new Escenario();
        var cliente = new ClienteAutocompletarDto { Nombre = "Carlos", Direccion = "Calle 9" };
        e.Pedidos.BuscarClienteFrecuenteAsync(1, "3001112233").Returns(cliente);

        var json = Assert.IsType<JsonResult>(await e.Controlador.BuscarCliente("3001112233"));

        Assert.Same(cliente, json.Value);
    }

    [Fact]
    public async Task BuscarCliente_SinCoincidencia_RetornaJsonNulo()
    {
        var e = new Escenario();
        e.Pedidos.BuscarClienteFrecuenteAsync(1, "3000000000").Returns((ClienteAutocompletarDto?)null);

        var json = Assert.IsType<JsonResult>(await e.Controlador.BuscarCliente("3000000000"));

        Assert.Null(json.Value);
    }

    // ===== Activos e Historial =====

    [Fact]
    public async Task Activos_SinNegocio_RetornaPedidosYRepartidoresVacios()
    {
        var e = new Escenario();
        var lista = new List<Pedido>();
        e.Pedidos.ObtenerPedidosActivosAsync(1).Returns(lista);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Activos());

        Assert.Same(lista, vista.Model);
        Assert.Empty(Assert.IsType<List<Repartidor>>(vista.ViewData["Repartidores"]));
    }

    [Fact]
    public async Task Activos_ConNegocio_ListaSoloLosRepartidoresActivosDeSuNegocio()
    {
        var e = new Escenario().ConNegocio();
        e.Pedidos.ObtenerPedidosActivosAsync(1).Returns(new List<Pedido>());
        e.Contexto.Usuarios.AddRange(
            new Usuario { Id = 2, Correo = "a@gtrack.local", Documento = "200000", Rol = RolUsuario.Repartidor, Estado = EstadoCuenta.Activo },
            new Usuario { Id = 3, Correo = "b@gtrack.local", Documento = "300000", Rol = RolUsuario.Repartidor, Estado = EstadoCuenta.Suspendido });
        e.Contexto.Repartidores.AddRange(
            new Repartidor { Id = 5, UsuarioId = 2, NegocioId = 10 },   // activo, de este negocio
            new Repartidor { Id = 6, UsuarioId = 3, NegocioId = 10 },   // suspendido
            new Repartidor { Id = 7, UsuarioId = 2, NegocioId = 99 });  // de otro negocio
        await e.Contexto.SaveChangesAsync();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Activos());

        var repartidores = Assert.IsType<List<Repartidor>>(vista.ViewData["Repartidores"]);
        Assert.Equal(5, Assert.Single(repartidores).Id);
    }

    [Fact]
    public async Task Historial_RetornaVistaConElHistorial()
    {
        var e = new Escenario();
        var lista = new List<Pedido> { new() { Id = 1 } };
        e.Pedidos.ObtenerHistorialPedidosAsync(1).Returns(lista);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Historial());

        Assert.Same(lista, vista.Model);
    }

    // ===== ActualizarEstado =====

    [Fact]
    public async Task ActualizarEstado_Falla_GuardaElMensajeDelServicio()
    {
        var e = new Escenario();
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, "Este pedido ya se encuentra finalizado y no puede ser modificado."));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(1, 3, null));

        Assert.Equal("Activos", r.ActionName);
        Assert.Equal("Este pedido ya se encuentra finalizado y no puede ser modificado.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task ActualizarEstado_FallaSinMensaje_GuardaMensajePorDefecto()
    {
        var e = new Escenario();
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, null));

        await e.Controlador.ActualizarEstado(1, 3, null);

        Assert.Equal("No fue posible actualizar el estado.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task ActualizarEstado_Exitoso_GuardaMensajeDeExito()
    {
        var e = new Escenario();
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(1, 3, 5));

        Assert.Equal("Activos", r.ActionName);
        Assert.Equal("¬°El estado del pedido se ha actualizado correctamente!", e.Controlador.TempData["Mensaje"]);
    }

    // ===== Consultar (CU-05) =====

    [Fact]
    public void Consultar_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<ViewResult>(e.Controlador.Consultar());
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("ABC")]
    [InlineData("ABC-1234")]
    [InlineData("ABCDEFGHI")]
    public async Task Consultar_Post_CodigoConFormatoInvalido_MuestraCodigoNoEncontrado(string? codigo)
    {
        var e = new Escenario();

        var r = await e.Controlador.Consultar(codigo!);

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "C√≥digo no encontrado, verifica e intenta nuevamente");
    }

    [Fact]
    public async Task Consultar_Post_PedidoNoExiste_MuestraCodigoNoEncontrado()
    {
        var e = new Escenario();

        var r = await e.Controlador.Consultar("ABC12345");

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "C√≥digo no encontrado, verifica e intenta nuevamente");
    }

    [Fact]
    public async Task Consultar_Post_PedidoExisteSinSqlReal_MuestraErrorDeCarga()
    {
        // La l√≠nea de tiempo usa SQL crudo (SqlQuery), que EF InMemory no soporta:
        // esto ejercita el camino de error FE-14-CU05.
        var e = new Escenario();
        e.Contexto.Usuarios.Add(new Usuario { Id = 1, Correo = "n@gtrack.local", Documento = "100000", Rol = RolUsuario.Negocio });
        e.Contexto.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
        e.Contexto.Pedidos.Add(new Pedido { Id = 1, Codigo = "ABC12345", NegocioId = 10, ClienteId = 1 });
        await e.Contexto.SaveChangesAsync();

        var r = await e.Controlador.Consultar(" abc12345 ");

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "No fue posible cargar la informaci√≥n. Intenta nuevamente");
    }

    // ===== Ubicacion =====

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    [InlineData("ABC")]
    [InlineData("ABC-1234")]
    public async Task Ubicacion_CodigoInvalido_RetornaNoDisponible(string codigo)
    {
        var e = new Escenario();

        var json = Assert.IsType<JsonResult>(await e.Controlador.Ubicacion(codigo)).AJson();

        Assert.Contains("\"disponible\":false", json);
        await e.Ubicaciones.DidNotReceive().ObtenerPorCodigoAsync(Arg.Any<string>());
    }

    [Fact]
    public async Task Ubicacion_ConUbicacion_RetornaCoordenadasYEstado()
    {
        var e = new Escenario();
        var fecha = new DateTime(2026, 11, 14, 12, 0, 0, DateTimeKind.Utc);
        e.Ubicaciones.ObtenerPorCodigoAsync("ABC12345").Returns(Ubi(true, null, 4.7m, -74.1m, fecha, "EnCamino"));

        var json = Assert.IsType<JsonResult>(await e.Controlador.Ubicacion(" abc12345 ")).AJson();

        Assert.Contains("\"disponible\":true", json);
        Assert.Contains("\"lat\":4.7", json);
        Assert.Contains("\"lng\":-74.1", json);
        Assert.Contains("\"fechaUtc\":\"2026-11-14T12:00:00Z\"", json);
        Assert.Contains("\"estado\":\"EnCamino\"", json);
    }

    [Fact]
    public async Task Ubicacion_SinUbicacion_RetornaNoDisponibleConEstado()
    {
        var e = new Escenario();
        e.Ubicaciones.ObtenerPorCodigoAsync("ABC12345")
            .Returns(Ubi(false, "No hay ubicaci√≥n disponible para este pedido.", null, null, null, "Entregado"));

        var json = Assert.IsType<JsonResult>(await e.Controlador.Ubicacion("ABC12345")).AJson();

        Assert.Contains("\"disponible\":false", json);
        Assert.Contains("\"estado\":\"Entregado\"", json);
    }
}ParseOptions.0.jsonæÿ
^C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\PedidoServiceTests.cs≈◊using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;

public class PedidoServiceTests
{
    private sealed class Escenario
    {
        public PedidoRepositoryFalso Pedidos { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public AppDbContext Contexto { get; set; } = ContextoFactory.Crear();
        public EmailServiceFalso Email { get; } = new();

        public PedidoService Servicio => new(Pedidos, Negocios, Contexto, Email, NullLogger<PedidoService>.Instance);


        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Mi Negocio" });
            return this;
        }

        public Pedido AgregarPedido(EstadoPedido estado, int? repartidorId = null, int negocioId = 10, int id = 1)
        {
            var p = new Pedido
            {
                Id = id,
                Codigo = $"PED{id:00000}",
                NegocioId = negocioId,
                EstadoPedidoId = (int)estado,
                RepartidorId = repartidorId
            };
            Pedidos.Pedidos.Add(p);
            return p;
        }

        public async Task AgregarRepartidorAsync(int id = 5, int usuarioId = 2)
        {
            Contexto.Repartidores.Add(new Repartidor { Id = id, UsuarioId = usuarioId, NegocioId = 10 });
            await Contexto.SaveChangesAsync();
        }

        // Pedido guardado en el contexto (lo usan CancelarPorCliente y RegistrarNovedad, que leen directo de la BD)
        public async Task AgregarPedidoEnContextoAsync(
            string codigo = "ABC12345", EstadoPedido estado = EstadoPedido.Recibido, int? repartidorId = null, int id = 1)
        {
            Contexto.Usuarios.Add(new Usuario { Id = 1, Correo = "n@gtrack.local", Documento = "100000", Rol = RolUsuario.Negocio });
            Contexto.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Mi Negocio" });
            Contexto.Set<Cliente>().Add(new Cliente { Id = 1, NombreCompleto = "Carlos", Telefono = "3001112233", NegocioId = 10 });
            Contexto.Pedidos.Add(new Pedido
            {
                Id = id,
                Codigo = codigo,
                NegocioId = 10,
                ClienteId = 1,
                EstadoPedidoId = (int)estado,
                RepartidorId = repartidorId
            });
            await Contexto.SaveChangesAsync();
        }

        public async Task SuspenderAsync(int repartidorId = 5)
        {
            Contexto.SuspensionRepartidor.Add(new SuspensionRepartidor
            {
                RepartidorId = repartidorId,
                AdministradorId = 1,
                Motivo = "Prueba",
                FechaSuspension = DateTime.UtcNow
            });
            await Contexto.SaveChangesAsync();
        }
    }

    private static RegistrarPedidoDto DtoValido() => new()
    {
        ClienteNombre = "Carlos Ruiz",
        ClienteTelefono = "3001112233",
        DireccionEntrega = " Calle 5 # 6-7 ",
        MetodoPago = MetodoPago.Efectivo,
        Productos =
        [
            new ItemPedidoDto { Descripcion = " Pizza ", Cantidad = 2, PrecioUnitario = 15000m },
            new ItemPedidoDto { Descripcion = "   " }
        ]
    };

    // ===== BuscarClienteFrecuente =====

    [Fact]
    public async Task BuscarCliente_NegocioNoExiste_RetornaNull()
    {
        var e = new Escenario();

        Assert.Null(await e.Servicio.BuscarClienteFrecuenteAsync(1, "3001112233"));
    }

    [Fact]
    public async Task BuscarCliente_SinPedidosPrevios_RetornaNull()
    {
        var e = new Escenario().ConNegocio();

        Assert.Null(await e.Servicio.BuscarClienteFrecuenteAsync(1, "3001112233"));
    }

    [Fact]
    public async Task BuscarCliente_PedidoSinCliente_RetornaNull()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);

        Assert.Null(await e.Servicio.BuscarClienteFrecuenteAsync(1, "3001112233"));
    }

    [Fact]
    public async Task BuscarCliente_ConPedidoPrevio_RetornaNombreYDireccion()
    {
        var e = new Escenario().ConNegocio();
        var pedido = e.AgregarPedido(EstadoPedido.Entregado);
        pedido.DireccionEntrega = "Calle 9";
        pedido.Cliente = new Cliente { Telefono = "3001112233", NombreCompleto = "Carlos" };

        var dto = await e.Servicio.BuscarClienteFrecuenteAsync(1, " 3001112233 ");

        Assert.NotNull(dto);
        Assert.Equal("Carlos", dto!.Nombre);
        Assert.Equal("Calle 9", dto.Direccion);
    }

    // ===== RegistrarAsync =====

    [Fact]
    public async Task Registrar_NegocioNoExiste_RetornaError()
    {
        var e = new Escenario();

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible identificar tu negocio", error);
    }

    [Fact]
    public async Task Registrar_SinProductosValidos_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Productos = [new ItemPedidoDto { Descripcion = "  " }];

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.False(ok);
        Assert.Equal("Debes completar todos los campos obligatorios del pedido", error);
    }

    [Fact]
    public async Task Registrar_ClienteNuevo_CreaClienteYPedido()
    {
        var e = new Escenario().ConNegocio();

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(8, codigo!.Length);

        var cliente = await e.Contexto.Set<Cliente>().SingleAsync();
        Assert.Equal("Carlos Ruiz", cliente.NombreCompleto);

        var pedido = Assert.Single(e.Pedidos.Pedidos);
        Assert.Equal(codigo, pedido.Codigo);
        Assert.Equal(cliente.Id, pedido.ClienteId);
        Assert.Equal("Calle 5 # 6-7", pedido.DireccionEntrega);
        Assert.Equal((int)EstadoPedido.Recibido, pedido.EstadoPedidoId);
        Assert.Equal("Pizza", Assert.Single(pedido.Items).Descripcion);
    }

    [Fact]
    public async Task Registrar_ClienteExistente_ActualizaNombreYDireccion()
    {
        var e = new Escenario().ConNegocio();
        e.Contexto.Set<Cliente>().Add(new Cliente
        {
            Id = 7,
            Telefono = "3001112233",
            NombreCompleto = "Nombre viejo",
            DireccionPredeterminada = "Direcci√≥n vieja",
            NegocioId = 10
        });
        await e.Contexto.SaveChangesAsync();

        var (ok, _, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.True(ok);
        var cliente = await e.Contexto.Set<Cliente>().SingleAsync();
        Assert.Equal("Carlos Ruiz", cliente.NombreCompleto);
        Assert.Equal("Calle 5 # 6-7", cliente.DireccionPredeterminada);
        Assert.Equal(7, e.Pedidos.Pedidos[0].ClienteId);
    }

    [Theory]
    [InlineData("nombre")]
    [InlineData("telefono")]
    [InlineData("direccion")]
    [InlineData("pago")]
    public async Task Registrar_FaltaUnCampoObligatorio_RetornaErrorYNoCreaNada(string campo)
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        switch (campo)
        {
            case "nombre": dto.ClienteNombre = "  "; break;
            case "telefono": dto.ClienteTelefono = ""; break;
            case "direccion": dto.DireccionEntrega = " "; break;
            case "pago": dto.MetodoPago = null; break;
        }

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.False(ok);
        Assert.Equal(PedidoService.MensajeCamposObligatorios, error);
        Assert.Null(codigo);
        Assert.Equal(0, await e.Contexto.Set<Cliente>().CountAsync());
        Assert.Empty(e.Pedidos.Pedidos);
    }

    [Theory]
    [InlineData(0, 1000)]
    [InlineData(1, 0)]
    public async Task Registrar_CantidadOPrecioInvalidos_RetornaError(int cantidad, decimal precio)
    {
        var e = new Escenario().ConNegocio();
        var dto = DtoValido();
        dto.Productos = [new ItemPedidoDto { Descripcion = "Pizza", Cantidad = cantidad, PrecioUnitario = precio }];

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, dto);

        Assert.False(ok);
        Assert.Equal("La cantidad y el precio de cada producto deben ser mayores que cero", error);
    }

    [Fact]
    public async Task Registrar_FallaGuardarCliente_RetornaErrorYNoRegistraElPedido()
    {
        var e = new Escenario { Contexto = ContextoFactory.CrearQueFallaAlGuardar() }.ConNegocio();

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible registrar el pedido. Intenta nuevamente", error);
        Assert.Null(codigo);
        Assert.Empty(e.Pedidos.Pedidos);
    }

    [Fact]
    public async Task Registrar_CodigoNuncaEsUnico_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Pedidos.CodigosSiempreExisten = true;

        var (ok, error, codigo) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible registrar el pedido. Intenta nuevamente", error);
        Assert.Null(codigo);
    }

    [Fact]
    public async Task Registrar_FallaAlGuardarPedido_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Pedidos.DebeFallarAlAgregar = true;

        var (ok, error, _) = await e.Servicio.RegistrarAsync(1, DtoValido());

        Assert.False(ok);
        Assert.Equal("No fue posible registrar el pedido. Intenta nuevamente", error);
    }

    // ===== ActualizarEstadoAsync: flujo del negocio =====

    [Fact]
    public async Task ActualizarEstado_PedidoNoExiste_RetornaError()
    {
        var e = new Escenario().ConNegocio();

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 99, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no pertenece a tu negocio", error);
    }

    [Fact]
    public async Task ActualizarEstado_PedidoDeOtroNegocio_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido, negocioId: 99);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no pertenece a tu negocio", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Entregado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task ActualizarEstado_PedidoFinalizado_NoSePuedeModificar(EstadoPedido estado)
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(estado);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Equal("Este pedido ya se encuentra finalizado y no puede ser modificado.", error);
    }

    [Fact]
    public async Task ActualizarEstado_EntregadoSinHaberSidoAsignado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Entregado);

        Assert.False(ok);
        Assert.Equal("Un pedido no puede saltarse estados: de \"Recibido\" primero debe pasar a \"En preparaci√≥n\"", error);
    }

    [Fact]
    public async Task ActualizarEstado_AsignarSinRepartidor_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.ListoParaEntrega);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Asignado);

        Assert.False(ok);
        Assert.Equal("Debes seleccionar un repartidor antes de pasar el pedido a este estado.", error);
    }

    [Fact]
    public async Task ActualizarEstado_AsignarRepartidorSuspendido_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.ListoParaEntrega);
        await e.SuspenderAsync(5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.Asignado, 5);

        Assert.False(ok);
        Assert.Contains("suspendido", error);
    }

    [Fact]
    public async Task ActualizarEstado_NegocioRetrocedeDeEstado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)EstadoPedido.EnPreparacion);

        Assert.False(ok);
        Assert.Contains("no puede volver a un estado anterior", error);
    }

    [Fact]
    public async Task ActualizarEstado_EstadoInexistente_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, 99);

        Assert.False(ok);
        Assert.Equal("El estado seleccionado no es v√°lido", error);
    }

    // El guardado del estado usa ExecuteUpdateAsync, que EF InMemory no soporta (en SQL Server real s√≠).
    // Por eso estas pruebas verifican que el cambio PASA todas las validaciones y llega al guardado:
    // el √∫nico error posible es el de la base de datos, nunca uno de regla de negocio.
    private const string ErrorDeGuardado = "No fue posible actualizar el estado del pedido. Intenta nuevamente";

    [Theory]
    [InlineData(EstadoPedido.Recibido, EstadoPedido.EnPreparacion, null, null)]
    [InlineData(EstadoPedido.EnPreparacion, EstadoPedido.ListoParaEntrega, null, null)]
    [InlineData(EstadoPedido.ListoParaEntrega, EstadoPedido.Asignado, 5, null)]   // repartidor elegido
    [InlineData(EstadoPedido.Asignado, EstadoPedido.EnCamino, null, 5)]            // el pedido ya ten√≠a repartidor
    [InlineData(EstadoPedido.Asignado, EstadoPedido.Asignado, 6, 5)]               // cambio de repartidor
    [InlineData(EstadoPedido.Recibido, EstadoPedido.Cancelado, null, null)]        // cancelar siempre se permite
    public async Task ActualizarEstado_NegocioCambioPermitido_LlegaAlGuardado(
        EstadoPedido actual, EstadoPedido nuevo, int? repartidorElegido, int? repartidorDelPedido)
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(actual, repartidorId: repartidorDelPedido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(1, 1, (int)nuevo, repartidorElegido);

        Assert.False(ok);
        Assert.Equal(ErrorDeGuardado, error);
    }

    // ===== Regla de estados (ValidarCambioEstado) =====

    [Theory]
    [InlineData(0, 1)]
    [InlineData(1, 2)]
    [InlineData(2, 3)]
    [InlineData(3, 4)]
    [InlineData(4, 5)]
    [InlineData(3, 3)]   // mismo estado (cambiar repartidor)
    [InlineData(0, 6)]   // cancelar
    [InlineData(4, 6)]
    public void ValidarCambioEstado_CambioPermitido_RetornaNull(int actual, int nuevo)
    {
        Assert.Null(PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    [Theory]
    [InlineData(0, 2)]
    [InlineData(1, 4)]
    [InlineData(2, 5)]
    public void ValidarCambioEstado_SaltarseEstados_RetornaError(int actual, int nuevo)
    {
        Assert.Contains("no puede saltarse estados", PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    [Theory]
    [InlineData(3, 1)]
    [InlineData(4, 0)]
    public void ValidarCambioEstado_Retroceder_RetornaError(int actual, int nuevo)
    {
        Assert.Contains("no puede volver a un estado anterior", PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    [Theory]
    [InlineData(0, -1)]
    [InlineData(0, 7)]
    public void ValidarCambioEstado_EstadoFueraDeRango_RetornaError(int actual, int nuevo)
    {
        Assert.Equal("El estado seleccionado no es v√°lido", PedidoService.ValidarCambioEstado(actual, nuevo));
    }

    // ===== ActualizarEstadoAsync: flujo del repartidor =====

    [Fact]
    public async Task ActualizarEstado_UsuarioDesconocido_RetornaError()
    {
        var e = new Escenario().ConNegocio();

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(99, 1, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("No fue posible identificar tu negocio o usuario", error);
    }

    [Fact]
    public async Task ActualizarEstado_RepartidorSuspendido_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        await e.SuspenderAsync();

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("Tu cuenta de repartidor se encuentra actualmente suspendida.", error);
    }

    [Theory]
    [InlineData(99, 99)]  // el pedido no existe
    [InlineData(1, 77)]   // el pedido es de otro repartidor
    public async Task ActualizarEstado_RepartidorSinElPedidoAsignado_RetornaError(int pedidoId, int repartidorDelPedido)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: repartidorDelPedido);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, pedidoId, (int)EstadoPedido.EnCamino);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no est√° asignado a tu cuenta.", error);
    }

    [Fact]
    public async Task ActualizarEstado_RepartidorTransicionInvalida_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(EstadoPedido.Asignado, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)EstadoPedido.Entregado);

        Assert.False(ok);
        Assert.Equal("Este pedido ya no se puede actualizar", error);
    }

    // Igual que arriba: ExecuteUpdateAsync no existe en InMemory, as√≠ que se comprueba que la transici√≥n
    // pasa la validaci√≥n y llega al guardado.
    [Theory]
    [InlineData(EstadoPedido.Asignado, EstadoPedido.EnCamino)]
    [InlineData(EstadoPedido.EnCamino, EstadoPedido.Entregado)]
    public async Task ActualizarEstado_RepartidorTransicionValida_LlegaAlGuardado(EstadoPedido actual, EstadoPedido nuevo)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync();
        e.AgregarPedido(actual, repartidorId: 5);

        var (ok, error) = await e.Servicio.ActualizarEstadoAsync(2, 1, (int)nuevo);

        Assert.False(ok);
        Assert.Equal(ErrorDeGuardado, error);
    }

    // ===== Listados =====

    [Fact]
    public async Task Listados_NegocioNoExiste_RetornanVacio()
    {
        var e = new Escenario();

        Assert.Empty(await e.Servicio.ObtenerPedidosActivosAsync(1));
        Assert.Empty(await e.Servicio.ObtenerHistorialPedidosAsync(1));
    }

    [Fact]
    public async Task Listados_SeparanActivosDeHistorial()
    {
        var e = new Escenario().ConNegocio();
        e.AgregarPedido(EstadoPedido.Recibido, id: 1);
        e.AgregarPedido(EstadoPedido.EnCamino, id: 2);
        e.AgregarPedido(EstadoPedido.Entregado, id: 3);
        e.AgregarPedido(EstadoPedido.Cancelado, id: 4);

        var activos = await e.Servicio.ObtenerPedidosActivosAsync(1);
        var historial = await e.Servicio.ObtenerHistorialPedidosAsync(1);

        Assert.Equal(2, activos.Count);
        Assert.All(activos, p => Assert.True(p.EstadoPedidoId < (int)EstadoPedido.Entregado));
        Assert.Equal(2, historial.Count);
        Assert.All(historial, p => Assert.True(p.EstadoPedidoId >= (int)EstadoPedido.Entregado));
    }

    // ===== CU-17: cancelar pedido (cliente) =====

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("ABC")]
    [InlineData("ABC-1234")]
    public async Task Cancelar_CodigoConFormatoInvalido_RetornaCodigoNoEncontrado(string? codigo)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync(codigo, "Me equivoqu√©");

        Assert.False(ok);
        Assert.Equal(PedidoService.MensajeCodigoNoEncontrado, error);
    }

    [Theory]
    [InlineData(null)]
    [InlineData("   ")]
    public async Task Cancelar_SinMotivo_RetornaError(string? motivo)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", motivo);

        Assert.False(ok);
        Assert.Equal("Escribe el motivo de la cancelaci√≥n", error);
    }

    [Fact]
    public async Task Cancelar_MotivoDemasiadoLargo_RetornaError()
    {
        var e = new Escenario();
        var motivo = new string('a', PedidoService.MaxCaracteresMotivo + 1);

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", motivo);

        Assert.False(ok);
        Assert.Equal($"El motivo puede tener m√°ximo {PedidoService.MaxCaracteresMotivo} caracteres", error);
    }

    [Fact]
    public async Task Cancelar_PedidoNoExiste_RetornaCodigoNoEncontrado()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("abc12345", "Me equivoqu√©");

        Assert.False(ok);
        Assert.Equal(PedidoService.MensajeCodigoNoEncontrado, error);
    }

    [Fact]
    public async Task Cancelar_YaExisteSolicitud_RetornaError()
    {
        var e = new Escenario();
        await e.AgregarPedidoEnContextoAsync();
        e.Contexto.SolicitudesCancelacion.Add(new SolicitudCancelacion
        {
            PedidoId = 1,
            Motivo = "Antes",
            FechaSolicitud = DateTime.UtcNow
        });
        await e.Contexto.SaveChangesAsync();

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", "Otra vez");

        Assert.False(ok);
        Assert.Equal("Ya existe una solicitud de cancelaci√≥n para este pedido", error);
    }

    [Theory]
    [InlineData(EstadoPedido.EnCamino)]
    [InlineData(EstadoPedido.Entregado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task Cancelar_PedidoYaNoCancelable_RetornaError(EstadoPedido estado)
    {
        var e = new Escenario();
        await e.AgregarPedidoEnContextoAsync(estado: estado);

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", "Me equivoqu√©");

        Assert.False(ok);
        Assert.Equal("Este pedido ya no puede ser cancelado", error);
    }

    [Fact]
    public async Task Cancelar_PedidoCancelable_LlegaAlGuardado()
    {
        // La cancelaci√≥n usa transacci√≥n y ExecuteUpdateAsync, que EF InMemory no soporta:
        // se comprueba que pasa todas las validaciones y llega al guardado.
        var e = new Escenario();
        await e.AgregarPedidoEnContextoAsync(estado: EstadoPedido.Recibido);

        var (ok, error) = await e.Servicio.CancelarPorClienteAsync("ABC12345", "Me equivoqu√©");

        Assert.False(ok);
        Assert.Equal("No fue posible cancelar el pedido. Intenta nuevamente", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Recibido, true)]
    [InlineData(EstadoPedido.EnPreparacion, true)]
    [InlineData(EstadoPedido.ListoParaEntrega, true)]
    [InlineData(EstadoPedido.Asignado, true)]
    [InlineData(EstadoPedido.EnCamino, false)]
    [InlineData(EstadoPedido.Entregado, false)]
    [InlineData(EstadoPedido.Cancelado, false)]
    public void EsCancelablePorCliente_SegunElEstado(EstadoPedido estado, bool esperado)
    {
        Assert.Equal(esperado, PedidoService.EsCancelablePorCliente((int)estado));
    }

    // ===== CU-16: novedad de pedido (repartidor) =====

    private static readonly int TipoNovedadValido = (int)Enum.GetValues<TipoNovedad>().First();

    [Theory]
    [InlineData(null)]
    [InlineData(999)]
    public async Task Novedad_TipoInvalido_RetornaError(int? tipo)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, tipo, null);

        Assert.False(ok);
        Assert.Equal("Debes seleccionar un tipo de novedad", error);
    }

    [Fact]
    public async Task Novedad_ObservacionesDemasiadoLargas_RetornaError()
    {
        var e = new Escenario();
        var texto = new string('a', PedidoService.MaxCaracteresObservaciones + 1);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, texto);

        Assert.False(ok);
        Assert.Equal($"Las observaciones pueden tener m√°ximo {PedidoService.MaxCaracteresObservaciones} caracteres", error);
    }

    [Fact]
    public async Task Novedad_SinPerfilDeRepartidor_RetornaError()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, null);

        Assert.False(ok);
        Assert.Equal("No se encontr√≥ el perfil de repartidor para tu cuenta.", error);
    }

    [Fact]
    public async Task Novedad_PedidoNoAsignadoAlRepartidor_RetornaError()
    {
        var e = new Escenario();
        await e.AgregarRepartidorAsync();
        await e.AgregarPedidoEnContextoAsync(repartidorId: 77);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, null);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado o no est√° asignado a tu cuenta.", error);
    }

    [Theory]
    [InlineData(EstadoPedido.Entregado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task Novedad_PedidoFinalizado_RetornaError(EstadoPedido estado)
    {
        var e = new Escenario();
        await e.AgregarRepartidorAsync();
        await e.AgregarPedidoEnContextoAsync(estado: estado, repartidorId: 5);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, null);

        Assert.False(ok);
        Assert.Equal("No se pueden reportar novedades sobre este pedido", error);
    }

    [Theory]
    [InlineData(" Llanta ponchada ", "Llanta ponchada")]
    [InlineData("   ", null)]
    [InlineData(null, null)]
    public async Task Novedad_PedidoActivo_RegistraLaNovedadSinCambiarElEstado(string? observaciones, string? guardada)
    {
        var e = new Escenario();
        await e.AgregarRepartidorAsync();
        await e.AgregarPedidoEnContextoAsync(estado: EstadoPedido.EnCamino, repartidorId: 5);

        var (ok, error) = await e.Servicio.RegistrarNovedadAsync(2, 1, TipoNovedadValido, observaciones);

        Assert.True(ok);
        Assert.Null(error);
        var novedad = await e.Contexto.NovedadesPedido.SingleAsync();
        Assert.Equal(1, novedad.PedidoId);
        Assert.Equal(guardada, novedad.Observaciones);
        var pedido = await e.Contexto.Pedidos.AsNoTracking().SingleAsync();
        Assert.Equal((int)EstadoPedido.EnCamino, pedido.EstadoPedidoId);
    }
}ParseOptions.0.jsonç@
dC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\RecuperacionServiceTests.csè?using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging.Abstractions;

public class RecuperacionServiceTests
{
    private sealed class HasherConHashInvalido : IPasswordHasher<Usuario>
    {
        public string HashPassword(Usuario user, string password) => $"HASH:{password}";

        public PasswordVerificationResult VerifyHashedPassword(Usuario user, string hashedPassword, string providedPassword) =>
            throw new FormatException("Hash inv√°lido");
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
    [InlineData("abcdef", "abcdef")]          // sin n√∫mero
    public async Task Restablecer_PasswordInvalida_RetornaError(string nueva, string confirmacion)
    {
        var e = new Escenario();
        e.AgregarUsuario();
        e.AgregarToken("tok");

        var (ok, error) = await e.Servicio.RestablecerAsync("tok", nueva, confirmacion);

        Assert.False(ok);
        Assert.Equal("Las contrase√±as no coinciden o no cumplen el formato requerido", error);
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
        Assert.Equal("La nueva contrase√±a no puede ser igual a la anterior", error);
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
}ParseOptions.0.jsonƒ|
eC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\RepartidorControllerTests.cs≈{using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;

public class RepartidorControllerTests
{
    private sealed class Escenario
    {
        public RepartidorRepositoryFalso Repartidores { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public IActivacionCuentaService Activacion { get; } = Substitute.For<IActivacionCuentaService>();
        public IPedidoService Pedidos { get; } = Substitute.For<IPedidoService>();
        public IUbicacionService Ubicaciones { get; } = Substitute.For<IUbicacionService>();
        public IPerfilRepartidorService Perfil { get; } = Substitute.For<IPerfilRepartidorService>();
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();
        public RepartidorController Controlador { get; }

        public Escenario(int usuarioId = 1, string rol = "Negocio")
        {
            Activacion.EnviarEnlaceAsync(
                    Arg.Any<Usuario>(), Arg.Any<string>(), Arg.Any<string?>(), Arg.Any<Func<string, string>>())
                .Returns(true);

            var servicio = new RepartidorService(
                Repartidores, Negocios, Usuarios, Activacion,
                NullLogger<RepartidorService>.Instance);

            Controlador = new RepartidorController(
                Repartidores, Negocios, servicio,
                Substitute.For<IWebHostEnvironment>(), Contexto,
                Pedidos, Ubicaciones, Perfil,
                NullLogger<RepartidorController>.Instance)
                .Preparar(usuarioId: usuarioId, rol: rol);
        }

        public Escenario ConNegocio()
        {
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1 });
            return this;
        }

        public async Task AgregarRepartidorAsync(
            int repartidorId = 5, int usuarioId = 2, int negocioId = 10, EstadoCuenta estado = EstadoCuenta.Activo)
        {
            Contexto.Usuarios.Add(new Usuario
            {
                Id = usuarioId,
                Correo = $"u{usuarioId}@gtrack.local",
                Documento = $"{usuarioId}00000",
                PasswordHash = "HASH:Clave123",
                Rol = RolUsuario.Repartidor,
                Estado = estado
            });
            Contexto.Repartidores.Add(new Repartidor { Id = repartidorId, UsuarioId = usuarioId, NegocioId = negocioId });
            await Contexto.SaveChangesAsync();
        }
    }

    private static Task<(bool Ok, string? Error)> Res(bool ok, string? error = null) =>
        Task.FromResult((ok, error));

    private static RegistroRepartidorDto Dto() => new()
    {
        NombreCompleto = "Juan P√©rez",
        Documento = "987654",
        Telefono = "3101234567",
        Correo = "juan@gtrack.local",
        Vehiculo = TipoVehiculo.Moto,
        Placa = "ABC12D"
    };

    // ===== Index =====

    [Fact]
    public async Task Index_SinNegocio_RetornaListaVacia()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index());

        Assert.Empty(Assert.IsType<List<Repartidor>>(vista.Model));
    }

    [Fact]
    public async Task Index_ConNegocio_RetornaSusRepartidores()
    {
        var e = new Escenario().ConNegocio();
        e.Repartidores.Repartidores.Add(new Repartidor { Id = 1, NegocioId = 10 });
        e.Repartidores.Repartidores.Add(new Repartidor { Id = 2, NegocioId = 99 });

        var vista = Assert.IsType<ViewResult>(await e.Controlador.Index());

        Assert.Single(Assert.IsType<List<Repartidor>>(vista.Model));
    }

    // ===== Registrar =====

    [Fact]
    public void Registrar_Get_RetornaVista()
    {
        var e = new Escenario();

        Assert.IsType<RegistroRepartidorDto>(Assert.IsType<ViewResult>(e.Controlador.Registrar()).Model);
    }

    [Fact]
    public async Task Registrar_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario().ConNegocio();
        e.Controlador.ModelState.AddModelError("Correo", "Correo no v√°lido");

        Assert.IsType<ViewResult>(await e.Controlador.Registrar(Dto()));
        Assert.Empty(e.Repartidores.Repartidores);
    }

    [Fact]
    public async Task Registrar_Post_CorreoYaExiste_MuestraErrorEnElCampo()
    {
        var e = new Escenario().ConNegocio();
        e.Usuarios.Usuarios.Add(new Usuario { Id = 9, Correo = "juan@gtrack.local", Documento = "111111" });

        var r = await e.Controlador.Registrar(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState["Correo"]!.Errors,
            err => err.ErrorMessage == "Este correo electr√≥nico ya se encuentra registrado.");
    }

    [Fact]
    public async Task Registrar_Post_DocumentoYaExiste_MuestraErrorEnElCampo()
    {
        var e = new Escenario().ConNegocio();
        e.Negocios.DocumentosExistentes.Add("987654");

        var r = await e.Controlador.Registrar(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState["Documento"]!.Errors,
            err => err.ErrorMessage == "Este n√∫mero de documento ya se encuentra registrado.");
    }

    [Fact]
    public async Task Registrar_Post_NegocioNoExiste_MuestraError()
    {
        var e = new Escenario();

        var r = await e.Controlador.Registrar(Dto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "No fue posible identificar tu negocio");
    }

    [Theory]
    [InlineData(TipoVehiculo.Moto)]
    [InlineData(TipoVehiculo.Carro)]
    public async Task Registrar_Post_Exitoso_CreaCuentaPendienteYRepartidor(TipoVehiculo vehiculo)
    {
        var e = new Escenario().ConNegocio();
        var dto = Dto();
        dto.Vehiculo = vehiculo;

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.Registrar(dto));

        Assert.Equal("Index", r.ActionName);
        Assert.StartsWith("¬°Repartidor registrado!", (string)e.Controlador.TempData["Mensaje"]!);

        var usuario = e.Repartidores.UsuarioRegistrado!;
        Assert.Equal(RolUsuario.Repartidor, usuario.Rol);
        Assert.Equal(EstadoCuenta.PendienteActivacion, usuario.Estado);
        Assert.Equal("", usuario.PasswordHash);

        var repartidor = Assert.Single(e.Repartidores.Repartidores);
        Assert.Equal(10, repartidor.NegocioId);
        Assert.Equal(vehiculo, repartidor.Vehiculo);
    }

    // ===== CambiarEstado =====

    [Fact]
    public async Task CambiarEstado_SinNegocio_RetornaNotFound()
    {
        var e = new Escenario();

        Assert.IsType<NotFoundResult>(await e.Controlador.CambiarEstado(5));
    }

    [Fact]
    public async Task CambiarEstado_RepartidorNoExiste_GuardaError()
    {
        var e = new Escenario().ConNegocio();

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.CambiarEstado(5));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal("El repartidor no existe o no pertenece a tu negocio.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task CambiarEstado_RepartidorDeOtroNegocio_GuardaError()
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync(negocioId: 99);

        await e.Controlador.CambiarEstado(5);

        Assert.Equal("El repartidor no existe o no pertenece a tu negocio.", e.Controlador.TempData["Error"]);
    }

    [Theory]
    [InlineData(EstadoCuenta.Activo, EstadoCuenta.Suspendido)]
    [InlineData(EstadoCuenta.Suspendido, EstadoCuenta.Activo)]
    public async Task CambiarEstado_AlternaEntreActivoYSuspendido(EstadoCuenta inicial, EstadoCuenta esperado)
    {
        var e = new Escenario().ConNegocio();
        await e.AgregarRepartidorAsync(estado: inicial);

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.CambiarEstado(5));

        Assert.Equal("Index", r.ActionName);
        Assert.Equal("El estado del repartidor ha sido actualizado correctamente.", e.Controlador.TempData["Mensaje"]);
        var usuario = await e.Contexto.Usuarios.AsNoTracking().SingleAsync();
        Assert.Equal(esperado, usuario.Estado);
    }

    // ===== MisPedidos =====

    [Fact]
    public async Task MisPedidos_SinPerfilDeRepartidor_GuardaErrorYRetornaListaVacia()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");

        var vista = Assert.IsType<ViewResult>(await e.Controlador.MisPedidos());

        Assert.Empty(Assert.IsType<List<Pedido>>(vista.Model));
        Assert.Equal("No se encontr√≥ el perfil de repartidor para tu cuenta.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task MisPedidos_RetornaSoloAsignadosYEnCamino_DelMasNuevoAlMasViejo()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        await e.AgregarRepartidorAsync();
        e.Contexto.Set<Cliente>().Add(new Cliente { Id = 1, NombreCompleto = "Cliente Prueba", Telefono = "3000000000", NegocioId = 10 });
        e.Contexto.Pedidos.AddRange(
            new Pedido { Id = 1, Codigo = "PED00001", ClienteId = 1, RepartidorId = 5, EstadoPedidoId = (int)EstadoPedido.Asignado, FechaCreacion = new DateTime(2026, 11, 1) },
            new Pedido { Id = 2, Codigo = "PED00002", ClienteId = 1, RepartidorId = 5, EstadoPedidoId = (int)EstadoPedido.EnCamino, FechaCreacion = new DateTime(2026, 11, 2) },
            new Pedido { Id = 3, Codigo = "PED00003", ClienteId = 1, RepartidorId = 5, EstadoPedidoId = (int)EstadoPedido.Entregado },
            new Pedido { Id = 4, Codigo = "PED00004", ClienteId = 1, RepartidorId = 99, EstadoPedidoId = (int)EstadoPedido.Asignado });
        await e.Contexto.SaveChangesAsync();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.MisPedidos());

        var pedidos = Assert.IsType<List<Pedido>>(vista.Model);
        Assert.Equal(new[] { 2, 1 }, pedidos.Select(p => p.Id));
    }

    [Fact]
    public async Task MisPedidos_FallaLaBaseDeDatos_RetornaVistaConModeloNulo()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Contexto.Dispose();

        var vista = Assert.IsType<ViewResult>(await e.Controlador.MisPedidos());

        Assert.Null(vista.Model);
    }

    // ===== ActualizarEstado / IniciarEntrega / MarcarEntregado =====

    [Theory]
    [InlineData(EstadoPedido.Recibido)]
    [InlineData(EstadoPedido.Asignado)]
    [InlineData(EstadoPedido.Cancelado)]
    public async Task ActualizarEstado_EstadoNoPermitido_GuardaErrorSinLlamarAlServicio(EstadoPedido estado)
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(10, (int)estado));

        Assert.Equal("MisPedidos", r.ActionName);
        Assert.Equal("Este pedido ya no se puede actualizar", e.Controlador.TempData["Error"]);
        await e.Pedidos.DidNotReceiveWithAnyArgs().ActualizarEstadoAsync(default, default, default, default);
    }

    [Fact]
    public async Task ActualizarEstado_ServicioFallaConMensaje_GuardaElMensaje()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, "Tu cuenta de repartidor se encuentra actualmente suspendida."));

        await e.Controlador.ActualizarEstado(10, (int)EstadoPedido.EnCamino);

        Assert.Equal("Tu cuenta de repartidor se encuentra actualmente suspendida.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task ActualizarEstado_ServicioFallaSinMensaje_GuardaMensajePorDefecto()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(false, null));

        await e.Controlador.ActualizarEstado(10, (int)EstadoPedido.Entregado);

        Assert.Equal("Este pedido ya no se puede actualizar", e.Controlador.TempData["Error"]);
    }

    [Theory]
    [InlineData(EstadoPedido.EnCamino, "Entrega iniciada: el pedido ahora est√° en camino.")]
    [InlineData(EstadoPedido.Entregado, "Entrega registrada exitosamente")]
    public async Task ActualizarEstado_Exitoso_GuardaMensajeSegunElEstado(EstadoPedido estado, string mensaje)
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.ActualizarEstado(10, (int)estado));

        Assert.Equal("MisPedidos", r.ActionName);
        Assert.Equal(mensaje, e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task ActualizarEstado_ElServicioLanzaExcepcion_GuardaErrorGeneral()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Task.FromException<(bool Ok, string? Error)>(new InvalidOperationException("fallo")));

        await e.Controlador.ActualizarEstado(10, (int)EstadoPedido.EnCamino);

        Assert.Equal("No fue posible actualizar el estado del pedido. Intenta nuevamente.", e.Controlador.TempData["Error"]);
    }

    [Fact]
    public async Task IniciarEntrega_PideAlServicioPasarAEnCamino()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        await e.Controlador.IniciarEntrega(10);

        await e.Pedidos.Received(1).ActualizarEstadoAsync(2, 10, (int)EstadoPedido.EnCamino, null);
    }

    [Fact]
    public async Task MarcarEntregado_PideAlServicioPasarAEntregado()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Pedidos.ActualizarEstadoAsync(Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int>(), Arg.Any<int?>())
            .Returns(Res(true));

        await e.Controlador.MarcarEntregado(10);

        await e.Pedidos.Received(1).ActualizarEstadoAsync(2, 10, (int)EstadoPedido.Entregado, null);
    }

    // ===== ActualizarUbicacion =====

    [Fact]
    public async Task ActualizarUbicacion_RetornaJsonConElResultadoDelServicio()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Ubicaciones.ActualizarAsync(2, 10, 4.7m, -74.1m).Returns(Res(true));

        var json = Assert.IsType<JsonResult>(await e.Controlador.ActualizarUbicacion(10, 4.7m, -74.1m)).AJson();

        Assert.Contains("\"ok\":true", json);
    }

    [Fact]
    public async Task ActualizarUbicacion_ServicioFalla_RetornaJsonConElError()
    {
        var e = new Escenario(usuarioId: 2, rol: "Repartidor");
        e.Ubicaciones.ActualizarAsync(2, 10, 4.7m, -74.1m).Returns(Res(false, "El pedido no se encuentra en camino."));

        var json = Assert.IsType<JsonResult>(await e.Controlador.ActualizarUbicacion(10, 4.7m, -74.1m)).AJson();

        Assert.Contains("\"ok\":false", json);
        Assert.Contains("El pedido no se encuentra en camino.", json);
    }
}ParseOptions.0.json¡.
bC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\RepartidorServiceTests.cs≈-using Microsoft.Extensions.Logging.Abstractions;
using NSubstitute;

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

        // Simula que el correo de activaci√≥n sale (true) o falla (false)
        public void ActivacionEnvia(bool resultado) =>
            Activacion.EnviarEnlaceAsync(
                    Arg.Any<Usuario>(), Arg.Any<string>(), Arg.Any<string?>(), Arg.Any<Func<string, string>>())
                .Returns(resultado);
    }

    private static RegistroRepartidorDto DtoValido() => new()
    {
        NombreCompleto = "Juan P√©rez",
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
        Assert.Equal("Este n√∫mero de documento ya se encuentra registrado.", r.Error);
    }

    [Fact]
    public async Task Registrar_CorreoYaRegistrado_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Usuarios.Usuarios.Add(new Usuario { Correo = "juan@gtrack.local" });

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este correo electr√≥nico ya se encuentra registrado.", r.Error);
    }

    [Fact]
    public async Task Registrar_TelefonoEnUso_RetornaError()
    {
        var e = new Escenario().ConNegocio();
        e.Repartidores.TelefonosEnUso.Add("3101234567");

        var r = await e.Servicio.RegistrarAsync(1, DtoValido(), Enlace);

        Assert.False(r.Ok);
        Assert.Equal("Este tel√©fono ya se encuentra registrado.", r.Error);
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
            usuario, "Juan P√©rez", "Mi Negocio", Arg.Any<Func<string, string>>());
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
}ParseOptions.0.jsonª
lC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\UbicacionServiceConContextoTests.csµusing Microsoft.Extensions.Logging.Abstractions;

public class UbicacionServiceConContextoTests
{
    private sealed class Escenario
    {
        public PedidoRepositoryFalso Pedidos { get; } = new();
        public UbicacionRepositoryFalso Ubicaciones { get; } = new();
        public AppDbContext Contexto { get; } = ContextoFactory.Crear();

        public UbicacionService Servicio => new(
            Ubicaciones, Pedidos, Contexto, NullLogger<UbicacionService>.Instance);

        public async Task PrepararAsync(bool conRepartidor = true, int repartidorDelPedido = 5)
        {
            if (conRepartidor)
            {
                Contexto.Repartidores.Add(new Repartidor { Id = 5, UsuarioId = 2, NegocioId = 10 });
                await Contexto.SaveChangesAsync();
            }

            Pedidos.Pedidos.Add(new Pedido
            {
                Id = 1,
                Codigo = "ABC12345",
                EstadoPedidoId = (int)EstadoPedido.EnCamino,
                RepartidorId = repartidorDelPedido
            });
        }
    }

    [Fact]
    public async Task Actualizar_RepartidorNoExiste_RetornaError()
    {
        var e = new Escenario();
        await e.PrepararAsync(conRepartidor: false);

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no pertenece al repartidor.", error);
    }

    [Fact]
    public async Task Actualizar_PedidoDeOtroRepartidor_RetornaError()
    {
        var e = new Escenario();
        await e.PrepararAsync(repartidorDelPedido: 99);

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no pertenece al repartidor.", error);
    }

    [Fact]
    public async Task Actualizar_DatosValidos_GuardaLaUbicacion()
    {
        var e = new Escenario();
        await e.PrepararAsync();

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(4.7m, e.Ubicaciones.Ubicaciones[1].Latitud);
        Assert.Equal(-74.1m, e.Ubicaciones.Ubicaciones[1].Longitud);
    }

    [Fact]
    public async Task Actualizar_UltimoGuardadoHaceMenosDeTresSegundos_IgnoraSinError()
    {
        var e = new Escenario();
        await e.PrepararAsync();
        e.Ubicaciones.Ubicaciones[1] = new UbicacionPedido
        {
            PedidoId = 1,
            Latitud = 1m,
            Longitud = 1m,
            FechaActualizacion = DateTime.UtcNow
        };

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(1m, e.Ubicaciones.Ubicaciones[1].Latitud);   // no se sobrescribi√≥
    }

    [Fact]
    public async Task Actualizar_UltimoGuardadoHaceMasDeTresSegundos_ActualizaLaUbicacion()
    {
        var e = new Escenario();
        await e.PrepararAsync();
        e.Ubicaciones.Ubicaciones[1] = new UbicacionPedido
        {
            PedidoId = 1,
            Latitud = 1m,
            Longitud = 1m,
            FechaActualizacion = DateTime.UtcNow.AddSeconds(-10)
        };

        var (ok, _) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.True(ok);
        Assert.Equal(4.7m, e.Ubicaciones.Ubicaciones[1].Latitud);
    }

    [Fact]
    public async Task Actualizar_FallaAlGuardar_RetornaError()
    {
        var e = new Escenario();
        await e.PrepararAsync();
        e.Ubicaciones.DebeFallarAlGuardar = true;

        var (ok, error) = await e.Servicio.ActualizarAsync(2, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("No fue posible actualizar la ubicaci√≥n.", error);
    }
}ParseOptions.0.jsonÏ&
aC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\UbicacionServiceTests.csÒ%using Microsoft.Extensions.Logging.Abstractions;

public class UbicacionServiceTests
{
    // Se pasa null en AppDbContext porque estas pruebas no llegan al paso que consulta
    // la tabla de repartidores (eso se prueba despu√©s con EF Core InMemory).
    private static UbicacionService Crear(PedidoRepositoryFalso pedidos, UbicacionRepositoryFalso ubicaciones) =>
        new(ubicaciones, pedidos, null!, NullLogger<UbicacionService>.Instance);

    private static Pedido PedidoEnEstado(EstadoPedido estado) => new()
    {
        Id = 1,
        Codigo = "ABC12345",
        EstadoPedidoId = (int)estado
    };

    // ===== ActualizarAsync =====

    [Theory]
    [InlineData(91, 0)]
    [InlineData(-91, 0)]
    [InlineData(0, 181)]
    [InlineData(0, -181)]
    public async Task Actualizar_CoordenadasFueraDeRango_RetornaError(int lat, int lng)
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error) = await servicio.ActualizarAsync(1, 1, lat, lng);

        Assert.False(ok);
        Assert.Contains("Coordenadas inv√°lidas", error);
    }

    [Fact]
    public async Task Actualizar_PedidoNoExiste_RetornaError()
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error) = await servicio.ActualizarAsync(1, 99, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado.", error);
    }

    [Fact]
    public async Task Actualizar_PedidoNoEstaEnCamino_RetornaError()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.Asignado));
        var servicio = Crear(pedidos, new UbicacionRepositoryFalso());

        var (ok, error) = await servicio.ActualizarAsync(1, 1, 4.7m, -74.1m);

        Assert.False(ok);
        Assert.Equal("El pedido no se encuentra en camino.", error);
    }

    // ===== ObtenerPorCodigoAsync =====

    [Theory]
    [InlineData("")]
    [InlineData("   ")]
    public async Task ObtenerPorCodigo_CodigoVacio_RetornaError(string codigo)
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error, _, _, _, _) = await servicio.ObtenerPorCodigoAsync(codigo);

        Assert.False(ok);
        Assert.Equal("El c√≥digo del pedido es requerido.", error);
    }

    [Fact]
    public async Task ObtenerPorCodigo_PedidoNoExiste_RetornaError()
    {
        var servicio = Crear(new PedidoRepositoryFalso(), new UbicacionRepositoryFalso());

        var (ok, error, _, _, _, _) = await servicio.ObtenerPorCodigoAsync("NOEXISTE");

        Assert.False(ok);
        Assert.Equal("El pedido no fue encontrado.", error);
    }

    [Fact]
    public async Task ObtenerPorCodigo_PedidoNoEstaEnCamino_NoHayUbicacion()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.Entregado));
        var servicio = Crear(pedidos, new UbicacionRepositoryFalso());

        var (ok, error, lat, _, _, estado) = await servicio.ObtenerPorCodigoAsync("ABC12345");

        Assert.False(ok);
        Assert.Equal("No hay ubicaci√≥n disponible para este pedido.", error);
        Assert.Null(lat);
        Assert.Equal("Entregado", estado);
    }

    [Fact]
    public async Task ObtenerPorCodigo_EnCaminoSinUbicacion_RetornaError()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.EnCamino));
        var servicio = Crear(pedidos, new UbicacionRepositoryFalso());

        var (ok, error, _, _, _, estado) = await servicio.ObtenerPorCodigoAsync("ABC12345");

        Assert.False(ok);
        Assert.Equal("No hay ubicaci√≥n registrada para este pedido.", error);
        Assert.Equal("EnCamino", estado);
    }

    [Fact]
    public async Task ObtenerPorCodigo_EnCaminoConUbicacion_RetornaCoordenadas()
    {
        var pedidos = new PedidoRepositoryFalso();
        pedidos.Pedidos.Add(PedidoEnEstado(EstadoPedido.EnCamino));
        var ubicaciones = new UbicacionRepositoryFalso();
        ubicaciones.Ubicaciones[1] = new UbicacionPedido
        {
            PedidoId = 1,
            Latitud = 4.7m,
            Longitud = -74.1m,
            FechaActualizacion = DateTime.UtcNow
        };
        var servicio = Crear(pedidos, ubicaciones);

        var (ok, error, lat, lng, fecha, estado) = await servicio.ObtenerPorCodigoAsync(" ABC12345 ");

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(4.7m, lat);
        Assert.Equal(-74.1m, lng);
        Assert.Equal(DateTimeKind.Utc, fecha!.Value.Kind);
        Assert.Equal("EnCamino", estado);
    }
}ParseOptions.0.jsonÂN
bC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\UsuarioControllerTests.csÈMusing System.Security.Claims;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using NSubstitute;

public class UsuarioControllerTests
{
    private sealed class Escenario
    {
        public IAuthService Auth { get; } = Substitute.For<IAuthService>();
        public IRecuperacionService Recuperacion { get; } = Substitute.For<IRecuperacionService>();
        public IActivacionCuentaService Activacion { get; } = Substitute.For<IActivacionCuentaService>();
        public IAuthenticationService Autenticacion { get; } = Substitute.For<IAuthenticationService>();
        public UsuarioController Controlador { get; }

        public Escenario(bool autenticado = false)
        {
            Controlador = new UsuarioController(Auth, Recuperacion, Activacion).Preparar(
                usuarioId: autenticado ? 1 : null,
                rol: autenticado ? "Negocio" : null,
                autenticacion: Autenticacion);
        }
    }
    private static Task<(Usuario? Usuario, string? Error)> Login(Usuario? u, string? error) => Task.FromResult((u, error));
    private static Task<(bool Ok, string? Error)> Resultado(bool ok, string? error = null) => Task.FromResult((ok, error));

    private static LoginDto LoginDto() => new() { Identificador = "negocio@gtrack.local", Password = "Clave123" };

    private static void AssertRedirigeAlHome(IActionResult r)
    {
        var redir = Assert.IsType<RedirectToActionResult>(r);
        Assert.Equal("Index", redir.ActionName);
        Assert.Equal("Home", redir.ControllerName);
    }

    // ===== Login =====

    [Fact]
    public void Login_Get_SinSesion_RetornaVista()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(e.Controlador.Login());

        Assert.IsType<LoginDto>(vista.Model);
    }

    [Fact]
    public void Login_Get_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(e.Controlador.Login());
    }

    [Fact]
    public async Task Login_Post_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(await e.Controlador.Login(LoginDto()));
    }

    [Fact]
    public async Task Login_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Password", "Todos los campos son obligatorios");

        Assert.IsType<ViewResult>(await e.Controlador.Login(LoginDto()));
        await e.Auth.DidNotReceive().IniciarSesionAsync(Arg.Any<LoginDto>());
    }

    [Fact]
    public async Task Login_Post_CredencialesIncorrectas_MuestraError()
    {
        var e = new Escenario();
        e.Auth.IniciarSesionAsync(Arg.Any<LoginDto>()).Returns(Login(null, "Usuario o contrase√±a incorrectos"));

        var r = await e.Controlador.Login(LoginDto());

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage == "Usuario o contrase√±a incorrectos");
    }

    [Fact]
    public async Task Login_Post_Exitoso_InicaSesionConLosClaimsDelUsuario()
    {
        var e = new Escenario();
        var usuario = new Usuario { Id = 7, Correo = "negocio@gtrack.local", Rol = RolUsuario.Negocio };
        e.Auth.IniciarSesionAsync(Arg.Any<LoginDto>()).Returns(Login(usuario, null));

        var r = await e.Controlador.Login(LoginDto());

        AssertRedirigeAlHome(r);
        await e.Autenticacion.Received(1).SignInAsync(
            Arg.Any<HttpContext>(),
            CookieAuthenticationDefaults.AuthenticationScheme,
            Arg.Is<ClaimsPrincipal>(p =>
                p.FindFirst(ClaimTypes.NameIdentifier)!.Value == "7" &&
                p.FindFirst(ClaimTypes.Role)!.Value == "Negocio"),
            Arg.Any<AuthenticationProperties>());
    }

    // ===== Logout =====

    [Fact]
    public async Task Logout_Exitoso_GuardaMensajeYRedirige()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(await e.Controlador.Logout());

        Assert.Equal("Tu sesi√≥n ha sido cerrada exitosamente", e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task Logout_Falla_GuardaMensajeDeError()
    {
        var e = new Escenario(autenticado: true);
        e.Autenticacion.SignOutAsync(Arg.Any<HttpContext>(), Arg.Any<string>(), Arg.Any<AuthenticationProperties>())
            .Returns(Task.FromException(new InvalidOperationException("fallo")));

        AssertRedirigeAlHome(await e.Controlador.Logout());

        Assert.Equal("No fue posible cerrar la sesi√≥n. Intenta nuevamente", e.Controlador.TempData["Error"]);
    }

    // ===== Recuperar contrase√±a =====

    [Fact]
    public void RecuperarContrasena_Get_SinSesion_RetornaVista()
    {
        var e = new Escenario();

        var vista = Assert.IsType<ViewResult>(e.Controlador.RecuperarContrasena());

        Assert.IsType<RecuperarDto>(vista.Model);
    }

    [Fact]
    public void RecuperarContrasena_Get_ConSesion_RedirigeAlHome()
    {
        var e = new Escenario(autenticado: true);

        AssertRedirigeAlHome(e.Controlador.RecuperarContrasena());
    }

    [Fact]
    public async Task RecuperarContrasena_Post_ModeloInvalido_RetornaVista()
    {
        var e = new Escenario();
        e.Controlador.ModelState.AddModelError("Correo", "Correo no v√°lido");

        Assert.IsType<ViewResult>(await e.Controlador.RecuperarContrasena(new RecuperarDto { Correo = "x" }));
    }

    [Fact]
    public async Task RecuperarContrasena_Post_LimiteSuperado_MuestraError()
    {
        var e = new Escenario();
        e.Recuperacion.SolicitarAsync(Arg.Any<string>(), Arg.Any<Func<string, string>>())
            .Returns(ResultadoSolicitud.LimiteSuperado);

        var r = await e.Controlador.RecuperarContrasena(new RecuperarDto { Correo = "a@gtrack.local" });

        Assert.IsType<ViewResult>(r);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors, err => err.ErrorMessage.Contains("superado"));
    }

    [Fact]
    public async Task RecuperarContrasena_Post_Procesada_RedirigeAlLoginYConstruyeElEnlace()
    {
        var e = new Escenario();
        var url = Substitute.For<IUrlHelper>();
        url.Action(Arg.Any<UrlActionContext>()).Returns("https://gtrack.local/Usuario/RestablecerContrasena?token=tok");
        e.Controlador.Url = url;

        string? enlace = null;
        e.Recuperacion.SolicitarAsync(Arg.Any<string>(), Arg.Any<Func<string, string>>())
            .Returns(ci =>
            {
                enlace = ci.ArgAt<Func<string, string>>(1)("tok");
                return ResultadoSolicitud.Procesada;
            });

        var r = Assert.IsType<RedirectToActionResult>(
            await e.Controlador.RecuperarContrasena(new RecuperarDto { Correo = "a@gtrack.local" }));

        Assert.Equal("Login", r.ActionName);
        Assert.Contains("token=tok", enlace);
        Assert.NotNull(e.Controlador.TempData["Mensaje"]);
    }

    // ===== Restablecer contrase√±a =====

    [Fact]
    public async Task RestablecerContrasena_Get_TokenVigente_RetornaVistaConToken()
    {
        var e = new Escenario();
        e.Recuperacion.TokenVigenteAsync("tok").Returns(true);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena("tok"));

        Assert.Equal("tok", Assert.IsType<RestablecerDto>(vista.Model).Token);
    }

    [Fact]
    public async Task RestablecerContrasena_Get_TokenNoVigente_MuestraTokenInvalido()
    {
        var e = new Escenario();
        e.Recuperacion.TokenVigenteAsync("tok").Returns(false);

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena("tok"));

        Assert.Equal("TokenInvalido", vista.ViewName);
    }

    [Fact]
    public async Task RestablecerContrasena_Post_Exitoso_RedirigeAlLogin()
    {
        var e = new Escenario();
        e.Recuperacion.RestablecerAsync("tok", "NuevaClave1", "NuevaClave1").Returns(Resultado(true));

        var r = Assert.IsType<RedirectToActionResult>(await e.Controlador.RestablecerContrasena(
            new RestablecerDto { Token = "tok", NuevaPassword = "NuevaClave1", ConfirmarPassword = "NuevaClave1" }));

        Assert.Equal("Login", r.ActionName);
        Assert.Equal("Tu contrase√±a ha sido restablecida exitosamente", e.Controlador.TempData["Mensaje"]);
    }

    [Fact]
    public async Task RestablecerContrasena_Post_TokenInvalido_MuestraVistaTokenInvalido()
    {
        var e = new Escenario();
        e.Recuperacion.RestablecerAsync(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>())
            .Returns(Resultado(false, RecuperacionService.MensajeTokenInvalido));

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena(new RestablecerDto { Token = "tok" }));

        Assert.Equal("TokenInvalido", vista.ViewName);
    }

    [Fact]
    public async Task RestablecerContrasena_Post_OtroError_MuestraElErrorEnLaVista()
    {
        var e = new Escenario();
        e.Recuperacion.RestablecerAsync(Arg.Any<string>(), Arg.Any<string>(), Arg.Any<string>())
            .Returns(Resultado(false, "La nueva contrase√±a no puede ser igual a la anterior"));

        var vista = Assert.IsType<ViewResult>(await e.Controlador.RestablecerContrasena(new RestablecerDto { Token = "tok" }));

        Assert.IsType<RestablecerDto>(vista.Model);
        Assert.Contains(e.Controlador.ModelState[""]!.Errors,
            err => err.ErrorMessage == "La nueva contrase√±a no puede ser igual a la anterior");
    }
}ParseOptions.0.json‘
[C:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\UtilidadesTests.csﬂusing Microsoft.Extensions.Logging.Abstractions;

public class UtilidadesTests
{
    // ===== ValidadorPassword =====

    [Theory]
    [InlineData("Clave123", true)]
    [InlineData("abc12d", true)]
    [InlineData("abc1", false)]     // muy corta
    [InlineData("abcdef", false)]   // sin n√∫mero
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
}ParseOptions.0.json›
lC:\Users\camil\.nuget\packages\microsoft.net.test.sdk\17.14.1\build\net8.0\Microsoft.NET.Test.Sdk.Program.cs◊// <auto-generated> This file has been auto generated. </auto-generated>
using System;
[Microsoft.VisualStudio.TestPlatform.TestSDKAutoGeneratedCode]
class AutoGeneratedProgram {static void Main(string[] args){}}ParseOptions.0.jsonó
yC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\obj\Debug\net10.0\Gtrack.Tests.GlobalUsings.g.csÑ// <auto-generated/>
global using System;
global using System.Collections.Generic;
global using System.IO;
global using System.Linq;
global using System.Net.Http;
global using System.Threading;
global using System.Threading.Tasks;
global using Xunit;
ParseOptions.0.jsonÌ
äC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\obj\Debug\net10.0\.NETCoreApp,Version=v10.0.AssemblyAttributes.cs»// <autogenerated />
using System;
using System.Reflection;
[assembly: global::System.Runtime.Versioning.TargetFrameworkAttribute(".NETCoreApp,Version=v10.0", FrameworkDisplayName = ".NET 10.0")]
ParseOptions.0.jsonÉ	
wC:\Users\camil\Documentos\5TO SEMESTRE\ING. SOFTWARE\GTrack\Gtrack.Tests\obj\Debug\net10.0\Gtrack.Tests.AssemblyInfo.csÚ//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Reflection;

[assembly: System.Reflection.AssemblyCompanyAttribute("Gtrack.Tests")]
[assembly: System.Reflection.AssemblyConfigurationAttribute("Debug")]
[assembly: System.Reflection.AssemblyFileVersionAttribute("1.0.0.0")]
[assembly: System.Reflection.AssemblyInformationalVersionAttribute("1.0.0+2cb2f3c71f2a69ced5e43371923158cd78ca5ce9")]
[assembly: System.Reflection.AssemblyProductAttribute("Gtrack.Tests")]
[assembly: System.Reflection.AssemblyTitleAttribute("Gtrack.Tests")]
[assembly: System.Reflection.AssemblyVersionAttribute("1.0.0.0")]

// Generated by the MSBuild WriteCodeFragment class.

ParseOptions.0.json