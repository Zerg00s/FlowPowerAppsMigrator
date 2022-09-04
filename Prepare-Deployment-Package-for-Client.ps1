param (
    [string]$Path
)
# Created by Denis Molodtsov (@Zerg00s) in 2018

$ErrorActionPreference = "Stop"

$host.UI.RawUI.WindowTitle = "Flow & Power Apps Migrator"

Write-host
Write-host
Write-Host "       ______ _                          _____                            " -ForegroundColor Yellow
Write-Host "      |  ____| |                 ___    |  __ \                           " -ForegroundColor Yellow
Write-Host "      | |__  | | _____      __  ( _ )   | |__) |____      _____ _ __      " -ForegroundColor Yellow
Write-Host "      |  __| | |/ _ \ \ /\ / /  / _ \/\ |  ___/ _ \ \ /\ / / _ \ `'__|    " -ForegroundColor Yellow
Write-Host "      | |    | | (_) \ V  V /  | (_>  < | |  | (_) \ V  V /  __/ |        " -ForegroundColor Yellow
Write-Host "      |_|    |_|\___/ \_/\_/    \___/\/_|_|   \___/ \_/\_/ \___|_|        " -ForegroundColor Yellow
Write-Host "          /\                     |  \/  (_)               | |             " -ForegroundColor Cyan
Write-Host "         /  \   _ __  _ __  ___  | \  / |_  __ _ _ __ __ _| |_ ___  _ __  " -ForegroundColor Cyan
Write-Host "        / /\ \ | `'_ \| `'_ \/ __| | |\/| | |/ _`` | `'__/ _`` | __/ _ \| `'__|" -ForegroundColor Cyan
Write-Host "       / ____ \| |_) | |_) \__ \ | |  | | | (_| | | | (_| | || (_) | |   " -ForegroundColor Cyan
Write-Host "      /_/    \_\ .__/| .__/|___/ |_|  |_|_|\__, |_|  \__,_|\__\___/|_|   " -ForegroundColor Cyan
Write-Host "               | |   | |                    __/ |                        " -ForegroundColor Cyan
Write-Host "               |_|   |_|                   |___/                         " -ForegroundColor Cyan
Write-host                                                                             
Write-host "-----------------------------------------------------------------------------"
Write-host

Write-Host "This script will produce a sharable package that your Client or Partner can use for deployments" -ForegroundColor Yellow

Set-Location $Path
. .\MISC\PS-Forms.ps1

Get-ChildItem -Recurse | Unblock-File
# Legacy PowerShell PnP Module is used because the new one has a critical bug
Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -DisableNameChecking

$Migration = @{
    SOURCE_SITE_URL = "https://contoso.sharepoint.com/sites/Site_A"
    MIGRATE_LISTS   = $true    
}

$Migration = Get-FormItemProperties `
    -item $Migration `
    -dialogTitle "Enter source site URL" `
    -propertiesOrder @("SOURCE_SITE_URL", "MIGRATE_LISTS") 

$SOURCE_SITE_URL = $Migration.SOURCE_SITE_URL
if ($Migration.MIGRATE_LISTS -like "true" -or 
    $Migration.MIGRATE_LISTS -like "yes" -or
    $Migration.MIGRATE_LISTS -like "1"
) {
    $Migration.MIGRATE_LISTS = $true
}
else {
    $Migration.MIGRATE_LISTS = $false
}
$MIGRATE_LISTS = $Migration.MIGRATE_LISTS


# Preparing package for the client
New-Item -ItemType Directory -Force -Path "package" | Out-Null
. .\GenerateInitialMapping.ps1 -DestinationFolder ".\package"
if ($MIGRATE_LISTS) {
    . .\MISC\Move-Lists.ps1 -Path $Path -MigrationType Export -SourceSite $SOURCE_SITE_URL
}

if ((Test-Path -Path "package\MISC") -eq $false) {
    New-Item -ItemType Directory -Force -Path "package\src" | Out-Null
    New-Item -ItemType Directory -Force -Path "package\MISC" | Out-Null
    Copy-Item -Path "MISC\SharePointPnPPowerShellOnline" -Destination "package\MISC" -Recurse
    Copy-Item -Path "MISC\PS-Forms.ps1" -Destination "package\MISC"
    Copy-Item -Path "MISC\Move-Lists.ps1" -Destination "package\MISC"
    Copy-Item -Path "MISC\Convert-Packages.ps1" -Destination "package"
    Copy-Item -Path "MISC\Convert-Packages.bat" -Destination "package"
    Copy-Item -Path "Lists.xml" -Destination "package"

    Get-ChildItem *.json | ForEach-Object { 
        Copy-Item -Path $_.Name -Destination "package"
    }
      
    Copy-Item -Path "ConvertPackage.ps1" -Destination "package"
    Copy-Item -Path "CompleteResourceMapping.ps1" -Destination "package"
}

Write-host '[Important] Next steps' -ForegroundColor Yellow
Write-host "1) Export your Power Apps And Flows" -ForegroundColor Yellow
Write-host "2) Place all of these exported ZIP files to the package\src folder" -ForegroundColor Yellow
Write-host "3) Share the package directory with your Client or Partner" -ForegroundColor Yellow
Write-host "4) Instruct your Client or Partner to run Convert-Packages.bat on their end" -ForegroundColor Yellow
Write-host "5) Instruct your Client or Partner deploy all converted Apps and Flows from \dist directory" -ForegroundColor Yellow
