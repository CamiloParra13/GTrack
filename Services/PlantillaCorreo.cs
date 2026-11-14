using System.Net;
using System.Text;

public record CorreoHtml(string Html, string Texto);

public static class PlantillaCorreo
{
    public const string ContentIdLogo = "logo-gtrack";

    private const string Azul = "#1f5eff";
    private const string AzulOscuro = "#1748c9";
    private const string Fuente = "font-family:'Segoe UI',Roboto,Helvetica,Arial,sans-serif;";

    public static CorreoHtml Crear(
        string titulo,
        string saludo,
        IEnumerable<string> parrafos,
        string? codigo = null,
        string? textoBoton = null,
        string? urlBoton = null,
        IEnumerable<(string Etiqueta, string Valor)>? datos = null,
        string? nota = null)
    {
        var listaParrafos = parrafos.ToList();
        var filas = datos?.ToList() ?? new List<(string Etiqueta, string Valor)>();
        var hayBoton = !string.IsNullOrWhiteSpace(textoBoton) && !string.IsNullOrWhiteSpace(urlBoton);
        var boton = hayBoton ? textoBoton : null;
        var url = hayBoton ? urlBoton : null;

        return new CorreoHtml(
            ConstruirHtml(titulo, saludo, listaParrafos, codigo, boton, url, filas, nota),
            ConstruirTexto(titulo, saludo, listaParrafos, codigo, boton, url, filas, nota));
    }

