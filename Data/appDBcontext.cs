using Microsoft.EntityFrameworkCore;

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
    public DbSet<SuspensionRepartidor> SuspensionRepartidor { get; set; }
    public DbSet<UbicacionPedido> UbicacionesPedido => Set<UbicacionPedido>();
    public DbSet<SolicitudCancelacion> SolicitudesCancelacion => Set<SolicitudCancelacion>();
    public DbSet<NovedadPedido> NovedadesPedido => Set<NovedadPedido>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Usuario>(e =>
        {
            // La tabla tiene un trigger (script de triggers y procedimientos). Así EF no usa
            // OUTPUT sin INTO, que SQL Server no permite en tablas con triggers.
            e.ToTable("Usuario", t => t.HasTrigger("trg_Usuario_EliminacionLogica"));
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
            // Columna de la BD que no está en el modelo: se llena al aprobar el negocio
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
            // Tabla con triggers (script de triggers y procedimientos): EF no debe usar OUTPUT sin INTO
            e.ToTable("Pedido", t =>
            {
                t.HasTrigger("trg_Pedido_ValidarCambioEstado");
                t.HasTrigger("trg_Pedido_Notificaciones");
            });
            e.Property(p => p.Codigo).HasMaxLength(8).IsFixedLength().IsUnicode(false);
            e.Property(p => p.DireccionEntrega).HasMaxLength(200);

            e.HasOne(p => p.Negocio).WithMany()
                .HasForeignKey(p => p.NegocioId)
                .OnDelete(DeleteBehavior.Restrict);

            e.HasOne(p => p.Cliente).WithMany()
                .HasForeignKey(p => p.ClienteId)
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

        // CU-17: tabla creada con Database/cambios_02_cancelacion_cliente.sql
        modelBuilder.Entity<SolicitudCancelacion>(e =>
        {
            e.ToTable("SolicitudCancelacion");
            e.Property(s => s.Motivo).HasMaxLength(250);
            e.HasIndex(s => s.PedidoId).IsUnique();
            e.HasOne(s => s.Pedido).WithMany()
                .HasForeignKey(s => s.PedidoId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        // CU-16: novedades que reporta el repartidor (la tabla ya existe en la base de datos)
        modelBuilder.Entity<NovedadPedido>(e =>
        {
            e.ToTable("NovedadPedido");
            e.Property(n => n.Observaciones).HasMaxLength(500);
            e.Property(n => n.Fecha).HasColumnType("datetime2(0)");
            e.HasIndex(n => n.PedidoId);
            e.HasOne(n => n.Pedido).WithMany()
                .HasForeignKey(n => n.PedidoId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<UbicacionPedido>(e =>
        {
            e.ToTable("UbicacionPedido");
            e.HasKey(u => u.PedidoId);
            e.Property(u => u.PedidoId).ValueGeneratedNever();
            e.Property(u => u.Latitud).HasPrecision(9, 6);
            e.Property(u => u.Longitud).HasPrecision(9, 6);
            e.Property(u => u.FechaActualizacion).HasColumnType("datetime2(0)");

            e.HasOne(u => u.Pedido)
                .WithOne()
                .HasForeignKey<UbicacionPedido>(u => u.PedidoId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }
}