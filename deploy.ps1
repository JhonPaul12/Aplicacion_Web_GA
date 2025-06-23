param(
    [string]$publishFolder = ".\publish",
    [string]$iisFolder = "C:\inetpub\wwwroot\MiApp"
)

# Nombre del AppPool (cámbialo si usas otro)
$appPoolName = "DefaultAppPool"

Write-Host "Importando módulo de IIS..."
Import-Module WebAdministration

Write-Host "Deteniendo AppPool '$appPoolName'..."
Stop-WebAppPool -Name $appPoolName

Write-Host "Copiando archivos a $iisFolder..."
Copy-Item -Path "$publishFolder\*" -Destination $iisFolder -Recurse -Force

Write-Host "Iniciando AppPool '$appPoolName'..."
Start-WebAppPool -Name $appPoolName

Write-Host "Despliegue completo."
