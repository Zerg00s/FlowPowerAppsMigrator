# This code is used to convert packages in the \src folder and save them to the \dist folder. 
# It first cleans any previously generated packages. It then gets a list of packages 
# from the \src folder with the .zip extension. It imports a CSV file containing 
# resource mapping information, and creates a dist folder if it does not exist. 

# It then iterates through each package, extracting it to a destination folder 
# and replacing any old IDs with new ones from the resource mapping file. 
# If an MSAPP package is found, it extracts that too and replaces any old IDs 
# with new ones from the resource mapping file. It then creates a new zip file 
# for each package, either using tar or System.IO.Compression.ZipFile depending 
# on whether or not it is a solution package, and saves it to the \dist folder. 

# Finally, it prints out a message that all packages have been converted and 
# saved to the \dist folder, and invokes 
# this directory in Windows Explorer so that its contents can be viewed.


Add-Type -AssemblyName System.IO.Compression.FileSystem
$CurrentPath = (Get-Location).Path + "\"

# Clean previously generated packages
Get-ChildItem $CurrentPath -Filter "Converted*" -Recurse | Remove-Item

$packages = Get-ChildItem -Path .\src -Filter "*.zip"

$resources = Import-Csv  -Path .\resourceMapping.csv

# Create dist folder if it does not exist
if (-not (Test-Path .\dist)) {
    New-Item -ItemType Directory -Path .\dist | Out-Null
}

for ($k = 0; $k -lt $packages.count; $k++) {
    $package = $packages[$k]
    $DestinationFolder = $CurrentPath + "dist\" + $package.BaseName
    Remove-Item $DestinationFolder -Force -Recurse -ErrorAction SilentlyContinue

    [System.IO.Compression.ZipFile]::ExtractToDirectory($package.FullName, $DestinationFolder)

    $files = Get-ChildItem $DestinationFolder -Recurse -File -Include ('*.json', '*.xml')
    $files | ForEach-Object {
        for ($i = 0; $i -lt $resources.Count; $i++) {
            Write-Host Converting $resources[$i].resource "... "
            if ($resources[$i].newId) {
                try {
                    $content = Get-Content -LiteralPath $_.FullName -ErrorAction Stop
                    $content -replace $resources[$i].oldId, $resources[$i].newId | Set-Content -LiteralPath $_.FullName
                    Write-host "  [Success] " -ForegroundColor Green -NoNewline
                    Write-host  $($resources[$i].resource) converted
                }
                catch {
                    Write-host "  [Error] " -ForegroundColor Red -NoNewline
                    Write-host "Failed to process file: $($_.FullName)"
                    Write-host "  Error: $_" -ForegroundColor Red
                }
            }
            else {
                if ($resources[$i].resource -match ".aspx" -eq $false) {
                    Write-host "`  [Warning] " -ForegroundColor Yellow -NoNewline
                    Write-host SharePoint List or a Library is missing in the destination site collection. Make sure it exists if used: $($resources[$i].resource)
                }
            }
        }
    }

    $solutionManifest = Get-ChildItem -Path $DestinationFolder -Filter "solution.xml"
    if ($solutionManifest) {
        Write-host  $package.Name is a Solution Package -ForegroundColor Cyan
    }

    # Searching for an MSAPP file. These are zip-archives that need to be converted too:
    $msappPackages = Get-ChildItem $DestinationFolder -Recurse -File -Filter "*.msapp*"

    if ($null -ne $msappPackages -and $msappPackages.Count -ne 0) {
        for ($y = 0; $y -lt $msappPackages.count; $y++) {
            $msAppPackage = $msappPackages[$y];
            $msAppPackageDestinationFolder = $msappPackage.Directory.FullName + "\" + $msAppPackage.BaseName
            [System.IO.Compression.ZipFile]::ExtractToDirectory($msAppPackage.FullName , $msAppPackageDestinationFolder)

            $files = Get-ChildItem $msAppPackageDestinationFolder -Recurse -File -Filter "*.json*"
            $files | ForEach-Object {
                for ($i = 0; $i -lt $resources.Count; $i++) {
                    if ([System.String]::IsNullOrEmpty($resources[$i].newId) -eq $false) {
                        try {
                            $content = Get-Content -LiteralPath $_.FullName -ErrorAction Stop
                            $content -replace $resources[$i].oldId, $resources[$i].newId | Set-Content -LiteralPath $_.FullName
                        }
                        catch {
                            Write-host "  [Error] " -ForegroundColor Red -NoNewline
                            Write-host "Failed to process MSAPP file: $($_.FullName)"
                            Write-host "  Error: $_" -ForegroundColor Red
                        }
                    }
                    else {                        
                        if ($resources[$i].resource -match ".aspx" -eq $false) {
                            Write-host "`  [Warning] " -ForegroundColor Yellow -NoNewline
                            Write-host SharePoint List or a Library is missing in the destination site collection. Make sure it exists if used: $($resources[$i].resource)
                        }
                    }
                }
            }
            Write-host "App sub-package found:" $msAppPackage
            Remove-Item $msAppPackage.FullName -Force
            Push-Location $msAppPackageDestinationFolder
           
            [System.IO.Compression.ZipFile]::CreateFromDirectory($msAppPackageDestinationFolder, $msAppPackage.FullName, [System.IO.Compression.CompressionLevel]::Optimal, $false)
            
            Pop-Location
            Remove-Item $msAppPackageDestinationFolder -Force -Recurse -ErrorAction SilentlyContinue            
        }
    }

    Remove-Item $($CurrentPath + "dist\Converted_" + $package.BaseName + ".zip") -Force -Recurse -ErrorAction SilentlyContinue
    Push-Location $($DestinationFolder)
    if ($solutionManifest) {
        tar -a -c -f $("..\Converted_" + $package.BaseName + ".zip") *
    }
    else {
        [System.IO.Compression.ZipFile]::CreateFromDirectory($DestinationFolder, $CurrentPath + "dist\Converted_" + $package.BaseName + ".zip", [System.IO.Compression.CompressionLevel]::Optimal, $false)
    }
    Pop-Location

    Remove-Item $DestinationFolder -Force -Recurse -ErrorAction SilentlyContinue
}

Write-Host \src packages were converted and saved to the \dist folder -ForegroundColor Green


Invoke-Item .\dist