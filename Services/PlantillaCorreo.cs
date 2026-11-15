using System.Net;
using System.Text;

namespace Gtrack;

// Correo listo para enviar: versión HTML (con la marca de GTrack) y versión de texto plano
// para los clientes de correo que no muestran HTML.
public record CorreoHtml(string Html, string Texto);

// Color del recuadro de nota que va al final del correo
public enum TipoNota { Info, Aviso, Exito }

// Plantilla de todos los correos de GTrack, con los mismos colores y estilos de la página (site.css):
//   azul #1f5eff (--gt-blue) · azul oscuro #1748c9 · fondo #f5f7fb (--gt-bg) · texto del logo #0f1b3d
// Los correos se arman con tablas y estilos en línea porque Gmail y Outlook ignoran el CSS externo.
// El logo va incrustado en el mensaje (cid:logo-gtrack), así se ve aunque la página no esté publicada.
public static class PlantillaCorreo
{
    public const string ContentIdLogo = "logo-gtrack";

    private const string Fuente = "-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,'Helvetica Neue',Arial,sans-serif";

    // Arma el correo completo. En los párrafos, el texto entre **dos asteriscos** se muestra en negrita.
    public static CorreoHtml Crear(
        string titulo,
        string saludo,
        IEnumerable<string> parrafos,
        string? etiqueta = null,
        IEnumerable<(string Etiqueta, string Valor)>? datos = null,
        string? codigo = null,
        string? textoBoton = null,
        string? urlBoton = null,
        string? nota = null,
        TipoNota tipoNota = TipoNota.Info,
        string? resumen = null)
    {
        var listaParrafos = parrafos.Where(p => !string.IsNullOrWhiteSpace(p)).ToList();
        var filas = datos?.Where(d => !string.IsNullOrWhiteSpace(d.Valor)).ToList() ?? [];
        var hayBoton = !string.IsNullOrWhiteSpace(textoBoton) && !string.IsNullOrWhiteSpace(urlBoton);

        // Texto que los buzones muestran junto al asunto
        var vistaPrevia = resumen ?? (listaParrafos.Count > 0 ? SinFormato(listaParrafos[0]) : titulo);
        if (vistaPrevia.Length > 140) vistaPrevia = vistaPrevia[..139] + "…";

        var html = new StringBuilder();
        if (!string.IsNullOrWhiteSpace(etiqueta)) html.Append(Bloque(BloqueEtiqueta, ("TEXTO", E(etiqueta))));
        html.Append(Bloque(BloqueTitulo, ("TEXTO", E(titulo))));
        html.Append(Bloque(BloqueSaludo, ("TEXTO", E(saludo))));
        foreach (var p in listaParrafos) html.Append(Bloque(BloqueParrafo, ("TEXTO", ConFormato(p))));

        if (filas.Count > 0)
        {
            var contenidoFilas = new StringBuilder();
            for (var i = 0; i < filas.Count; i++)
            {
                if (i > 0) contenidoFilas.Append(BloqueSeparadorDato);
                contenidoFilas.Append(Bloque(BloqueFilaDato, ("ETIQUETA", E(filas[i].Etiqueta)), ("VALOR", E(filas[i].Valor))));
            }
            html.Append(Bloque(BloqueDatos, ("FILAS", contenidoFilas.ToString())));
        }

        if (!string.IsNullOrWhiteSpace(codigo)) html.Append(Bloque(BloqueCodigo, ("CODIGO", E(codigo))));

        if (hayBoton)
        {
            html.Append(Bloque(BloqueBoton, ("URL", E(urlBoton)), ("TEXTO", E(textoBoton))));
            html.Append(Bloque(BloqueEnlaceAlternativo, ("URL", E(urlBoton))));
        }

        if (!string.IsNullOrWhiteSpace(nota))
        {
            var (fondo, acento, color) = tipoNota switch
            {
                TipoNota.Aviso => ("#fff8e6", "#f59f00", "#7a5200"),
                TipoNota.Exito => ("#e9f6ef", "#198754", "#146c43"),
                _ => ("#eef2ff", "#1f5eff", "#24345e")
            };
            html.Append(Bloque(BloqueNota, ("FONDO", fondo), ("ACENTO", acento), ("COLOR", color), ("TEXTO", ConFormato(nota))));
        }

        var documento = Bloque(Diseno,
            ("FUENTE", Fuente),
            ("TITULO", E(titulo)),
            ("PREHEADER", E(vistaPrevia)),
            ("LOGO", ContentIdLogo),
            ("ANIO", DateTime.UtcNow.Year.ToString()),
            ("CONTENIDO", html.ToString()));

        return new CorreoHtml(
            documento,
            ConstruirTexto(titulo, saludo, listaParrafos, etiqueta, filas, codigo,
                hayBoton ? textoBoton : null, hayBoton ? urlBoton : null, nota));
    }

