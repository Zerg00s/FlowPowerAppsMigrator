[CmdletBinding()]
param (
    [Parameter()]
    [string]$Path,

    [Parameter(Mandatory = $true)]
    [ValidateSet('Export', 'Import')]
    [string]$MigrationType,

    [Parameter(Mandatory = $false)]
    [string]$SourceSite,

    [Parameter(Mandatory = $false)]
    [string]$TargetSite     
)


#-----------------------------------------------------------------------
# Script lets you migrate one or more SharePoint lists from source site
# To destination site
# Denis Molodtsov, 2021
#-----------------------------------------------------------------------

$ErrorActionPreference = "Stop"

Write-Host $Path -ForegroundColor Green

Set-Location $Path
. .\MISC\PS-Forms.ps1

Get-ChildItem -Recurse | Unblock-File
# Legacy PowerShell PnP Module is used because the new one has a critical bug
Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -DisableNameChecking


try {
    $lists = Get-PnPList
}
catch {
    $errorSuggestion = "If you already have enough permissions, try running the script with CLEAR_CREDENTIALS_CACHE set to True"
    if ($error[0].Exception.Message -match "(403)" -or $error[0].Exception.Message -match "unauthorized") {
        if ($MigrationType -eq "Export") {
            Write-Host "[Error] make sure you have FULL CONTROL at the source site $SourceSite" -ForegroundColor Yellow
        }
        elseif ($MigrationType -eq "Import") {
            Write-Host "[Error] make sure you have FULL CONTROL at the target site $TargetSite" -ForegroundColor Yellow
        }
        else {
            Write-Host "[Error] make sure you have FULL CONTROL at the source site $SourceSite and target site $TargetSite" -ForegroundColor Yellow
        }
        Write-Host $errorSuggestion -ForegroundColor Yellow
        
    }
    else {
        Write-Host $error[0].Exception.Message
    }
    throw 
}


if ($MigrationType -eq "Export") {
    Write-Host "Exporting lists and libraries..." -ForegroundColor Yellow
    Get-ChildItem *.xml | ForEach-Object { Remove-Item -Path $_.FullName }
    Get-ChildItem *.json | ForEach-Object { Remove-Item -Path $_.FullName }
    $lists = Get-PnPList
    $lists = $lists | Where-Object { $_.Hidden -eq $false }
    
    $selectedLists = Get-FormArrayItems ($lists) -dialogTitle "Select lists and libraries to migrate" -key Title
    $titles = $selectedLists.Title

    # If a list contains custom content types, we will have to move them all.
    $exportContentTypes = $false
    foreach ($list in $selectedLists) {
        $listContentTypes = Get-PnPContentType -List $list         
        $context = $list.Context        
        foreach ($contentType in $listContentTypes) {
            $context.Load($contentType)
            $context.ExecuteQuery()  
            [xml]$xml = $contentType.SchemaXml 
            if ($null -eq $xml.ContentType.FeatureId) {
                $exportContentTypes = $true;
            }
        }
    } 
    
    if ($exportContentTypes) {
        Get-PnPProvisioningTemplate -ListsToExtract $titles -Out "Lists.xml" -Handlers Lists, ContentTypes, Fields -Force -WarningAction Ignore 
    }
    else {
        Get-PnPProvisioningTemplate -ListsToExtract $titles -Out "Lists.xml" -Handlers Lists -Force -WarningAction Ignore
    }

    # Remove all Property Bag entries from the lists. Begin
    ((Get-Content -Path Lists.xml -Raw -Encoding UTF8) -replace '<\?xml version="1.0"\?>', '' -replace 'RootSite', 'Web') | Set-Content -Path Lists.xml -Encoding UTF8
    
    $xml = [xml](Get-Content Lists.xml)


    $propertyBagEntries = $xml.GetElementsByTagName('pnp:PropertyBagEntries')
    if ($propertyBagEntries -ne $null -and $propertyBagEntries.Count -gt 0) {
        for ($i = $propertyBagEntries.Count - 1; $i -gt -1 ; $i--) {
            $supress = $propertyBagEntries[$i].ParentNode.RemoveChild($propertyBagEntries[$i])
        }      
    }

    $xml.Save('Lists.xml')
    "<?xml version=""1.0""?>`n" + (Get-Content "Lists.xml" -Raw -Encoding UTF8) | Set-Content "Lists.xml" -Encoding UTF8

    # Remove all Property Bag entries from the lists. End

    foreach ($title in $titles) {
        # Get the latest list item form layout. Footer, Header and the Body:
        $list = Get-PnPList $title -Includes ContentTypes
        $contentType = $list.ContentTypes | Where-Object { $_.Name -eq "Item" }
        $contentType.ClientFormCustomFormatter | Set-Content .\$title.json
    }
}

if ($MigrationType -eq "Import") {
    Write-Host "Importing lists and libraries..." -ForegroundColor Yellow

    
    try {
        Apply-PnPProvisioningTemplate -Path Lists.xml 
    }
    catch {
        Write-Host "[Error] " -NoNewline -ForegroundColor Red
        if ($error[0].Exception.Message -match "(403)" -or $error[0].Exception.Message -match "unauthorized") {
            Write-Host "Make sure you have full control at the target site $TargetSite" -ForegroundColor Yellow
        }
        elseif ($error[0].Exception.Message -match "E_ACCESSDENIED") {
            Write-Host "Make sure that both target site and the source sites created with the same language. Cross-language list migration is not supported." -ForegroundColor Cyan
        }
        else {
            Write-Host $error[0].Exception.Message
        }
        throw 
    }

    
    $jsonFiles = Get-ChildItem *.json
    if ($jsonFiles) {
        $titles = $jsonFiles | ForEach-Object { "$($_.BaseName)" }

        foreach ($title in $titles) {
            $list = Get-PnPList $title -Includes ContentTypes
            $contentType = $list.ContentTypes | Where-Object { $_.Name -eq "Item" }
            if ($contentType) {
                $json = Get-Content .\$title.json
                $contentType.ClientFormCustomFormatter = $json
                $contentType.Update($false)
                $contentType.Context.ExecuteQuery();
            }
        }
    }
}
