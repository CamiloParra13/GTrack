using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Licencia Community de QuestPDF (gratuita para proyectos académicos y organizaciones pequeñas)
QuestPDF.Settings.License = QuestPDF.Infrastructure.LicenseType.Community;

builder.Services.AddControllersWithViews(o => o.ModelBinderProviders.Insert(0, new InvariantDecimalModelBinderProvider())); // decimales siempre con punto (coordenadas, precios)
builder.Services.AddAntiforgery(o => o.HeaderName = "RequestVerificationToken");

// Conexión a SQL Server (cadena "GtrackDb" en appsettings.json)
builder.Services.AddDbContext<AppDbContext>(o =>
    o.UseSqlServer(builder.Configuration.GetConnectionString("GtrackDb")));

builder.Services.AddScoped<IUsuarioRepository, UsuarioRepository>();
builder.Services.AddScoped<ITokenRecuperacionRepository, TokenRecuperacionRepository>();
builder.Services.AddScoped<INegocioRepository, NegocioRepository>();
builder.Services.AddScoped<ICodigoVerificacionRepository, CodigoVerificacionRepository>();
builder.Services.AddScoped<IRepartidorRepository, RepartidorRepository>();
builder.Services.AddScoped<IAdministracionRepository, AdministracionRepository>();
builder.Services.AddScoped<IPedidoRepository, PedidoRepository>();
builder.Services.AddScoped<IUbicacionRepository, UbicacionRepository>();

// RNF-01: contraseñas cifradas con bcrypt (ver Utilities/BCryptPasswordHasher.cs)
builder.Services.AddScoped<IPasswordHasher<Usuario>, BCryptPasswordHasher>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IRecuperacionService, RecuperacionService>();
builder.Services.AddScoped<INegocioService, NegocioService>();
builder.Services.AddScoped<IActivacionCuentaService, ActivacionCuentaService>();
builder.Services.AddScoped<IRepartidorService, RepartidorService>();
builder.Services.AddScoped<IPerfilRepartidorService, PerfilRepartidorService>(); // CU-12 y CU-14
builder.Services.AddScoped<IAdministracionService, AdministracionService>();
builder.Services.AddScoped<IEmailService, EmailSmtpService>();
builder.Services.AddScoped<IPedidoService, PedidoService>();
builder.Services.AddScoped<IUbicacionService, UbicacionService>();
builder.Services.AddScoped<IReporteService, ReporteService>();
builder.Services.AddSingleton<IExportadorReportes, ExportadorReportes>();

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(o =>
    {
        o.LoginPath = "/Usuario/Login";
        o.AccessDeniedPath = "/Usuario/Login";

        // La sesión caduca tras 30 minutos sin actividad
        o.ExpireTimeSpan = TimeSpan.FromMinutes(30);
        o.SlidingExpiration = true;
        o.Cookie.HttpOnly = true;
        o.Cookie.SecurePolicy = CookieSecurePolicy.SameAsRequest;
    });

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

// Páginas de error con la marca de GTrack (404, 403, etc.)
app.UseStatusCodePagesWithReExecute("/Home/StatusCode", "?code={0}");

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

// CU-01 paso 1: la URL principal muestra la página de inicio con los dos botones
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();