    // Para los correos que todavía se envían como texto: cada línea se vuelve un párrafo de la plantilla
    public static CorreoHtml DesdeTexto(string asunto, string texto)
    {
        var parrafos = texto.Replace("\r\n", "\n")
            .Split('\n', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);
        return Crear(titulo: asunto, saludo: "Hola,", parrafos: parrafos);
    }

    // ---------------------------------------------------------------- utilidades

    // Codifica el texto para HTML. Las llaves también se codifican para que un dato escrito por
    // un usuario nunca se confunda con un marcador {{...}} de la plantilla.
    private static string E(string? s) =>
        WebUtility.HtmlEncode(s ?? "").Replace("{", "&#123;").Replace("}", "&#125;");

    private static string ConFormato(string texto) =>
        Patrones.Negrita().Replace(E(texto), "<strong style=\"color:#0f1b3d;font-weight:700;\">$1</strong>");

    private static string SinFormato(string texto) => texto.Replace("**", "");

    private static string Bloque(string plantilla, params (string Clave, string Valor)[] valores)
    {
        var resultado = plantilla;
        foreach (var (clave, valor) in valores)
            resultado = resultado.Replace("{{" + clave + "}}", valor);
        return resultado;
    }

    private static string ConstruirTexto(string titulo, string saludo, List<string> parrafos, string? etiqueta,
        List<(string Etiqueta, string Valor)> datos, string? codigo, string? textoBoton, string? urlBoton, string? nota)
    {
        var t = new StringBuilder();
        t.AppendLine("GTrack · Gestión y seguimiento de pedidos");
        t.AppendLine(new string('=', 44)).AppendLine();
        if (!string.IsNullOrWhiteSpace(etiqueta)) t.AppendLine(etiqueta.ToUpperInvariant());
        t.AppendLine(titulo).AppendLine();
        t.AppendLine(saludo).AppendLine();
        foreach (var p in parrafos) t.AppendLine(SinFormato(p)).AppendLine();

        foreach (var (e, v) in datos) t.AppendLine($"  - {e}: {v}");
        if (datos.Count > 0) t.AppendLine();

        if (!string.IsNullOrWhiteSpace(codigo)) t.AppendLine($"Tu código: {codigo}").AppendLine();
        if (textoBoton is not null && urlBoton is not null) t.AppendLine($"{textoBoton}: {urlBoton}").AppendLine();
        if (!string.IsNullOrWhiteSpace(nota)) t.AppendLine(SinFormato(nota)).AppendLine();

        t.AppendLine("--");
        t.AppendLine("Este mensaje fue enviado automáticamente por GTrack. Por favor, no respondas a este correo.");
        return t.ToString();
    }

    // ---------------------------------------------------------------- bloques HTML
    // Marcadores: {{NOMBRE}}. Se reemplazan en Bloque(); los valores escritos por usuarios pasan antes por E().

