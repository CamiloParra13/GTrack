public interface IExportadorReportes
{
    byte[] ReporteNegocioExcel(ReporteNegocioDto r);
    byte[] ReporteNegocioPdf(ReporteNegocioDto r);

    byte[] HistorialExcel(HistorialExportDto h);
    byte[] HistorialCsv(HistorialExportDto h);
    byte[] HistorialPdf(HistorialExportDto h);

    byte[] ReporteAdminExcel(ReporteAdminDto r);
    byte[] ReporteAdminPdf(ReporteAdminDto r);
}
