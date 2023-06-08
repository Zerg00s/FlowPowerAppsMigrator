[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [switch]$DoNotReconnect
)
if ($null -eq $TARGET_SITE_URL) {
    $TARGET_SITE_URL = Read-Host "Enter the URL of the destination SharePoint site"
}
if($DoNotReconnect.IsPresent -eq $false){
    if($USE_APP_ONLY_AUTHENTICATION){
        $TargetAppId = "0789bce2-cd45-4668-a20e-91e730c70861"
        $TargetAppSecret = "oRYj4s+2zBosk04X+AS+SQGKha/2BS4iek0mfd2PHsg="
        Connect-PnPOnline -Url $TARGET_SITE_URL -ClientId $TargetAppId -ClientSecret $TargetAppSecret -WarningAction Ignore
    }else{
        Connect-PnPOnline -Url $TARGET_SITE_URL -UseWebLogin -WarningAction Ignore
    }    
}

$lists = Get-PnPList -Includes Views, Fields, DefaultView
$lists = $lists | Where-Object hidden -eq $false

$resources = Import-Csv -Path .\resourceMapping.csv
$resources[0].newId = $TARGET_SITE_URL

$lists | ForEach-Object {
    $line = "" | Select-Object resource, oldId, newId
    $line.resource = $_.RootFolder.ServerRelativeUrl.Replace($_.ParentWebUrl, "")
    $line.newId = $_.ID
    # There could be more than one resource: 
    $resource = $resources | Where-Object resource -eq $line.resource
    if ($resource -ne $null) {
        if(@($resource).Count -gt 1){
            Write-Host "More than one resource found for $line.resource" -ForegroundColor Yellow
            foreach($r in $resource){
                $r.newId = $line.newId
            }

        }else{
            $resource.newId = $line.newId
        }        
    }
    foreach ($view in $_.Views) {
        $line = "" | Select-Object resource, oldId, newId
        $line.resource = $view.ServerRelativeUrl.Replace($_.ParentWebUrl, "")
        $line.newId = $view.ID

        $resource = $resources | Where-Object resource -eq $line.resource
        if ($resource -ne $null) {
            if(@($resource).Count -gt 1){
                Write-Host "More than one resource found for $line.resource" -ForegroundColor Yellow
                foreach($r in $resource){
                    $r.newId = $line.newId
                }
    
            }else{
                $resource.newId = $line.newId
            }        
        }     
  
    }

    $resource = $resources | Where-Object resource -eq $line.resource
    if ($resource -ne $null) {
        if(@($resource).Count -gt 1){
            Write-Host "More than one resource found for $line.resource" -ForegroundColor Yellow
            foreach($r in $resource){
                $r.newId = $line.newId
            }

        }else{
            $resource.newId = $line.newId
        }        
    }
}

$resources | Export-Csv -Path "resourceMapping.csv" -NoTypeInformation
Write-Host Mapping file resourceMapping.csv fully complete -ForegroundColor Green