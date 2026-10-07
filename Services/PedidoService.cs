using System.Security.Cryptography;

// CU-03: Implementación del servicio de pedidos
public class PedidoService(
    IPedidoRepository pedidos,
    INegocioRepository negocios,
    ILogger<PedidoService> logger) : IPedidoService
{
    private const string AlfabetoCodigo = "ABCDEFGHJKMNPQRSTUVWXYZ23456789";

    public async Task<ClienteAutocompletarDto?> BuscarClienteFrecuenteAsync(int usuarioNegocioId, string telefono)
    {
        var negocio = await negocios.ObtenerPorUsuarioIdAsync(usuarioNegocioId);
        if (negocio is null) return null;

        var ultimoPedido = await pedidos.ObtenerUltimoPorTelefonoAsync(negocio.Id, telefono.Trim());
        if (ultimoPedido is null) return null;

        return new ClienteAutocompletarDto
        {
            Nombre = ultimoPedido.ClienteNombre,
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

        var valorTotal = items.Sum(i => i.Cantidad * i.PrecioUnitario);

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
            ClienteNombre = dto.ClienteNombre.Trim(),
            ClienteTelefono = dto.ClienteTelefono.Trim(),
            DireccionEntrega = dto.DireccionEntrega.Trim(),
            MetodoPago = dto.MetodoPago!.Value,
            Estado = EstadoPedido.Recibido,
            ValorTotal = valorTotal,
            FechaCreacion = DateTime.UtcNow,
            Items = items
        };

        try
        {
            await pedidos.AgregarAsync(pedido);
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Error al guardar el pedido con código {Codigo} para el negocio {NegocioId}", codigo, negocio.Id);
            return (false, "No fue posible registrar el pedido. Intenta nuevamente", null);
        }

        return (true, null, codigo);
    }
}

