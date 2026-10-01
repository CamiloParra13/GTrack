using Microsoft.EntityFrameworkCore;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Usuario> Usuarios => Set<Usuario>();
    public DbSet<TokenRecuperacion> TokensRecuperacion => Set<TokenRecuperacion>();
    public DbSet<Negocio> Negocios => Set<Negocio>();
    public DbSet<CodigoVerificacion> CodigosVerificacion => Set<CodigoVerificacion>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Usuario>(e =>
        {
            e.Property(u => u.Correo).HasMaxLength(150);
            e.Property(u => u.Documento).HasMaxLength(20);
            e.HasIndex(u => u.Correo).IsUnique();
            e.HasIndex(u => u.Documento).IsUnique();
        });

        modelBuilder.Entity<TokenRecuperacion>(e =>
        {
            e.Property(t => t.TokenHash).HasMaxLength(64);
            e.HasIndex(t => t.TokenHash).IsUnique();
        });

        modelBuilder.Entity<Negocio>(e =>
        {
            e.Property(n => n.Nombre).HasMaxLength(100);
            e.Property(n => n.TipoActividad).HasMaxLength(60);
            e.Property(n => n.Telefono).HasMaxLength(15);
            e.Property(n => n.Direccion).HasMaxLength(200);
            e.HasIndex(n => n.Telefono).IsUnique();
            e.HasOne(n => n.Usuario).WithOne()
                .HasForeignKey<Negocio>(n => n.UsuarioId)
                .OnDelete(DeleteBehavior.Restrict);
        });

        modelBuilder.Entity<CodigoVerificacion>(e =>
        {
            e.Property(c => c.CodigoHash).HasMaxLength(64);
            e.HasIndex(c => c.UsuarioId);
        });
    }
}
