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
        Get-pnpProvisioningTemplate -ListsToExtract $titles -Out "Lists.xml" -Handlers Lists, ContentTypes, Fields -Force -WarningAction Ignore 
    }
    else {
        Get-pnpProvisioningTemplate -ListsToExtract $titles -Out "Lists.xml" -Handlers Lists -Force -WarningAction Ignore
    }

    # Remove all Property Bag entries from the lists. Begin
    ((Get-Content -path Lists.xml -Raw -Encoding UTF8) -replace '<\?xml version="1.0"\?>','' -replace 'RootSite', 'Web') | Set-Content -Path Lists.xml -Encoding UTF8
    
    $xml = [xml](Get-Content Lists.xml)


    $propertyBagEntries = $xml.GetElementsByTagName('pnp:PropertyBagEntries')
    if($propertyBagEntries -ne $null -and $propertyBagEntries.Count -gt 0) {
       for ($i = $propertyBagEntries.Count -1; $i -gt -1 ; $i--) {
        $propertyBagEntries[$i].ParentNode.RemoveChild($propertyBagEntries[$i])
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
    Apply-PnPProvisioningTemplate -Path Lists.xml 
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