    private const string Diseno = """
        <!DOCTYPE html>
        <html lang="es" xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">
        <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="x-apple-disable-message-reformatting">
        <meta name="format-detection" content="telephone=no, date=no, address=no, email=no">
        <meta name="color-scheme" content="light">
        <meta name="supported-color-schemes" content="light">
        <title>{{TITULO}}</title>
        <!--[if mso]>
        <noscript><xml><o:OfficeDocumentSettings><o:PixelsPerInch>96</o:PixelsPerInch></o:OfficeDocumentSettings></xml></noscript>
        <style>table, td, p, a, span, h1, div { font-family: 'Segoe UI', Arial, sans-serif !important; }</style>
        <![endif]-->
        <style>
          body { margin: 0; padding: 0; width: 100% !important; background-color: #f5f7fb; }
          a { color: #1f5eff; }
          @media only screen and (max-width: 620px) {
            .gt-exterior { padding: 16px 8px !important; }
            .gt-pad { padding-left: 22px !important; padding-right: 22px !important; }
            .gt-titulo { font-size: 22px !important; }
            .gt-dato-etiqueta, .gt-dato-valor { display: block !important; width: auto !important; }
            .gt-dato-etiqueta { padding-bottom: 0 !important; }
            .gt-dato-valor { padding-top: 3px !important; }
          }
        </style>
        </head>
        <body style="margin:0;padding:0;background-color:#f5f7fb;">
        <div style="display:none;font-size:1px;line-height:1px;max-height:0;max-width:0;opacity:0;overflow:hidden;mso-hide:all;">{{PREHEADER}}&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;&#847;&zwnj;&nbsp;</div>
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#f5f7fb" style="background-color:#f5f7fb;">
          <tr>
            <td align="center" class="gt-exterior" style="padding:32px 12px;">
              <!--[if mso]><table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" align="center"><tr><td><![endif]-->
              <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="max-width:600px;">
                <tr>
                  <td bgcolor="#ffffff" style="background-color:#ffffff;border:1px solid #e5e9f2;border-top:5px solid #1f5eff;border-radius:16px;">
                    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                      <tr>
                        <td class="gt-pad" style="padding:22px 32px 20px;border-bottom:1px solid #eef1f6;">
                          <table role="presentation" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                              <td valign="middle" style="padding-right:12px;">
                                <img src="cid:{{LOGO}}" width="42" height="43" alt="GTrack" style="display:block;width:42px;height:43px;border:0;outline:none;text-decoration:none;">
                              </td>
                              <td valign="middle" style="font-family:{{FUENTE}};">
                                <div style="font-size:22px;line-height:26px;font-weight:700;color:#0f1b3d;">GTrack</div>
                                <div style="font-size:12px;line-height:17px;color:#6b7488;">Gestión y seguimiento de pedidos</div>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
                        <td class="gt-pad" style="padding:32px 32px 10px;font-family:{{FUENTE}};">
        {{CONTENIDO}}
                        </td>
                      </tr>
                      <tr>
                        <td class="gt-pad" style="padding:6px 32px 28px;font-family:{{FUENTE}};">
                          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                              <td style="border-top:1px solid #eef1f6;padding-top:18px;font-size:12px;line-height:19px;color:#6b7488;">
                                Este mensaje fue enviado automáticamente por <strong style="color:#1f5eff;">GTrack</strong>. Por favor, no respondas a este correo.<br>
                                Si no esperabas este mensaje, puedes ignorarlo con tranquilidad.
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td align="center" style="padding:18px 12px 0;font-family:{{FUENTE}};font-size:12px;line-height:18px;color:#9aa3b5;">
                    &copy; {{ANIO}} GTrack &middot; Gestión y seguimiento de pedidos
                  </td>
                </tr>
              </table>
              <!--[if mso]></td></tr></table><![endif]-->
            </td>
          </tr>
        </table>
        </body>
        </html>
        """;

    private const string BloqueEtiqueta = """
        <p style="margin:0 0 10px;font-size:12px;line-height:16px;font-weight:700;letter-spacing:1.4px;text-transform:uppercase;color:#1f5eff;">{{TEXTO}}</p>

        """;

    private const string BloqueTitulo = """
        <h1 class="gt-titulo" style="margin:0 0 18px;font-size:26px;line-height:1.25;font-weight:700;color:#0f1b3d;">{{TEXTO}}</h1>

        """;

