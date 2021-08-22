param (
    [string]$Path
)

$ErrorActionPreference = "Stop"

$host.UI.RawUI.WindowTitle = "Flow & Power Apps Migrator"
Write-Host $Path -ForegroundColor Green

Write-host
Write-host
Write-Host "______ _                          _____                            "
Write-Host "|  ____| |                 ___    |  __ \                          "
Write-Host "| |__  | | _____      __  ( _ )   | |__) |____      _____ _ __     "
Write-Host "|  __| | |/ _ \ \ /\ / /  / _ \/\ |  ___/ _ \ \ /\ / / _ \ `'__|    "
Write-Host "| |    | | (_) \ V  V /  | (_>  < | |  | (_) \ V  V /  __/ |       "
Write-Host "|_|    |_|\___/ \_/\_/    \___/\/_|_|   \___/ \_/\_/ \___|_|       "
Write-Host "    /\                     |  \/  (_)               | |            "
Write-Host "   /  \   _ __  _ __  ___  | \  / |_  __ _ _ __ __ _| |_ ___  _ __ "
Write-Host "  / /\ \ | `'_ \| `'_ \/ __| | |\/| | |/ _`` | `'__/ _`` | __/ _ \| `'__|"
Write-Host " / ____ \| |_) | |_) \__ \ | |  | | | (_| | | | (_| | || (_) | |   "
Write-Host "/_/    \_\ .__/| .__/|___/ |_|  |_|_|\__, |_|  \__,_|\__\___/|_|   "
Write-Host "         | |   | |                    __/ |                        "
Write-Host "         |_|   |_|                   |___/                         "
Write-host                                                                       
Write-host "---------------------------------------------------------------------------"
Write-host   
# Created by Denis Molodtsov, 2018

Set-Location $Path
. .\MISC\PS-Forms.ps1

Get-ChildItem -Recurse | Unblock-File
# Legacy PowerShell PnP Module is used because the new one has a critical bug
Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -DisableNameChecking

$Migration = @{
    SOURCE_SITE_URL = "https://contoso.sharepoint.com/sites/Site_A"
    TARGET_SITE_URL = "https://contoso.sharepoint.com/sites/Site_b"
}

$Migration = Get-FormItemProperties -item $Migration -dialogTitle "Enter source and target sites" -propertiesOrder @("SOURCE_SITE_URL", "TARGET_SITE_URL") 


. .\GenerateInitialMapping.ps1
. .\CompleteResourceMapping.ps1
. .\ConvertPackage.ps1