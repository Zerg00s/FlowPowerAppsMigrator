# $TARGET_SITE_URL = "https://zergs.sharepoint.com/teams/pmportal"
# Connect-PnPOnline -Url $TARGET_SITE_URL

$lists = Get-PnPList -Includes Views,Fields,DefaultView
$lists = $lists | where hidden -eq $false

$resources = Import-Csv -Path .\PowerAppsConverter\resourceMapping.csv
$resources[0].newId = $TARGET_SITE_URL

$lists | ForEach-Object{
    $line = "" | select resource,oldId,newId
    $line.resource = $_.RootFolder.ServerRelativeUrl.Replace($_.ParentWebUrl,"")
    $line.newId = $_.ID
    $resource = $resources | where resource -eq $line.resource
    if ($resource -ne $null){
       $resource.newId = $line.newId
    }

    $line = "" | select resource,oldId,newId
    $line.resource = $_.DefaultView.ServerRelativeUrl.Replace($_.ParentWebUrl,"")
    $line.newId = $_.DefaultView.ID
    
    $resource = $resources | where resource -eq $line.resource
    if ($resource -ne $null){
        $resource.newId = $line.newId
    }
}

$resources | Export-Csv -Path .\PowerAppsConverter\resourceMapping.csv