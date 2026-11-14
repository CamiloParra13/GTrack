public class NegocioRepositoryFalso : INegocioRepository
{
    public List<Negocio> Negocios { get; } = new();
    public HashSet<string> DocumentosExistentes { get; } = new();
    public HashSet<string> TelefonosExistentes { get; } = new();
    public bool TienePedidosActivos { get; set; }
    public bool TieneRepartidoresVinculados { get; set; }
    public bool SeLlamoActualizar { get; private set; }
    public bool SeLlamoRegistrar { get; private set; }

    public Task<Negocio?> BuscarPorIdAsync(int id) =>
        Task.FromResult(Negocios.FirstOrDefault(n => n.Id == id));

    public Task<Negocio?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(Negocios.FirstOrDefault(n => n.UsuarioId == usuarioId));

    public Task<bool> ExisteDocumentoAsync(string documento) =>
        Task.FromResult(DocumentosExistentes.Contains(documento));

    public Task<bool> ExisteTelefonoAsync(string telefono, int? excluirNegocioId = null) =>
        Task.FromResult(TelefonosExistentes.Contains(telefono));

    public Task RegistrarAsync(Usuario usuario, Negocio negocio)
    {
        SeLlamoRegistrar = true;
        negocio.Usuario = usuario;
        Negocios.Add(negocio);
        return Task.CompletedTask;
    }

    public Task ActualizarAsync(Negocio negocio)
    {
        SeLlamoActualizar = true;
        return Task.CompletedTask;
    }

    public Task<bool> TienePedidosActivosAsync(int negocioId) => Task.FromResult(TienePedidosActivos);

    public Task<bool> TieneRepartidoresVinculadosAsync(int negocioId) => Task.FromResult(TieneRepartidoresVinculados);
}