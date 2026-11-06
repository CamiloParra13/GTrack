public interface ICodigoVerificacionRepository
{
    Task AgregarAsync(CodigoVerificacion codigo);
    Task<CodigoVerificacion?> ObtenerUltimoAsync(int usuarioId);
    Task ActualizarAsync(CodigoVerificacion codigo);
}
