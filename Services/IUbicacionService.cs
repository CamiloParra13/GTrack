public interface IUbicacionService
{
    Task<(bool Ok, string? Error)> ActualizarAsync(int repartidorUsuarioId, int pedidoId, decimal lat, decimal lng);
    Task<(bool Ok, string? Error, decimal? Latitud, decimal? Longitud, DateTime? FechaUtc, string? Estado)> ObtenerPorCodigoAsync(string codigoPedido);
}

