using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllersWithViews();

builder.Services.AddSingleton<RepositorioEnMemoria>();
builder.Services.AddSingleton<IUsuarioRepository>(sp => sp.GetRequiredService<RepositorioEnMemoria>());
builder.Services.AddSingleton<ITokenRecuperacionRepository>(sp => sp.GetRequiredService<RepositorioEnMemoria>());
builder.Services.AddSingleton<INegocioRepository>(sp => sp.GetRequiredService<RepositorioEnMemoria>());
builder.Services.AddSingleton<ICodigoVerificacionRepository>(sp => sp.GetRequiredService<RepositorioEnMemoria>());
builder.Services.AddSingleton<IRepartidorRepository>(sp => sp.GetRequiredService<RepositorioEnMemoria>());
builder.Services.AddSingleton<IAdministracionRepository>(sp => sp.GetRequiredService<RepositorioEnMemoria>());

builder.Services.AddScoped<IPasswordHasher<Usuario>, PasswordHasher<Usuario>>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IRecuperacionService, RecuperacionService>();
builder.Services.AddScoped<INegocioService, NegocioService>();
builder.Services.AddScoped<IRepartidorService, RepartidorService>();
builder.Services.AddScoped<IAdministracionService, AdministracionService>();
builder.Services.AddScoped<IEmailService, EmailDesarrolloService>();

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