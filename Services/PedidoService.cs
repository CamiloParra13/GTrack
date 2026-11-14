using System.Security.Cryptography;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

public class PedidoService(
    IPedidoRepository pedidos,
    INegocioRepository negocios,
    AppDbContext context,
    ILogger<PedidoService> logger) : IPedidoService
{
    private const string AlfabetoCodigo = "ABCDEFGHJKMNPQRSTUVWXYZ23456789";

    public async Task<ClienteAutocompletarDto?> BuscarClienteFrecuenteAsync(int usuarioNegocioId, string telefono)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return null;

        var ultimoPedido = await pedidos.ObtenerUltimoPorTelefonoAsync(negocio.Id, telefono.Trim());
        if (ultimoPedido is null || ultimoPedido.Cliente is null) return null;

        return new ClienteAutocompletarDto
        {
            Nombre = ultimoPedido.Cliente.NombreCompleto,
            Direccion = ultimoPedido.DireccionEntrega
        };
    }

    public async Task<(bool Ok, string? Error, string? Codigo)> RegistrarAsync(int usuarioNegocioId, RegistrarPedidoDto dto)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null)
            return (false, "No fue posible identificar tu negocio", null);

        var items = dto.Productos
            .Where(p => !string.IsNullOrWhiteSpace(p.Descripcion))
            .Select(p => new ItemPedido
            {
                Descripcion = p.Descripcion.Trim(),
                Cantidad = p.Cantidad,
                PrecioUnitario = p.PrecioUnitario
            })
            .ToList();

        if (items.Count == 0)
            return (false, "Debes completar todos los campos obligatorios del pedido", null);

        int clienteId = 1;
        try
        {
            var telefono = dto.ClienteTelefono?.Trim();
            var nombre = dto.ClienteNombre?.Trim();
            var direccion = dto.DireccionEntrega?.Trim();

            if (!string.IsNullOrEmpty(telefono))
            {
                var clienteDb = await context.Set<Cliente>()
                    .IgnoreQueryFilters()
                    .FirstOrDefaultAsync(c => c.Telefono == telefono);

                if (clienteDb != null)
                {
                    clienteId = clienteDb.Id;

                    // Actualizamos nombre si cambió
                    if (!string.IsNullOrEmpty(nombre) && clienteDb.NombreCompleto != nombre)
                    {
                        clienteDb.NombreCompleto = nombre;
                    }

                    // MEJORA 2: Actualizar la dirección predeterminada si el usuario introdujo una nueva
                    if (!string.IsNullOrEmpty(direccion) && clienteDb.DireccionPredeterminada != direccion)
                    {
                        clienteDb.DireccionPredeterminada = direccion;
                    }

                    await context.SaveChangesAsync();
                }
                else
                {
                    var nuevoCliente = new Cliente
                    {
                        NombreCompleto = !string.IsNullOrEmpty(nombre) ? nombre : "Cliente Frecuente",
                        Telefono = telefono,
                        DireccionPredeterminada = !string.IsNullOrEmpty(direccion) ? direccion : "Sin dirección",
                        FechaRegistro = DateTime.UtcNow,
                        NegocioId = negocio.Id
                    };

                    context.Set<Cliente>().Add(nuevoCliente);
                    await context.SaveChangesAsync();
                    clienteId = nuevoCliente.Id;
                }
            }
        }
        catch (Exception ex)
        {
            context.ChangeTracker.Clear();
            logger.LogWarning(ex, "No se pudo registrar/buscar el cliente automáticamente, usando valor por defecto.");
            clienteId = 1;
        }

        string? codigo = null;
        for (var intento = 0; intento < 5; intento++)
        {
            var candidato = RandomNumberGenerator.GetString(AlfabetoCodigo, 8);
            if (!await pedidos.ExisteCodigoAsync(candidato))
            {
                codigo = candidato;
                break;
            }
        }

        if (codigo is null)
        {
            logger.LogError("No fue posible generar un código único de pedido tras 5 intentos para el negocio {NegocioId}", negocio.Id);
            return (false, "No fue posible registrar el pedido. Intenta nuevamente", null);
        }

        var pedido = new Pedido
        {
            Codigo = codigo,
            NegocioId = negocio.Id,
            ClienteId = clienteId,
            DireccionEntrega = dto.DireccionEntrega.Trim(),
            MetodoPagoId = (int)dto.MetodoPago!.Value,
            EstadoPedidoId = 0,
            FechaCreacion = DateTime.UtcNow,
            Items = items
        };

        try
        {
            await pedidos.AgregarAsync(pedido);
            await RegistrarHistorialAsync(pedido.Id, (int)EstadoPedido.Recibido, usuarioNegocioId, "Pedido registrado");
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al guardar el pedido con código {Codigo} para el negocio {NegocioId}", codigo, negocio.Id);
            return (false, "No fue posible registrar el pedido. Intenta nuevamente", null);
        }

        return (true, null, codigo);
    }

    public async Task<(bool Ok, string? Error)> ActualizarEstadoAsync(int usuarioId, int pedidoId, int nuevoEstadoId, int? repartidorId = null)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioId);
        if (negocio is not null)
        {
            var pedido = await pedidos.ObtenerPorIdAsync(pedidoId);
            if (pedido is null || pedido.NegocioId != negocio.Id)
                return (false, "El pedido no fue encontrado o no pertenece a tu negocio");

            // MEJORA 1: Blindar pedidos finalizados (si ya está Entregado o Cancelado, no se puede modificar)
            if (pedido.EstadoPedidoId == (int)EstadoPedido.Entregado || pedido.EstadoPedidoId == (int)EstadoPedido.Cancelado)
            {
                return (false, "Este pedido ya se encuentra finalizado y no puede ser modificado.");
            }

            // MEJORA 3: Validación básica de secuencia de estados (Evitar saltos extraños si es necesario)
            // (Opcional según tu flujo: Asegurar que un pedido no pase directamente a Entregado sin estar Asignado o En Camino)
            if (nuevoEstadoId == (int)EstadoPedido.Entregado && pedido.EstadoPedidoId < (int)EstadoPedido.Asignado)
            {
                return (false, "El pedido debe ser asignado y despachado antes de poder marcarse como entregado.");
            }

            if (nuevoEstadoId >= (int)EstadoPedido.Asignado && nuevoEstadoId <= (int)EstadoPedido.Entregado)
            {
                int? repartidorAValidar = repartidorId.HasValue && repartidorId.Value > 0
                    ? repartidorId
                    : pedido.RepartidorId;

                if (repartidorAValidar.HasValue && repartidorAValidar.Value > 0)
                {
                    var estaSuspendido = await context.Set<SuspensionRepartidor>()
                        .AnyAsync(s => s.RepartidorId == repartidorAValidar.Value);

                    if (estaSuspendido)
                    {
                        return (false, "No es posible procesar el pedido: el repartidor asignado se encuentra actualmente suspendido.");
                    }

                    if (repartidorId.HasValue && repartidorId.Value > 0)
                    {
                        pedido.RepartidorId = repartidorId.Value;
                    }
                }
                else if (pedido.RepartidorId is null)
                {
                    return (false, "Debes seleccionar un repartidor antes de pasar el pedido a este estado.");
                }
            }

            try
            {
                pedido.EstadoPedidoId = nuevoEstadoId;
                await pedidos.ActualizarAsync(pedido);
                await RegistrarHistorialAsync(pedido.Id, nuevoEstadoId, usuarioId, null);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error al actualizar el estado del pedido {PedidoId} para el negocio {NegocioId}", pedidoId, negocio.Id);
                return (false, "No fue posible actualizar el estado del pedido. Intenta nuevamente");
            }

            return (true, null);
        }

        // Flujo para rol Repartidor: solo puede cambiar sus pedidos y flujo Asignado -> EnCamino -> Entregado
        var repartidor = await context.Repartidores
            .AsNoTracking()
            .FirstOrDefaultAsync(r => r.UsuarioId == usuarioId);

        if (repartidor is not null)
        {
            var estaSuspendido = await context.Set<SuspensionRepartidor>()
                .AnyAsync(s => s.RepartidorId == repartidor.Id);

            if (estaSuspendido)
            {
                return (false, "Tu cuenta de repartidor se encuentra actualmente suspendida.");
            }

            var pedido = await pedidos.ObtenerPorIdAsync(pedidoId);
            if (pedido is null || pedido.RepartidorId != repartidor.Id)
            {
                return (false, "El pedido no fue encontrado o no está asignado a tu cuenta.");
            }

            // Solo siguiendo el flujo Asignado → EnCamino → Entregado
            bool transicionValida = (pedido.EstadoPedidoId == (int)EstadoPedido.Asignado && nuevoEstadoId == (int)EstadoPedido.EnCamino)
                                 || (pedido.EstadoPedidoId == (int)EstadoPedido.EnCamino && nuevoEstadoId == (int)EstadoPedido.Entregado);

            if (!transicionValida)
            {
                return (false, "Este pedido ya no se puede actualizar");  // FE-18-CU08
            }

            try
            {
                pedido.EstadoPedidoId = nuevoEstadoId;
                await pedidos.ActualizarAsync(pedido);
                await RegistrarHistorialAsync(pedido.Id, nuevoEstadoId, usuarioId, null);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error al actualizar el estado del pedido {PedidoId} para el repartidor {RepartidorId}", pedidoId, repartidor.Id);
                return (false, "No fue posible actualizar el estado del pedido. Intenta nuevamente");
            }

            return (true, null);
        }

        return (false, "No fue posible identificar tu negocio o usuario");
    }

    // Guarda una fila en HistorialEstadoPedido (línea de tiempo del CU-05 y hora del cambio del CU-08).
    // Un fallo aquí no debe revertir el cambio de estado ya guardado: se registra en el log.
    private async Task RegistrarHistorialAsync(int pedidoId, int estadoId, int? usuarioId, string? observacion)
    {
        try
        {
            var fecha = DateTime.UtcNow;
            await context.Database.ExecuteSqlInterpolatedAsync(
                $"INSERT INTO dbo.HistorialEstadoPedido (PedidoId, EstadoPedidoId, UsuarioId, Observacion, FechaCambio) VALUES ({pedidoId}, {estadoId}, {usuarioId}, {observacion}, {fecha})");
        }
        catch (Exception ex)
        {
            logger.LogWarning(ex, "No se pudo registrar el historial del pedido {PedidoId} (estado {EstadoId})", pedidoId, estadoId);
        }
    }

    public async Task<List<Pedido>> ObtenerPedidosActivosAsync(int usuarioNegocioId)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return [];

        var listaPedidos = await pedidos.ObtenerPorNegocioAsync(negocio.Id);

        return listaPedidos
            .Where(p => p.EstadoPedidoId != (int)EstadoPedido.Entregado && p.EstadoPedidoId != (int)EstadoPedido.Cancelado)
            .ToList();
    }

    public async Task<List<Pedido>> ObtenerHistorialPedidosAsync(int usuarioNegocioId)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return [];

        var listaPedidos = await pedidos.ObtenerPorNegocioAsync(negocio.Id);

        return listaPedidos
            .Where(p => p.EstadoPedidoId == (int)EstadoPedido.Entregado || p.EstadoPedidoId == (int)EstadoPedido.Cancelado)
            .ToList();
    }
}