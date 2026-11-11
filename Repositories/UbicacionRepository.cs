using Microsoft.EntityFrameworkCore;

public class UbicacionRepository(AppDbContext db) : IUbicacionRepository
{
    public async Task<UbicacionPedido?> ObtenerAsync(int pedidoId) =>
        await db.UbicacionesPedido
            .FirstOrDefaultAsync(u => u.PedidoId == pedidoId);

    public async Task GuardarAsync(int pedidoId, decimal lat, decimal lng)
    {
        var ubicacion = await db.UbicacionesPedido
            .FirstOrDefaultAsync(u => u.PedidoId == pedidoId);

        if (ubicacion is null)
        {
            ubicacion = new UbicacionPedido
            {
                PedidoId = pedidoId,
                Latitud = lat,
                Longitud = lng,
                FechaActualizacion = DateTime.UtcNow
            };
            db.UbicacionesPedido.Add(ubicacion);
        }
        else
        {
            ubicacion.Latitud = lat;
            ubicacion.Longitud = lng;
            ubicacion.FechaActualizacion = DateTime.UtcNow;
            db.UbicacionesPedido.Update(ubicacion);
        }

        await db.SaveChangesAsync();
    }
}

