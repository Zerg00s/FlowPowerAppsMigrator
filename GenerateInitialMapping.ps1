[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$DestinationFolder = $null
)
if ($null -eq $SOURCE_SITE_URL) {
    $SOURCE_SITE_URL = Read-Host "Enter the URL of the original (old) SharePoint site"
}

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

if ($DestinationFolder) {
    $destinationCsvPath = Join-Path $DestinationFolder "resourceMapping.csv"
}
else {
    $destinationCsvPath = "resourceMapping.csv"
}

$resources | Export-Csv -Path $destinationCsvPath -NoTypeInformation
Write-Host Mapping file resourceMapping.csv is generated -ForegroundColor Green
