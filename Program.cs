using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

builder.Services.AddDbContext<AppDbContext>(o =>
    o.UseSqlServer(builder.Configuration.GetConnectionString("GtrackDb")));

builder.Services.AddScoped<IUsuarioRepository, UsuarioRepository>();
builder.Services.AddScoped<ITokenRecuperacionRepository, TokenRecuperacionRepository>();
builder.Services.AddScoped<INegocioRepository, NegocioRepository>();
builder.Services.AddScoped<ICodigoVerificacionRepository, CodigoVerificacionRepository>();
builder.Services.AddScoped<IRepartidorRepository, RepartidorRepository>();
builder.Services.AddScoped<IAdministracionRepository, AdministracionRepository>();
builder.Services.AddScoped<IPedidoRepository, PedidoRepository>();
builder.Services.AddScoped<INotificacionRepository, NotificacionRepository>();

builder.Services.AddScoped<IPasswordHasher<Usuario>, PasswordHasher<Usuario>>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IRecuperacionService, RecuperacionService>();
builder.Services.AddScoped<INegocioService, NegocioService>();
builder.Services.AddScoped<IRepartidorService, RepartidorService>();
builder.Services.AddScoped<IAdministracionService, AdministracionService>();
builder.Services.AddScoped<IPedidoService, PedidoService>();
builder.Services.AddScoped<INotificacionService, NotificacionService>();

builder.Services.Configure<EmailOptions>(builder.Configuration.GetSection("Email"));
var passwordCorreo = builder.Configuration["Email:Password"];
if (string.IsNullOrWhiteSpace(passwordCorreo))
    builder.Services.AddScoped<IEmailService, EmailDesarrolloService>();
else
    builder.Services.AddScoped<IEmailService, EmailSmtpService>();

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(o =>
    {
        o.LoginPath = "/Usuario/Login";
        o.AccessDeniedPath = "/Usuario/Login";
    });

var app = builder.Build();

if (string.IsNullOrWhiteSpace(passwordCorreo))
    app.Logger.LogWarning("CORREO EN MODO DESARROLLO: los correos NO se envían, solo se escriben en la consola. Configura Email:Password para enviarlos por Gmail.");
else
    app.Logger.LogInformation("CORREO ACTIVO: se enviará por {Host} desde {Usuario}",
        builder.Configuration["Email:Host"], builder.Configuration["Email:Usuario"]);

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
