public interface IEmailService
{
    // Texto simple: se envía igual dentro de la plantilla de GTrack
    Task EnviarAsync(string para, string asunto, string cuerpo);

    // Correo armado con PlantillaCorreo.Crear(...)
    Task EnviarAsync(string para, string asunto, CorreoHtml correo);
}
