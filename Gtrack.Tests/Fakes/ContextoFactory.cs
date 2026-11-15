using Microsoft.EntityFrameworkCore;

public class AppDbContextQueFallaAlGuardar(DbContextOptions<AppDbContext> options) : AppDbContext(options)
{
    public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default) =>
        throw new InvalidOperationException("Fallo simulado al guardar");
}

public static class ContextoFactory
{
    private static DbContextOptions<AppDbContext> Opciones() =>
        new DbContextOptionsBuilder<AppDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;

    public static AppDbContext Crear() => new(Opciones());

    public static AppDbContext CrearQueFallaAlGuardar() => new AppDbContextQueFallaAlGuardar(Opciones());
}