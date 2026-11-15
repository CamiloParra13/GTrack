namespace Gtrack.Tests;

public class AdministracionRepositoryFalso : IAdministracionRepository
{
    public List<Administrador> Administradores { get; } = new();
    public Usuario? UsuarioRegistrado { get; private set; }
    public HashSet<string> TelefonosEnUso { get; } = new();
    public List<NegocioAdminDto> Negocios { get; } = new();
    public List<AdministradorDto> AdministradoresListados { get; } = new();
    public bool ResultadoAprobar { get; set; } = true;
    public int? UltimoNegocioAprobado { get; private set; }

    public Task RegistrarAdministradorAsync(Usuario usuario, Administrador administrador)
    {
        UsuarioRegistrado = usuario;
        administrador.Usuario = usuario;
        Administradores.Add(administrador);
        return Task.CompletedTask;
    }

    public Task<List<AdministradorDto>> ListarAdministradoresAsync() => Task.FromResult(AdministradoresListados);

    public Task<List<NegocioAdminDto>> ListarNegociosAsync() => Task.FromResult(Negocios);

    public Task<bool> AprobarNegocioAsync(int negocioId)
    {
        UltimoNegocioAprobado = negocioId;
        return Task.FromResult(ResultadoAprobar);
    }

    public Task<bool> TelefonoEnUsoAsync(string telefono) => Task.FromResult(TelefonosEnUso.Contains(telefono));

    // Devuelve null si no hay coincidencia, como el real
    public Task<Administrador?> ObtenerPorUsuarioIdAsync(int usuarioId) =>
        Task.FromResult(Administradores.FirstOrDefault(a =>
            a.UsuarioId == usuarioId || a.Usuario?.Id == usuarioId));
}