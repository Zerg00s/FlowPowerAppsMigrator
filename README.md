# Flow & Power Apps Migrator

Have you ever tried moving canvas apps or cloud flows across Microsoft 365 tenants or sites? This is a common task when deploying apps and flows to production. Apps and flows have to be exported, imported and SharePoint actions manually updated. These manual updates are error-prone and labor intensive. **Flow & Power Apps Migrator** automatically converts exported flows and apps to be compatible with the target environment. 

# Prerequisites 

- [Download the latest version of the Flow & Power Apps Migrator](https://github.com/Zerg00s/FlowPowerAppsMigrator/releases/download/1.4/FlowPowerAppsMigrator.zip).
- Extract the ZIP package.
- Run the PowerShell script to install [PnP PowerShell](https://github.com/SharePoint/PnP-PowerShell):
  `Install-Module SharePointPnPPowerShellOnline` 
- Make sure that SharePoint lists and libraries exist in the target environment. 

# Convert flows and apps

## Export flows and apps
First, export all your flows and apps on disk. Place them in the `\src` folder.

![](images/2018-07-25-20-53-52.png)

## 2. Place exported flows and apps in the src folder
![](images/2018-07-25-20-57-29.png)

## 3. Run RunAllSripts.ps1 form PowerShell
The scripts will iterate through all ZIP files inside the `\src` directory and convert them to be compatible with the new Microsoft 365 tenant or site.
- `powershell`
- `cd C:\FlowPowerAppsMigrator`
- `.\RunAllScripts.ps1`

![](images/2018-07-25-21-00-48.png)

Example:

![](images/2018-07-25-21-08-30.png)

## 4. Navigate to the \dist folder and collect converted flows and apps

![](images/2018-07-25-21-11-04.png)

## 5. Import converted flows and apps
Now go ahead and import your flows and apps to the destination tenant. All SharePoint actions are now be converted and to the new location.

![](images/2018-07-25-21-14-55.png)


## How it works

**Flow & Power Apps Migrator** finds all unique IDs pointing to the source SharePoint site and replaces them with the destination IDs. `resourceMapping.csv` contains the mapping of these IDs.
