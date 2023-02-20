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

Set-PnPTraceLog -On -LogFile traceoutput.txt -Level Debug

Set-Location $Path
. .\MISC\PS-Forms.ps1

Get-ChildItem -Recurse | Unblock-File
# Legacy PowerShell PnP Module is used because 
# the new one (PnP.PowerShell) requires Tenant Admin consent for the PnP Azure App Registration
# and it's not possible to use it in the context of a non-admin user
Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -DisableNameChecking

$Migration = @{
    SOURCE_SITE_URL = "https://contoso.sharepoint.com/sites/Site_A"
    TARGET_SITE_URL = "https://contoso.sharepoint.com/sites/Site_b"
    MIGRATE_LISTS   = $true
    CLEAR_CREDENTIALS_CACHE = $false
}

$Migration = Get-FormItemProperties `
    -item $Migration `
    -dialogTitle "Enter source and target sites" `
    -propertiesOrder @("SOURCE_SITE_URL", "TARGET_SITE_URL", "MIGRATE_LISTS", "CLEAR_CREDENTIALS_CACHE") 

$SOURCE_SITE_URL = $Migration.SOURCE_SITE_URL
$TARGET_SITE_URL = $Migration.TARGET_SITE_URL
if ($Migration.MIGRATE_LISTS -like "true" -or 
    $Migration.MIGRATE_LISTS -like "yes" -or
    $Migration.MIGRATE_LISTS -like "1"
) {
    $Migration.MIGRATE_LISTS = $true
}else {
    $Migration.MIGRATE_LISTS = $false
}
$MIGRATE_LISTS = $Migration.MIGRATE_LISTS


if ($Migration.CLEAR_CREDENTIALS_CACHE -like "true" -or 
    $Migration.CLEAR_CREDENTIALS_CACHE -like "yes" -or
    $Migration.CLEAR_CREDENTIALS_CACHE -like "1"
) {
    $Migration.CLEAR_CREDENTIALS_CACHE = $true
}else {
    $Migration.CLEAR_CREDENTIALS_CACHE = $false
}
$CLEAR_CREDENTIALS_CACHE = $Migration.CLEAR_CREDENTIALS_CACHE

. .\GenerateInitialMapping.ps1
if ($MIGRATE_LISTS) {
    . .\MISC\Move-Lists.ps1 -Path $Path -MigrationType Export -SourceSite $SOURCE_SITE_URL
}

Write-Host "[Attention] Look for a login popup in a separate window. Please, log in to the target site $TARGET_SITE_URL." -ForegroundColor Cyan
If($CLEAR_CREDENTIALS_CACHE){
    Connect-PnPOnline -Url $TARGET_SITE_URL -SPOManagementShell -ClearTokenCache -WarningAction Ignore
}else{
    Connect-PnPOnline -Url $TARGET_SITE_URL -UseWebLogin -WarningAction Ignore
}

# Verify the connection
$Response = Invoke-PnPSPRestMethod -Url "$TARGET_SITE_URL/_api/web/currentUser"
Write-Host 
Write-Host Connected to the target site -ForegroundColor Green 
Write-Host "`tSite: $TARGET_SITE_URL" -ForegroundColor Yellow 
Write-Host "`tUser: $($Response.Title) ($($Response.Email))" -ForegroundColor Yellow 


if ($MIGRATE_LISTS) {   
    Write-Host Applying PnP Template to $TARGET_SITE_URL -ForegroundColor Cyan
    . .\MISC\Move-Lists.ps1 -Path $Path -MigrationType Import -TargetSite $TARGET_SITE_URL
}

. .\CompleteResourceMapping.ps1 -DoNotReconnect

. .\ConvertPackage.ps1
