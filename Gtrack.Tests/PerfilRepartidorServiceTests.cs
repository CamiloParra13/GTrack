using Microsoft.Extensions.Logging.Abstractions;

namespace Gtrack.Tests;

// CU-12 Eliminar repartidor y CU-14 Editar repartidor
public class PerfilRepartidorServiceTests
{
    private const string MensajeCodigoExpirado = "El código expiró o ya no es válido. Solicita uno nuevo";
    private const string MensajeContrasenaIncorrecta = "Contraseña incorrecta";

    private sealed class Escenario
    {
        public AppDbContext Contexto { get; }
        public RepartidorRepositoryFalso Repartidores { get; } = new();
        public NegocioRepositoryFalso Negocios { get; } = new();
        public UsuarioRepositoryFalso Usuarios { get; } = new();
        public CodigoVerificacionRepositoryFalso Codigos { get; } = new();
        public EmailServiceFalso Email { get; } = new();

        public Usuario UsuarioNegocio { get; } = new()
        {
            Id = 1, Correo = "negocio@gtrack.local", Documento = "900123", Rol = RolUsuario.Negocio,
            Estado = EstadoCuenta.Activo, PasswordHash = "HASH:Negocio123"
        };

        public Usuario UsuarioRepartidor { get; } = new()
        {
            Id = 2, Correo = "rep@gtrack.local", Documento = "1010", Rol = RolUsuario.Repartidor,
            Estado = EstadoCuenta.Activo, PasswordHash = "HASH:Clave123"
        };

        public Repartidor Repartidor { get; }

        public PerfilRepartidorService Servicio => new(
            Contexto, Repartidores, Negocios, Usuarios, Codigos,
            new PasswordHasherFalso(), Email, NullLogger<PerfilRepartidorService>.Instance);

        public Escenario(bool conRepartidor = true, bool fallaAlGuardar = false)
        {
            Contexto = fallaAlGuardar ? ContextoFactory.CrearQueFallaAlGuardar() : ContextoFactory.Crear();
            Negocios.Negocios.Add(new Negocio { Id = 10, UsuarioId = 1, Nombre = "Comidas Rápidas" });
            Usuarios.Usuarios.Add(UsuarioNegocio);

            Repartidor = new Repartidor
            {
                Id = 5, UsuarioId = 2, NegocioId = 10, NombreCompleto = "Juan Gómez", Telefono = "3001234567",
                Vehiculo = TipoVehiculo.Moto, Placa = "ABC12D", Usuario = UsuarioRepartidor
            };

            if (!conRepartidor) return;
            Usuarios.Usuarios.Add(UsuarioRepartidor);
            Repartidores.Repartidores.Add(Repartidor);
            Contexto.Repartidores.Add(Repartidor);
            Contexto.SaveChanges();   // síncrono: el contexto que falla solo falla en SaveChangesAsync
        }

        public void AgregarPedido(EstadoPedido estado)
        {
            Contexto.Pedidos.Add(new Pedido { Codigo = "PED" + Guid.NewGuid().ToString("N")[..5], RepartidorId = 5, EstadoPedidoId = (int)estado });
            Contexto.SaveChanges();
        }

        public CodigoVerificacion AgregarCodigo(string codigo = "123456", bool verificado = false, bool usado = false,
            int minutosVigencia = 10, DateTime? bloqueadoHasta = null, int intentos = 0)
        {
            var c = new CodigoVerificacion
            {
                Id = Codigos.Codigos.Count + 1,
                UsuarioId = 2,
                CodigoHash = TokenUtil.Hash(codigo),
                Expira = DateTime.UtcNow.AddMinutes(minutosVigencia),
                Verificado = verificado,
                Usado = usado,
                BloqueadoHasta = bloqueadoHasta,
                Intentos = intentos
            };
            Codigos.Codigos.Add(c);
            return c;
        }
    }

    private static EditarRepartidorDto DtoEdicion(TipoVehiculo vehiculo = TipoVehiculo.Carro, string? placa = "abc-123") => new()
    {
        NombreCompleto = " Juan Pérez ",
        Telefono = "3001112233",
        Correo = " nuevo@gtrack.local ",
        Vehiculo = vehiculo,
        Placa = placa
    };

