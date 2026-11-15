# GTrack

Aplicación web para la gestión y el seguimiento de pedidos a domicilio. Conecta a **negocios**, **repartidores** y **administradores** en una sola plataforma: el negocio registra pedidos, el repartidor los entrega y comparte su ubicación, y el administrador supervisa las cuentas y los reportes.

Proyecto académico desarrollado para el curso de Ingeniería de Software I, Universidad de Cundinamarca.

## Funcionalidades

| Rol | Qué puede hacer |
|---|---|
| **Negocio** | Registrarse con verificación por correo, administrar su perfil (con página pública), registrar pedidos, consultar pedidos activos e historial, y generar reportes en Excel, PDF y CSV. |
| **Repartidor** | Registrarse con verificación por correo, administrar su perfil, ver sus pedidos asignados, actualizar el estado de la entrega y compartir su ubicación. |
| **Administrador** | Validar, suspender o rechazar cuentas, registrar otros administradores y consultar reportes generales. |
| **Cliente** | Consultar el estado y la ubicación de su pedido con el código de seguimiento. |

Otras características:

- Seguimiento en mapa de la ubicación del repartidor (Leaflet y OpenStreetMap).
- Siete estados de pedido: Recibido, En preparación, Listo para entrega, Asignado, En camino, Entregado y Cancelado.
- Activación de cuenta y recuperación de contraseña por correo electrónico.
- Contraseñas cifradas con **bcrypt** (factor de trabajo 12). Las cuentas con el hash anterior (PBKDF2) se migran automáticamente en su siguiente inicio de sesión.
- Sesión por cookie `HttpOnly` con caducidad de 30 minutos de inactividad y protección contra CSRF.

## Tecnologías

- **Backend:** C# y ASP.NET Core MVC (.NET 10)
- **Datos:** Entity Framework Core con SQL Server
- **Frontend:** Razor, HTML, CSS, JavaScript y Bootstrap
- **Reportes:** ClosedXML (Excel) y QuestPDF (PDF)
- **Pruebas:** xUnit, NSubstitute y EF Core InMemory
- **Calidad:** SonarQube Cloud

## Requisitos previos

- [.NET SDK 10](https://dotnet.microsoft.com/download)
- SQL Server (Express o superior)
- Una cuenta de correo con acceso SMTP (por ejemplo, Gmail con contraseña de aplicación)

## Instalación y ejecución

1. Clona el repositorio:

   ```bash
   git clone https://github.com/CamiloParra13/GTrack.git
   cd GTrack
   ```

2. Crea la base de datos `gTrack` en SQL Server con el script de creación de tablas del proyecto.

3. Revisa la cadena de conexión `GtrackDb` en `appsettings.json`. Por defecto usa autenticación de Windows en `localhost`:

   ```json
   "ConnectionStrings": {
     "GtrackDb": "Server=localhost;Database=gTrack;Trusted_Connection=True;TrustServerCertificate=True;"
   }
   ```

4. Configura el correo con *user secrets*, para no guardar credenciales en el repositorio:

   ```bash
   dotnet user-secrets set "Email:User" "tu_correo@gmail.com"
   dotnet user-secrets set "Email:Password" "tu_contraseña_de_aplicación"
   ```

   Parámetros opcionales: `Email:Host` (por defecto `smtp.gmail.com`), `Email:Port` (por defecto `587`), `Email:From` y `Email:NombreRemitente`.

5. Ejecuta la aplicación:

   ```bash
   dotnet restore
   dotnet run
   ```

   La aplicación queda disponible en `https://localhost:7172` (o `http://localhost:5097`).

## Pruebas

```bash
dotnet test Gtrack.slnx
```

El proyecto incluye más de 370 pruebas unitarias sobre controladores, servicios y utilidades.

Para ejecutar el análisis de calidad con cobertura en SonarQube Cloud, usa el script incluido (pide el token al ejecutarse y no lo guarda):

```powershell
powershell -ExecutionPolicy Bypass -File .\analizar_sonar.ps1
```

## Estructura del proyecto

```
GTrack/
├── Controllers/     # Controladores MVC por rol y módulo
├── Models/          # Entidades del dominio
├── Dtos/            # Objetos de transferencia y validaciones
├── Services/        # Lógica de negocio, correo y reportes
├── Repositories/    # Acceso a datos con EF Core
├── Data/            # DbContext
├── Utilities/       # Cifrado, validadores y helpers
├── Views/           # Vistas Razor
├── wwwroot/         # Archivos estáticos (CSS, JS, imágenes)
└── Gtrack.Tests/    # Pruebas unitarias
```

## Autores

- Wilmar Valbuena
- Camilo Parra
- Alexander Penagos
