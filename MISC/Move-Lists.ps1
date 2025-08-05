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
    ((Get-Content -Path Lists.xml -Raw -Encoding UTF8) -replace '<\?xml version="1.0"\?>', '' -replace 'RootSite', 'Web' -replace '(?<=\{[^}]*)\&(?=[^}]*\})', '&amp;') | Set-Content -Path Lists.xml -Encoding UTF8

    # Removing Site fields that cause the Exception from HRESULT: 0x80070005 (E_ACCESSDENIED)


    # Load the XML from file
    $xml = [xml](Get-Content Lists.xml)

    # Select all hidden nodes based on the Group attribute
    $hiddenNodes = $xml.SelectNodes("//*[@Group='_Hidden']")

    # Remove each hidden node
    foreach ($node in $hiddenNodes) {
        $node.ParentNode.RemoveChild($node) | Out-Null
    }
    
    $nodesToRemove = @(
        "0x0100415C46DF0F4B45939BDEC96C5014A10E",  # Microblog Properties Content Type
        "0x0101009148F5A04DDD49CBA7127AADA5FB792B",  # Rich Media Asset Content Type
        "0x0101009148F5A04DDD49CBA7127AADA5FB792B00291D173ECE694D56B19D111489C4369D"  # Video Rendition Content Type
        "0x0101009D1CB255DA76424F860D91F20E6C41180043153F945E98468297E67C3EEE43AB70",  # Space Content Type
        "0x0101009D1CB255DA76424F860D91F20E6C411800C57E7DC123744954AACC08D1D5260154")  # Content Freshness

    foreach ($nodeId in $nodesToRemove) {
        $nodes = $xml.SelectNodes("//*[@ID='$nodeId']")
        foreach ($node in $nodes) {
            $node.ParentNode.RemoveChild($node) | Out-Null
        }
    }

    # Find all nodes with CustomFormatter attribute and remove this attribute along with its value
    # <Field CustomFormatter="XXX" DisplayName="Choice Field" FillInChoice="FALSE" Format="Dropdown" IsModern="TRUE" Name="ChoiceField" Title="Choice Field" Type="Choice" ID="{37f50195-22dc-46c3-bbd5-70f5c539e6c7}" SourceID="{{listid:Test list}}" >

    $nodes = $xml.SelectNodes("//*[@CustomFormatter]")
    foreach ($node in $nodes) {
        $node.RemoveAttribute("CustomFormatter") | Out-Null
    }
    
    # Select all extended columns nodes based on the Group attribute
    # We don't want to migrate extended columns
    $extendedColumnNodes = $xml.SelectNodes("//*[@Group='Extended Columns']")
    if ($extendedColumnNodes -ne $null) {
        Write-Host "Extended columns count: " $extendedColumnNodes.Count
        # Remove each node
        foreach ($extendedColumnNode in $extendedColumnNodes) {
            $extendedColumnNode.ParentNode.RemoveChild($extendedColumnNode) | Out-Null
        }
    }

    # Fix Formula nodes - replace [{fieldtitle:FieldName}] with just FieldName
    $formulaNodes = $xml.SelectNodes("//Formula")
    if ($formulaNodes -ne $null -and $formulaNodes.Count -gt 0) {
        Write-Host "Processing Formula nodes: " $formulaNodes.Count
        foreach ($formulaNode in $formulaNodes) {
            if ($formulaNode.InnerText -match '\[\{fieldtitle:([^}]+)\}\]') {
                $originalFormula = $formulaNode.InnerText
                $updatedFormula = $originalFormula -replace '\[\{fieldtitle:([^}]+)\}\]', '$1'
                $formulaNode.InnerText = $updatedFormula
                Write-Host "Updated formula: $originalFormula -> $updatedFormula"
            }
        }
    }

    # Get all 'Field' nodes with attribute Hidden='TRUE'
    $hiddenFields = $xml.SelectNodes("//Field[@Hidden='TRUE']")
    if ($null -ne $hiddenFields) {
        Write-Host "Hidden fields count: " $hiddenFields
        # Remove all 'Field' nodes with attribute Hidden='TRUE'
        foreach ($field in $hiddenFields) {
            $field.ParentNode.RemoveChild($field) | Out-Null
        }
      
    }

    $siteFields = $xml.GetElementsByTagName("pnp:SiteFields")   
   
    # Check if 'SiteFields' node is empty
    if ($null -ne $siteFields) {
        if ($siteFields.GetType().Name -eq "XmlElementList") {
            $siteFields = $siteFields[0]
        }

        if ($null -ne $siteFields.ChildNodes) {
            if ($siteFields.ChildNodes.Count -eq 0) {
                # Remove the 'SiteFields' node completely
                $siteFields.ParentNode.RemoveChild($siteFields) | Out-Null
            }
        }       
    }
    
    
    $propertyBagEntries = $xml.GetElementsByTagName('pnp:PropertyBagEntries')
    if ($propertyBagEntries -ne $null -and $propertyBagEntries.Count -gt 0) {
        for ($i = $propertyBagEntries.Count - 1; $i -gt -1 ; $i--) {
            $propertyBagEntries[$i].ParentNode.RemoveChild($propertyBagEntries[$i])  | Out-Null
        }
    }

    $xml.Save('Lists.xml')
    "<?xml version=""1.0""?>`n" + (Get-Content "Lists.xml" -Raw -Encoding UTF8) | Set-Content "Lists.xml" -Encoding UTF8

    # Remove all Property Bag entries from the lists. End
    foreach ($title in $titles) {
        # Get the latest list item form layout. Footer, Header and the Body:
        $list = Get-PnPList $title -Includes ContentTypes
        if ($list -is [array]) {
            $list = $list[0]
        }        
        $contentType = $list.ContentTypes | Where-Object { $_.Name -eq "Item" }
        if ($null -eq $contentType) {
            continue
        }
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
            Write-Host "Make sure you have full control at the target site. However, This error is not always related to the permissions. $TargetSite" -ForegroundColor Yellow
        }
        elseif ($error[0].Exception.Message -match "E_ACCESSDENIED") {
            Write-Host "Tips: 1) Make sure that both target site and the source sites created with the same language. Cross-language list migration is not supported." -ForegroundColor Cyan
            Write-Host "Tips: 2) Read https://github.com/Zerg00s/FlowPowerAppsMigrator/wiki -> Create a SharePoint-only application and use it for authenticaiton" -ForegroundColor Cyan
            Write-Host "Tips: 3) Create an issue on https://github.com/Zerg00s/FlowPowerAppsMigrator/issues. And Share the Lists.xml file in the root folder." -ForegroundColor Cyan
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
