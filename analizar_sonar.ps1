# Análisis completo de GTrack en SonarCloud (con cobertura de pruebas).
#
# Uso: abrir PowerShell en la carpeta donde está Gtrack.slnx y ejecutar:
#   powershell -ExecutionPolicy Bypass -File .\analizar_sonar.ps1
#
# El token se pide al ejecutar el script; no se guarda en ningún archivo.
#
# Cobertura: no se cuentan las vistas Razor, Program.cs, los repositorios (consultan SQL Server real)
# ni el envío real de correos por SMTP. Es el mismo alcance definido en el documento de pruebas unitarias.

$ErrorActionPreference = "Stop"

$proyecto     = "CamiloParra13_GTrack"
$organizacion = "camiloparra13"   # cámbiala si tu organización tiene otro nombre

$tokenSeguro = Read-Host "Pega el token de SonarCloud" -AsSecureString
$token = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($tokenSeguro))

function Paso($texto) { Write-Host ""; Write-Host "==> $texto" -ForegroundColor Cyan }

Paso "Borrando resultados de pruebas anteriores"
Remove-Item -Recurse -Force "Gtrack.Tests\TestResults" -ErrorAction SilentlyContinue

Paso "Iniciando el análisis"
dotnet sonarscanner begin `
    /k:"$proyecto" `
    /o:"$organizacion" `
    /d:sonar.token="$token" `
    /d:sonar.host.url="https://sonarcloud.io" `
    /d:sonar.cs.opencover.reportsPaths="**/coverage.opencover.xml" `
    /d:sonar.exclusions="**/wwwroot/lib/**,**/appsettings.Production.json" `
    /d:sonar.coverage.exclusions="**/Views/**,**/Program.cs,**/Repositories/**,**/Services/EmailSmtpService.cs,**/wwwroot/**"
if ($LASTEXITCODE -ne 0) { throw "Falló el inicio del análisis (revisa el token y la organización)." }

Paso "Compilando"
dotnet build Gtrack.slnx --no-incremental
if ($LASTEXITCODE -ne 0) { throw "La compilación falló. Corrige los errores antes de analizar." }

Paso "Ejecutando pruebas con cobertura"
dotnet test Gtrack.slnx --no-build --collect:"XPlat Code Coverage" -- DataCollectionRunSettings.DataCollectors.DataCollector.Configuration.Format=opencover
if ($LASTEXITCODE -ne 0) { throw "Alguna prueba falló. Revisa el resultado de las pruebas." }

$cobertura = Get-ChildItem -Recurse -Filter coverage.opencover.xml -Path "Gtrack.Tests\TestResults" -ErrorAction SilentlyContinue
if (-not $cobertura) { throw "No se generó el archivo coverage.opencover.xml." }
Write-Host "Archivo de cobertura: $($cobertura[0].FullName)" -ForegroundColor Green

Paso "Enviando resultados a SonarCloud"
dotnet sonarscanner end /d:sonar.token="$token"
if ($LASTEXITCODE -ne 0) { throw "Falló el envío del análisis." }

Write-Host ""
Write-Host "Listo. Espera uno o dos minutos y recarga SonarCloud." -ForegroundColor Green
