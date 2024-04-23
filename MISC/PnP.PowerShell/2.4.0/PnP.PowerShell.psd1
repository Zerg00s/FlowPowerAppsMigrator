@{
	NestedModules =  'Core/PnP.PowerShell.dll'
	ModuleVersion = '2.4.0'
	Description = 'Microsoft 365 Patterns and Practices PowerShell Cmdlets'
	GUID = '0b0430ce-d799-4f3b-a565-f0dca1f31e17'
	Author = 'Microsoft 365 Patterns and Practices'
	CompanyName = 'Microsoft 365 Patterns and Practices'	
	ProcessorArchitecture = 'None'
	FunctionsToExport = '*'  
	CmdletsToExport = @("Add-PnPAdaptiveScopeProperty","Add-PnPEntraIDGroupMember","Add-PnPEntraIDGroupOwner","Add-PnPEntraIDServicePrincipalAppRole","Add-PnPPropertyBagValue","Add-PnPSiteClassification","Clear-PnPEntraIDGroupMember","Clear-PnPEntraIDGroupOwner","Copy-PnPFolder","Get-PnPClientSidePage","Get-PnPEntraIDActivityReportDirectoryAudit","Get-PnPEntraIDActivityReportSignIn","Get-PnPEntraIDApp","Get-PnPEntraIDAppPermission","Get-PnPEntraIDAppSitePermission","Get-PnPEntraIDGroup","Get-PnPEntraIDGroupMember","Get-PnPEntraIDGroupOwner","Get-PnPEntraIDServicePrincipal","Get-PnPEntraIDServicePrincipalAssignedAppRole","Get-PnPEntraIDServicePrincipalAvailableAppRole","Get-PnPEntraIDUser","Get-PnPMicrosoft365GroupMembers","Get-PnPMicrosoft365GroupOwners","Get-PnPPowerPlatformConnector","Get-PnPRetentionLabel","Get-PnPSiteClassification","Get-PnPWebhookSubscriptions","Grant-PnPEntraIDAppSitePermission","Invoke-PnPSearchQuery","Move-PnPClientSideComponent","New-PnPEntraIDGroup","New-PnPEntraIDUserTemporaryAccessPass","Register-PnPEntraIDApp","Remove-PnPClientSidePage","Remove-PnPEntraIDApp","Remove-PnPEntraIDGroup","Remove-PnPEntraIDGroupMember","Remove-PnPEntraIDGroupOwner","Remove-PnPEntraIDServicePrincipalAssignedAppRole","Remove-PnPSiteClassitication","Reset-PnPLabel","Revoke-PnPEntraIDAppSitePermission","Set-PnPClientSidePage","Set-PnPEntraIDAppSitePermission","Set-PnPEntraIDGroup","Set-PnPLabel","Update-PnPVivaConnectionsDashboardACE","Update-SiteClassification","Add-PnPAlert","Add-PnPApp","Add-PnPApplicationCustomizer","Add-PnPAvailableSiteClassification","Add-PnPAzureADGroupMember","Add-PnPAzureADGroupOwner","Add-PnPAzureADServicePrincipalAppRole","Add-PnPContentType","Add-PnPContentTypesFromContentTypeHub","Add-PnPContentTypeToDocumentSet","Add-PnPContentTypeToList","Add-PnPCustomAction","Add-PnPDataRowsToSiteTemplate","Add-PnPDocumentSet","Add-PnPEventReceiver","Add-PnPField","Add-PnPFieldFromXml","Add-PnPFieldToContentType","Add-PnPFile","Add-PnPFileAnonymousSharingLink","Add-PnPFileOrganizationalSharingLink","Add-PnPFileSharingInvite","Add-PnPFileToSiteTemplate","Add-PnPFileUserSharingLink","Add-PnPFlowOwner","Add-PnPFolder","Add-PnPFolderAnonymousSharingLink","Add-PnPFolderOrganizationalSharingLink","Add-PnPFolderSharingInvite","Add-PnPFolderUserSharingLink","Add-PnPGroupMember","Add-PnPHtmlPublishingPageLayout","Add-PnPHubSiteAssociation","Add-PnPHubToHubAssociation","Add-PnPIndexedProperty","Add-PnPJavaScriptBlock","Add-PnPJavaScriptLink","Add-PnPListDesign","Add-PnPListFoldersToSiteTemplate","Add-PnPListItem","Add-PnPListItemAttachment","Add-PnPListItemComment","Add-PnPMasterPage","Add-PnPMicrosoft365GroupMember","Add-PnPMicrosoft365GroupOwner","Add-PnPMicrosoft365GroupToSite","Add-PnPNavigationNode","Add-PnPOrgAssetsLibrary","Add-PnPOrgNewsSite","Add-PnPPage","Add-PnPPageImageWebPart","Add-PnPPageSection","Add-PnPPageTextPart","Add-PnPPageWebPart","Add-PnPPlannerBucket","Add-PnPPlannerRoster","Add-PnPPlannerRosterMember","Add-PnPPlannerTask","Add-PnPPublishingImageRendition","Add-PnPPublishingPage","Add-PnPPublishingPageLayout","Add-PnPRoleDefinition","Add-PnPSiteCollectionAdmin","Add-PnPSiteCollectionAppCatalog","Add-PnPSiteDesign","Add-PnPSiteDesignFromWeb","Add-PnPSiteDesignTask","Add-PnPSiteScript","Add-PnPSiteScriptPackage","Add-PnPSiteTemplate","Add-PnPStoredCredential","Add-PnPTaxonomyField","Add-PnPTeamsChannel","Add-PnPTeamsChannelUser","Add-PnPTeamsTab","Add-PnPTeamsTeam","Add-PnPTeamsUser","Add-PnPTenantCdnOrigin","Add-PnPTenantSequence","Add-PnPTenantSequenceSite","Add-PnPTenantSequenceSubSite","Add-PnPTenantTheme","Add-PnPTermToTerm","Add-PnPView","Add-PnPViewsFromXML","Add-PnPVivaConnectionsDashboardACE","Add-PnPWebhookSubscription","Add-PnPWebPartToWebPartPage","Add-PnPWebPartToWikiPage","Add-PnPWikiPage","Approve-PnPTenantServicePrincipalPermissionRequest","Clear-PnPAzureADGroupMember","Clear-PnPAzureADGroupOwner","Clear-PnPDefaultColumnValues","Clear-PnPListItemAsRecord","Clear-PnPMicrosoft365GroupMember","Clear-PnPMicrosoft365GroupOwner","Clear-PnPRecycleBinItem","Clear-PnPTenantAppCatalogUrl","Clear-PnPTenantRecycleBinItem","Connect-PnPOnline","Convert-PnPFile","Convert-PnPFolderToSiteTemplate","Convert-PnPSiteTemplate","Convert-PnPSiteTemplateToMarkdown","ConvertTo-PnPPage","Copy-PnPFile","Copy-PnPItemProxy","Copy-PnPList","Copy-PnPTeamsTeam","Deny-PnPTenantServicePrincipalPermissionRequest","Disable-PnPFeature","Disable-PnPFlow","Disable-PnPPageScheduling","Disable-PnPPowerShellTelemetry","Disable-PnPSharingForNonOwnersOfSite","Disable-PnPSiteClassification","Disable-PnPTenantServicePrincipal","Disconnect-PnPOnline","Enable-PnPCommSite","Enable-PnPFeature","Enable-PnPFlow","Enable-PnPPageScheduling","Enable-PnPPowerShellTelemetry","Enable-PnPSiteClassification","Enable-PnPTenantServicePrincipal","Export-PnPFlow","Export-PnPListToSiteTemplate","Export-PnPPage","Export-PnPPageMapping","Export-PnPPowerApp","Export-PnPTaxonomy","Export-PnPTermGroupToXml","Export-PnPUserInfo","Export-PnPUserProfile","Find-PnPFile","Get-PnPAccessToken","Get-PnPAlert","Get-PnPApp","Get-PnPAppAuthAccessToken","Get-PnPAppErrors","Get-PnPAppInfo","Get-PnPApplicationCustomizer","Get-PnPAuditing","Get-PnPAuthenticationRealm","Get-PnPAvailableLanguage","Get-PnPAvailablePageComponents","Get-PnPAvailableSensitivityLabel","Get-PnPAvailableSiteClassification","Get-PnPAzureACSPrincipal","Get-PnPAzureADActivityReportDirectoryAudit","Get-PnPAzureADActivityReportSignIn","Get-PnPAzureADApp","Get-PnPAzureADAppPermission","Get-PnPAzureADAppSitePermission","Get-PnPAzureADGroup","Get-PnPAzureADGroupMember","Get-PnPAzureADGroupOwner","Get-PnPAzureADServicePrincipal","Get-PnPAzureADServicePrincipalAssignedAppRole","Get-PnPAzureADServicePrincipalAvailableAppRole","Get-PnPAzureADUser","Get-PnPAzureCertificate","Get-PnPBrowserIdleSignout","Get-PnPBuiltInDesignPackageVisibility","Get-PnPBuiltInSiteTemplateSettings","Get-PnPChangeLog","Get-PnPCompatibleHubContentTypes","Get-PnPConnection","Get-PnPContainer","Get-PnPContainerTypeConfiguration","Get-PnPContentType","Get-PnPContentTypePublishingHubUrl","Get-PnPContentTypePublishingStatus","Get-PnPContext","Get-PnPCustomAction","Get-PnPDefaultColumnValues","Get-PnPDeletedContainer","Get-PnPDeletedMicrosoft365Group","Get-PnPDeletedTeam","Get-PnPDiagnostics","Get-PnPDisableSpacesActivation","Get-PnPDocumentSetTemplate","Get-PnPEventReceiver","Get-PnPException","Get-PnPExternalUser","Get-PnPFeature","Get-PnPField","Get-PnPFile","Get-PnPFileAnalyticsData","Get-PnPFileInFolder","Get-PnPFileSharingLink","Get-PnPFileVersion","Get-PnPFlow","Get-PnPFlowOwner","Get-PnPFlowRun","Get-PnPFolder","Get-PnPFolderInFolder","Get-PnPFolderItem","Get-PnPFolderSharingLink","Get-PnPFolderStorageMetric","Get-PnPFooter","Get-PnPGraphAccessToken","Get-PnPGraphSubscription","Get-PnPGroup","Get-PnPGroupMember","Get-PnPGroupPermissions","Get-PnPHideDefaultThemes","Get-PnPHomePage","Get-PnPHomeSite","Get-PnPHubSite","Get-PnPHubSiteChild","Get-PnPIndexedPropertyKeys","Get-PnPInPlaceRecordsManagement","Get-PnPIsSiteAliasAvailable","Get-PnPJavaScriptLink","Get-PnPKnowledgeHubSite","Get-PnPLabel","Get-PnPLargeListOperationStatus","Get-PnPList","Get-PnPListDesign","Get-PnPListInformationRightsManagement","Get-PnPListItem","Get-PnPListItemAttachment","Get-PnPListItemComment","Get-PnPListItemPermission","Get-PnPListItemVersion","Get-PnPListPermissions","Get-PnPListRecordDeclaration","Get-PnPMasterPage","Get-PnPMessageCenterAnnouncement","Get-PnPMicrosoft365ExpiringGroup","Get-PnPMicrosoft365Group","Get-PnPMicrosoft365GroupEndpoint","Get-PnPMicrosoft365GroupMember","Get-PnPMicrosoft365GroupOwner","Get-PnPMicrosoft365GroupSettings","Get-PnPMicrosoft365GroupSettingTemplates","Get-PnPMicrosoft365GroupTeam","Get-PnPMicrosoft365GroupYammerCommunity","Get-PnPNavigationNode","Get-PnPOrgAssetsLibrary","Get-PnPOrgNewsSite","Get-PnPPage","Get-PnPPageComponent","Get-PnPPageLikedByInformation","Get-PnPPlannerBucket","Get-PnPPlannerConfiguration","Get-PnPPlannerPlan","Get-PnPPlannerRosterMember","Get-PnPPlannerRosterPlan","Get-PnPPlannerTask","Get-PnPPlannerUserPolicy","Get-PnPPowerApp","Get-PnPPowerPlatformCustomConnector","Get-PnPPowerPlatformEnvironment","Get-PnPPowerPlatformSolution","Get-PnPPowerShellTelemetryEnabled","Get-PnPProperty","Get-PnPPropertyBag","Get-PnPPublishingImageRendition","Get-PnPRecycleBinItem","Get-PnPRequestAccessEmails","Get-PnPRoleDefinition","Get-PnPSearchConfiguration","Get-PnPSearchCrawlLog","Get-PnPSearchSettings","Get-PnPServiceCurrentHealth","Get-PnPServiceHealthIssue","Get-PnPSharePointAddIn","Get-PnPSharingForNonOwnersOfSite","Get-PnPSite","Get-PnPSiteAnalyticsData","Get-PnPSiteClosure","Get-PnPSiteCollectionAdmin","Get-PnPSiteCollectionAppCatalog","Get-PnPSiteCollectionTermStore","Get-PnPSiteDesign","Get-PnPSiteDesignRights","Get-PnPSiteDesignRun","Get-PnPSiteDesignRunStatus","Get-PnPSiteDesignTask","Get-PnPSiteGroup","Get-PnPSitePolicy","Get-PnPSiteScript","Get-PnPSiteScriptFromList","Get-PnPSiteScriptFromWeb","Get-PnPSiteSearchQueryResults","Get-PnPSiteSensitivityLabel","Get-PnPSiteTemplate","Get-PnPSiteUserInvitations","Get-PnPSiteVersionPolicy","Get-PnPSiteVersionPolicyProgress","Get-PnPStorageEntity","Get-PnPStoredCredential","Get-PnPStructuralNavigationCacheSiteState","Get-PnPStructuralNavigationCacheWebState","Get-PnPSubWeb","Get-PnPSyntexModel","Get-PnPSyntexModelPublication","Get-PnPTaxonomyItem","Get-PnPTaxonomySession","Get-PnPTeamsApp","Get-PnPTeamsChannel","Get-PnPTeamsChannelFilesFolder","Get-PnPTeamsChannelMessage","Get-PnPTeamsChannelMessageReply","Get-PnPTeamsChannelUser","Get-PnPTeamsPrimaryChannel","Get-PnPTeamsTab","Get-PnPTeamsTag","Get-PnPTeamsTeam","Get-PnPTeamsUser","Get-PnPTemporarilyDisableAppBar","Get-PnPTenant","Get-PnPTenantAppCatalogUrl","Get-PnPTenantCdnEnabled","Get-PnPTenantCdnOrigin","Get-PnPTenantCdnPolicies","Get-PnPTenantDeletedSite","Get-PnPTenantId","Get-PnPTenantInfo","Get-PnPTenantInstance","Get-PnPTenantRecycleBinItem","Get-PnPTenantRetentionLabel","Get-PnPTenantSequence","Get-PnPTenantSequenceSite","Get-PnPTenantServicePrincipal","Get-PnPTenantServicePrincipalPermissionGrants","Get-PnPTenantServicePrincipalPermissionRequests","Get-PnPTenantSite","Get-PnPTenantSyncClientRestriction","Get-PnPTenantTemplate","Get-PnPTenantTheme","Get-PnPTerm","Get-PnPTermGroup","Get-PnPTermLabel","Get-PnPTermSet","Get-PnPTheme","Get-PnPTimeZoneId","Get-PnPUnfurlLink","Get-PnPUnifiedAuditLog","Get-PnPUPABulkImportStatus","Get-PnPUser","Get-PnPUserOneDriveQuota","Get-PnPUserProfileProperty","Get-PnPView","Get-PnPVivaConnectionsDashboardACE","Get-PnPWeb","Get-PnPWebHeader","Get-PnPWebhookSubscription","Get-PnPWebPart","Get-PnPWebPartProperty","Get-PnPWebPartXml","Get-PnPWebPermission","Get-PnPWebTemplates","Get-PnPWikiPageContent","Grant-PnPAzureADAppSitePermission","Grant-PnPHubSiteRights","Grant-PnPSiteDesignRights","Grant-PnPTenantServicePrincipalPermission","Import-PnPTaxonomy","Import-PnPTermGroupFromXml","Import-PnPTermSet","Install-PnPApp","Invoke-PnPBatch","Invoke-PnPGraphMethod","Invoke-PnPListDesign","Invoke-PnPQuery","Invoke-PnPSiteDesign","Invoke-PnPSiteScript","Invoke-PnPSiteSwap","Invoke-PnPSiteTemplate","Invoke-PnPSPRestMethod","Invoke-PnPTenantTemplate","Invoke-PnPTransformation","Invoke-PnPWebAction","Measure-PnPList","Measure-PnPWeb","Merge-PnPTerm","Move-PnPFile","Move-PnPFolder","Move-PnPItemProxy","Move-PnPListItemToRecycleBin","Move-PnPPageComponent","Move-PnPRecycleBinItem","Move-PnPTerm","Move-PnPTermSet","New-PnPAzureADGroup","New-PnPAzureADUserTemporaryAccessPass","New-PnPAzureCertificate","New-PnPBatch","New-PnPContainerType","New-PnPExtensibilityHandlerObject","New-PnPGraphSubscription","New-PnPGroup","New-PnPList","New-PnPMicrosoft365Group","New-PnPMicrosoft365GroupSettings","New-PnPPersonalSite","New-PnPPlannerPlan","New-PnPSdnProvider","New-PnPSite","New-PnPSiteCollectionTermStore","New-PnPSiteGroup","New-PnPSiteTemplate","New-PnPSiteTemplateFromFolder","New-PnPTeamsApp","New-PnPTeamsTeam","New-PnPTenantSequence","New-PnPTenantSequenceCommunicationSite","New-PnPTenantSequenceTeamNoGroupSite","New-PnPTenantSequenceTeamNoGroupSubSite","New-PnPTenantSequenceTeamSite","New-PnPTenantSite","New-PnPTenantTemplate","New-PnPTerm","New-PnPTermGroup","New-PnPTermLabel","New-PnPTermSet","New-PnPUPABulkImportJob","New-PnPUser","New-PnPWeb","Publish-PnPApp","Publish-PnPCompanyApp","Publish-PnPContentType","Publish-PnPSyntexModel","Read-PnPSiteTemplate","Read-PnPTenantTemplate","Receive-PnPCopyMoveJobStatus","Register-PnPAppCatalogSite","Register-PnPAzureADApp","Register-PnPHubSite","Register-PnPManagementShellAccess","Remove-PnPAdaptiveScopeProperty","Remove-PnPAlert","Remove-PnPApp","Remove-PnPApplicationCustomizer","Remove-PnPAvailableSiteClassification","Remove-PnPAzureADApp","Remove-PnPAzureADGroup","Remove-PnPAzureADGroupMember","Remove-PnPAzureADGroupOwner","Remove-PnPAzureADServicePrincipalAssignedAppRole","Remove-PnPContainer","Remove-PnPContainerType","Remove-PnPContentType","Remove-PnPContentTypeFromDocumentSet","Remove-PnPContentTypeFromList","Remove-PnPCustomAction","Remove-PnPDeletedMicrosoft365Group","Remove-PnPEventReceiver","Remove-PnPExternalUser","Remove-PnPField","Remove-PnPFieldFromContentType","Remove-PnPFile","Remove-PnPFileFromSiteTemplate","Remove-PnPFileSharingLink","Remove-PnPFileVersion","Remove-PnPFlow","Remove-PnPFlowOwner","Remove-PnPFolder","Remove-PnPFolderSharingLink","Remove-PnPGraphSubscription","Remove-PnPGroup","Remove-PnPGroupMember","Remove-PnPHomeSite","Remove-PnPHubSiteAssociation","Remove-PnPHubToHubAssociation","Remove-PnPIndexedProperty","Remove-PnPJavaScriptLink","Remove-PnPKnowledgeHubSite","Remove-PnPList","Remove-PnPListDesign","Remove-PnPListItem","Remove-PnPListItemAttachment","Remove-PnPListItemComment","Remove-PnPListItemVersion","Remove-PnPMicrosoft365Group","Remove-PnPMicrosoft365GroupMember","Remove-PnPMicrosoft365GroupOwner","Remove-PnPMicrosoft365GroupPhoto","Remove-PnPMicrosoft365GroupSettings","Remove-PnPNavigationNode","Remove-PnPOrgAssetsLibrary","Remove-PnPOrgNewsSite","Remove-PnPPage","Remove-PnPPageComponent","Remove-PnPPlannerBucket","Remove-PnPPlannerPlan","Remove-PnPPlannerRoster","Remove-PnPPlannerRosterMember","Remove-PnPPlannerTask","Remove-PnPPropertyBagValue","Remove-PnPPublishingImageRendition","Remove-PnPRoleDefinition","Remove-PnPSdnProvider","Remove-PnPSearchConfiguration","Remove-PnPSiteCollectionAdmin","Remove-PnPSiteCollectionAppCatalog","Remove-PnPSiteCollectionTermStore","Remove-PnPSiteDesign","Remove-PnPSiteDesignTask","Remove-PnPSiteGroup","Remove-PnPSiteScript","Remove-PnPSiteSensitivityLabel","Remove-PnPSiteUserInvitations","Remove-PnPStorageEntity","Remove-PnPStoredCredential","Remove-PnPTaxonomyItem","Remove-PnPTeamsApp","Remove-PnPTeamsChannel","Remove-PnPTeamsChannelUser","Remove-PnPTeamsTab","Remove-PnPTeamsTag","Remove-PnPTeamsTeam","Remove-PnPTeamsUser","Remove-PnPTenantCdnOrigin","Remove-PnPTenantDeletedSite","Remove-PnPTenantSite","Remove-PnPTenantSyncClientRestriction","Remove-PnPTenantTheme","Remove-PnPTerm","Remove-PnPTermGroup","Remove-PnPTermLabel","Remove-PnPUser","Remove-PnPUserInfo","Remove-PnPUserProfile","Remove-PnPView","Remove-PnPVivaConnectionsDashboardACE","Remove-PnPWeb","Remove-PnPWebhookSubscription","Remove-PnPWebPart","Remove-PnPWikiPage","Rename-PnPFile","Rename-PnPFolder","Rename-PnPTenantSite","Repair-PnPSite","Request-PnPAccessToken","Request-PnPPersonalSite","Request-PnPReIndexList","Request-PnPReIndexWeb","Request-PnPSyntexClassifyAndExtract","Reset-PnPFileVersion","Reset-PnPMicrosoft365GroupExpiration","Reset-PnPRetentionLabel","Reset-PnPUserOneDriveQuotaToDefault","Resolve-PnPFolder","Restart-PnPFlowRun","Restore-PnPDeletedContainer","Restore-PnPDeletedMicrosoft365Group","Restore-PnPFileVersion","Restore-PnPListItemVersion","Restore-PnPRecycleBinItem","Restore-PnPTenantRecycleBinItem","Restore-PnPTenantSite","Revoke-PnPAzureADAppSitePermission","Revoke-PnPHubSiteRights","Revoke-PnPSiteDesignRights","Revoke-PnPTenantServicePrincipalPermission","Revoke-PnPUserSession","Save-PnPPageConversionLog","Save-PnPSiteTemplate","Save-PnPTenantTemplate","Send-PnPMail","Set-PnPAdaptiveScopeProperty","Set-PnPApplicationCustomizer","Set-PnPAppSideLoading","Set-PnPAuditing","Set-PnPAvailablePageLayouts","Set-PnPAzureADAppSitePermission","Set-PnPAzureADGroup","Set-PnPBrowserIdleSignout","Set-PnPBuiltInDesignPackageVisibility","Set-PnPBuiltInSiteTemplateSettings","Set-PnPContentType","Set-PnPContext","Set-PnPDefaultColumnValues","Set-PnPDefaultContentTypeToList","Set-PnPDefaultPageLayout","Set-PnPDisableSpacesActivation","Set-PnPDocumentSetField","Set-PnPField","Set-PnPFileCheckedIn","Set-PnPFileCheckedOut","Set-PnPFolderPermission","Set-PnPFooter","Set-PnPGraphSubscription","Set-PnPGroup","Set-PnPGroupPermissions","Set-PnPHideDefaultThemes","Set-PnPHomePage","Set-PnPHomeSite","Set-PnPHubSite","Set-PnPImageListItemColumn","Set-PnPIndexedProperties","Set-PnPInPlaceRecordsManagement","Set-PnPKnowledgeHubSite","Set-PnPList","Set-PnPListInformationRightsManagement","Set-PnPListItem","Set-PnPListItemAsRecord","Set-PnPListItemPermission","Set-PnPListPermission","Set-PnPListRecordDeclaration","Set-PnPMasterPage","Set-PnPMessageCenterAnnouncementAsArchived","Set-PnPMessageCenterAnnouncementAsFavorite","Set-PnPMessageCenterAnnouncementAsNotArchived","Set-PnPMessageCenterAnnouncementAsNotFavorite","Set-PnPMessageCenterAnnouncementAsRead","Set-PnPMessageCenterAnnouncementAsUnread","Set-PnPMicrosoft365Group","Set-PnPMicrosoft365GroupSettings","Set-PnPMinimalDownloadStrategy","Set-PnPPage","Set-PnPPageTextPart","Set-PnPPageWebPart","Set-PnPPlannerBucket","Set-PnPPlannerConfiguration","Set-PnPPlannerPlan","Set-PnPPlannerTask","Set-PnPPlannerUserPolicy","Set-PnPPropertyBagValue","Set-PnPRequestAccessEmails","Set-PnPRetentionLabel","Set-PnPRoleDefinition","Set-PnPSearchConfiguration","Set-PnPSearchExternalItem","Set-PnPSearchSettings","Set-PnPSite","Set-PnPSiteArchiveState","Set-PnPSiteClassification","Set-PnPSiteClosure","Set-PnPSiteDesign","Set-PnPSiteGroup","Set-PnPSitePolicy","Set-PnPSiteScript","Set-PnPSiteScriptPackage","Set-PnPSiteSensitivityLabel","Set-PnPSiteTemplateMetadata","Set-PnPSiteVersionPolicy","Set-PnPStorageEntity","Set-PnPStructuralNavigationCacheSiteState","Set-PnPStructuralNavigationCacheWebState","Set-PnPTaxonomyFieldValue","Set-PnPTeamifyPromptHidden","Set-PnPTeamsChannel","Set-PnPTeamsChannelUser","Set-PnPTeamsTab","Set-PnPTeamsTag","Set-PnPTeamsTeam","Set-PnPTeamsTeamArchivedState","Set-PnPTeamsTeamPicture","Set-PnPTemporarilyDisableAppBar","Set-PnPTenant","Set-PnPTenantAppCatalogUrl","Set-PnPTenantCdnEnabled","Set-PnPTenantCdnPolicy","Set-PnPTenantSite","Set-PnPTenantSyncClientRestriction","Set-PnPTerm","Set-PnPTermGroup","Set-PnPTermSet","Set-PnPTheme","Set-PnPTraceLog","Set-PnPUserOneDriveQuota","Set-PnPUserProfileProperty","Set-PnPView","Set-PnPVivaConnectionsDashboardACE","Set-PnPWeb","Set-PnPWebHeader","Set-PnPWebhookSubscription","Set-PnPWebPartProperty","Set-PnPWebPermission","Set-PnPWebTheme","Set-PnPWikiPageContent","Stop-PnPFlowRun","Submit-PnPSearchQuery","Submit-PnPTeamsChannelMessage","Sync-PnPAppToTeams","Sync-PnPSharePointUserProfilesFromAzureActiveDirectory","Test-PnPListItemIsRecord","Test-PnPMicrosoft365GroupAliasIsUsed","Test-PnPSite","Test-PnPTenantTemplate","Undo-PnPFileCheckedOut","Uninstall-PnPApp","Unpublish-PnPApp","Unpublish-PnPContentType","Unpublish-PnPSyntexModel","Unregister-PnPHubSite","Update-PnPApp","Update-PnPAvailableSiteClassification","Update-PnPSiteDesignFromWeb","Update-PnPTeamsApp","Update-PnPTeamsUser","Update-PnPUserType")
	VariablesToExport = '*'
	AliasesToExport = '*'
	FormatsToProcess = 'PnP.PowerShell.Format.ps1xml'
	PowerShellVersion = '7.2'
	PrivateData = @{
		PSData = @{
			Tags = 'SharePoint','PnP','Teams','Planner'
			ProjectUri = 'https://aka.ms/sppnp'
			IconUri = 'https://raw.githubusercontent.com/pnp/media/40e7cd8952a9347ea44e5572bb0e49622a102a12/parker/ms/300w/parker-ms-300.png'
		}
	}
}

