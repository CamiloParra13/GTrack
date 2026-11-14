// Nombres y colores de los 7 estados del pedido (se usan en pantalla, Excel y PDF)
public static class EstadoPedidoInfo
{
    public static string Nombre(int estadoId) => (EstadoPedido)estadoId switch
    {
        EstadoPedido.Recibido => "Recibido",
        EstadoPedido.EnPreparacion => "En preparación",
        EstadoPedido.ListoParaEntrega => "Listo para entrega",
        EstadoPedido.Asignado => "Asignado",
        EstadoPedido.EnCamino => "En camino",
        EstadoPedido.Entregado => "Entregado",
        EstadoPedido.Cancelado => "Cancelado",
        _ => "Desconocido"
    };

    public static string Color(int estadoId) => (EstadoPedido)estadoId switch
    {
        EstadoPedido.Recibido => "#6c757d",
        EstadoPedido.EnPreparacion => "#f0ad00",
        EstadoPedido.ListoParaEntrega => "#0dcaf0",
        EstadoPedido.Asignado => "#6f42c1",
        EstadoPedido.EnCamino => "#fd7e14",
        EstadoPedido.Entregado => "#198754",
        EstadoPedido.Cancelado => "#dc3545",
        _ => "#adb5bd"
    };

    public static string NombreCuenta(EstadoCuenta e) => e switch
    {
        EstadoCuenta.Activo => "Activo",
        EstadoCuenta.PendienteValidacion => "Pendiente de validación",
        EstadoCuenta.Suspendido => "Suspendido",
        EstadoCuenta.Rechazado => "Rechazado",
        EstadoCuenta.PendienteActivacion => "Pendiente de activación",
        _ => "Eliminado"
    };

    public static string ColorCuenta(EstadoCuenta e) => e switch
    {
        EstadoCuenta.Activo => "#198754",
        EstadoCuenta.PendienteValidacion => "#f0ad00",
        EstadoCuenta.Suspendido => "#6c757d",
        EstadoCuenta.Rechazado => "#dc3545",
        EstadoCuenta.PendienteActivacion => "#fd7e14",
        _ => "#343a40"
    };
}
