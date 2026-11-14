using Microsoft.EntityFrameworkCore;

// Mapea los modelos de C# a las tablas de la base gTrack (SQL Server).
// La base ya existe (script gTrack.sql): NO se usan migraciones.
public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Usuario> Usuarios => Set<Usuario>();
    public DbSet<TokenRecuperacion> TokensRecuperacion => Set<TokenRecuperacion>();
    public DbSet<Negocio> Negocios => Set<Negocio>();
    public DbSet<CodigoVerificacion> CodigosVerificacion => Set<CodigoVerificacion>();
    public DbSet<Repartidor> Repartidores => Set<Repartidor>();
    public DbSet<Administrador> Administradores => Set<Administrador>();
    public DbSet<Pedido> Pedidos => Set<Pedido>();
    public DbSet<ItemPedido> ItemsPedido => Set<ItemPedido>();
    public DbSet<Notificacion> Notificaciones => Set<Notificacion>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Usuario>(e =>
        {
            e.ToTable("Usuario");
            e.Property(u => u.PasswordHash).HasColumnName("ContrasenaHash");
            e.Property(u => u.Rol).HasColumnName("RolId");
            e.Property(u => u.Estado).HasColumnName("EstadoCuentaId");
            e.Property(u => u.Correo).HasMaxLength(150);
            e.Property(u => u.Documento).HasMaxLength(20).IsUnicode(false);
            e.HasIndex(u => u.Correo).IsUnique();
            e.HasIndex(u => u.Documento).IsUnique();
        });

        modelBuilder.Entity<TokenRecuperacion>(e =>
        {
            e.ToTable("TokenRecuperacion");
            e.Property(t => t.Expira).HasColumnName("FechaExpiracion");
            e.Property(t => t.TokenHash).HasMaxLength(64);
            e.HasIndex(t => t.TokenHash).IsUnique();
        });

        modelBuilder.Entity<Negocio>(e =>
        {
            e.ToTable("Negocio");
            e.Property(n => n.Nombre).HasMaxLength(100);
            e.Property(n => n.TipoActividad).HasMaxLength(100);
            e.Property(n => n.Telefono).HasMaxLength(15).IsUnicode(false);
            e.Property(n => n.Direccion).HasMaxLength(200);
            e.Property<DateTime?>("FechaValidacion");
            e.HasIndex(n => n.Telefono).IsUnique();
            e.HasOne(n => n.Usuario).WithOne()
                .HasForeignKey<Negocio>(n => n.UsuarioId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<CodigoVerificacion>(e =>
        {
            e.ToTable("CodigoVerificacion");
            e.Property(c => c.Expira).HasColumnName("FechaExpiracion");
            e.Property(c => c.CodigoHash).HasMaxLength(64);
            e.HasIndex(c => c.UsuarioId);
        });

        modelBuilder.Entity<Repartidor>(e =>
        {
            e.ToTable("Repartidor");
            e.Property(r => r.Vehiculo).HasColumnName("TipoVehiculoId");
            e.Property(r => r.NombreCompleto).HasMaxLength(100);
            e.Property(r => r.Telefono).HasMaxLength(15).IsUnicode(false);
            e.Property(r => r.Placa).HasMaxLength(10).IsUnicode(false);
            e.HasOne(r => r.Usuario).WithMany()
                .HasForeignKey(r => r.UsuarioId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Administrador>(e =>
        {
            e.ToTable("Administrador");
            e.Property(a => a.NombreCompleto).HasMaxLength(100);
            e.Property(a => a.Telefono).HasMaxLength(15).IsUnicode(false);
            e.HasOne(a => a.Usuario).WithMany()
                .HasForeignKey(a => a.UsuarioId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<Pedido>(e =>
        {
            e.ToTable("Pedido");
            e.Property(p => p.Codigo).HasMaxLength(8).IsFixedLength().IsUnicode(false);
            e.Property(p => p.MetodoPago).HasColumnName("MetodoPagoId");
            e.Property(p => p.Estado).HasColumnName("EstadoPedidoId");
            e.Property(p => p.ClienteNombre).HasMaxLength(100);
            e.Property(p => p.ClienteTelefono).HasMaxLength(15).IsUnicode(false);
            e.Property(p => p.DireccionEntrega).HasMaxLength(200);
            e.Property(p => p.ValorTotal).HasPrecision(18, 2);
            e.HasOne(p => p.Negocio).WithMany()
                .HasForeignKey(p => p.NegocioId)
                .OnDelete(DeleteBehavior.Restrict);
            e.HasMany(p => p.Items).WithOne(i => i.Pedido)
                .HasForeignKey(i => i.PedidoId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<ItemPedido>(e =>
        {
            e.ToTable("ItemPedido");
            e.Property(i => i.Descripcion).HasMaxLength(100);
            e.Property(i => i.PrecioUnitario).HasPrecision(18, 2);
        });

        modelBuilder.Entity<Notificacion>(e =>
        {
            e.ToTable("Notificacion");
            e.Property(n => n.Titulo).HasMaxLength(100);
            e.Property(n => n.Mensaje).HasMaxLength(300);
            e.Property(n => n.Enlace).HasMaxLength(200);
            e.HasIndex(n => new { n.UsuarioId, n.Leida, n.FechaCreacion });
        });
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
    }
}
