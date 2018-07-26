$siteURL = "https://source.sharepoint.com/teams/portal"

Connect-PnPOnline -Url $siteURL

$lists = Get-PnPList -Includes Views,Fields,DefaultView
$lists = $lists | where hidden -eq $false

$resources = @()
$line = "" | select resource,oldId,newId
$line.resource = "SiteUrl"
$line.oldId = $siteURL
$resources += $line

$lists | ForEach-Object{
    $line = "" | select resource,oldId,newId
    $line.resource = $_.RootFolder.ServerRelativeUrl.Replace($_.ParentWebUrl,"")
    $line.oldId = $_.ID
    $resources += $line

    $line = "" | select resource,oldId,newId
    $line.resource = $_.DefaultView.ServerRelativeUrl.Replace($_.ParentWebUrl,"")
    $line.oldId = $_.DefaultView.ID
    $resources += $line
}

$resources | Export-Csv -Path "resourceMapping.csv"