// Alternativa para desarrollo: no envía nada, solo escribe el correo (versión texto) en el log
public class EmailDesarrolloService(ILogger<EmailDesarrolloService> logger) : IEmailService
{
    public Task EnviarAsync(string para, string asunto, string cuerpo) =>
        EnviarAsync(para, asunto, PlantillaCorreo.DesdeTexto(asunto, cuerpo));

    public Task EnviarAsync(string para, string asunto, CorreoHtml correo)
    {
        logger.LogInformation("CORREO para {Para} | {Asunto}{Nueva}{Cuerpo}", para, asunto, Environment.NewLine, correo.Texto);
        return Task.CompletedTask;
    }
}
