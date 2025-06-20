param(
    [string]$publishFolder = ".\publish",
    [string]$iisFolder = "C:\inetpub\wwwroot\MiApp"
)

Write-Host "Copiando archivos..."
Copy-Item -Path "$publishFolder\*" -Destination $iisFolder -Recurse -Force

Write-Host "Reiniciando AppPool..."
Import-Module WebAdministration
Restart-WebAppPool -Name "DefaultAppPool"

Write-Host "Despliegue completo."
