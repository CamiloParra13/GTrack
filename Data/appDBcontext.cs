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

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(AppDbContext).Assembly);
    }
}
