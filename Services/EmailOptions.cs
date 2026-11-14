public class EmailOptions
{
    public string Host { get; set; } = "smtp.gmail.com";
    public int Port { get; set; } = 587;
    public string Usuario { get; set; } = "";
    public string Password { get; set; } = "";
    public string NombreRemitente { get; set; } = "GTrack";
    public string UrlBase { get; set; } = "";
}
