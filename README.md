![SharePoint Online](https://img.shields.io/badge/SharePoint-Online-yellow.svg) 
![Windows](https://img.shields.io/static/v1?label=OS&message=Windows&color=green)
![Version](https://img.shields.io/static/v1?label=Version&message=3.0&color=white)


# Flow & Power Apps Migrator

Have you ever tried moving canvas apps or cloud flows across Microsoft 365 tenants or sites? This is a common task when deploying apps and flows to production. Apps and flows have to be exported, imported and SharePoint actions manually updated. These manual updates are error-prone and labor intensive. **Flow & Power Apps Migrator** automatically converts exported flows and apps to be compatible with the target environment. 

## Watch a Demo 
[![](MISC/IMG/Video_Thumbnail.jpg)](https://youtu.be/06io-y3pMKU)
# Prerequisites 

- Make sure that SharePoint lists and libraries exist in the target environment. You can use [Move-Lists](https://github.com/Zerg00s/Move-Lists) for this purpose.
- [Download the latest version of the Flow & Power Apps Migrator](https://github.com/Zerg00s/FlowPowerAppsMigrator/releases/download/2.0/FlowPowerAppsMigrator.zip).
- Extract the ZIP package.

<img style="padding-left:50px" src="MISC/IMG/UnzippedPackage.png">

# Convert flows and apps

## Export flows and apps
Export all of your flows:

![](MISC/IMG/Export.png)

Export all of your apps:

![](MISC/IMG/ExportApp.png)

## 2. Place exported flows and apps in the src folder
![](MISC/IMG/2018-07-25-20-57-29.png)

## 3. Run Migrate-Packages.bat
The scripts will iterate through all ZIP files inside the `\src` directory and convert them to be compatible with the new Microsoft 365 tenant or site.
- Run `Migrate-Packages.bat` script

<img style="padding-left:50px" src="MISC/IMG/Migrator.png">

- Enter source site URL and target site URL:

<img style="padding-left:50px" src="MISC/IMG/UI.png">

- Sit back and wait for the conversion to finish.



## 4. Navigate to the \dist folder and collect converted flows and apps

![](MISC/IMG/2018-07-25-21-11-04.png)

## 5. Import converted flows and apps
Now go ahead and import your flows and apps to the destination tenant. All SharePoint actions are now be converted and point to the new location.


###  <b>Power Apps</b> data sources are all converted

![](MISC/IMG/DataSourcesConverted_2.0.png)

### <b>Flow actions</b> are also converted

![](MISC/IMG/FlowsConverted_2.0.png)

## How it works

**Flow & Power Apps Migrator** finds all unique IDs pointing to the source SharePoint site and replaces them with the destination IDs. `resourceMapping.csv` contains the mapping of these IDs.

![](MISC/IMG/CSV.png)

## Limitations

- Does not support macOS and Linux.
- Only SharePoint data sources are updated.

# Preparing a deployment package for your Clients and Partners

`Prepare-Deployment-Package-for-Client.bat` script prepares a deployment package that you can share with your Clients or Partners. 

## On your end

- Run `Prepare-Deployment-Package-for-Client.bat`
- Export your Solutions, Power Apps and Flows and save them to the `package\src` directory
- Send the `package` directory to your Client or Partner.  


## On the Client's side

Run The package directory will contain a .bat file that your clients will click to:

- Run `Convert-Packages.bat`
- Navigate to the `dist` folder and deploy converted solutions, apps and flows that will be compatible with the target environment.

**Note:** `Convert-Packages.bat` will:

- Deploy SharePoint lists and libraries (if you chose to do package them)
- Convert Apps and Flows from `src` and saves them to 'dist'.

![image](https://user-images.githubusercontent.com/2797648/138599549-cef7b847-582e-4e91-8c75-a37a8e82a00d.png)


# Latest Updates

### 3.0 Version - Major update

New features added:

- `Migrate-Packages.bat` script now migrates SharePoint lists and libraries that your Apps and Flow depend on.
- Added `Prepare-Deployment-Package-for-Client.bat` script that lets you prepare a deployment package that you can share with your Clients or Partners. Running this script will generate a package directory that you can then send to your Clients and Partners. Distribution of your apps and flows is now easier than ever.

### 2.1 Version

New feature added:

- added support for migration solutions. Thanks to [Mark Doria](https://www.linkedin.com/in/mark-doria/) for helping with this feature.
