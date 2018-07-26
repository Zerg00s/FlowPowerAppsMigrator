Add-Type -AssemblyName System.IO.Compression.FileSystem
$CurrentPath = (Get-Location).Path + "\"

# Clean previously generated packages
Get-ChildItem $CurrentPath -Filter "Converted*" -Recurse| Remove-Item

$packages = Get-ChildItem -Path .\src -Filter "*.zip"

$resources = Import-Csv  -Path .\resourceMapping.csv

for($k=0;$k -lt $packages.count; $k++){
    $package = $packages[$k];
    $DestinationFolder = $CurrentPath +"dist\"+$package.BaseName
    Remove-Item $DestinationFolder -Force -Recurse -ErrorAction SilentlyContinue

    [System.IO.Compression.ZipFile]::ExtractToDirectory($package.FullName, $DestinationFolder)

    $files =  Get-ChildItem $DestinationFolder -Recurse -File -Filter "*.json*"

    $files | ForEach-Object {
        for($i=0;$i -lt $resources.Count;$i++){
            if($resources[$i].newId -ne $null){
                (Get-Content $_.FullName) -replace $resources[$i].oldId, $resources[$i].newId | Set-Content $_.FullName
            }
        }
    }

    # Searching for MSAPP file. These are zip-archives that need to be Converted too:
    $msappPackages =  Get-ChildItem $DestinationFolder -Recurse -File -Filter "*.msapp*"

    if ($null -ne $msappPackages -and $msappPackages.Count -ne 0){
        for($y=0;$y -lt $msappPackages.count; $y++){
            $msAppPackage = $msappPackages[$y];
            $msAppPackageDestinationFolder = $msappPackage.Directory.FullName +"\"+$msAppPackage.BaseName
            [System.IO.Compression.ZipFile]::ExtractToDirectory($msAppPackage.FullName , $msAppPackageDestinationFolder)

            $files =  Get-ChildItem $msAppPackageDestinationFolder -Recurse -File -Filter "*.json*"
            $files | ForEach-Object {
                for($i=0;$i -lt $resources.Count;$i++){
                    if($resources[$i].newId -ne $null){
                        (Get-Content $_.FullName) -replace $resources[$i].oldId, $resources[$i].newId | Set-Content $_.FullName
                    }
                }
            }
            Write-host "App Package found:" $msAppPackage
            Remove-Item $msAppPackage.FullName -Force
            [System.IO.Compression.ZipFile]::CreateFromDirectory($msAppPackageDestinationFolder, $msAppPackage.FullName, [System.IO.Compression.CompressionLevel]::Optimal, $false)
            Remove-Item $msAppPackageDestinationFolder -Force -Recurse -ErrorAction SilentlyContinue
        }

    }

    Remove-Item $($CurrentPath + "dist\Converted_"+$package.BaseName + ".zip") -Force -Recurse -ErrorAction SilentlyContinue
    [System.IO.Compression.ZipFile]::CreateFromDirectory($DestinationFolder, $CurrentPath + "dist\Converted_"+$package.BaseName + ".zip", [System.IO.Compression.CompressionLevel]::Optimal, $false)

    Remove-Item $DestinationFolder -Force -Recurse -ErrorAction SilentlyContinue
}

Write-Host All Apps were converted -ForegroundColor Green
Invoke-Item .\dist