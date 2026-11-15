using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;

namespace Gtrack;

public class EmailSmtpService(
    IConfiguration config,
    IWebHostEnvironment entorno,
    ILogger<EmailSmtpService> logger) : IEmailService
{
    // Los correos que todavía se arman como texto también salen con la plantilla de GTrack
    public Task EnviarAsync(string para, string asunto, string cuerpo) =>
        EnviarAsync(para, asunto, PlantillaCorreo.DesdeTexto(asunto, cuerpo));

    public async Task EnviarAsync(string para, string asunto, CorreoHtml correo)
    {
        var host = config["Email:Host"] ?? "smtp.gmail.com";
        var port = int.TryParse(config["Email:Port"], out var puerto) ? puerto : 587;
        var user = config["Email:User"] ?? config["Email:Usuario"] ?? throw new InvalidOperationException("Falta Email:User");
        var pass = config["Email:Password"] ?? throw new InvalidOperationException("Falta Email:Password");
        var from = config["Email:From"] ?? user;
        var remitente = config["Email:NombreRemitente"] ?? "GTrack";

        using var msg = new MailMessage
        {
            From = new MailAddress(from, remitente, Encoding.UTF8),
            Subject = asunto,
            SubjectEncoding = Encoding.UTF8,
            BodyEncoding = Encoding.UTF8
        };
        msg.To.Add(new MailAddress(para));

        // Texto plano para los clientes que no muestran HTML y la versión HTML con el logo incrustado
        msg.AlternateViews.Add(AlternateView.CreateAlternateViewFromString(correo.Texto, Encoding.UTF8, MediaTypeNames.Text.Plain));

        var vistaHtml = AlternateView.CreateAlternateViewFromString(correo.Html, Encoding.UTF8, MediaTypeNames.Text.Html);
        var logo = await LeerLogoAsync();
        if (logo is not null)
        {
            vistaHtml.LinkedResources.Add(new LinkedResource(new MemoryStream(logo), "image/png")
            {
                ContentId = PlantillaCorreo.ContentIdLogo,
                TransferEncoding = TransferEncoding.Base64
            });
        }
        msg.AlternateViews.Add(vistaHtml);

        using var smtp = new SmtpClient(host, port)
        {
            EnableSsl = true,
            DeliveryMethod = SmtpDeliveryMethod.Network,
            UseDefaultCredentials = false,
            Credentials = new NetworkCredential(user, pass)
        };

        await smtp.SendMailAsync(msg);
        if (logger.IsEnabled(LogLevel.Information))
            logger.LogInformation("Correo enviado a {Para}: {Asunto}", para, asunto);
    }

    // Versión pequeña del logo para el correo (si no existe, se usa el logo de la página)
    private async Task<byte[]?> LeerLogoAsync()
    {
        var carpeta = Path.Combine(entorno.WebRootPath ?? Path.Combine(entorno.ContentRootPath, "wwwroot"), "images");
        foreach (var archivo in new[] { "Logo_Gtrack_correo.png", "Logo_Gtrack.png" })
        {
            var ruta = Path.Combine(carpeta, archivo);
            if (File.Exists(ruta)) return await File.ReadAllBytesAsync(ruta);
        }

        logger.LogWarning("No se encontró el logo de GTrack para los correos en {Carpeta}", carpeta);
        return null;
    }
}
