![SharePoint Online](https://img.shields.io/badge/SharePoint-Online-yellow.svg) 
![Windows](https://img.shields.io/static/v1?label=OS&message=Windows&color=green)
![Version](https://img.shields.io/static/v1?label=Version&message=2.0&color=white)


# Flow & Power Apps Migrator

Have you ever tried moving canvas apps or cloud flows across Microsoft 365 tenants or sites? This is a common task when deploying apps and flows to production. Apps and flows have to be exported, imported and SharePoint actions manually updated. These manual updates are error-prone and labor intensive. **Flow & Power Apps Migrator** automatically converts exported flows and apps to be compatible with the target environment. 

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
Now go ahead and import your flows and apps to the destination tenant. All SharePoint actions are now be converted and to the new location.


Power Automate data sources are all converted:

![](MISC/IMG/DataSourcesConverted_2.0.png)

Flows actions are also converted:

![](MISC/IMG/FlowsConverted_2.0.png)

## How it works

**Flow & Power Apps Migrator** finds all unique IDs pointing to the source SharePoint site and replaces them with the destination IDs. `resourceMapping.csv` contains the mapping of these IDs.

![](MISC/IMG/CSV.png)

## Limitations

- Flow & Power Apps Migrator does not migrate lists and libraries. Use [Move-Lists](https://github.com/Zerg00s/Move-Lists) to migrate SharePoint lists and libraries.
- Does not support macOS and Linux.
- Solutions are not supported. You can only use this script against standalone Power Apps and Cloud flows.
- Only SharePoint data sources are updated.