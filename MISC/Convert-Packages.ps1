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


Set-Location $Path
. .\MISC\PS-Forms.ps1

Get-ChildItem -Recurse | Unblock-File
# Legacy PowerShell PnP Module is used because the new one has a critical bug
Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -DisableNameChecking

$Migration = @{
    TARGET_SITE_URL = "https://contoso.sharepoint.com/sites/Site_b"
}

$Migration = Get-FormItemProperties -item $Migration -dialogTitle "Enter target site" -propertiesOrder @("TARGET_SITE_URL") 
$TARGET_SITE_URL = $Migration.TARGET_SITE_URL

if($USE_APP_ONLY_AUTHENTICATION){
    Connect-PnPOnline -Url $TARGET_SITE_URL -ClientId $TARGET_SITE_APP_ID -ClientSecret $TARGET_SITE_APP_SECRET -WarningAction Ignore
}else{
    Connect-PnPOnline -Url $TARGET_SITE_URL -UseWebLogin -WarningAction Ignore
}

$xmlFiles = Get-ChildItem *.xml
if ($xmlFiles.Count -ne 0) {
    Write-Host Convert-Packages 1: $TARGET_SITE_URL Import of XML -ForegroundColor Yellow
    . .\MISC\Move-Lists.ps1 -Path $Path -MigrationType Import -TargetSite $TARGET_SITE_URL
}
. .\CompleteResourceMapping.ps1 -DoNotReconnect
. .\ConvertPackage.ps1