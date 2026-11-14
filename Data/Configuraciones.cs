using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

// Una configuración por tabla. Los nombres de tabla y columna son los del script gTrack.sql.
// Los enums se guardan como int y sus valores coinciden con las tablas de catálogo
// (Rol, EstadoCuenta, TipoVehiculo, EstadoPedido, MetodoPago).

public class UsuarioConfig : IEntityTypeConfiguration<Usuario>
{
    public void Configure(EntityTypeBuilder<Usuario> e)
    {
        e.ToTable("Usuario");
        e.Property(u => u.Correo).HasMaxLength(150);
        e.Property(u => u.Documento).HasMaxLength(20).IsUnicode(false);
        e.Property(u => u.PasswordHash).HasColumnName("ContrasenaHash").HasMaxLength(500);
        e.Property(u => u.Rol).HasColumnName("RolId");
        e.Property(u => u.Estado).HasColumnName("EstadoCuentaId");
        e.Property(u => u.MotivoRechazo).HasMaxLength(300);
        e.HasIndex(u => u.Correo).IsUnique();
        e.HasIndex(u => u.Documento).IsUnique();
    }
}

public class AdministradorConfig : IEntityTypeConfiguration<Administrador>
{
    public void Configure(EntityTypeBuilder<Administrador> e)
    {
        e.ToTable("Administrador");
        e.Property(a => a.NombreCompleto).HasMaxLength(100);
        e.Property(a => a.Telefono).HasMaxLength(15).IsUnicode(false);
        e.HasOne(a => a.Usuario).WithOne()
            .HasForeignKey<Administrador>(a => a.UsuarioId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}

public class NegocioConfig : IEntityTypeConfiguration<Negocio>
{
    public void Configure(EntityTypeBuilder<Negocio> e)
    {
        e.ToTable("Negocio");
        e.Property(n => n.Nombre).HasMaxLength(100);
        e.Property(n => n.TipoActividad).HasMaxLength(100);
        e.Property(n => n.Telefono).HasMaxLength(15).IsUnicode(false);
        e.Property(n => n.Direccion).HasMaxLength(200);
        e.HasIndex(n => n.Telefono).IsUnique();
        e.HasOne(n => n.Usuario).WithOne()
            .HasForeignKey<Negocio>(n => n.UsuarioId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}

public class RepartidorConfig : IEntityTypeConfiguration<Repartidor>
{
    public void Configure(EntityTypeBuilder<Repartidor> e)
    {
        e.ToTable("Repartidor");
        e.Property(r => r.NombreCompleto).HasMaxLength(100);
        e.Property(r => r.Telefono).HasMaxLength(15).IsUnicode(false);
        e.Property(r => r.Vehiculo).HasColumnName("TipoVehiculoId");
        e.Property(r => r.Placa).HasMaxLength(10).IsUnicode(false);
        e.HasIndex(r => r.Telefono).IsUnique();
        e.HasOne(r => r.Usuario).WithOne()
            .HasForeignKey<Repartidor>(r => r.UsuarioId)
            .OnDelete(DeleteBehavior.Restrict);
        e.HasOne<Negocio>().WithMany()
            .HasForeignKey(r => r.NegocioId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}

public class CodigoVerificacionConfig : IEntityTypeConfiguration<CodigoVerificacion>
{
    public void Configure(EntityTypeBuilder<CodigoVerificacion> e)
    {
        e.ToTable("CodigoVerificacion");
        e.Property(c => c.CodigoHash).HasMaxLength(200);
        e.Property(c => c.Expira).HasColumnName("FechaExpiracion");
        e.HasOne<Usuario>().WithMany().HasForeignKey(c => c.UsuarioId).OnDelete(DeleteBehavior.Restrict);
    }
}

public class TokenRecuperacionConfig : IEntityTypeConfiguration<TokenRecuperacion>
{
    public void Configure(EntityTypeBuilder<TokenRecuperacion> e)
    {
        e.ToTable("TokenRecuperacion");
        e.Property(t => t.TokenHash).HasMaxLength(200);
        e.Property(t => t.Expira).HasColumnName("FechaExpiracion");
        e.HasIndex(t => t.TokenHash).IsUnique();
        e.HasOne<Usuario>().WithMany().HasForeignKey(t => t.UsuarioId).OnDelete(DeleteBehavior.Restrict);
    }
}

public class PedidoConfig : IEntityTypeConfiguration<Pedido>
{
    public void Configure(EntityTypeBuilder<Pedido> e)
    {
        // La tabla tiene un trigger (límite de 3 pedidos activos por repartidor):
        // EF necesita saberlo para no usar OUTPUT en el INSERT/UPDATE.
        e.ToTable("Pedido", t => t.HasTrigger("trgPedidoLimiteRepartidor"));
        e.Property(p => p.Codigo).HasMaxLength(8).IsFixedLength().IsUnicode(false);
        e.Property(p => p.ClienteNombre).HasMaxLength(100);
        e.Property(p => p.ClienteTelefono).HasMaxLength(15).IsUnicode(false);
        e.Property(p => p.DireccionEntrega).HasMaxLength(200);
        e.Property(p => p.MetodoPago).HasColumnName("MetodoPagoId");
        e.Property(p => p.Estado).HasColumnName("EstadoPedidoId");
        e.Property(p => p.ValorTotal).HasPrecision(18, 2);
        e.HasIndex(p => p.Codigo).IsUnique();
        e.HasOne(p => p.Negocio).WithMany()
            .HasForeignKey(p => p.NegocioId)
            .OnDelete(DeleteBehavior.Restrict);
        e.HasMany(p => p.Items).WithOne(i => i.Pedido)
            .HasForeignKey(i => i.PedidoId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}

public class ItemPedidoConfig : IEntityTypeConfiguration<ItemPedido>
{
    public void Configure(EntityTypeBuilder<ItemPedido> e)
    {
        e.ToTable("ItemPedido");   // la columna Subtotal es calculada en SQL y no se mapea
        e.Property(i => i.Descripcion).HasMaxLength(100);
        e.Property(i => i.PrecioUnitario).HasPrecision(18, 2);
    }
}
