public class CodigoVerificacionRepositoryFalso : ICodigoVerificacionRepository
{
    public List<CodigoVerificacion> Codigos { get; } = new();

    public Task AgregarAsync(CodigoVerificacion codigo)
    {
        Codigos.Add(codigo);
        return Task.CompletedTask;
    }

    public Task<CodigoVerificacion?> ObtenerUltimoAsync(int usuarioId) =>
        Task.FromResult(Codigos.Where(c => c.UsuarioId == usuarioId)
            .OrderByDescending(c => c.FechaCreacion)
            .ThenByDescending(c => c.Id)
            .FirstOrDefault());

    public Task ActualizarAsync(CodigoVerificacion codigo) => Task.CompletedTask;
}