using Microsoft.EntityFrameworkCore;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<Usuario> Usuarios => Set<Usuario>();
    public DbSet<TokenRecuperacion> TokensRecuperacion => Set<TokenRecuperacion>();

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
    }
}