    // ===== Perfil =====

    [Fact]
    public async Task ObtenerPerfil_NoExiste_RetornaNull()
    {
        var e = new Escenario(conRepartidor: false);

        Assert.Null(await e.Servicio.ObtenerPerfilAsync(2));
    }

    [Fact]
    public async Task ObtenerPerfil_Existe_RetornaDatosYPedidosPendientes()
    {
        var e = new Escenario();
        e.AgregarPedido(EstadoPedido.Asignado);
        e.AgregarPedido(EstadoPedido.EnCamino);
        e.AgregarPedido(EstadoPedido.Entregado);

        var perfil = await e.Servicio.ObtenerPerfilAsync(2);

        Assert.NotNull(perfil);
        Assert.Equal("Juan Gómez", perfil.NombreCompleto);
        Assert.Equal("rep@gtrack.local", perfil.Correo);
        Assert.Equal("Comidas Rápidas", perfil.Negocio);
        Assert.Equal(2, perfil.PedidosPendientes);
    }

    // ===== CU-14: motivo para no editar =====

    [Fact]
    public async Task MotivoNoEditable_SinRepartidor_SinPermisos()
    {
        var e = new Escenario(conRepartidor: false);

        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, await e.Servicio.MotivoNoEditableAsync(2));
    }

    [Fact]
    public async Task MotivoNoEditable_CuentaSuspendida_NoPuedeEditar()
    {
        var e = new Escenario();
        e.UsuarioRepartidor.Estado = EstadoCuenta.Suspendido;

        Assert.Equal(PerfilRepartidorService.MensajeSuspendido, await e.Servicio.MotivoNoEditableAsync(2));
    }

    [Fact]
    public async Task MotivoNoEditable_ConPedidosAsignados_NoPuedeEditar()
    {
        var e = new Escenario();
        e.AgregarPedido(EstadoPedido.Asignado);

        Assert.Equal(PerfilRepartidorService.MensajeConPedidos, await e.Servicio.MotivoNoEditableAsync(2));
    }

    [Fact]
    public async Task MotivoNoEditable_SinRestricciones_RetornaNull()
    {
        var e = new Escenario();

        Assert.Null(await e.Servicio.MotivoNoEditableAsync(2));
    }

    // ===== CU-14: código de verificación =====

    [Fact]
    public async Task SolicitarCodigo_NoPuedeEditar_RetornaElMotivo()
    {
        var e = new Escenario();
        e.AgregarPedido(EstadoPedido.EnCamino);

        var (ok, error) = await e.Servicio.SolicitarCodigoAsync(2);

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeConPedidos, error);
        Assert.Empty(e.Email.EnviadosHtml);
    }

    [Fact]
    public async Task SolicitarCodigo_Bloqueado_RetornaMensajeDeBloqueo()
    {
        var e = new Escenario();
        e.AgregarCodigo(bloqueadoHasta: DateTime.UtcNow.AddMinutes(10));

        var (ok, error) = await e.Servicio.SolicitarCodigoAsync(2);

        Assert.False(ok);
        Assert.StartsWith("La edición de tu perfil está bloqueada", error);
    }

    [Fact]
    public async Task SolicitarCodigo_Exitoso_GuardaElCodigoYEnviaElCorreo()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.SolicitarCodigoAsync(2);

        Assert.True(ok);
        Assert.Null(error);
        Assert.Single(e.Codigos.Codigos);
        var correo = Assert.Single(e.Email.EnviadosHtml);
        Assert.Equal("rep@gtrack.local", correo.Para);
        Assert.Equal("Tu código de verificación de GTrack", correo.Asunto);
    }

    [Fact]
    public async Task SolicitarCodigo_FallaElCorreo_RetornaError()
    {
        var e = new Escenario();
        e.Email.DebeFallar = true;

        var (ok, error) = await e.Servicio.SolicitarCodigoAsync(2);

        Assert.False(ok);
        Assert.Equal("No fue posible enviar el código. Intenta nuevamente", error);
    }

    [Fact]
    public async Task VerificarCodigo_SinCodigo_RetornaExpirado()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(2, "123456");

        Assert.False(ok);
        Assert.Equal(MensajeCodigoExpirado, error);
    }

    [Fact]
    public async Task VerificarCodigo_Bloqueado_RetornaMensajeDeBloqueo()
    {
        var e = new Escenario();
        e.AgregarCodigo(bloqueadoHasta: DateTime.UtcNow.AddMinutes(5));

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(2, "123456");

        Assert.False(ok);
        Assert.StartsWith("La edición de tu perfil está bloqueada", error);
    }

    [Fact]
    public async Task VerificarCodigo_Vencido_RetornaExpirado()
    {
        var e = new Escenario();
        e.AgregarCodigo(minutosVigencia: -1);

        var (_, error) = await e.Servicio.VerificarCodigoAsync(2, "123456");

        Assert.Equal(MensajeCodigoExpirado, error);
    }

    [Fact]
    public async Task VerificarCodigo_Incorrecto_SumaUnIntento()
    {
        var e = new Escenario();
        var codigo = e.AgregarCodigo();

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(2, "000000");

        Assert.False(ok);
        Assert.Equal("Código incorrecto, intenta nuevamente", error);
        Assert.Equal(1, codigo.Intentos);
        Assert.Null(codigo.BloqueadoHasta);
    }

    [Fact]
    public async Task VerificarCodigo_TercerIntentoFallido_BloqueaLaEdicion()
    {
        var e = new Escenario();
        var codigo = e.AgregarCodigo(intentos: 2);

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(2, "000000");

        Assert.False(ok);
        Assert.StartsWith("Superaste 3 intentos fallidos", error);
        Assert.NotNull(codigo.BloqueadoHasta);
    }

    [Fact]
    public async Task VerificarCodigo_Correcto_AutorizaLaEdicion()
    {
        var e = new Escenario();
        var codigo = e.AgregarCodigo();

        var (ok, error) = await e.Servicio.VerificarCodigoAsync(2, " 123456 ");

        Assert.True(ok);
        Assert.Null(error);
        Assert.True(codigo.Verificado);
        Assert.True(await e.Servicio.EdicionAutorizadaAsync(2));
    }

    [Fact]
    public async Task EdicionAutorizada_CodigoYaUsado_RetornaFalse()
    {
        var e = new Escenario();
        e.AgregarCodigo(verificado: true, usado: true);

        Assert.False(await e.Servicio.EdicionAutorizadaAsync(2));
    }

    // ===== CU-14: edición =====

    [Fact]
    public async Task ObtenerParaEditar_NoExiste_RetornaNull()
    {
        var e = new Escenario(conRepartidor: false);

        Assert.Null(await e.Servicio.ObtenerParaEditarAsync(2));
    }

    [Fact]
    public async Task ObtenerParaEditar_Existe_RetornaLosDatosActuales()
    {
        var e = new Escenario();

        var dto = await e.Servicio.ObtenerParaEditarAsync(2);

        Assert.NotNull(dto);
        Assert.Equal("Juan Gómez", dto.NombreCompleto);
        Assert.Equal("rep@gtrack.local", dto.Correo);
        Assert.Equal(TipoVehiculo.Moto, dto.Vehiculo);
        Assert.Equal("ABC12D", dto.Placa);
    }

    [Fact]
    public async Task Editar_SinVerificacion_NoPermiteEditar()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.EditarAsync(2, DtoEdicion());

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinVerificacion, error);
    }

    [Fact]
    public async Task Editar_LeAsignaronUnPedido_NoPermiteEditar()
    {
        var e = new Escenario();
        e.AgregarCodigo(verificado: true);
        e.AgregarPedido(EstadoPedido.Asignado);

        var (ok, error) = await e.Servicio.EditarAsync(2, DtoEdicion());

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeConPedidos, error);
    }

    [Fact]
    public async Task Editar_CorreoDeOtraCuenta_RetornaError()
    {
        var e = new Escenario();
        e.AgregarCodigo(verificado: true);
        e.Contexto.Usuarios.Add(new Usuario { Id = 8, Correo = "nuevo@gtrack.local", Documento = "8080" });
        e.Contexto.SaveChanges();

        var (ok, error) = await e.Servicio.EditarAsync(2, DtoEdicion());

        Assert.False(ok);
        Assert.Equal("El correo ya está registrado en otra cuenta", error);
    }

    [Fact]
    public async Task Editar_TelefonoDeUnNegocio_RetornaError()
    {
        var e = new Escenario();
        e.AgregarCodigo(verificado: true);
        e.Contexto.Negocios.Add(new Negocio { Id = 20, UsuarioId = 1, Nombre = "Otro", Telefono = "3001112233" });
        e.Contexto.SaveChanges();

        var (ok, error) = await e.Servicio.EditarAsync(2, DtoEdicion());

        Assert.False(ok);
        Assert.Equal("El teléfono ya está registrado en otra cuenta", error);
    }

    [Fact]
    public async Task Editar_DatosValidos_GuardaLosCambiosYUsaElCodigo()
    {
        var e = new Escenario();
        var codigo = e.AgregarCodigo(verificado: true);

        var (ok, error) = await e.Servicio.EditarAsync(2, DtoEdicion());

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal("Juan Pérez", e.Repartidor.NombreCompleto);
        Assert.Equal("3001112233", e.Repartidor.Telefono);
        Assert.Equal(TipoVehiculo.Carro, e.Repartidor.Vehiculo);
        Assert.Equal("ABC123", e.Repartidor.Placa);
        Assert.Equal("nuevo@gtrack.local", e.UsuarioRepartidor.Correo);
        Assert.True(codigo.Usado);
    }

    [Fact]
    public async Task Editar_Bicicleta_QuitaLaPlaca()
    {
        var e = new Escenario();
        e.AgregarCodigo(verificado: true);

        var (ok, _) = await e.Servicio.EditarAsync(2, DtoEdicion(TipoVehiculo.Bicicleta, "ABC12D"));

        Assert.True(ok);
        Assert.Null(e.Repartidor.Placa);
    }

    [Fact]
    public async Task Editar_FallaAlGuardar_RetornaError()
    {
        var e = new Escenario(fallaAlGuardar: true);
        e.AgregarCodigo(verificado: true);

        var (ok, error) = await e.Servicio.EditarAsync(2, DtoEdicion());

        Assert.False(ok);
        Assert.Equal("No fue posible actualizar la información. Intenta Nuevamente", error);
    }

    // ===== CU-12: el repartidor elimina su cuenta =====

    [Fact]
    public async Task ValidarEliminacionPropia_SinRepartidor_SinPermisos()
    {
        var e = new Escenario(conRepartidor: false);

        var (ok, error) = await e.Servicio.ValidarEliminacionPropiaAsync(2);

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, error);
    }

    [Fact]
    public async Task ValidarEliminacionPropia_ConEntregasPendientes_NoPermite()
    {
        var e = new Escenario();
        e.AgregarPedido(EstadoPedido.EnCamino);

        var (ok, error) = await e.Servicio.ValidarEliminacionPropiaAsync(2);

        Assert.False(ok);
        Assert.Equal("No es posible eliminar la cuenta mientras tengas entregas pendientes", error);
    }

    [Fact]
    public async Task EliminarCuentaPropia_ConEntregasPendientes_NoElimina()
    {
        var e = new Escenario();
        e.AgregarPedido(EstadoPedido.Asignado);

        var (ok, _) = await e.Servicio.EliminarCuentaPropiaAsync(2, "Clave123");

        Assert.False(ok);
        Assert.Equal(EstadoCuenta.Activo, e.UsuarioRepartidor.Estado);
    }

    [Fact]
    public async Task EliminarCuentaPropia_UsuarioNoExiste_SinPermisos()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Remove(e.UsuarioRepartidor);

        var (ok, error) = await e.Servicio.EliminarCuentaPropiaAsync(2, "Clave123");

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, error);
    }

    [Theory]
    [InlineData("OtraClave1")]
    [InlineData("")]
    public async Task EliminarCuentaPropia_ContrasenaIncorrecta_NoElimina(string password)
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.EliminarCuentaPropiaAsync(2, password);

        Assert.False(ok);
        Assert.Equal(MensajeContrasenaIncorrecta, error);
        Assert.Equal(EstadoCuenta.Activo, e.UsuarioRepartidor.Estado);
    }

    [Fact]
    public async Task EliminarCuentaPropia_SinContrasenaGuardada_NoElimina()
    {
        var e = new Escenario();
        e.UsuarioRepartidor.PasswordHash = "";

        var (ok, error) = await e.Servicio.EliminarCuentaPropiaAsync(2, "Clave123");

        Assert.False(ok);
        Assert.Equal(MensajeContrasenaIncorrecta, error);
    }

    [Fact]
    public async Task EliminarCuentaPropia_DatosValidos_DaDeBajaYLiberaElCorreo()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.EliminarCuentaPropiaAsync(2, "Clave123");

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal(EstadoCuenta.Eliminado, e.UsuarioRepartidor.Estado);
        Assert.Equal("eliminado.2.rep@gtrack.local", e.UsuarioRepartidor.Correo);
        Assert.Equal("X2-1010", e.UsuarioRepartidor.Documento);
        Assert.True(e.Usuarios.SeLlamoActualizar);
    }

    // ===== FA-13-CU12: el negocio elimina a su repartidor =====

    [Fact]
    public async Task ValidarEliminacionPorNegocio_NegocioNoExiste_SinPermisos()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.ValidarEliminacionPorNegocioAsync(99, 5);

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, error);
    }

    [Fact]
    public async Task ValidarEliminacionPorNegocio_RepartidorYaEliminado_SinPermisos()
    {
        var e = new Escenario();
        e.UsuarioRepartidor.Estado = EstadoCuenta.Eliminado;

        var (ok, error) = await e.Servicio.ValidarEliminacionPorNegocioAsync(1, 5);

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, error);
    }

    [Fact]
    public async Task ValidarEliminacionPorNegocio_ConEntregasPendientes_NoPermite()
    {
        var e = new Escenario();
        e.AgregarPedido(EstadoPedido.Asignado);

        var (ok, error) = await e.Servicio.ValidarEliminacionPorNegocioAsync(1, 5);

        Assert.False(ok);
        Assert.Equal("No es posible eliminar a este repartidor mientras tenga entregas pendientes", error);
    }

    [Fact]
    public async Task ValidarEliminacionPorNegocio_SinPendientes_Permite()
    {
        var e = new Escenario();

        var (ok, error) = await e.Servicio.ValidarEliminacionPorNegocioAsync(1, 5);

        Assert.True(ok);
        Assert.Null(error);
    }

    [Fact]
    public async Task EliminarPorNegocio_RepartidorDeOtroNegocio_NoElimina()
    {
        var e = new Escenario();

        var (ok, error, nombre) = await e.Servicio.EliminarPorNegocioAsync(1, 99, "Negocio123");

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, error);
        Assert.Null(nombre);
    }

    [Fact]
    public async Task EliminarPorNegocio_UsuarioDelNegocioNoExiste_SinPermisos()
    {
        var e = new Escenario();
        e.Usuarios.Usuarios.Remove(e.UsuarioNegocio);

        var (ok, error, _) = await e.Servicio.EliminarPorNegocioAsync(1, 5, "Negocio123");

        Assert.False(ok);
        Assert.Equal(PerfilRepartidorService.MensajeSinPermisos, error);
    }

    [Fact]
    public async Task EliminarPorNegocio_ContrasenaIncorrecta_NoElimina()
    {
        var e = new Escenario();

        var (ok, error, _) = await e.Servicio.EliminarPorNegocioAsync(1, 5, "Otra123");

        Assert.False(ok);
        Assert.Equal(MensajeContrasenaIncorrecta, error);
        Assert.Equal(EstadoCuenta.Activo, e.UsuarioRepartidor.Estado);
    }

    [Fact]
    public async Task EliminarPorNegocio_DatosValidos_DaDeBajaAlRepartidor()
    {
        var e = new Escenario();

        var (ok, error, nombre) = await e.Servicio.EliminarPorNegocioAsync(1, 5, "Negocio123");

        Assert.True(ok);
        Assert.Null(error);
        Assert.Equal("Juan Gómez", nombre);
        Assert.Equal(EstadoCuenta.Eliminado, e.UsuarioRepartidor.Estado);
    }
}
