namespace Gtrack.Tests;

public class EmailServiceFalso : IEmailService
{
    public List<(string Para, string Asunto, string Cuerpo)> Enviados { get; } = new();
    public List<(string Para, string Asunto, CorreoHtml Correo)> EnviadosHtml { get; } = new();
    public bool DebeFallar { get; set; }

    public Task EnviarAsync(string para, string asunto, string cuerpo)
    {
        if (DebeFallar) throw new Exception("Fallo simulado de envío de correo");
        Enviados.Add((para, asunto, cuerpo));
        return Task.CompletedTask;
    }

    public Task EnviarAsync(string para, string asunto, CorreoHtml correo)
    {
        if (DebeFallar) throw new Exception("Fallo simulado de envío de correo");
        EnviadosHtml.Add((para, asunto, correo));
        return Task.CompletedTask;
    }
}