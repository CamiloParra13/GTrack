using Microsoft.Extensions.Options;

public class NotificacionService(
    INotificacionRepository notificaciones,
    IEmailService email,
    IOptions<EmailOptions> opciones,
    ILogger<NotificacionService> logger) : INotificacionService
{
    private const int MaxTitulo = 100;
    private const int MaxMensaje = 300;

    public async Task NegocioPendienteAsync(string nombreNegocio, string documento, string correoNegocio)
    {
        try
        {
            var admins = await notificaciones.ListarAdministradoresActivosAsync();
            if (admins.Count == 0) return;

            var avisos = admins.Select(a => new Notificacion
            {
                UsuarioId = a.Id,
                Titulo = Recortar("Nuevo negocio pendiente de validación", MaxTitulo),
                Mensaje = Recortar($"{nombreNegocio} (documento {documento}) completó su registro y espera tu aprobación.", MaxMensaje),
                Enlace = "/Admin/Negocios"
            }).ToList();
            await notificaciones.AgregarAsync(avisos);

            var enlace = UrlAbsoluta("/Admin/Negocios");
            var envios = admins.Select(admin => EnviarSeguroAsync(
                admin.Correo,
                "Nuevo negocio pendiente de validación en GTrack",
                PlantillaCorreo.Crear(
                    titulo: "Hay un negocio esperando tu aprobación",
                    saludo: "Hola, administrador",
                    parrafos: ["Un negocio acaba de completar el formulario de registro y está pendiente de validación."],
                    datos: [("Negocio", nombreNegocio), ("Documento", documento), ("Correo", correoNegocio)],
                    textoBoton: "Revisar solicitud",
                    urlBoton: enlace,
                    nota: "Mientras no apruebes la cuenta, el negocio no podrá iniciar sesión.")));
            await Task.WhenAll(envios);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo avisar a los administradores del negocio pendiente {Negocio}", nombreNegocio);
        }
    }

    public async Task NegocioAprobadoAsync(int usuarioNegocioId, string nombreNegocio, string correoNegocio)
    {
        try
        {
            await notificaciones.AgregarAsync(new[]
            {
                new Notificacion
                {
                    UsuarioId = usuarioNegocioId,
                    Titulo = Recortar("Tu cuenta fue validada", MaxTitulo),
                    Mensaje = Recortar($"¡Bienvenido, {nombreNegocio}! Ya puedes registrar pedidos y repartidores.", MaxMensaje),
                    Enlace = "/Pedido/Registrar"
                }
            });
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo guardar la notificación de aprobación del negocio {Negocio}", nombreNegocio);
        }

        await EnviarSeguroAsync(
            correoNegocio,
            "Tu negocio fue validado en GTrack",
            PlantillaCorreo.Crear(
                titulo: "¡Tu cuenta fue validada!",
                saludo: $"Hola, {nombreNegocio}",
                parrafos:
                [
                    "Buenas noticias: un administrador revisó y aprobó la información de tu negocio.",
                    "Ya puedes iniciar sesión para registrar pedidos y gestionar a tus repartidores."
                ],
                textoBoton: "Iniciar sesión",
                urlBoton: UrlAbsoluta("/Usuario/Login")));
    }

    public async Task RepartidorRegistradoAsync(int usuarioNegocioId, string nombreRepartidor)
    {
        try
        {
            await notificaciones.AgregarAsync(new[]
            {
                new Notificacion
                {
                    UsuarioId = usuarioNegocioId,
                    Titulo = Recortar("Repartidor registrado", MaxTitulo),
                    Mensaje = Recortar($"{nombreRepartidor} fue registrado como repartidor de tu negocio.", MaxMensaje),
                    Enlace = "/Repartidor"
                }
            });
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo guardar la notificación del repartidor {Repartidor}", nombreRepartidor);
        }
    }

    public Task<List<Notificacion>> ListarAsync(int usuarioId, int maximo = 50) =>
        notificaciones.ListarAsync(usuarioId, maximo);

    public Task<int> ContarNoLeidasAsync(int usuarioId) =>
        notificaciones.ContarNoLeidasAsync(usuarioId);

    public async Task<string?> AbrirAsync(int usuarioId, int id)
    {
        var notificacion = await notificaciones.ObtenerAsync(usuarioId, id);
        if (notificacion is null) return null;

        await notificaciones.MarcarLeidaAsync(usuarioId, id);
        return notificacion.Enlace;
    }

    public Task MarcarTodasLeidasAsync(int usuarioId) =>
        notificaciones.MarcarTodasLeidasAsync(usuarioId);

    private async Task EnviarSeguroAsync(string para, string asunto, CorreoHtml correo)
    {
        try
        {
            await email.EnviarAsync(para, asunto, correo);
        }
        catch (Exception ex)
        {
            logger.LogWarning(ex, "No se pudo enviar el correo '{Asunto}' a {Para}", asunto, para);
        }
    }

    private string? UrlAbsoluta(string ruta)
    {
        var baseUrl = opciones.Value.UrlBase?.Trim().TrimEnd('/');
        return string.IsNullOrEmpty(baseUrl) ? null : baseUrl + ruta;
    }

    private static string Recortar(string texto, int max) =>
        texto.Length <= max ? texto : texto[..(max - 1)] + "…";
}
