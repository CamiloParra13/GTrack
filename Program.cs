using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

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

builder.Services.AddScoped<IPasswordHasher<Usuario>, PasswordHasher<Usuario>>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IRecuperacionService, RecuperacionService>();
builder.Services.AddScoped<INegocioService, NegocioService>();
builder.Services.AddScoped<IRepartidorService, RepartidorService>();
builder.Services.AddScoped<IAdministracionService, AdministracionService>();
builder.Services.AddScoped<IEmailService, EmailDesarrolloService>();
builder.Services.AddScoped<IPedidoService, PedidoService>();

builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(o =>
    {
        o.LoginPath = "/Usuario/Login";
        o.AccessDeniedPath = "/Usuario/Login";
    });

var app = builder.Build();

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

// CU-01 paso 1: la URL principal muestra la página de inicio con los dos botones
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
