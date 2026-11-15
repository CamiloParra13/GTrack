public class EstadoPedidoInfoTests
{
    [Theory]
    [InlineData(EstadoPedido.Recibido, "Recibido", "#6c757d")]
    [InlineData(EstadoPedido.EnPreparacion, "En preparación", "#f0ad00")]
    [InlineData(EstadoPedido.ListoParaEntrega, "Listo para entrega", "#0dcaf0")]
    [InlineData(EstadoPedido.Asignado, "Asignado", "#6f42c1")]
    [InlineData(EstadoPedido.EnCamino, "En camino", "#fd7e14")]
    [InlineData(EstadoPedido.Entregado, "Entregado", "#198754")]
    [InlineData(EstadoPedido.Cancelado, "Cancelado", "#dc3545")]
    public void Pedido_NombreYColorSegunElEstado(EstadoPedido estado, string nombre, string color)
    {
        Assert.Equal(nombre, EstadoPedidoInfo.Nombre((int)estado));
        Assert.Equal(color, EstadoPedidoInfo.Color((int)estado));
    }

    [Fact]
    public void Pedido_EstadoDesconocido_UsaValoresPorDefecto()
    {
        Assert.Equal("Desconocido", EstadoPedidoInfo.Nombre(99));
        Assert.Equal("#adb5bd", EstadoPedidoInfo.Color(99));
    }

    [Theory]
    [InlineData(EstadoCuenta.Activo, "Activo", "#198754")]
    [InlineData(EstadoCuenta.PendienteValidacion, "Pendiente de validación", "#f0ad00")]
    [InlineData(EstadoCuenta.Suspendido, "Suspendido", "#6c757d")]
    [InlineData(EstadoCuenta.Rechazado, "Rechazado", "#dc3545")]
    [InlineData(EstadoCuenta.PendienteActivacion, "Pendiente de activación", "#fd7e14")]
    [InlineData(EstadoCuenta.Eliminado, "Eliminado", "#343a40")]
    public void Cuenta_NombreYColorSegunElEstado(EstadoCuenta estado, string nombre, string color)
    {
        Assert.Equal(nombre, EstadoPedidoInfo.NombreCuenta(estado));
        Assert.Equal(color, EstadoPedidoInfo.ColorCuenta(estado));
    }
}