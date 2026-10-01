public interface INegocioService
{
    // CU-01
    Task<(bool Ok, string? Error, bool CorreoEnviado)> RegistrarAsync(RegistroNegocioDto dto);

    // Perfil (CU-11 / CU-13) y perfil público (CU-25)
    Task<PerfilNegocioDto?> ObtenerPerfilAsync(int usuarioId);
    Task<PerfilPublicoNegocioDto?> ObtenerPerfilPublicoAsync(int negocioId);

    // CU-13
    Task<(bool Ok, string? Error)> SolicitarCodigoAsync(int usuarioId);
    Task<(bool Ok, string? Error)> VerificarCodigoAsync(int usuarioId, string codigo);
    Task<bool> EdicionAutorizadaAsync(int usuarioId);
    Task<EditarNegocioDto?> ObtenerParaEditarAsync(int usuarioId);
    Task<(bool Ok, string? Error)> EditarAsync(int usuarioId, EditarNegocioDto dto);

    // CU-11
    Task<(bool Ok, string? Error)> ValidarEliminacionAsync(int usuarioId, string password);
    Task<(bool Ok, string? Error)> EliminarCuentaAsync(int usuarioId, string password);
}
