using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using Microsoft.Extensions.Options;

public class EmailSmtpService(
    IOptions<EmailOptions> opciones,
    IWebHostEnvironment entorno,
    ILogger<EmailSmtpService> logger) : IEmailService
{
    private readonly EmailOptions config = opciones.Value;

    public Task EnviarAsync(string para, string asunto, string cuerpo) =>
        EnviarAsync(para, asunto, PlantillaCorreo.DesdeTexto(asunto, cuerpo));

    public async Task EnviarAsync(string para, string asunto, CorreoHtml correo)
    {
        if (string.IsNullOrWhiteSpace(config.Usuario) || string.IsNullOrWhiteSpace(config.Password))
            throw new InvalidOperationException("Falta configurar Email:Usuario o Email:Password");

        using var mensaje = new MailMessage
        {
            From = new MailAddress(config.Usuario, config.NombreRemitente, Encoding.UTF8),
            Subject = asunto,
            SubjectEncoding = Encoding.UTF8,
            BodyEncoding = Encoding.UTF8
        };
        mensaje.To.Add(new MailAddress(para));

        mensaje.AlternateViews.Add(
            AlternateView.CreateAlternateViewFromString(correo.Texto, Encoding.UTF8, MediaTypeNames.Text.Plain));

        var vistaHtml = AlternateView.CreateAlternateViewFromString(correo.Html, Encoding.UTF8, MediaTypeNames.Text.Html);

        var rutaLogo = Path.Combine(entorno.WebRootPath ?? entorno.ContentRootPath, "images", "Logo_Gtrack.png");
        if (File.Exists(rutaLogo))
        {
            vistaHtml.LinkedResources.Add(new LinkedResource(rutaLogo, "image/png")
            {
                ContentId = PlantillaCorreo.ContentIdLogo,
                TransferEncoding = TransferEncoding.Base64
            });
        }
        mensaje.AlternateViews.Add(vistaHtml);

        using var smtp = new SmtpClient(config.Host, config.Port)
        {
            EnableSsl = true,
            DeliveryMethod = SmtpDeliveryMethod.Network,
            UseDefaultCredentials = false,
            Credentials = new NetworkCredential(config.Usuario, config.Password.Replace(" ", "")),
            Timeout = 15000
        };

        try
        {
            await smtp.SendMailAsync(mensaje);
            logger.LogInformation("Correo enviado a {Para}: {Asunto}", para, asunto);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo enviar el correo a {Para}: {Asunto}", para, asunto);
            throw;
        }
    }
}
