public interface IEmailService
{
    Task EnviarAsync(string para, string asunto, string cuerpo);

    Task EnviarAsync(string para, string asunto, CorreoHtml correo);
}
