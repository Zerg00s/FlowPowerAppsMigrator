$SOURCE_SITE_URL = Read-Host "Enter the URL of the original (old) SharePoint site"

Connect-PnPOnline -Url $SOURCE_SITE_URL

$lists = Get-PnPList -Includes Views,Fields,DefaultView
$lists = $lists | Where-Object hidden -eq $false

$resources = @()
$line = "" | Select-Object resource,oldId,newId
$line.resource = "SiteUrl"
$line.oldId = $SOURCE_SITE_URL
$resources += $line

$lists | ForEach-Object{
    $line = "" | Select-Object resource,oldId,newId
    $line.resource = $_.RootFolder.ServerRelativeUrl.Replace($_.ParentWebUrl,"")
    $line.oldId = $_.ID
    $resources += $line

    $line = "" | Select-Object resource,oldId,newId
    $line.resource = $_.DefaultView.ServerRelativeUrl.Replace($_.ParentWebUrl,"")
    $line.oldId = $_.DefaultView.ID
    $resources += $line
}

$resources | Export-Csv -Path "resourceMapping.csv"
Write-Host resourceMapping.csv generated -ForegroundColor Green