# SIG # Begin signature block
# MIInywYJKoZIhvcNAQcCoIInvDCCJ7gCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA9G5lbsz+SmbCG
# +VwkJT5cpWKwWQ7UzabjLGrKbuQOE6CCDYUwggYDMIID66ADAgECAhMzAAADri01
# UchTj1UdAAAAAAOuMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjMxMTE2MTkwODU5WhcNMjQxMTE0MTkwODU5WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQD0IPymNjfDEKg+YyE6SjDvJwKW1+pieqTjAY0CnOHZ1Nj5irGjNZPMlQ4HfxXG
# yAVCZcEWE4x2sZgam872R1s0+TAelOtbqFmoW4suJHAYoTHhkznNVKpscm5fZ899
# QnReZv5WtWwbD8HAFXbPPStW2JKCqPcZ54Y6wbuWV9bKtKPImqbkMcTejTgEAj82
# 6GQc6/Th66Koka8cUIvz59e/IP04DGrh9wkq2jIFvQ8EDegw1B4KyJTIs76+hmpV
# M5SwBZjRs3liOQrierkNVo11WuujB3kBf2CbPoP9MlOyyezqkMIbTRj4OHeKlamd
# WaSFhwHLJRIQpfc8sLwOSIBBAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUhx/vdKmXhwc4WiWXbsf0I53h8T8w
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzUwMTgzNjAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# AGrJYDUS7s8o0yNprGXRXuAnRcHKxSjFmW4wclcUTYsQZkhnbMwthWM6cAYb/h2W
# 5GNKtlmj/y/CThe3y/o0EH2h+jwfU/9eJ0fK1ZO/2WD0xi777qU+a7l8KjMPdwjY
# 0tk9bYEGEZfYPRHy1AGPQVuZlG4i5ymJDsMrcIcqV8pxzsw/yk/O4y/nlOjHz4oV
# APU0br5t9tgD8E08GSDi3I6H57Ftod9w26h0MlQiOr10Xqhr5iPLS7SlQwj8HW37
# ybqsmjQpKhmWul6xiXSNGGm36GarHy4Q1egYlxhlUnk3ZKSr3QtWIo1GGL03hT57
# xzjL25fKiZQX/q+II8nuG5M0Qmjvl6Egltr4hZ3e3FQRzRHfLoNPq3ELpxbWdH8t
# Nuj0j/x9Crnfwbki8n57mJKI5JVWRWTSLmbTcDDLkTZlJLg9V1BIJwXGY3i2kR9i
# 5HsADL8YlW0gMWVSlKB1eiSlK6LmFi0rVH16dde+j5T/EaQtFz6qngN7d1lvO7uk
# 6rtX+MLKG4LDRsQgBTi6sIYiKntMjoYFHMPvI/OMUip5ljtLitVbkFGfagSqmbxK
# 7rJMhC8wiTzHanBg1Rrbff1niBbnFbbV4UDmYumjs1FIpFCazk6AADXxoKCo5TsO
# zSHqr9gHgGYQC2hMyX9MGLIpowYCURx3L7kUiGbOiMwaMIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCGZwwghmYAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAAOuLTVRyFOPVR0AAAAA
# A64wDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIFnm
# k8WcQd5GVlYYYhx7dyMRcMAGSKzq+as8cU/eo8gZMEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEAAn45RnKP3zPJHhau9aAqNm9L6dTVwSbD4E8J
# +0e3Vwzc5l4GVz4VRpDIsc5lxNxJYpXsIbADU+ltJ1PNW82PyBTLLPIYzXynfdD+
# L1Itl4QLvQxKA/cuuWQ8cAtFIrR58UWRlhmpSCvpMiL6hhUqRp/whKXYgTfboJ+1
# +6RMjIg1YMyV6F6F1voGIFBl73E6iICTqawzCb5SjewQf9NvN2uWEMAmPHYSQN7O
# +GHBYSL5lRoNkFwtqXDS0XrXhl+MN70EGNv2CHMdPDusIUAKRnPGou5QWZ+Yb/HF
# UDSKo73od+8J97lmifafWXHswzR77reD+RLsixmq5ZudPnR3uaGCFyYwghciBgor
# BgEEAYI3AwMBMYIXEjCCFw4GCSqGSIb3DQEHAqCCFv8wghb7AgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFXBgsqhkiG9w0BCRABBKCCAUYEggFCMIIBPgIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCC/BlULLqREP77t/ePuaXn1g7o+8Ae4wM5o
# porNet4qggIGZdXlajv9GBEyMDI0MDMwMTE1Mjc1OC44WjAEgAIB9KCB2KSB1TCB
# 0jELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMk
# TWljcm9zb2Z0IElyZWxhbmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1U
# aGFsZXMgVFNTIEVTTjowODQyLTRCRTYtQzI5QTElMCMGA1UEAxMcTWljcm9zb2Z0
# IFRpbWUtU3RhbXAgU2VydmljZaCCEXcwggcnMIIFD6ADAgECAhMzAAAB2o7VyVoA
# 0RGxAAEAAAHaMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBD
# QSAyMDEwMB4XDTIzMTAxMjE5MDY1OVoXDTI1MDExMDE5MDY1OVowgdIxCzAJBgNV
# BAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4w
# HAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29m
# dCBJcmVsYW5kIE9wZXJhdGlvbnMgTGltaXRlZDEmMCQGA1UECxMdVGhhbGVzIFRT
# UyBFU046MDg0Mi00QkU2LUMyOUExJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0
# YW1wIFNlcnZpY2UwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCTkAYI
# drVRUdY/I0AODQ3/G3Fa10jdPNAjSj0kKO0ue7Apz1NBSheO8Ni+qh7cJuBJwpRd
# nK7lxaf5ez6TEINuRO1/MQ5r8a/AQROogEgDwn603m7rwLGVnCWIcu6a4ArgX+zo
# nV6YLFtcvKelbO7A9mrqf9Lr3mMXl5SrbD4zAqZR5JNG2vh4C4aNCevCnY4twzNi
# ufcB8vca7bGCvl/Xq2wxmdppl9++uWkuUO/7oA8TFYM8o/NMiZ+lC55Jw/YuJFEM
# VYaldXXPwxelAXrs37pJDHne7a81BGTEcpWu6ob8FHkJYMwkIaWY8/s7EIKV5T3M
# 7xndIqq+5QAsH1RqIOaZSM3RMb7dUwPCZnn/NfWkysB9SFRCMGCwOrr0vJEXQOkc
# bzHG//7pTYyLhnHsspDAFxMp1ayxvVbyuK36wrBi9499C5onboPqMK3Ao0GoGJqx
# pNYQcpF4paPWAfEMsuUNSoRrh+uVd8xcvGtJMGygUbPFUeB7aD2MPc9Q3XCX2QTt
# nYc198gDIqQhpukpr5r2r0bF4cvNOY4gKQ8jfrNP2+6LNs/IkVhiZOjPbrk9uPd4
# BVf/SSxoOWCSQiVyPssZDvzl52SbLhrdPs1i3R0uFyFwRte6D7uSrBX0Ux0RJaEd
# nSOhsGmsSMg8kh2DrbyMnZWu7uJX53wo2P6ikwIDAQABo4IBSTCCAUUwHQYDVR0O
# BBYEFKF8jclRPWYTlYsxFFcITYC/D19FMB8GA1UdIwQYMBaAFJ+nFV0AXmJdg/Tl
# 0mWnG1M1GelyMF8GA1UdHwRYMFYwVKBSoFCGTmh0dHA6Ly93d3cubWljcm9zb2Z0
# LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUyMFRpbWUtU3RhbXAlMjBQQ0ElMjAy
# MDEwKDEpLmNybDBsBggrBgEFBQcBAQRgMF4wXAYIKwYBBQUHMAKGUGh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2VydHMvTWljcm9zb2Z0JTIwVGltZS1T
# dGFtcCUyMFBDQSUyMDIwMTAoMSkuY3J0MAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/
# BAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQDAgeAMA0GCSqGSIb3DQEBCwUAA4IC
# AQC5g1XU7biNIwBLeNTtjjPAlNt+0xjMoaxq+xcyghBWl8baKpPyDm0K4qtXGh1Y
# dr8rkNuJ8903Tgb+63LP6pz4zsZ1xS8mT3mli7DbgEVZlFYslWF412AeQ8M2lmYE
# nGPBii+8ho8lq4e/FiVIIe6xNfuVQ+YdP+q7PXQUagMyPX4Wc+7KbI7fL58edFhM
# WwUkh+632mx3p3aXqm05lv0X3Gk/hhSLE/oNno+8ESiKv0IZ7KBfJqRTTx1dav1i
# v6xfwoaL5ISTA75arRE1ovexqJTkimpmQvW2IHDyn89vHnduVictdFbUPT+fgv9n
# Tnw2s9UZnjm9uym3oIWtEnz3K4k3zkVb6jw0mt5/Te3YU2O/uPSPHr6GnfYXWfAn
# yDj37cLd8U19kYTGSQlaBZWmx3L32/OK2hTOnM+RGJPsdWlRIl7YCukdMZ9cIzFx
# 39AFpUo6kZM70p0SsxbGcBJe+FWoZSlYSPgovUU/fuhnNMVsye80CFBRNyYosefu
# yi/AKx3wWPVBS8+LJ26Ce0IqdyAA25FOGS9IkPI/CMa2u2kmH06FHn5nLd3TOvX3
# +BHodiofTbCooqYefPQKf8UtYxEpa34y/4P2W6GkuXfWtnwOffJrmw7yw+ceTz9+
# +9NL5v2PjyIZqdn077ktrJ3XmQZsk6nFDR0TZgpPp41d5zCCB3EwggVZoAMCAQIC
# EzMAAAAVxedrngKbSZkAAAAAABUwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBS
# b290IENlcnRpZmljYXRlIEF1dGhvcml0eSAyMDEwMB4XDTIxMDkzMDE4MjIyNVoX
# DTMwMDkzMDE4MzIyNVowfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwggIi
# MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDk4aZM57RyIQt5osvXJHm9DtWC
# 0/3unAcH0qlsTnXIyjVX9gF/bErg4r25PhdgM/9cT8dm95VTcVrifkpa/rg2Z4VG
# Iwy1jRPPdzLAEBjoYH1qUoNEt6aORmsHFPPFdvWGUNzBRMhxXFExN6AKOG6N7dcP
# 2CZTfDlhAnrEqv1yaa8dq6z2Nr41JmTamDu6GnszrYBbfowQHJ1S/rboYiXcag/P
# XfT+jlPP1uyFVk3v3byNpOORj7I5LFGc6XBpDco2LXCOMcg1KL3jtIckw+DJj361
# VI/c+gVVmG1oO5pGve2krnopN6zL64NF50ZuyjLVwIYwXE8s4mKyzbnijYjklqwB
# Sru+cakXW2dg3viSkR4dPf0gz3N9QZpGdc3EXzTdEonW/aUgfX782Z5F37ZyL9t9
# X4C626p+Nuw2TPYrbqgSUei/BQOj0XOmTTd0lBw0gg/wEPK3Rxjtp+iZfD9M269e
# wvPV2HM9Q07BMzlMjgK8QmguEOqEUUbi0b1qGFphAXPKZ6Je1yh2AuIzGHLXpyDw
# wvoSCtdjbwzJNmSLW6CmgyFdXzB0kZSU2LlQ+QuJYfM2BjUYhEfb3BvR/bLUHMVr
# 9lxSUV0S2yW6r1AFemzFER1y7435UsSFF5PAPBXbGjfHCBUYP3irRbb1Hode2o+e
# FnJpxq57t7c+auIurQIDAQABo4IB3TCCAdkwEgYJKwYBBAGCNxUBBAUCAwEAATAj
# BgkrBgEEAYI3FQIEFgQUKqdS/mTEmr6CkTxGNSnPEP8vBO4wHQYDVR0OBBYEFJ+n
# FV0AXmJdg/Tl0mWnG1M1GelyMFwGA1UdIARVMFMwUQYMKwYBBAGCN0yDfQEBMEEw
# PwYIKwYBBQUHAgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvRG9j
# cy9SZXBvc2l0b3J5Lmh0bTATBgNVHSUEDDAKBggrBgEFBQcDCDAZBgkrBgEEAYI3
# FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAf
# BgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvXzpoYxDBWBgNVHR8ETzBNMEugSaBH
# hkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNS
# b29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUF
# BzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0Nl
# ckF1dF8yMDEwLTA2LTIzLmNydDANBgkqhkiG9w0BAQsFAAOCAgEAnVV9/Cqt4Swf
# ZwExJFvhnnJL/Klv6lwUtj5OR2R4sQaTlz0xM7U518JxNj/aZGx80HU5bbsPMeTC
# j/ts0aGUGCLu6WZnOlNN3Zi6th542DYunKmCVgADsAW+iehp4LoJ7nvfam++Kctu
# 2D9IdQHZGN5tggz1bSNU5HhTdSRXud2f8449xvNo32X2pFaq95W2KFUn0CS9QKC/
# GbYSEhFdPSfgQJY4rPf5KYnDvBewVIVCs/wMnosZiefwC2qBwoEZQhlSdYo2wh3D
# YXMuLGt7bj8sCXgU6ZGyqVvfSaN0DLzskYDSPeZKPmY7T7uG+jIa2Zb0j/aRAfbO
# xnT99kxybxCrdTDFNLB62FD+CljdQDzHVG2dY3RILLFORy3BFARxv2T5JL5zbcqO
# Cb2zAVdJVGTZc9d/HltEAY5aGZFrDZ+kKNxnGSgkujhLmm77IVRrakURR6nxt67I
# 6IleT53S0Ex2tVdUCbFpAUR+fKFhbHP+CrvsQWY9af3LwUFJfn6Tvsv4O+S3Fb+0
# zj6lMVGEvL8CwYKiexcdFYmNcP7ntdAoGokLjzbaukz5m/8K6TT4JDVnK+ANuOaM
# mdbhIurwJ0I9JZTmdHRbatGePu1+oDEzfbzL6Xu/OHBE0ZDxyKs6ijoIYn/ZcGNT
# TY3ugm2lBRDBcQZqELQdVTNYs6FwZvKhggLTMIICPAIBATCCAQChgdikgdUwgdIx
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1p
# Y3Jvc29mdCBJcmVsYW5kIE9wZXJhdGlvbnMgTGltaXRlZDEmMCQGA1UECxMdVGhh
# bGVzIFRTUyBFU046MDg0Mi00QkU2LUMyOUExJTAjBgNVBAMTHE1pY3Jvc29mdCBU
# aW1lLVN0YW1wIFNlcnZpY2WiIwoBATAHBgUrDgMCGgMVAEKiHyGJYx1GzaGNP8I4
# V0Z/7EgNoIGDMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTAwDQYJ
# KoZIhvcNAQEFBQACBQDpjD/PMCIYDzIwMjQwMzAxMTk1MTQzWhgPMjAyNDAzMDIx
# OTUxNDNaMHMwOQYKKwYBBAGEWQoEATErMCkwCgIFAOmMP88CAQAwBgIBAAIBbDAH
# AgEAAgIRfjAKAgUA6Y2RTwIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZ
# CgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBADr9
# 8vI/W3d2+YmWa1lLrqv5zZh1lFgyl4lldCzMoHlKg6374Jm1EH1yp2iWGbZ8sU2L
# GE5s/8uDG9rabqnFqc2alb2WC4uNwGDXPMOnzx6joqVnZFkuPudZnZBGBeXrCpJ/
# /qmRiYZXwp5epEEfCYhyr5fGCkvrOLBTFUU2C5huMYIEDTCCBAkCAQEwgZMwfDEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWlj
# cm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAAHajtXJWgDREbEAAQAAAdow
# DQYJYIZIAWUDBAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAv
# BgkqhkiG9w0BCQQxIgQggtSJN4xcKmhA9DXvrqho3KhlkGvNKsEbkgnpQHyuWV0w
# gfoGCyqGSIb3DQEJEAIvMYHqMIHnMIHkMIG9BCAipaNpYsDvnqTe95Dj1C09020I
# 5ljibrW/ndICOxg9xjCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpX
# YXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQg
# Q29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAy
# MDEwAhMzAAAB2o7VyVoA0RGxAAEAAAHaMCIEIOJ0Lm7/2UoG8RXhPr0WsyPewxwr
# QCPzx0FasPyfnS1nMA0GCSqGSIb3DQEBCwUABIICAEV6Y0tE7nXhk8W0ISB8qeLY
# lvdFQ7NO2widDHZnDWmYZ4hp2I8uCXHozEiqXk9m9C87/UeVrS4k88eZ4gg2KYUO
# 1vIZXAG+n5G6E/8RpJ0V/EEJRxUZDcLbjj6sOlQV8BDPRP1fluEQleirGjmvPkep
# mB1AdKBVN54dOhRWCFyvezNIgnlERF1SGg65g19KrVao9gSZ0vupxgW4Yn6WtFra
# o1d41dvjZGOAEM1cbeqdeaxvMUqcniq/d1g1rcvvhgX6KawF6y8CBCG5NPukRa+e
# /jznatNnVNFMCJRuA//n0ddh7FWC4gNt9Adn9o+yPsmi58067yKugIeh08Vw2TXS
# CGRb105V8tdTQ+xQTa3virCY8YzJji/cSB9zjKCyNX4vFnE7xuO43O+jTdMu7jIg
# G8oXHeJuvX4p3ga8NI7HqZ7dv9ofbAxXGOeb04rxqSMMPuLoI7yrLOItuYTcMC5h
# 7mn/oJJzFLGdKtjaX+WoXOYdO635R1PjYBpMbSJj1BagVJzyeDCmpWe8uTHZ5JGo
# i45miQYWpF4OR/xKIamrxTpzl8pfOZgi0WwTWHbCSpiwer2DFX7zpiMqUaCwkVtq
# na3OXNElw5KQKc1AzMBLy/oQj4nUOkm7LEgdGyFFfz4JxxfFzGML59UBAf/XwTV0
# 6TAF8eavT4UDzNQOb1IZ
# SIG # End signature block
