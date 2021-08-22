param (
    [string]$Path
)

$ErrorActionPreference = "Stop"

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