    public static CorreoHtml DesdeTexto(string asunto, string texto)
    {
        var parrafos = texto.Replace("\r\n", "\n")
            .Split('\n', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
        return Crear(titulo: asunto, saludo: "Hola,", parrafos: parrafos);
    }

    private static string E(string? s) => WebUtility.HtmlEncode(s ?? "");

    private static string ConstruirHtml(string titulo, string saludo, List<string> parrafos, string? codigo,
        string? textoBoton, string? urlBoton, List<(string Etiqueta, string Valor)> datos, string? nota)
    {
        var resumen = parrafos.Count > 0 ? parrafos[0] : titulo;
        if (resumen.Length > 110) resumen = resumen[..110] + "…";

        var h = new StringBuilder();
        h.Append("<!DOCTYPE html><html lang=\"es\"><head><meta charset=\"utf-8\">");
        h.Append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
        h.Append("<title>").Append(E(titulo)).Append("</title></head>");
        h.Append("<body style=\"margin:0;padding:0;background-color:#f5f7fb;\">");

        h.Append("<div style=\"display:none;max-height:0;overflow:hidden;opacity:0;color:transparent;\">")
         .Append(E(resumen)).Append("</div>");

        h.Append("<table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color:#f5f7fb;padding:24px 12px;\"><tr><td align=\"center\">");
        h.Append("<table role=\"presentation\" width=\"600\" cellpadding=\"0\" cellspacing=\"0\" style=\"width:100%;max-width:600px;\">");

        h.Append("<tr><td align=\"center\" style=\"background-color:#ffffff;border-top:6px solid ").Append(Azul)
         .Append(";border-radius:16px 16px 0 0;padding:26px 32px 6px;\">");
        h.Append("<img src=\"cid:").Append(ContentIdLogo)
         .Append("\" width=\"64\" height=\"65\" alt=\"\" style=\"display:block;margin:0 auto 6px;border:0;\">");
        h.Append("<div style=\"").Append(Fuente).Append("font-size:26px;font-weight:700;color:").Append(Azul)
         .Append(";letter-spacing:.5px;\">GTrack</div>");
        h.Append("<div style=\"").Append(Fuente).Append("font-size:13px;color:#6b7280;margin-top:2px;\">Gestión y seguimiento de pedidos</div>");
        h.Append("</td></tr>");

        h.Append("<tr><td style=\"background-color:#ffffff;padding:8px 32px 8px;").Append(Fuente).Append("color:#374151;\">");
        h.Append("<h1 style=\"margin:20px 0 8px;font-size:24px;line-height:1.3;color:#111827;font-weight:700;\">").Append(E(titulo)).Append("</h1>");
        h.Append("<p style=\"margin:0 0 16px;font-size:16px;line-height:1.6;color:#111827;font-weight:600;\">").Append(E(saludo)).Append("</p>");

        foreach (var p in parrafos)
            h.Append("<p style=\"margin:0 0 16px;font-size:16px;line-height:1.6;color:#374151;\">").Append(E(p)).Append("</p>");

        if (!string.IsNullOrWhiteSpace(codigo))
        {
            h.Append("<table role=\"presentation\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin:24px auto;\"><tr>");
            h.Append("<td align=\"center\" style=\"background-color:#eef3ff;border:2px dashed ").Append(Azul)
             .Append(";border-radius:12px;padding:16px 32px;font-family:Consolas,'Courier New',monospace;font-size:36px;font-weight:700;letter-spacing:10px;color:")
             .Append(AzulOscuro).Append(";\">").Append(E(codigo)).Append("</td></tr></table>");
        }

        if (datos.Count > 0)
        {
            h.Append("<table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin:8px 0 20px;background-color:#f5f7fb;border-radius:12px;\">");
            foreach (var (etiqueta, valor) in datos)
            {
                h.Append("<tr><td style=\"padding:12px 16px;").Append(Fuente)
                 .Append("font-size:13px;color:#6b7280;width:38%;border-bottom:1px solid #e5e7eb;\">").Append(E(etiqueta)).Append("</td>");
                h.Append("<td style=\"padding:12px 16px;").Append(Fuente)
                 .Append("font-size:15px;font-weight:600;color:#111827;border-bottom:1px solid #e5e7eb;word-break:break-all;\">").Append(E(valor)).Append("</td></tr>");
            }
            h.Append("</table>");
        }

        if (textoBoton is not null && urlBoton is not null)
        {
            h.Append("<table role=\"presentation\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin:24px auto 8px;\"><tr>");
            h.Append("<td align=\"center\" style=\"background-color:").Append(Azul).Append(";border-radius:10px;\">");
            h.Append("<a href=\"").Append(E(urlBoton)).Append("\" target=\"_blank\" style=\"display:inline-block;padding:14px 32px;")
             .Append(Fuente).Append("font-size:16px;font-weight:700;color:#ffffff;text-decoration:none;border-radius:10px;\">")
             .Append(E(textoBoton)).Append("</a></td></tr></table>");
            h.Append("<p style=\"margin:12px 0 16px;font-size:12px;line-height:1.5;color:#6b7280;text-align:center;\">")
             .Append("Si el botón no funciona, copia y pega este enlace en tu navegador:<br>")
             .Append("<a href=\"").Append(E(urlBoton)).Append("\" style=\"color:").Append(Azul).Append(";word-break:break-all;\">")
             .Append(E(urlBoton)).Append("</a></p>");
        }

        if (!string.IsNullOrWhiteSpace(nota))
        {
            h.Append("<div style=\"margin:16px 0 8px;padding:12px 16px;background-color:#fff8e6;border-left:4px solid #f5a623;border-radius:6px;font-size:14px;line-height:1.5;color:#7a5200;\">")
             .Append(E(nota)).Append("</div>");
        }
        h.Append("</td></tr>");

        h.Append("<tr><td style=\"background-color:#ffffff;border-radius:0 0 16px 16px;padding:16px 32px 28px;\">");
        h.Append("<div style=\"border-top:1px solid #e5e7eb;padding-top:16px;").Append(Fuente)
         .Append("font-size:12px;line-height:1.6;color:#6b7280;text-align:center;\">");
        h.Append("Este mensaje fue enviado automáticamente por <strong style=\"color:").Append(Azul).Append(";\">GTrack</strong>. ");
        h.Append("Por favor, no respondas a este correo.<br>Si no esperabas este mensaje, puedes ignorarlo con tranquilidad.");
        h.Append("</div></td></tr>");

        h.Append("<tr><td align=\"center\" style=\"padding:16px;").Append(Fuente).Append("font-size:12px;color:#9ca3af;\">")
         .Append("© ").Append(DateTime.UtcNow.Year).Append(" GTrack. Todos los derechos reservados.</td></tr>");

        h.Append("</table></td></tr></table></body></html>");
        return h.ToString();
    }

    private static string ConstruirTexto(string titulo, string saludo, List<string> parrafos, string? codigo,
        string? textoBoton, string? urlBoton, List<(string Etiqueta, string Valor)> datos, string? nota)
    {
        var t = new StringBuilder();
        t.AppendLine("GTrack").AppendLine(new string('=', 40)).AppendLine();
        t.AppendLine(titulo).AppendLine();
        t.AppendLine(saludo).AppendLine();
        foreach (var p in parrafos) t.AppendLine(p).AppendLine();

        if (!string.IsNullOrWhiteSpace(codigo)) t.AppendLine("Tu código: " + codigo).AppendLine();

        foreach (var (etiqueta, valor) in datos) t.AppendLine(etiqueta + ": " + valor);
        if (datos.Count > 0) t.AppendLine();

        if (textoBoton is not null && urlBoton is not null) t.AppendLine(textoBoton + ": " + urlBoton).AppendLine();
        if (!string.IsNullOrWhiteSpace(nota)) t.AppendLine(nota).AppendLine();

        t.AppendLine("--");
        t.AppendLine("Este mensaje fue enviado automáticamente por GTrack. Por favor, no respondas a este correo.");
        return t.ToString();
    }
}
