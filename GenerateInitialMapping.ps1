[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$DestinationFolder = $null
)
if ($null -eq $SOURCE_SITE_URL) {
    $SOURCE_SITE_URL = Read-Host "Enter the URL of the original (old) SharePoint site"
}

Write-Host "[Attention] Look for a login popup in a separate window. Please, log in to the source site site" -ForegroundColor Cyan

If($CLEAR_CREDENTIALS_CACHE){
    Connect-PnPOnline -Url $SOURCE_SITE_URL -SPOManagementShell -ClearTokenCache -WarningAction Ignore
}else{
    Connect-PnPOnline -Url $SOURCE_SITE_URL -UseWebLogin -WarningAction Ignore
}




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

    foreach ($view in $_.Views) {
        $line = "" | Select-Object resource, oldId, newId
        $line.resource = $view.ServerRelativeUrl.Replace($_.ParentWebUrl, "")
        $line.oldId = $view.ID
        $resources += $line
    }
}

if ($DestinationFolder) {
    $destinationCsvPath = Join-Path $DestinationFolder "resourceMapping.csv"
}
else {
    $destinationCsvPath = "resourceMapping.csv"
}

$resources | Export-Csv -Path $destinationCsvPath -NoTypeInformation
Write-Host Mapping file resourceMapping.csv is generated -ForegroundColor Green
