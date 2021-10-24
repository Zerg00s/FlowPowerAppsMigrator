@ECHO OFF
PowerShell.exe -Command "& '.\Prepare-Deployment-Package-for-Client.ps1' -path '%~dp0'"
PAUSE