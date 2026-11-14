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
}