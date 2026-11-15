using System.Security.Cryptography;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

public class PedidoService(
    IPedidoRepository pedidos,
    INegocioRepository negocios,
    AppDbContext context,
    IEmailService email,
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

    // FE-9-CU03
    public const string MensajeCamposObligatorios = "Debes completar todos los campos obligatorios del pedido";

    public async Task<(bool Ok, string? Error, string? Codigo)> RegistrarAsync(int usuarioNegocioId, RegistrarPedidoDto dto)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null)
            return (false, "No fue posible identificar tu negocio", null);

        // FE-9-CU03: se valida también aquí, aunque el formulario ya lo revise (RN-2-CU03: al menos un producto)
        var nombre = dto.ClienteNombre?.Trim() ?? "";
        var telefono = dto.ClienteTelefono?.Trim() ?? "";
        var direccion = dto.DireccionEntrega?.Trim() ?? "";

        var items = (dto.Productos ?? [])
            .Where(p => !string.IsNullOrWhiteSpace(p.Descripcion))
            .Select(p => new ItemPedido
            {
                Descripcion = p.Descripcion.Trim(),
                Cantidad = p.Cantidad,
                PrecioUnitario = p.PrecioUnitario
            })
            .ToList();

        if (nombre.Length == 0 || telefono.Length == 0 || direccion.Length == 0 ||
            dto.MetodoPago is not { } metodoPago || !Enum.IsDefined(metodoPago) || items.Count == 0)
            return (false, MensajeCamposObligatorios, null);

        if (items.Any(i => i.Cantidad < 1 || i.PrecioUnitario <= 0))
            return (false, "La cantidad y el precio de cada producto deben ser mayores que cero", null);

        // FA-03-CU03: el cliente se identifica por su teléfono dentro del negocio; si ya existe se actualizan
        // su nombre y su dirección (MEJORA 2), y si no, se crea. Si esto falla, el pedido no se registra.
        // Cada negocio tiene sus propios clientes (UQ_Cliente_Negocio_Telefono y FK_Pedido_Cliente_Negocio):
        // buscarlo en todos los negocios tomaba el cliente de otro negocio y el pedido no se podía guardar.
        int clienteId;
        try
        {
            var clienteDb = await context.Set<Cliente>()
                .IgnoreQueryFilters()
                .FirstOrDefaultAsync(c => c.NegocioId == negocio.Id && c.Telefono == telefono);

            if (clienteDb != null)
            {
                if (clienteDb.NombreCompleto != nombre) clienteDb.NombreCompleto = nombre;
                if (clienteDb.DireccionPredeterminada != direccion) clienteDb.DireccionPredeterminada = direccion;

                await context.SaveChangesAsync();
                clienteId = clienteDb.Id;
            }
            else
            {
                var nuevoCliente = new Cliente
                {
                    NombreCompleto = nombre,
                    Telefono = telefono,
                    DireccionPredeterminada = direccion,
                    FechaRegistro = DateTime.UtcNow,
                    NegocioId = negocio.Id
                };

                context.Set<Cliente>().Add(nuevoCliente);
                await context.SaveChangesAsync();
                clienteId = nuevoCliente.Id;
            }
        }
        catch (Exception ex)
        {
            context.ChangeTracker.Clear();
            logger.LogError(ex, "No se pudo registrar o actualizar el cliente del pedido para el negocio {NegocioId}", negocio.Id);
            return (false, "No fue posible registrar el pedido. Intenta nuevamente", null);
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
            DireccionEntrega = direccion,
            MetodoPagoId = (int)metodoPago,
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

    // ================= Regla de estados del pedido =================
    // Orden: Recibido(0) → En preparación(1) → Listo para entrega(2) → Asignado(3) → En camino(4) → Entregado(5). Cancelado = 6
    private static readonly string[] NombresEstado =
        ["Recibido", "En preparación", "Listo para entrega", "Asignado", "En camino", "Entregado", "Cancelado"];

    private const string MensajeEstadoCambiado = "El pedido cambió de estado mientras lo actualizabas. Revisa su estado e intenta nuevamente";

    private static string NombreEstado(int estadoId) =>
        estadoId >= 0 && estadoId < NombresEstado.Length ? NombresEstado[estadoId] : "Desconocido";

    // El pedido solo avanza al estado siguiente: no puede retroceder ni saltarse estados.
    // Cancelar se permite mientras no esté finalizado (Entregado/Cancelado se revisa antes).
    // Devuelve el mensaje de error, o null si el cambio está permitido.
    public static string? ValidarCambioEstado(int estadoActual, int nuevoEstadoId)
    {
        if (nuevoEstadoId < (int)EstadoPedido.Recibido || nuevoEstadoId > (int)EstadoPedido.Cancelado)
            return "El estado seleccionado no es válido";

        // Mismo estado (por ejemplo, cambiar el repartidor de un pedido Asignado) o cancelación
        if (nuevoEstadoId == estadoActual || nuevoEstadoId == (int)EstadoPedido.Cancelado)
            return null;

        if (nuevoEstadoId < estadoActual)
            return $"Un pedido no puede volver a un estado anterior: está en \"{NombreEstado(estadoActual)}\" y no puede pasar a \"{NombreEstado(nuevoEstadoId)}\"";

        if (nuevoEstadoId > estadoActual + 1)
            return $"Un pedido no puede saltarse estados: de \"{NombreEstado(estadoActual)}\" primero debe pasar a \"{NombreEstado(estadoActual + 1)}\"";

        return null;
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

            // MEJORA 3: el pedido no puede retroceder ni saltarse estados; solo avanza al siguiente.
            // Ej.: si está "En preparación" no puede pasar a "Asignado" (primero va "Listo para entrega"),
            // y si está "Asignado" no puede volver a "En preparación". Cancelarlo sí se permite.
            var estadoActual = pedido.EstadoPedidoId;
            var errorTransicion = ValidarCambioEstado(estadoActual, nuevoEstadoId);
            if (errorTransicion is not null)
            {
                return (false, errorTransicion);
            }

            int? nuevoRepartidorId = null;

            if (nuevoEstadoId >= (int)EstadoPedido.Asignado && nuevoEstadoId <= (int)EstadoPedido.Entregado)
            {
                int? repartidorAValidar = repartidorId.HasValue && repartidorId.Value > 0
                    ? repartidorId
                    : pedido.RepartidorId;

                if (repartidorAValidar.HasValue && repartidorAValidar.Value > 0)
                {
                    // Solo cuenta la suspensión abierta: una suspensión con fecha de reactivación ya terminó (CU-27)
                    var estaSuspendido = await context.Set<SuspensionRepartidor>()
                        .AnyAsync(s => s.RepartidorId == repartidorAValidar.Value && s.FechaReactivacion == null);

                    if (estaSuspendido)
                    {
                        return (false, "No es posible procesar el pedido: el repartidor asignado se encuentra actualmente suspendido.");
                    }

                    if (repartidorId.HasValue && repartidorId.Value > 0)
                    {
                        nuevoRepartidorId = repartidorId.Value;
                    }
                }
                else if (pedido.RepartidorId is null)
                {
                    return (false, "Debes seleccionar un repartidor antes de pasar el pedido a este estado.");
                }
            }

            try
            {
                // Se guarda solo si el pedido sigue en el estado que se validó: si el cliente lo canceló
                // o el repartidor lo avanzó un instante antes, no se cambia nada (así nunca retrocede).
                var filas = await context.Pedidos
                    .Where(p => p.Id == pedido.Id && p.EstadoPedidoId == estadoActual)
                    .ExecuteUpdateAsync(s => s
                        .SetProperty(p => p.EstadoPedidoId, nuevoEstadoId)
                        .SetProperty(p => p.RepartidorId, p => nuevoRepartidorId ?? p.RepartidorId));

                if (filas == 0)
                {
                    return (false, MensajeEstadoCambiado);
                }

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
                .AnyAsync(s => s.RepartidorId == repartidor.Id && s.FechaReactivacion == null);

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
                // Igual que con el negocio: si el cliente lo canceló un instante antes, no se cambia nada
                var estadoActual = pedido.EstadoPedidoId;
                var filas = await context.Pedidos
                    .Where(p => p.Id == pedido.Id && p.EstadoPedidoId == estadoActual && p.RepartidorId == repartidor.Id)
                    .ExecuteUpdateAsync(s => s.SetProperty(p => p.EstadoPedidoId, nuevoEstadoId));

                if (filas == 0)
                {
                    return (false, "Este pedido ya no se puede actualizar");  // FE-18-CU08
                }

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

    // ================= CU-17 Cancelar pedido (cliente) =================
    public const string MensajeCodigoNoEncontrado = "Código no encontrado, verifica e intenta nuevamente";     // FE-43-CU17
    public const int MaxCaracteresMotivo = 250;

    private const string MensajeNoCancelable = "Este pedido ya no puede ser cancelado";                        // FE-42-CU17
    private const string MensajeSolicitudDuplicada = "Ya existe una solicitud de cancelación para este pedido"; // FE-44-CU17
    private const string MensajeErrorCancelacion = "No fue posible cancelar el pedido. Intenta nuevamente";    // FE-45-CU17

    // Estados en los que el cliente puede cancelar: Recibido, En preparación, Listo para entrega o Asignado
    public static bool EsCancelablePorCliente(int estadoId) =>
        estadoId >= (int)EstadoPedido.Recibido && estadoId <= (int)EstadoPedido.Asignado;

    public async Task<(bool Ok, string? Error)> CancelarPorClienteAsync(string? codigo, string? motivo)
    {
        var codigoLimpio = codigo?.Trim().ToUpperInvariant() ?? "";
        if (!System.Text.RegularExpressions.Regex.IsMatch(codigoLimpio, "^[A-Z0-9]{8}$"))
            return (false, MensajeCodigoNoEncontrado);

        var motivoLimpio = motivo?.Trim() ?? "";
        if (motivoLimpio.Length == 0)
            return (false, "Escribe el motivo de la cancelación");
        if (motivoLimpio.Length > MaxCaracteresMotivo)
            return (false, $"El motivo puede tener máximo {MaxCaracteresMotivo} caracteres");

        try
        {
            var pedido = await context.Pedidos
                .AsNoTracking()
                .Include(p => p.Cliente)
                .Include(p => p.Negocio).ThenInclude(n => n!.Usuario)
                .FirstOrDefaultAsync(p => p.Codigo == codigoLimpio);

            if (pedido is null) return (false, MensajeCodigoNoEncontrado);

            // RN-1-CU17: una sola solicitud por pedido
            if (await context.SolicitudesCancelacion.AnyAsync(s => s.PedidoId == pedido.Id))
                return (false, MensajeSolicitudDuplicada);

            // RN-2-CU17: "En camino", "Entregado" (o ya cancelado por el negocio) no se pueden cancelar
            if (!EsCancelablePorCliente(pedido.EstadoPedidoId))
                return (false, MensajeNoCancelable);

            var ahora = DateTime.UtcNow;
            await using (var tx = await context.Database.BeginTransactionAsync())
            {
                // Se cambia el estado solo si sigue siendo cancelable: si el repartidor lo marcó
                // "En camino" justo antes, no se actualiza ninguna fila.
                var filas = await context.Pedidos
                    .Where(p => p.Id == pedido.Id &&
                                p.EstadoPedidoId >= (int)EstadoPedido.Recibido &&
                                p.EstadoPedidoId <= (int)EstadoPedido.Asignado)
                    .ExecuteUpdateAsync(s => s.SetProperty(p => p.EstadoPedidoId, (int)EstadoPedido.Cancelado));

                if (filas == 0)
                {
                    await tx.RollbackAsync();
                    return (false, MensajeNoCancelable);
                }

                context.SolicitudesCancelacion.Add(new SolicitudCancelacion
                {
                    PedidoId = pedido.Id,
                    Motivo = motivoLimpio,
                    FechaSolicitud = ahora
                });
                await context.SaveChangesAsync();
                await tx.CommitAsync();
            }

            // Línea de tiempo (CU-05). El cliente no tiene cuenta, por eso no hay usuario asociado.
            await RegistrarHistorialAsync(pedido.Id, (int)EstadoPedido.Cancelado, null, "Cancelado por el cliente");

            await NotificarCancelacionAsync(pedido, motivoLimpio, ahora);
            return (true, null);
        }
        catch (DbUpdateException ex)
        {
            // Dos solicitudes al mismo tiempo: el índice único deja pasar solo una
            context.ChangeTracker.Clear();
            logger.LogWarning(ex, "No se pudo guardar la solicitud de cancelación del pedido {Codigo}", codigoLimpio);
            return (false, MensajeSolicitudDuplicada);
        }
        catch (Exception ex)
        {
            context.ChangeTracker.Clear();
            logger.LogError(ex, "Error al cancelar el pedido {Codigo} por parte del cliente", codigoLimpio);
            return (false, MensajeErrorCancelacion);
        }
    }

    // Paso 8: aviso al negocio por correo. Si falla, la cancelación ya quedó guardada.
    private async Task NotificarCancelacionAsync(Pedido pedido, string motivo, DateTime fechaUtc)
    {
        var correo = pedido.Negocio?.Usuario?.Correo;
        if (string.IsNullOrWhiteSpace(correo)) return;

        try
        {
            var fecha = fechaUtc.AddHours(-5).ToString("dd/MM/yyyy hh:mm tt", new System.Globalization.CultureInfo("es-CO"));
            await email.EnviarAsync(correo, $"Pedido {pedido.Codigo} cancelado por el cliente", PlantillaCorreo.Crear(
                etiqueta: "Pedido cancelado",
                titulo: "Un cliente canceló su pedido",
                saludo: $"Hola, {pedido.Negocio!.Nombre}:",
                parrafos: [$"El cliente canceló el pedido **{pedido.Codigo}** desde la consulta de GTrack. El pedido ya aparece como \"Cancelado\" en tu historial."],
                datos:
                [
                    ("Código", pedido.Codigo),
                    ("Cliente", pedido.Cliente?.NombreCompleto ?? ""),
                    ("Dirección de entrega", pedido.DireccionEntrega),
                    ("Motivo", motivo),
                    ("Fecha", fecha)
                ],
                nota: "No es necesario preparar ni despachar este pedido.",
                tipoNota: TipoNota.Aviso,
                resumen: $"El cliente canceló el pedido {pedido.Codigo}. Motivo: {motivo}"));
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "No se pudo avisar al negocio la cancelación del pedido {Codigo}", pedido.Codigo);
        }
    }

    // ================= CU-16 Novedad de pedido (repartidor) =================
    public const int MaxCaracteresObservaciones = 500;

    private const string MensajeTipoNovedad = "Debes seleccionar un tipo de novedad";                     // FE-39-CU16
    private const string MensajeNovedadNoPermitida = "No se pueden reportar novedades sobre este pedido"; // FE-40-CU16
    private const string MensajeErrorNovedad = "No fue posible registrar la novedad. Intenta Nuevamente"; // FE-41-CU16

    public async Task<(bool Ok, string? Error)> RegistrarNovedadAsync(int usuarioRepartidorId, int pedidoId, int? tipoNovedadId, string? observaciones)
    {
        if (tipoNovedadId is null || !Enum.IsDefined(typeof(TipoNovedad), tipoNovedadId.Value))
            return (false, MensajeTipoNovedad);

        var texto = observaciones?.Trim() ?? "";
        if (texto.Length > MaxCaracteresObservaciones)
            return (false, $"Las observaciones pueden tener máximo {MaxCaracteresObservaciones} caracteres");

        try
        {
            var repartidor = await context.Repartidores
                .AsNoTracking()
                .FirstOrDefaultAsync(r => r.UsuarioId == usuarioRepartidorId);

            if (repartidor is null)
                return (false, "No se encontró el perfil de repartidor para tu cuenta.");

            var pedido = await context.Pedidos
                .AsNoTracking()
                .FirstOrDefaultAsync(p => p.Id == pedidoId && p.RepartidorId == repartidor.Id);

            if (pedido is null)
                return (false, "El pedido no fue encontrado o no está asignado a tu cuenta.");

            // RN-1-CU16: solo pedidos activos (ni entregados ni cancelados)
            if (pedido.EstadoPedidoId == (int)EstadoPedido.Entregado || pedido.EstadoPedidoId == (int)EstadoPedido.Cancelado)
                return (false, MensajeNovedadNoPermitida);

            // PE-31-CU16: la novedad queda registrada con fecha y hora. PE-32-CU16: el pedido no cambia de estado.
            context.NovedadesPedido.Add(new NovedadPedido
            {
                PedidoId = pedido.Id,
                TipoNovedadId = tipoNovedadId.Value,
                Observaciones = texto.Length == 0 ? null : texto,
                Fecha = DateTime.UtcNow
            });
            await context.SaveChangesAsync();
            return (true, null);
        }
        catch (Exception ex)
        {
            context.ChangeTracker.Clear();
            logger.LogError(ex, "Error al registrar la novedad del pedido {PedidoId}", pedidoId);
            return (false, MensajeErrorNovedad);
        }
    }
}
