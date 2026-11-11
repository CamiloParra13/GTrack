using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

public class UbicacionService(
    IUbicacionRepository ubicaciones,
    IPedidoRepository pedidos,
    AppDbContext context,
    ILogger<UbicacionService> logger) : IUbicacionService
{
    public async Task<(bool Ok, string? Error)> ActualizarAsync(int repartidorUsuarioId, int pedidoId, decimal lat, decimal lng)
    {
        // 1. Valida que lat esté entre -90 y 90 y lng entre -180 y 180
        if (lat < -90m || lat > 90m || lng < -180m || lng > 180m)
        {
            return (false, "Coordenadas inválidas. La latitud debe estar entre -90 y 90, y la longitud entre -180 y 180.");
        }

        // 2. Valida que el pedido exista
        var pedido = await pedidos.ObtenerPorIdAsync(pedidoId);
        if (pedido is null)
        {
            return (false, "El pedido no fue encontrado.");
        }

        // 3. Valida que esté en estado EnCamino
        if (pedido.EstadoPedidoId != (int)EstadoPedido.EnCamino)
        {
            return (false, "El pedido no se encuentra en camino.");
        }

        // 4. Valida que pertenezca al repartidor de ese usuario
        var repartidor = await context.Repartidores
            .AsNoTracking()
            .FirstOrDefaultAsync(r => r.UsuarioId == repartidorUsuarioId);

        if (repartidor is null || pedido.RepartidorId != repartidor.Id)
        {
            return (false, "El pedido no pertenece al repartidor.");
        }

        // 5. Si el último guardado fue hace menos de 3 segundos, ignora la actualización sin dar error
        var actual = await ubicaciones.ObtenerAsync(pedidoId);
        if (actual is not null)
        {
            var diferencia = DateTime.UtcNow - actual.FechaActualizacion;
            if (diferencia >= TimeSpan.Zero && diferencia < TimeSpan.FromSeconds(3))
            {
                return (true, null);
            }
        }

        try
        {
            await ubicaciones.GuardarAsync(pedidoId, lat, lng);
            return (true, null);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al guardar la ubicación del pedido {PedidoId}", pedidoId);
            return (false, "No fue posible actualizar la ubicación.");
        }
    }

    public async Task<(bool Ok, string? Error, decimal? Latitud, decimal? Longitud, DateTime? FechaUtc, string? Estado)> ObtenerPorCodigoAsync(string codigoPedido)
    {
        if (string.IsNullOrWhiteSpace(codigoPedido))
        {
            return (false, "El código del pedido es requerido.", null, null, null, null);
        }

        var pedido = await pedidos.ObtenerPorCodigoAsync(codigoPedido.Trim());
        if (pedido is null)
        {
            return (false, "El pedido no fue encontrado.", null, null, null, null);
        }

        var estado = ((EstadoPedido)pedido.EstadoPedidoId).ToString();

        // SOLO si el pedido está EnCamino; si no, devuelve que no hay ubicación.
        // Nunca devuelvas datos del repartidor (nombre, teléfono ni id).
        if (pedido.EstadoPedidoId != (int)EstadoPedido.EnCamino)
        {
            return (false, "No hay ubicación disponible para este pedido.", null, null, null, estado);
        }

        var ubicacion = await ubicaciones.ObtenerAsync(pedido.Id);
        if (ubicacion is null)
        {
            return (false, "No hay ubicación registrada para este pedido.", null, null, null, estado);
        }

        var fechaUtc = DateTime.SpecifyKind(ubicacion.FechaActualizacion, DateTimeKind.Utc);
        return (true, null, ubicacion.Latitud, ubicacion.Longitud, fechaUtc, estado);
    }
}

