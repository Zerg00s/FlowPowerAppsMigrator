[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$DestinationFolder = $null
)
if ($null -eq $SOURCE_SITE_URL) {
    $SOURCE_SITE_URL = Read-Host "Enter the URL of the original (old) SharePoint site"
}

Write-Host "[Attention] Look for a login popup in a separate window. Please, log in to the source site site $SOURCE_SITE_URL" -ForegroundColor Cyan

if($USE_APP_ONLY_AUTHENTICATION){
    Connect-PnPOnline -Url $SOURCE_SITE_URL -ClientId $SOURCE_SITE_APP_ID -ClientSecret $SOURCE_SITE_APP_SECRET -WarningAction Ignore
}elseIf ($CLEAR_CREDENTIALS_CACHE) {
    Connect-PnPOnline -Url $SOURCE_SITE_URL -SPOManagementShell -ClearTokenCache -WarningAction Ignore
}
else {
    Connect-PnPOnline -Url $SOURCE_SITE_URL -UseWebLogin -WarningAction Ignore
}

try {
    Write-Host
    Write-Host Connected to the source site -ForegroundColor Green 
    Write-Host "`tSite: $SOURCE_SITE_URL" -ForegroundColor Yellow 

    $lists = Get-PnPList -Includes Views, Fields, DefaultView
}
catch {
    if ($error[0].Exception.Message -match "(403)" -or $error[0].Exception.Message -match "unauthorized") {
        
        Write-Host "[Error] make sure you have FULL CONTROL at the source site: $SOURCE_SITE_URL" -ForegroundColor Yellow
        $errorSuggestion = "If you already have enough permissions, try running the script with CLEAR_CREDENTIALS_CACHE set to True"
        Write-Host $errorSuggestion -ForegroundColor Yellow
    }
    else {
        Write-Host Write-Host $error[0].Exception.Message
    }
    throw 
}

$lists = $lists | Where-Object hidden -EQ $false

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
