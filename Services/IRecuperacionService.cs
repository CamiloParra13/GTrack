public enum ResultadoSolicitud { Procesada, LimiteSuperado }

public interface IRecuperacionService
{
    Task<ResultadoSolicitud> SolicitarAsync(string correo, Func<string, string> construirEnlace);
    Task<bool> TokenVigenteAsync(string token);
    Task<(bool Ok, string? Error)> RestablecerAsync(string token, string nueva, string confirmacion);
}