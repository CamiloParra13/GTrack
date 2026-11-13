using System.Net;
using System.Net.Mail;
using System.Text;

public class EmailSmtpService(IConfiguration config) : IEmailService
{
    public async Task EnviarAsync(string para, string asunto, string cuerpo)
    {
        var host = config["Email:Host"] ?? "smtp.gmail.com";
        var port = int.Parse(config["Email:Port"] ?? "587");
        var user = config["Email:User"] ?? throw new InvalidOperationException("Falta Email:User");
        var pass = config["Email:Password"] ?? throw new InvalidOperationException("Falta Email:Password");
        var from = config["Email:From"] ?? user;

        using var msg = new MailMessage(new MailAddress(from, "GTrack"), new MailAddress(para))
        {
            Subject = asunto,
            Body = cuerpo,
            IsBodyHtml = false,
            SubjectEncoding = Encoding.UTF8,
            BodyEncoding = Encoding.UTF8
        };

        using var smtp = new SmtpClient(host, port)
        {
            EnableSsl = true,
            Credentials = new NetworkCredential(user, pass)
        };

        await smtp.SendMailAsync(msg);
    }
}