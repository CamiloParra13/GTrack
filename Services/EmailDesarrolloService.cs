public class EmailDesarrolloService(ILogger<EmailDesarrolloService> logger) : IEmailService
{
    public Task EnviarAsync(string para, string asunto, string cuerpo)
    {
        logger.LogInformation("CORREO para {Para} | {Asunto}{Nueva}{Cuerpo}", para, asunto, Environment.NewLine, cuerpo);
        return Task.CompletedTask;
    }
}