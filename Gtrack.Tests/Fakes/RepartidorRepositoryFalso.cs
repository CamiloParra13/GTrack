namespace Gtrack.Tests;

public class RepartidorRepositoryFalso : IRepartidorRepository
{
    public List<Repartidor> Repartidores { get; } = new();
    public HashSet<string> TelefonosEnUso { get; } = new();
    public bool SeLlamoRegistrar { get; private set; }
    public Usuario? UsuarioRegistrado { get; private set; }
    public Repartidor? UltimoReactivado { get; private set; }

    public Task RegistrarRepartidorAsync(Usuario usuario, Repartidor repartidor)
    {
        SeLlamoRegistrar = true;
        UsuarioRegistrado = usuario;
        repartidor.Usuario = usuario;
        Repartidores.Add(repartidor);
        return Task.CompletedTask;
    }

    public Task<List<Repartidor>> ListarPorNegocioAsync(int negocioId) =>
        Task.FromResult(Repartidores.Where(r => r.NegocioId == negocioId).ToList());

    public Task<bool> TelefonoEnUsoAsync(string telefono) =>
        Task.FromResult(TelefonosEnUso.Contains(telefono));

    public Task<Repartidor?> ObtenerDeNegocioAsync(int negocioId, int repartidorId) =>
        Task.FromResult(Repartidores.FirstOrDefault(r => r.Id == repartidorId && r.NegocioId == negocioId));

    public Task<Repartidor?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(Repartidores.FirstOrDefault(r => r.UsuarioId == usuarioId));

    public Task<Repartidor?> BuscarEliminadoAsync(string correo, string documento) =>
        Task.FromResult(Repartidores
            .Where(r => r.Usuario is { Estado: EstadoCuenta.Eliminado } &&
                        (r.Usuario.Correo == correo || r.Usuario.Correo == $"eliminado.{r.UsuarioId}.{correo}" ||
                         r.Usuario.Documento == documento || r.Usuario.Documento == $"X{r.UsuarioId}-{documento}"))
            .OrderByDescending(r => r.Id)
            .FirstOrDefault());

    public Task ReactivarAsync(Repartidor repartidor)
    {
        UltimoReactivado = repartidor;
        return Task.CompletedTask;
    }
}