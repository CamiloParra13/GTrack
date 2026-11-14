// Alternativa para desarrollo: no envía nada, solo escribe el correo (versión texto) en el log
public class EmailDesarrolloService(ILogger<EmailDesarrolloService> logger) : IEmailService
{
    public Task EnviarAsync(string para, string asunto, string cuerpo) =>
        EnviarAsync(para, asunto, PlantillaCorreo.DesdeTexto(asunto, cuerpo));

    public Task EnviarAsync(string para, string asunto, CorreoHtml correo)
    public Task EnviarAsync(string para, string asunto, string cuerpo) => Registrar(para, asunto, cuerpo);

    public Task EnviarAsync(string para, string asunto, CorreoHtml correo) => Registrar(para, asunto, correo.Texto);

    private Task Registrar(string para, string asunto, string cuerpo)
    {
        logger.LogInformation("CORREO para {Para} | {Asunto}{Nueva}{Cuerpo}", para, asunto, Environment.NewLine, correo.Texto);
        logger.LogInformation("CORREO (modo desarrollo, no se envió) para {Para} | {Asunto}{Nueva}{Cuerpo}",
            para, asunto, Environment.NewLine, cuerpo);
        return Task.CompletedTask;
    }
}
