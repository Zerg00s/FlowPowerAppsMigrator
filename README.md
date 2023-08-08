![SharePoint Online](https://img.shields.io/badge/SharePoint-Online-yellow.svg) 
![Windows](https://img.shields.io/static/v1?label=OS&message=Windows&color=green)
![Version](https://img.shields.io/static/v1?label=Version&message=3.9.4&color=white)


# Flow & Power Apps Migrator

Have you ever tried moving canvas apps or cloud flows across Microsoft 365 tenants or sites? This is a common task when deploying apps and flows to production. Apps and flows must be exported, and imported, and SharePoint actions must be manually updated. These manual updates are error-prone and labor-intensive. **Flow & Power Apps Migrator** automatically converts exported flows and apps to be compatible with the target environment. 

Flow & Power Apps Migrator also helps you migrate **SharePoint lists** that are used as a dependency for your Apps and Flows. There is an interactive UI form that lets you do just that.

Finally, the Flow & Power Apps Migrator converts **SharePoint List Forms customized with Power Apps**. 

## Download the latest version

<p align='center'>
   <a href="https://github.com/Zerg00s/FlowPowerAppsMigrator/releases" title="Download Flow and Apps Migrator">
     <img src="https://img.shields.io/badge/📩 Download-Migrator Latest Version-%23025a5f.svg?&style=for-the-badge&logoColor=red" />
  </a>&nbsp;&nbsp;     
</p>  

## Watch a Demo 
[![](MISC/IMG/Video_Thumbnail.jpg)](https://youtu.be/06io-y3pMKU)
# Prerequisites 

- [PowerShell 5.0 or later](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/install/installing-windows-powershell?view=powershell-7.2). 
- Make sure that the SharePoint site exists in the target environment. You don't have to create Lists and Libraries because this tool will do it for you.
- [Download the latest version of the Flow & Power Apps Migrator](https://github.com/Zerg00s/FlowPowerAppsMigrator/releases).
- Extract the ZIP package.
- Open a regular Windows PowerShell command prompt.
- Navigate to the extracted folder.
- Unblock the script files using the following command: `Get-ChildItem -Recurse | Unblock-File`

<img style="padding-left:50px" src="MISC/IMG/UnzippedPackage.png">

## Migrate-able artifacts

| Artifact      | Support |
| ----------- | ----------- |
| Standalone Canvas Power Apps | ✔       |
| Customized SharePoint List Forms Canvas apps | ✔ This works again since September 2022   |
| Canvas Power Apps that trigger Flows  | ✔ (flows are also migrated)       |
| Standalone Cloud Flows   | ✔        |
| Standalone Desktop Flows   | ❌        |
| Standalone Model-driven apps   | N/A (not tested)        |
| Solutions containing multiple canvas apps and flows  | ✔        |
| SharePoint Connectors   | ✔        |
| Non-SharePoint Connectors such as Word for Business   | ❌        |
| SharePoint Lists   | ✔        |
| SharePoint Libraries   | ✔        |
| Cross-Language Lists migration    | ❌ Both source and target sites must be created with the same language. Otherwise, you'll get the `0x80070005 (E_ACCESSDENIED)` error   |
| Modern JSON List customizations  | ✔        |
| SharePoint data   | ❌       |
| Content Types   | ✔ (migrated automatically)     |
| Lookup fields   | ⚠️ (migrated only if you migrate the lookup list, too)        |
| Data Sources located in a single site  | ✔        |
| Data Sources located in multiple sites and sub-sites   | ❌        |

# Convert flows, apps and solutions

## Export flows, apps and solutions
Export all of your flows:

![](MISC/IMG/Export.png)

Export all of your apps:

![](MISC/IMG/ExportApp.png)

## 2. Place exported flows, apps and solutions in the src folder
![](MISC/IMG/2018-07-25-20-57-29.png)

## 3. Run Migrate-Packages.bat
The scripts will iterate through all ZIP files inside the `\src` directory and convert them to be compatible with the new Microsoft 365 tenant or site.
- Run `Migrate-Packages.bat` script

<img style="padding-left:50px" src="MISC/IMG/Migrator.png">

- Enter source site URL and target site URL:
- Keep `MIGRATE_LISTS` property set to `True` if you want to migrate SharePoint lists and libraries.

![image](https://user-images.githubusercontent.com/2797648/138607676-dd256f1c-bb9f-4604-9a6e-d3080ae00686.png)

- Select lists and libraries to migrate

![image](https://user-images.githubusercontent.com/2797648/138607789-1471e92e-c8d8-4813-8b1d-2f2deef962eb.png)


- Sit back and wait for the lists and libraries to be migrated and the conversion process to finish.


## 4. Navigate to the \dist folder and collect converted flows, apps and solutions

![](MISC/IMG/2018-07-25-21-11-04.png)

## 5. Import converted flows, apps and solutions
Now you can import your flows and apps to the destination tenant. All SharePoint actions will now be converted and point to the new location.


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
- ZIP packages might not be converted if placed in a long path name on disk. For this reason, try placing the migrator as close to the root drive as possible.

# Preparing a deployment package for your Clients and Partners

What if you created an app or flow you want your Client or Partner to have? You can package your SharePoint Lists and the apps and flows in a single package. Then you would like to hand over this package and simple installation instructions. Guess what? There is a script that prepares this package automatically for you.

`Prepare-Deployment-Package-for-Client.bat` script prepares a deployment package you can share with your Clients or Partners. 

## On your end

- Run `Prepare-Deployment-Package-for-Client.bat`

![image](https://user-images.githubusercontent.com/2797648/138600042-dc80f7ea-cc7a-4240-9c26-3dc2ed617e4b.png)

- Export your Solutions, Power Apps and Flows and save them to the `package\src` directory

![image](https://user-images.githubusercontent.com/2797648/138600112-69dbe03d-3f66-4c4d-858a-d1473358280b.png)

- Send the `package` directory to your Client or Partner.  

![image](https://user-images.githubusercontent.com/2797648/138608613-3ede0cf6-a331-4058-9feb-bf55030c7f55.png)


## On the Client's side

- If it does not already exists, create a SharePoint Online site. It will contain SharePoint Lists and Libraries that Power Apps/Flows require.
- Open the `package` directory.
- Run `Convert-Packages.bat` script. 
- Provide target site URL.
- Import all solutions, flows and apps from the `dist` directory.

**Note:** `Convert-Packages.bat` will:

- Deploy SharePoint lists and libraries (if you want to package them)
- Convert Apps and Flows from `src` and saves them to 'dist'.

![image](https://user-images.githubusercontent.com/2797648/138599549-cef7b847-582e-4e91-8c75-a37a8e82a00d.png)

# Migrating Power Apps SharePoint List Form

SharePoint List forms customized with Power Apps can be migrated if you follow these steps:

- Navigate to your SharePoint List
- Click on one of the SharePoint list items
- Click on the ellipsis (3 dots) > Customize with Power Apps:
![](MISC/IMG/CustomizeWithPowerApps.png)

- Power apps Editor will open.
- Click on File > See all versions
![](MISC/IMG/SeeAllVersions.png)

- Click Export package:
![](MISC/IMG/ExportPackage.png)

- Type your app name
- Select "Create as new" under Import setup
- Click Export

![](MISC/IMG/ExportPackageProperties.png)
- Place the exported package in the `\src` directory
- Run `Migrate-Packages.bat` script


# Latest Updates

### 3.9.4 Version - 2023-08-6
#### Changes
- The pnp:SiteFields node is now automatically removed from the Lists.xml PnP provisioning template if it's empty. An empty node was causing the "invalid template" errors.

### 3.9.3 Version - 2023-07-14
#### Changes
- Removing more fields causing the infamous `0x80070005 (E_ACCESSDENIED)` error.
- Trimming trailing slashes in the site URLs

#### Known issues
- Migrated lists with custom content types end up with an extra content type that should be deleted manually after migration.
- Migrated lists might need fields added to the content type or a form. In some cases, migrated lists show only the Title in the edit form.

### 3.9.2 Version - 2023-07-05
#### Changes
- Removing Site fields causing the infamous `0x80070005 (E_ACCESSDENIED)` error.

#### Known issues
- Migrated lists with custom content types end up with an extra content type that should be deleted manually after migration.
- Migrated lists might need fields added to the content type or a form. In some cases, migrated lists show only the Title in the edit form.

### 3.9.1 Version - 2023-06-11
#### Changes
- fixed a bug reported by [spg-iwilson](https://github.com/spg-iwilson)

#### Known issues
- If the source and the target sites were created using different languages, then the app migrator will fail with the [Access is denied (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))](https://github.com/Zerg00s/FlowPowerAppsMigrator/issues/34) error. 
- Migrated lists with custom content types end up with an extra content type that should be deleted manually after migration.
- Migrated lists might need fields added to the content type or a form. In some cases, migrated lists show only the Title in the edit form.

### 3.9.0 Version - 2023-06-07

#### Changes
- Added an ability to run migrations using SharePoint-only App ID and App Secret. Use the `config\migrator-config.json` file to do it:

```
{
    "source-site-url": "",
    "target-site-url": "",
    "source-site-app-id":"",
    "source-site-app-secret":"",
    "target-site-app-id":"",
    "target-site-app-secret":""
}
```

#### Known issues
- If the source and the target sites were created using different languages, then the app migrator will fail with the [Access is denied (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))](https://github.com/Zerg00s/FlowPowerAppsMigrator/issues/34) error. 
- Migrated lists with custom content types end up with an extra content type that should be deleted manually after migration.
- Migrated lists might need fields added to the content type or a form. In some cases, migrated lists show only the Title in the edit form.

### 3.8.6 Version - 2023-05-10

#### Changes
- Fixed the issue related to the Trace log causing the migratory to fail.

### 3.8.5 Version - 2023-02-20

#### Changes
- Users connected to the source and target sites are now displayed in the console for easier troubleshooting.

### 3.8.4 Version - 2023-02-03

#### Changes
- Fixed the issue caused by lists having multiple personal views.

### 3.8.3 Version - 2022-09-30

#### Changes
- Added a check for the `E_ACCESSDENIED` error.

#### Known issues
- If the source and the target sites were created using different languages, then the app migrator will fail with the [Access is denied (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))](https://github.com/Zerg00s/FlowPowerAppsMigrator/issues/34) error. 
- Migrated lists with custom content types end up with an extra content type that should be deleted manually, after migration.
- Migrated lists might need fields to be added to the content type or a form. In some cases, migrated lists show only Title in the edit form.

### 3.8.2 Version - 2022-09-28

#### Changes
- Added a check of the source and target site permissions. If the user does not have the required permissions, the app migrator will stop and display an error message.

#### Known issues
- Occasional error: [Access is denied (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))](https://github.com/Zerg00s/FlowPowerAppsMigrator/issues/34). This error typically has nothing to do with permissions. It is hard to diagnose, but one of the fixes is to delete a target site and rerun the app migrator.
- Migrated lists with custom content types end up with extra content types that should be deleted manually, after migration.
- Migrated lists might need fields to be added to the content type or a form.


# 👉 [Troubleshooting Guide](https://github.com/Zerg00s/FlowPowerAppsMigrator/wiki/How-to-deal-with-the-%22Make-sure-you-have-FULL-CONTROL-at-the-source-site%22-Issue)

### 3.8.1 Version - 2022-09-04

#### Bug fixes
- Fixed an issue with lists not being migrated

#### Known issues
- Migrated lists with custom content types end up with extra content types that should be deleted manually.
- Migrated lists might need fields to be added to the content type or a form.



### 3.8 Version - 2022-09-04

#### New features
- Added ability to Clear Credentials cache (helpful when your credentials pop-up opens and closes automatically, without prompting you to enter your credentials)

#### Bug fixes
- Fixed an issue with migrating between non-English SharePoint sites. 

#### Known issues
- Migrated lists with custom content types end up with extra content types that should be deleted manually.
- Migrated lists might need fields to be added to the content type or a form.


### 3.7 Version - 2022-09-01

#### New features
- SharePoint list forms customized with Power Apps are now migrated by this tool. Credits to [kvadratnymedved](https://github.com/kvadratnymedved) and [amariak](https://github.com/amariak) for providing a solution. 🙏

#### Known issues
- Migrated lists with custom content types end up with extra content types that should be deleted manually.
- Migrated lists might need fields to be added to the content type or a form.
- Flow & Apps Migrator might cache your user credentials and not prompt you for them again. In this case, you will need to follow the steps [described in this issue](https://github.com/Zerg00s/FlowPowerAppsMigrator/issues/25)


### 3.6 Version 

#### New features
- Added an ability to migrate flows that refer to the List and Library views. This was done to address the issue [List Views not Migrated](https://github.com/Zerg00s/FlowPowerAppsMigrator/issues/22) submitted by [Juistin](https://github.com/C2C-Justin)

#### Known issues
- SharePoint list forms customized with Power Apps are no longer migrated by this tool. There is an issue I am still working on.

### 3.5 Version 

#### New features
- Added an ability to migrate content types and columns. These will be automatically migrated if your lists have any custom content types.

#### Known issues
- SharePoint list forms customized with Power Apps are no longer migrated by this tool. There is an issue I am still working on.


### 3.4 Version 

- Fixed a major bug preventing export-importing for the lists and libraries.

### 3.3 Version 

- Made console output more clear.

### 3.1 Version 

- Fixed a bug that corrupted solution zip files during the conversion process. It made it impossible to import solutions.

### 3.0 Version - Major update

New features added:

- `Migrate-Packages.bat` script now migrates SharePoint lists and libraries that your Apps and Flow depend on.
- Added `Prepare-Deployment-Package-for-Client.bat` script to prepare a deployment package to share with your Clients or Partners. Running this script will generate a package directory you can send to your Clients and Partners. Distribution of your apps and flows is now easier than ever.

### 2.1 Version

New feature added:

- added support for solution migration. Thanks to [Mark Doria](https://www.linkedin.com/in/mark-doria/) for helping with this feature.


## Support this project 
I like coffee and consume lots of it while coding. If you want to support me, you can click on the "buy me a coffee" button:

<br>
<p align='center'>
   <a href="https://www.buymeacoffee.com/DenisMolodtsov" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
</p>  
