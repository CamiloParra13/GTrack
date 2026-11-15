public class RepartidorRepositoryFalso : IRepartidorRepository
{
    public List<Repartidor> Repartidores { get; } = new();
    public HashSet<string> TelefonosEnUso { get; } = new();
    public bool SeLlamoRegistrar { get; private set; }
    public Usuario? UsuarioRegistrado { get; private set; }

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
}