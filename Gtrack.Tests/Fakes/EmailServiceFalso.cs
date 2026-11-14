public class EmailServiceFalso : IEmailService
{
    public List<(string Para, string Asunto, string Cuerpo)> Enviados { get; } = new();
    public bool DebeFallar { get; set; }

    public Task EnviarAsync(string para, string asunto, string cuerpo)
    {
        if (DebeFallar) throw new Exception("Fallo simulado de envío de correo");
        Enviados.Add((para, asunto, cuerpo));
        return Task.CompletedTask;
    }
}