    private const string BloqueSaludo = """
        <p style="margin:0 0 12px;font-size:16px;line-height:1.6;font-weight:600;color:#0f1b3d;">{{TEXTO}}</p>

        """;

    private const string BloqueParrafo = """
        <p style="margin:0 0 16px;font-size:15px;line-height:1.65;color:#4a5468;">{{TEXTO}}</p>

        """;

    private const string BloqueDatos = """
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" bgcolor="#f5f7fb" style="margin:6px 0 22px;background-color:#f5f7fb;border:1px solid #e5e9f2;border-radius:12px;">
        {{FILAS}}</table>

        """;

    private const string BloqueFilaDato = """
          <tr>
            <td class="gt-dato-etiqueta" width="38%" valign="top" style="padding:13px 18px;font-size:13px;line-height:20px;color:#6b7488;">{{ETIQUETA}}</td>
            <td class="gt-dato-valor" valign="top" style="padding:13px 18px;font-size:15px;line-height:20px;font-weight:600;color:#0f1b3d;word-break:break-word;">{{VALOR}}</td>
          </tr>

        """;

    private const string BloqueSeparadorDato = """
          <tr><td colspan="2" style="padding:0 18px;"><div style="height:1px;line-height:1px;font-size:1px;background-color:#e5e9f2;">&nbsp;</div></td></tr>

        """;

    private const string BloqueCodigo = """
        <table role="presentation" align="center" cellpadding="0" cellspacing="0" border="0" style="margin:8px auto 24px;">
          <tr>
            <td align="center" bgcolor="#eef2ff" style="background-color:#eef2ff;border:2px dashed #1f5eff;border-radius:14px;padding:16px 30px 16px 40px;font-family:Consolas,'SFMono-Regular',Menlo,'Courier New',monospace;font-size:34px;line-height:40px;font-weight:700;letter-spacing:10px;color:#1748c9;">{{CODIGO}}</td>
          </tr>
        </table>

        """;

    private const string BloqueBoton = """
        <table role="presentation" align="center" cellpadding="0" cellspacing="0" border="0" style="margin:26px auto 6px;">
          <tr>
            <td align="center" bgcolor="#1f5eff" style="background-color:#1f5eff;border-radius:999px;">
              <!--[if mso]>
              <v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" href="{{URL}}" style="height:50px;v-text-anchor:middle;width:280px;" arcsize="50%" stroke="f" fillcolor="#1f5eff">
                <w:anchorlock/>
                <center style="color:#ffffff;font-family:'Segoe UI',Arial,sans-serif;font-size:16px;font-weight:bold;">{{TEXTO}}</center>
              </v:roundrect>
              <![endif]-->
              <!--[if !mso]><!-->
              <a href="{{URL}}" target="_blank" rel="noopener" style="display:inline-block;padding:15px 36px;font-size:16px;line-height:20px;font-weight:700;color:#ffffff;text-decoration:none;border-radius:999px;background-color:#1f5eff;">{{TEXTO}}&nbsp;&rarr;</a>
              <!--<![endif]-->
            </td>
          </tr>
        </table>

        """;

    private const string BloqueEnlaceAlternativo = """
        <p style="margin:14px 0 22px;font-size:12px;line-height:1.6;color:#6b7488;text-align:center;">¿El botón no funciona? Copia y pega este enlace en tu navegador:<br><a href="{{URL}}" target="_blank" rel="noopener" style="color:#1f5eff;text-decoration:underline;word-break:break-all;">{{URL}}</a></p>

        """;

    private const string BloqueNota = """
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:6px 0 18px;">
          <tr>
            <td bgcolor="{{FONDO}}" style="background-color:{{FONDO}};border-left:4px solid {{ACENTO}};border-radius:10px;padding:14px 16px;font-size:14px;line-height:1.55;color:{{COLOR}};">{{TEXTO}}</td>
          </tr>
        </table>

        """;
}
