Set-Location $Path
# . .\MISC\PS-Forms.ps1

$SOURCE_SITE_URL = Read-Host "Enter the URL of the original (old) SharePoint site"

# $Migration = @{
#     SOURCE_SITE_URL = "https://contoso.sharepoint.com/sites/Site_A"
#     Target_Site = "https://contoso.sharepoint.com/sites/Site_b"
# }

$Migration = Get-FormItemProperties -item $Migration -dialogTitle "Enter source and target sites" -propertiesOrder @("SOURCE_SITE_URL", "Target_Site") 

Get-ChildItem -Recurse | Unblock-File
# Legacy PowerShell PnP Module is used because the new one has a critical bug
Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -DisableNameChecking

Connect-PnPOnline -Url $SOURCE_SITE_URL -UseWebLogin -WarningAction Ignore

$lists = Get-PnPList -Includes Views, Fields, DefaultView
$lists = $lists | Where-Object hidden -eq $false

$resources = @()
$line = "" | Select-Object resource, oldId, newId
$line.resource = "SiteUrl"
$line.oldId = $SOURCE_SITE_URL
$resources += $line

$lists | ForEach-Object {
    $line = "" | Select-Object resource, oldId, newId
    $line.resource = $_.RootFolder.ServerRelativeUrl.Replace($_.ParentWebUrl, "")
    $line.oldId = $_.ID
    $resources += $line

    $line = "" | Select-Object resource, oldId, newId
    $line.resource = $_.DefaultView.ServerRelativeUrl.Replace($_.ParentWebUrl, "")
    $line.oldId = $_.DefaultView.ID
    $resources += $line
}

$resources | Export-Csv -Path "resourceMapping.csv"
Write-Host resourceMapping.csv generated -ForegroundColor Green