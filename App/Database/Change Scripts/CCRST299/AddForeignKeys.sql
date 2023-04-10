/*
		this script was created by James

*/

SET NOCOUNT ON;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AlertOrganization_AlertID_dbo_Alert_AlertID')
BEGIN
ALTER TABLE dbo.AlertOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AlertOrganization_AlertID_dbo_Alert_AlertID FOREIGN KEY (AlertID)
	REFERENCES dbo.Alert (AlertID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AlertOrganization_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.AlertOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AlertOrganization_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AlertSourceCode_AlertID_dbo_Alert_AlertID')
BEGIN
ALTER TABLE dbo.AlertSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AlertSourceCode_AlertID_dbo_Alert_AlertID FOREIGN KEY (AlertID)
	REFERENCES dbo.Alert (AlertID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix		  
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AlertSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.AlertSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AlertSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AppropriateCounts_IndicationID_dbo_Indication_IndicationID')
BEGIN
ALTER TABLE dbo.AppropriateCounts
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AppropriateCounts_IndicationID_dbo_Indication_IndicationID FOREIGN KEY (IndicationID)
	REFERENCES dbo.Indication (IndicationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AspSettingType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.AspSettingType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AspSettingType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AspSourceCodeMap_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.AspSourceCodeMap
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AspSourceCodeMap_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AspSourceCodeMap_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.AspSourceCodeMap
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AspSourceCodeMap_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AuditLog_AuditLogRecordTypeId_dbo_AuditLogRecordType_AuditLogRecordTypeId')
BEGIN
ALTER TABLE dbo.AuditLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AuditLog_AuditLogRecordTypeId_dbo_AuditLogRecordType_AuditLogRecordTypeId FOREIGN KEY (AuditLogRecordTypeId)
	REFERENCES dbo.AuditLogRecordType (AuditLogRecordTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AuditLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.AuditLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AuditLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AuditLogIDduplicatelist_AuditLogId_dbo_AuditLog_AuditLogId')
BEGIN
ALTER TABLE dbo.AuditLogIDduplicatelist
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AuditLogIDduplicatelist_AuditLogId_dbo_AuditLog_AuditLogId FOREIGN KEY (AuditLogId)
	REFERENCES dbo.AuditLog (AuditLogId)
	NOT FOR REPLICATION;
END
GO




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix		  
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AutoResponseCode_LogeventID_dbo_LogEvent_LogEventID')
BEGIN
ALTER TABLE dbo.AutoResponseCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AutoResponseCode_LogeventID_dbo_LogEvent_LogEventID FOREIGN KEY (LogeventID)
	REFERENCES dbo.LogEvent (LogEventID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_BillTo_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.BillTo
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_BillTo_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_BillTo_CountryID_dbo_Country_COUNTRYID')
BEGIN
ALTER TABLE dbo.BillTo
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_BillTo_CountryID_dbo_Country_COUNTRYID FOREIGN KEY (CountryID)
	REFERENCES dbo.Country (COUNTRYID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_BillTo_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.BillTo
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_BillTo_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_BillTo_StateID_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.BillTo
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_BillTo_StateID_dbo_State_StateID FOREIGN KEY (StateID)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_BulletinBoard_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.BulletinBoard
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_BulletinBoard_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_BulletinBoard_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.BulletinBoard
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_BulletinBoard_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Call_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
--BEGIN
--ALTER TABLE dbo.Call
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_Call_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
--	REFERENCES dbo.AuditLogType (AuditLogTypeId)
--	NOT FOR REPLICATION;
--END
--GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Call_CallTypeID_dbo_CallType_CallTypeID')
--BEGIN
--ALTER TABLE dbo.Call
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_Call_CallTypeID_dbo_CallType_CallTypeID FOREIGN KEY (CallTypeID)
--	REFERENCES dbo.CallType (CallTypeID)
--	NOT FOR REPLICATION;
--END
--GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix		  
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Call_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.Call
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Call_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallBack_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.CallBack
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallBack_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallBack_PhoneID_dbo_Phone_PhoneID')
BEGIN
ALTER TABLE dbo.CallBack
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallBack_PhoneID_dbo_Phone_PhoneID FOREIGN KEY (PhoneID)
	REFERENCES dbo.Phone (PhoneID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallCriteria_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID')
BEGIN
ALTER TABLE dbo.CallCriteria
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallCriteria_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID FOREIGN KEY (ServiceLevelID)
	REFERENCES dbo.ServiceLevel (ServiceLevelID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallCustomField_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CallCustomField
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallCustomField_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallIncompleteDate_StatEmployeeID_dbo_StatEmployee_StatEmployeeID')
BEGIN
ALTER TABLE dbo.CallIncompleteDate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallIncompleteDate_StatEmployeeID_dbo_StatEmployee_StatEmployeeID FOREIGN KEY (StatEmployeeID)
	REFERENCES dbo.StatEmployee (StatEmployeeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallRecycle_CallTypeID_dbo_CallType_CallTypeID')
BEGIN
ALTER TABLE dbo.CallRecycle
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallRecycle_CallTypeID_dbo_CallType_CallTypeID FOREIGN KEY (CallTypeID)
	REFERENCES dbo.CallType (CallTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallRecycle_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.CallRecycle
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallRecycle_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CaseType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CaseType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CaseType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CODCaller_StateID_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.CODCaller
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CODCaller_StateID_dbo_State_StateID FOREIGN KEY (StateID)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CODMap_StateID_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.CODMap
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CODMap_StateID_dbo_State_StateID FOREIGN KEY (StateID)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ContactRoleMergeLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.ContactRoleMergeLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ContactRoleMergeLog_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ContactRoleMergeLog_PersonId_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.ContactRoleMergeLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ContactRoleMergeLog_PersonId_dbo_Person_PersonID FOREIGN KEY (PersonId)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ContactRoleMergeLog_RoleId_dbo_Roles_RoleID')
BEGIN
ALTER TABLE dbo.ContactRoleMergeLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ContactRoleMergeLog_RoleId_dbo_Roles_RoleID FOREIGN KEY (RoleId)
	REFERENCES dbo.Roles (RoleID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ContactRoleMergeLog_WebPersonId_dbo_WebPerson_WebPersonID')
BEGIN
ALTER TABLE dbo.ContactRoleMergeLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ContactRoleMergeLog_WebPersonId_dbo_WebPerson_WebPersonID FOREIGN KEY (WebPersonId)
	REFERENCES dbo.WebPerson (WebPersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CountryCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CountryCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CountryCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CountryCode_CountryId_dbo_Country_COUNTRYID')
BEGIN
ALTER TABLE dbo.CountryCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CountryCode_CountryId_dbo_Country_COUNTRYID FOREIGN KEY (CountryId)
	REFERENCES dbo.Country (COUNTRYID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_County_StateID_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.County
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_County_StateID_dbo_State_StateID FOREIGN KEY (StateID)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Criteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID')
BEGIN
ALTER TABLE dbo.Criteria
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Criteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID FOREIGN KEY (DonorCategoryID)
	REFERENCES dbo.DonorCategory (DonorCategoryID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Criteria_DynamicDonorCategoryID_dbo_DynamicDonorCategory_DynamicDonorCategoryID')
BEGIN
ALTER TABLE dbo.Criteria
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Criteria_DynamicDonorCategoryID_dbo_DynamicDonorCategory_DynamicDonorCategoryID FOREIGN KEY (DynamicDonorCategoryID)
	REFERENCES dbo.DynamicDonorCategory (DynamicDonorCategoryID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaAgeUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CriteriaAgeUnit
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaAgeUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaIndication_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.CriteriaIndication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaIndication_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaIndication_IndicationID_dbo_Indication_IndicationID')
BEGIN
ALTER TABLE dbo.CriteriaIndication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaIndication_IndicationID_dbo_Indication_IndicationID FOREIGN KEY (IndicationID)
	REFERENCES dbo.Indication (IndicationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CriteriaOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaOrganization_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.CriteriaOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaOrganization_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaOrganization_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.CriteriaOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaOrganization_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaProcessor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CriteriaProcessor
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaProcessor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaProcessor_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.CriteriaProcessor
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaProcessor_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaProcessor_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.CriteriaProcessor
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaProcessor_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaScheduleGroup_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.CriteriaScheduleGroup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaScheduleGroup_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.CriteriaScheduleGroup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaSourceCode_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.CriteriaSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaSourceCode_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.CriteriaSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaSubType_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.CriteriaSubType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaSubType_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaSubType_SubTypeID_dbo_SubType_SubTypeID')
BEGIN
ALTER TABLE dbo.CriteriaSubType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaSubType_SubTypeID_dbo_SubType_SubTypeID FOREIGN KEY (SubTypeID)
	REFERENCES dbo.SubType (SubTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaTemplate_ConditionalRO_CriteriaTemplateId_dbo_CriteriaTemplate_CriteriaTemplateID')
BEGIN
ALTER TABLE dbo.CriteriaTemplate_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaTemplate_ConditionalRO_CriteriaTemplateId_dbo_CriteriaTemplate_CriteriaTemplateID FOREIGN KEY (CriteriaTemplateId)
	REFERENCES dbo.CriteriaTemplate (CriteriaTemplateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaTemplate_ConditionalRO_FSAppropriateId_dbo_FSAppropriate_FSAppropriateID')
BEGIN
ALTER TABLE dbo.CriteriaTemplate_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaTemplate_ConditionalRO_FSAppropriateId_dbo_FSAppropriate_FSAppropriateID FOREIGN KEY (FSAppropriateId)
	REFERENCES dbo.FSAppropriate (FSAppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaTemplate_ConditionalRO_FSConditionId_dbo_FSCondition_FSConditionID')
BEGIN
ALTER TABLE dbo.CriteriaTemplate_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaTemplate_ConditionalRO_FSConditionId_dbo_FSCondition_FSConditionID FOREIGN KEY (FSConditionId)
	REFERENCES dbo.FSCondition (FSConditionID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaTemplate_ConditionalRO_FSIndicationId_dbo_FSIndication_FSIndicationID')
BEGIN
ALTER TABLE dbo.CriteriaTemplate_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaTemplate_ConditionalRO_FSIndicationId_dbo_FSIndication_FSIndicationID FOREIGN KEY (FSIndicationId)
	REFERENCES dbo.FSIndication (FSIndicationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CriteriaWeightUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.CriteriaWeightUnit
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CriteriaWeightUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DashBoardDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DashBoardDisplaySetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DashBoardDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DashBoardTimerDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DashBoardTimerDefault
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DashBoardTimerDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DashBoardTimerDefault_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId')
BEGIN
ALTER TABLE dbo.DashBoardTimerDefault
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DashBoardTimerDefault_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId FOREIGN KEY (DashBoardTimerTypeId)
	REFERENCES dbo.DashBoardTimerType (DashBoardTimerTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DashBoardTimerDefault_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId')
BEGIN
ALTER TABLE dbo.DashBoardTimerDefault
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DashBoardTimerDefault_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId FOREIGN KEY (DashBoardWindowId)
	REFERENCES dbo.DashBoardWindow (DashBoardWindowId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DashBoardTimerType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DashBoardTimerType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DashBoardTimerType_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DashBoardWindow_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DashBoardWindow
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DashBoardWindow_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DesignatedRequestors_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.DesignatedRequestors
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DesignatedRequestors_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DesignatedRequestors_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.DesignatedRequestors
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DesignatedRequestors_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DesignatedRequestors_ORG_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.DesignatedRequestors_ORG
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DesignatedRequestors_ORG_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DictionaryItemMisspelling_DictionaryItemID_dbo_DictionaryItem_DictionaryItemID')
BEGIN
ALTER TABLE dbo.DictionaryItemMisspelling
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DictionaryItemMisspelling_DictionaryItemID_dbo_DictionaryItem_DictionaryItemID FOREIGN KEY (DictionaryItemID)
	REFERENCES dbo.DictionaryItem (DictionaryItemID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DonorData
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO




-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracBatchLog_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.DonorTracBatchLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracBatchLog_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracCategory_DonorCategoryID_dbo_DonorCategory_DonorCategoryID')
BEGIN
ALTER TABLE dbo.DonorTracCategory
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracCategory_DonorCategoryID_dbo_DonorCategory_DonorCategoryID FOREIGN KEY (DonorCategoryID)
	REFERENCES dbo.DonorCategory (DonorCategoryID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracDB_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.DonorTracDB
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracDB_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracIdentifier_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DonorTracIdentifier
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracIdentifier_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracIdentifier_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.DonorTracIdentifier
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracIdentifier_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracURL_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DonorTracURL
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracURL_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracURL_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.DonorTracURL
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracURL_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracUser_DonorTracDBID_dbo_DonorTracDB_DonorTracDBID')
BEGIN
ALTER TABLE dbo.DonorTracUser
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracUser_DonorTracDBID_dbo_DonorTracDB_DonorTracDBID FOREIGN KEY (DonorTracDBID)
	REFERENCES dbo.DonorTracDB (DonorTracDBID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracUser_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.DonorTracUser
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracUser_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorTracUser_StatEmployeeID_dbo_StatEmployee_StatEmployeeID')
BEGIN
ALTER TABLE dbo.DonorTracUser
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorTracUser_StatEmployeeID_dbo_StatEmployee_StatEmployeeID FOREIGN KEY (StatEmployeeID)
	REFERENCES dbo.StatEmployee (StatEmployeeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DuplicateSearchRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DuplicateSearchRuleDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.DuplicateSearchRuleDefault
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DuplicateSearchRuleDefault_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DuplicateSearchRuleDefault_CallTypeID_dbo_CallType_CallTypeID')
BEGIN
ALTER TABLE dbo.DuplicateSearchRuleDefault
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DuplicateSearchRuleDefault_CallTypeID_dbo_CallType_CallTypeID FOREIGN KEY (CallTypeID)
	REFERENCES dbo.CallType (CallTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DuplicateSearchRuleDefault_DuplicateSearchRuleID_dbo_DuplicateSearchRule_DuplicateSearchRuleId')
BEGIN
ALTER TABLE dbo.DuplicateSearchRuleDefault
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DuplicateSearchRuleDefault_DuplicateSearchRuleID_dbo_DuplicateSearchRule_DuplicateSearchRuleId FOREIGN KEY (DuplicateSearchRuleID)
	REFERENCES dbo.DuplicateSearchRule (DuplicateSearchRuleId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_EmailType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.EmailType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_EmailType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFile_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.ExportFile
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFile_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFile_CloseCaseTriggerID_dbo_CloseCaseTrigger_CloseCaseTriggerID')
BEGIN
ALTER TABLE dbo.ExportFile
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFile_CloseCaseTriggerID_dbo_CloseCaseTrigger_CloseCaseTriggerID FOREIGN KEY (CloseCaseTriggerID)
	REFERENCES dbo.CloseCaseTrigger (CloseCaseTriggerID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFile_ExportFileTypeID_dbo_ExportFileType_ExportFileTypeID')
BEGIN
ALTER TABLE dbo.ExportFile
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFile_ExportFileTypeID_dbo_ExportFileType_ExportFileTypeID FOREIGN KEY (ExportFileTypeID)
	REFERENCES dbo.ExportFileType (ExportFileTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFile_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.ExportFile
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFile_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFile_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID')
BEGIN
ALTER TABLE dbo.ExportFile
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFile_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID FOREIGN KEY (WebReportGroupID)
	REFERENCES dbo.WebReportGroup (WebReportGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFileType_ExportFileDataTypeID_dbo_ExportFileDataType_ExportFileDataTypeID')
BEGIN
ALTER TABLE dbo.ExportFileType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFileType_ExportFileDataTypeID_dbo_ExportFileDataType_ExportFileDataTypeID FOREIGN KEY (ExportFileDataTypeID)
	REFERENCES dbo.ExportFileDataType (ExportFileDataTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ExportFileType_ExportFileXsltID_dbo_ExportFileXslt_ExportFileXsltID')
BEGIN
ALTER TABLE dbo.ExportFileType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ExportFileType_ExportFileXsltID_dbo_ExportFileXslt_ExportFileXsltID FOREIGN KEY (ExportFileXsltID)
	REFERENCES dbo.ExportFileXslt (ExportFileXsltID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Fax_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Fax
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Fax_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSBCase_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId')
BEGIN
ALTER TABLE dbo.FSBCase
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSBCase_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId FOREIGN KEY (FSBCaseTypeId)
	REFERENCES dbo.FSBCaseType (FSBCaseTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSBCase_SourceCodeId_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.FSBCase
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSBCase_SourceCodeId_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeId)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSBCaseCommentLog_FSBCaseId_dbo_FSBCase_FSBCaseId')
BEGIN
ALTER TABLE dbo.FSBCaseCommentLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSBCaseCommentLog_FSBCaseId_dbo_FSBCase_FSBCaseId FOREIGN KEY (FSBCaseId)
	REFERENCES dbo.FSBCase (FSBCaseId)
	NOT FOR REPLICATION;
END
GO



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FsbCaseStatus_ListFsbStatusId_dbo_ListFsbStatus_ListFsbStatusId')
BEGIN
ALTER TABLE dbo.FsbCaseStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FsbCaseStatus_ListFsbStatusId_dbo_ListFsbStatus_ListFsbStatusId FOREIGN KEY (ListFsbStatusId)
	REFERENCES dbo.ListFsbStatus (ListFsbStatusId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSBCaseStatusLog_FSBCaseId_dbo_FSBCase_FSBCaseId')
BEGIN
ALTER TABLE dbo.FSBCaseStatusLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSBCaseStatusLog_FSBCaseId_dbo_FSBCase_FSBCaseId FOREIGN KEY (FSBCaseId)
	REFERENCES dbo.FSBCase (FSBCaseId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSBCaseStatusLog_FSBStatusId_dbo_FSBStatus_FSBStatusId')
BEGIN
ALTER TABLE dbo.FSBCaseStatusLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSBCaseStatusLog_FSBStatusId_dbo_FSBStatus_FSBStatusId FOREIGN KEY (FSBStatusId)
	REFERENCES dbo.FSBStatus (FSBStatusId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSBStatus_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId')
BEGIN
ALTER TABLE dbo.FSBStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSBStatus_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId FOREIGN KEY (FSBCaseTypeId)
	REFERENCES dbo.FSBCaseType (FSBCaseTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSCase_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.FSCase
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSCase_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Gender_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Gender
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Gender_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_GeneralAlert_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.GeneralAlert
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_GeneralAlert_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_GeneralAlert_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.GeneralAlert
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_GeneralAlert_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Idd_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Idd
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Idd_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Idd_CountryId_dbo_Country_COUNTRYID')
BEGIN
ALTER TABLE dbo.Idd
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Idd_CountryId_dbo_Country_COUNTRYID FOREIGN KEY (CountryId)
	REFERENCES dbo.Country (COUNTRYID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ImportOrganizations_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.ImportOrganizations
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ImportOrganizations_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ImportOrganizations_phoneid_dbo_Phone_PhoneID')
BEGIN
ALTER TABLE dbo.ImportOrganizations
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ImportOrganizations_phoneid_dbo_Phone_PhoneID FOREIGN KEY (phoneid)
	REFERENCES dbo.Phone (PhoneID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ImportOrganizations_stateid_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.ImportOrganizations
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ImportOrganizations_stateid_dbo_State_StateID FOREIGN KEY (stateid)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_IndicationResponse_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.IndicationResponse
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_IndicationResponse_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Invoice_BillingAddressID_dbo_BillingAddress_BillingAddressID')
BEGIN
ALTER TABLE dbo.Invoice
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Invoice_BillingAddressID_dbo_BillingAddress_BillingAddressID FOREIGN KEY (BillingAddressID)
	REFERENCES dbo.BillingAddress (BillingAddressID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Invoice_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Invoice
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Invoice_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Invoice_backup_BillingAddressID_dbo_BillingAddress_BillingAddressID')
BEGIN
ALTER TABLE dbo.Invoice_backup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Invoice_backup_BillingAddressID_dbo_BillingAddress_BillingAddressID FOREIGN KEY (BillingAddressID)
	REFERENCES dbo.BillingAddress (BillingAddressID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Invoice_backup_InvoiceID_dbo_Invoice_InvoiceID')
BEGIN
ALTER TABLE dbo.Invoice_backup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Invoice_backup_InvoiceID_dbo_Invoice_InvoiceID FOREIGN KEY (InvoiceID)
	REFERENCES dbo.Invoice (InvoiceID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Invoice_backup_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Invoice_backup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Invoice_backup_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_InvoiceHistory_BillingAddressID_dbo_BillingAddress_BillingAddressID')
BEGIN
ALTER TABLE dbo.InvoiceHistory
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_InvoiceHistory_BillingAddressID_dbo_BillingAddress_BillingAddressID FOREIGN KEY (BillingAddressID)
	REFERENCES dbo.BillingAddress (BillingAddressID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_InvoiceHistory_InvoiceID_dbo_Invoice_InvoiceID')
BEGIN
ALTER TABLE dbo.InvoiceHistory
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_InvoiceHistory_InvoiceID_dbo_Invoice_InvoiceID FOREIGN KEY (InvoiceID)
	REFERENCES dbo.Invoice (InvoiceID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LifeBreachEmail_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.LifeBreachEmail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LifeBreachEmail_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LineItem_InvoiceID_dbo_Invoice_InvoiceID')
BEGIN
ALTER TABLE dbo.LineItem
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LineItem_InvoiceID_dbo_Invoice_InvoiceID FOREIGN KEY (InvoiceID)
	REFERENCES dbo.Invoice (InvoiceID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LineItem_LineItemDescriptionID_dbo_LineItemDescription_LineItemDescriptionID')
BEGIN
ALTER TABLE dbo.LineItem
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LineItem_LineItemDescriptionID_dbo_LineItemDescription_LineItemDescriptionID FOREIGN KEY (LineItemDescriptionID)
	REFERENCES dbo.LineItemDescription (LineItemDescriptionID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LineItemFormula_InvoiceID_dbo_Invoice_InvoiceID')
BEGIN
ALTER TABLE dbo.LineItemFormula
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LineItemFormula_InvoiceID_dbo_Invoice_InvoiceID FOREIGN KEY (InvoiceID)
	REFERENCES dbo.Invoice (InvoiceID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LineItemFormula_LineItemID_dbo_LineItem_LineItemID')
BEGIN
ALTER TABLE dbo.LineItemFormula
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LineItemFormula_LineItemID_dbo_LineItem_LineItemID FOREIGN KEY (LineItemID)
	REFERENCES dbo.LineItem (LineItemID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LineItemHistory_InvoiceHistoryID_dbo_InvoiceHistory_InvoiceHistoryID')
BEGIN
ALTER TABLE dbo.LineItemHistory
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LineItemHistory_InvoiceHistoryID_dbo_InvoiceHistory_InvoiceHistoryID FOREIGN KEY (InvoiceHistoryID)
	REFERENCES dbo.InvoiceHistory (InvoiceHistoryID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ListFsbStatus_ListFsbStatusColorId_dbo_ListFsbStatusColor_ListFsbStatusColorId')
BEGIN
ALTER TABLE dbo.ListFsbStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ListFsbStatus_ListFsbStatusColorId_dbo_ListFsbStatusColor_ListFsbStatusColorId FOREIGN KEY (ListFsbStatusColorId)
	REFERENCES dbo.ListFsbStatusColor (ListFsbStatusColorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
--	REFERENCES dbo.AuditLogType (AuditLogTypeId)
--	NOT FOR REPLICATION;
--END
--GO



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_LogEventTypeID_dbo_LogEventType_LogEventTypeID')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_LogEventTypeID_dbo_LogEventType_LogEventTypeID FOREIGN KEY (LogEventTypeID)
--	REFERENCES dbo.LogEventType (LogEventTypeID)
--	NOT FOR REPLICATION;
--END
--GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_OrganizationID_dbo_Organization_OrganizationID')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
--	REFERENCES dbo.Organization (OrganizationID)
--	NOT FOR REPLICATION;
--END
--GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_PersonID_dbo_Person_PersonID')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
--	REFERENCES dbo.Person (PersonID)
--	NOT FOR REPLICATION;
--END
--GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_PhoneID_dbo_Phone_PhoneID')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_PhoneID_dbo_Phone_PhoneID FOREIGN KEY (PhoneID)
--	REFERENCES dbo.Phone (PhoneID)
--	NOT FOR REPLICATION;
--END
--GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
--	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
--	NOT FOR REPLICATION;
--END
--GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_StatEmployeeID_dbo_StatEmployee_StatEmployeeID')
--BEGIN
--ALTER TABLE dbo.LogEvent
--	WITH NOCHECK
--	ADD CONSTRAINT FK_dbo_LogEvent_StatEmployeeID_dbo_StatEmployee_StatEmployeeID FOREIGN KEY (StatEmployeeID)
--	REFERENCES dbo.StatEmployee (StatEmployeeID)
--	NOT FOR REPLICATION;
--END
--GO

/** These may be added at a later date
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Message_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Message
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Message_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Message_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.Message
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Message_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Message_MessageTypeID_dbo_MessageType_MessageTypeID')
BEGIN
ALTER TABLE dbo.Message
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Message_MessageTypeID_dbo_MessageType_MessageTypeID FOREIGN KEY (MessageTypeID)
	REFERENCES dbo.MessageType (MessageTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Message_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Message
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Message_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Message_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.Message
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Message_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO
**/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_NDRICallSheet_RaceId_dbo_Race_RaceID')
BEGIN
ALTER TABLE dbo.NDRICallSheet
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_NDRICallSheet_RaceId_dbo_Race_RaceID FOREIGN KEY (RaceId)
	REFERENCES dbo.Race (RaceID)
	NOT FOR REPLICATION;
END
GO



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_NoCall_NoCallTypeID_dbo_NoCallType_NoCallTypeID')
BEGIN
ALTER TABLE dbo.NoCall
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_NoCall_NoCallTypeID_dbo_NoCallType_NoCallTypeID FOREIGN KEY (NoCallTypeID)
	REFERENCES dbo.NoCallType (NoCallTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_NOK_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.NOK
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_NOK_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OnlineHospitalAccount_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.OnlineHospitalAccount
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OnlineHospitalAccount_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OnlineHospitalAccount_WebPersonID_dbo_WebPerson_WebPersonID')
BEGIN
ALTER TABLE dbo.OnlineHospitalAccount
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OnlineHospitalAccount_WebPersonID_dbo_WebPerson_WebPersonID FOREIGN KEY (WebPersonID)
	REFERENCES dbo.WebPerson (WebPersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OnlineHospitalSourceCodeWebPerson_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.OnlineHospitalSourceCodeWebPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OnlineHospitalSourceCodeWebPerson_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OnlineHospitalSourceCodeWebPerson_webPersonID_dbo_WebPerson_WebPersonID')
BEGIN
ALTER TABLE dbo.OnlineHospitalSourceCodeWebPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OnlineHospitalSourceCodeWebPerson_webPersonID_dbo_WebPerson_WebPersonID FOREIGN KEY (webPersonID)
	REFERENCES dbo.WebPerson (WebPersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_CountryCodeId_dbo_CountryCode_CountryCodeId')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_CountryCodeId_dbo_CountryCode_CountryCodeId FOREIGN KEY (CountryCodeId)
	REFERENCES dbo.CountryCode (CountryCodeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_CountryID_dbo_Country_COUNTRYID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_CountryID_dbo_Country_COUNTRYID FOREIGN KEY (CountryID)
	REFERENCES dbo.Country (COUNTRYID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_CountyID_dbo_County_CountyID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_CountyID_dbo_County_CountyID FOREIGN KEY (CountyID)
	REFERENCES dbo.County (CountyID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_IddId_dbo_Idd_IddId')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_IddId_dbo_Idd_IddId FOREIGN KEY (IddId)
	REFERENCES dbo.Idd (IddId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_OrganizationStatusId_dbo_OrganizationStatus_OrganizationStatusID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_OrganizationStatusId_dbo_OrganizationStatus_OrganizationStatusID FOREIGN KEY (OrganizationStatusId)
	REFERENCES dbo.OrganizationStatus (OrganizationStatusID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_OrganizationTypeID_dbo_OrganizationType_OrganizationTypeID FOREIGN KEY (OrganizationTypeID)
	REFERENCES dbo.OrganizationType (OrganizationTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_PhoneID_dbo_Phone_PhoneID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_PhoneID_dbo_Phone_PhoneID FOREIGN KEY (PhoneID)
	REFERENCES dbo.Phone (PhoneID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_StateID_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_StateID_dbo_State_StateID FOREIGN KEY (StateID)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Organization_TimeZoneId_dbo_TimeZone_TimeZoneID')
BEGIN
ALTER TABLE dbo.Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Organization_TimeZoneId_dbo_TimeZone_TimeZoneID FOREIGN KEY (TimeZoneId)
	REFERENCES dbo.TimeZone (TimeZoneID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationAlias_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationAlias
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationAlias_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationAlias_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationAlias
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationAlias_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationASPSetting_AspSettingTypeId_dbo_AspSettingType_AspSettingTypeId')
BEGIN
ALTER TABLE dbo.OrganizationASPSetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationASPSetting_AspSettingTypeId_dbo_AspSettingType_AspSettingTypeId FOREIGN KEY (AspSettingTypeId)
	REFERENCES dbo.AspSettingType (AspSettingTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationASPSetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationASPSetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationASPSetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationASPSetting_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationASPSetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationASPSetting_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationCustomReport_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationCustomReport
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationCustomReport_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDashBoardTimer_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationDashBoardTimer
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDashBoardTimer_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDashBoardTimer_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId')
BEGIN
ALTER TABLE dbo.OrganizationDashBoardTimer
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDashBoardTimer_DashBoardTimerTypeId_dbo_DashBoardTimerType_DashBoardTimerTypeId FOREIGN KEY (DashBoardTimerTypeId)
	REFERENCES dbo.DashBoardTimerType (DashBoardTimerTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDashBoardTimer_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId')
BEGIN
ALTER TABLE dbo.OrganizationDashBoardTimer
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDashBoardTimer_DashBoardWindowId_dbo_DashBoardWindow_DashBoardWindowId FOREIGN KEY (DashBoardWindowId)
	REFERENCES dbo.DashBoardWindow (DashBoardWindowId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDashBoardTimer_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationDashBoardTimer
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDashBoardTimer_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationDisplaySetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDisplaySetting_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDisplaySetting_DashBoardDisplaySettingId_dbo_DashBoardDisplaySetting_DashBoardDisplaySettingId')
BEGIN
ALTER TABLE dbo.OrganizationDisplaySetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDisplaySetting_DashBoardDisplaySettingId_dbo_DashBoardDisplaySetting_DashBoardDisplaySettingId FOREIGN KEY (DashBoardDisplaySettingId)
	REFERENCES dbo.DashBoardDisplaySetting (DashBoardDisplaySettingId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDisplaySetting_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationDisplaySetting
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDisplaySetting_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationDuplicateSearchRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDuplicateSearchRule_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDuplicateSearchRule_CallTypeID_dbo_CallType_CallTypeID')
BEGIN
ALTER TABLE dbo.OrganizationDuplicateSearchRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDuplicateSearchRule_CallTypeID_dbo_CallType_CallTypeID FOREIGN KEY (CallTypeID)
	REFERENCES dbo.CallType (CallTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_dbo_DuplicateSearchRule_DuplicateSearchRuleId')
BEGIN
ALTER TABLE dbo.OrganizationDuplicateSearchRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_dbo_DuplicateSearchRule_DuplicateSearchRuleId FOREIGN KEY (DuplicateSearchRuleId)
	REFERENCES dbo.DuplicateSearchRule (DuplicateSearchRuleId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationDuplicateSearchRule_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationDuplicateSearchRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationDuplicateSearchRule_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationFsSourceCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationFsSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationFsSourceCode_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationFsSourceCode_OrganizationId_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationFsSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationFsSourceCode_OrganizationId_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationId)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationFsSourceCode_SourceCodeId_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.OrganizationFsSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationFsSourceCode_SourceCodeId_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeId)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationPhone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationPhone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationPhone_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.OrganizationPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationPhone_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationPhone_PhoneID_dbo_Phone_PhoneID')
BEGIN
ALTER TABLE dbo.OrganizationPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationPhone_PhoneID_dbo_Phone_PhoneID FOREIGN KEY (PhoneID)
	REFERENCES dbo.Phone (PhoneID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationPhone_SubLocationID_dbo_SubLocation_SubLocationID')
BEGIN
ALTER TABLE dbo.OrganizationPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationPhone_SubLocationID_dbo_SubLocation_SubLocationID FOREIGN KEY (SubLocationID)
	REFERENCES dbo.SubLocation (SubLocationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationPhone_SubLocationLevelID_dbo_SubLocationLevel_SubLocationLevelID')
BEGIN
ALTER TABLE dbo.OrganizationPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationPhone_SubLocationLevelID_dbo_SubLocationLevel_SubLocationLevelID FOREIGN KEY (SubLocationLevelID)
	REFERENCES dbo.SubLocationLevel (SubLocationLevelID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_OrganizationStatus_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.OrganizationStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_OrganizationStatus_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PagerType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.PagerType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PagerType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Permission_FUNCTIONID_dbo_Functions_FUNCTIONID')
BEGIN
ALTER TABLE dbo.Permission
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Permission_FUNCTIONID_dbo_Functions_FUNCTIONID FOREIGN KEY (FUNCTIONID)
	REFERENCES dbo.Functions (FUNCTIONID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Permission_PERMISSIONTYPEID_dbo_PermissionType_PERMISSIONTYPEID')
BEGIN
ALTER TABLE dbo.Permission
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Permission_PERMISSIONTYPEID_dbo_PermissionType_PERMISSIONTYPEID FOREIGN KEY (PERMISSIONTYPEID)
	REFERENCES dbo.PermissionType (PERMISSIONTYPEID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Person_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Person
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Person_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Person_GenderID_dbo_Gender_GenderID')
BEGIN
ALTER TABLE dbo.Person
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Person_GenderID_dbo_Gender_GenderID FOREIGN KEY (GenderID)
	REFERENCES dbo.Gender (GenderID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Person_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Person
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Person_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Person_PersonTypeID_dbo_PersonType_PersonTypeID')
BEGIN
ALTER TABLE dbo.Person
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Person_PersonTypeID_dbo_PersonType_PersonTypeID FOREIGN KEY (PersonTypeID)
	REFERENCES dbo.PersonType (PersonTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Person_RaceID_dbo_Race_RaceID')
BEGIN
ALTER TABLE dbo.Person
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Person_RaceID_dbo_Race_RaceID FOREIGN KEY (RaceID)
	REFERENCES dbo.Race (RaceID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Person_TrainedRequestorID_dbo_TrainedRequestor_TrainedRequestorID')
BEGIN
ALTER TABLE dbo.Person
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Person_TrainedRequestorID_dbo_TrainedRequestor_TrainedRequestorID FOREIGN KEY (TrainedRequestorID)
	REFERENCES dbo.TrainedRequestor (TrainedRequestorID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonLog_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.PersonLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonLog_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonLog_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.PersonLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonLog_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonLog_PersonTypeID_dbo_PersonType_PersonTypeID')
BEGIN
ALTER TABLE dbo.PersonLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonLog_PersonTypeID_dbo_PersonType_PersonTypeID FOREIGN KEY (PersonTypeID)
	REFERENCES dbo.PersonType (PersonTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonPhone_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.PersonPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonPhone_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonPhone_PagerTypeID_dbo_PagerType_PagerTypeID')
BEGIN
ALTER TABLE dbo.PersonPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonPhone_PagerTypeID_dbo_PagerType_PagerTypeID FOREIGN KEY (PagerTypeID)
	REFERENCES dbo.PagerType (PagerTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonPhone_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.PersonPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonPhone_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonPhone_PhoneID_dbo_Phone_PhoneID')
BEGIN
ALTER TABLE dbo.PersonPhone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonPhone_PhoneID_dbo_Phone_PhoneID FOREIGN KEY (PhoneID)
	REFERENCES dbo.Phone (PhoneID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PersonType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.PersonType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PersonType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Phone_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Phone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Phone_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Phone_PhoneTypeID_dbo_PhoneType_PhoneTypeID')
BEGIN
ALTER TABLE dbo.Phone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Phone_PhoneTypeID_dbo_PhoneType_PhoneTypeID FOREIGN KEY (PhoneTypeID)
	REFERENCES dbo.PhoneType (PhoneTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_PriceIncrease_InvoiceID_dbo_Invoice_InvoiceID')
BEGIN
ALTER TABLE dbo.PriceIncrease
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_PriceIncrease_InvoiceID_dbo_Invoice_InvoiceID FOREIGN KEY (InvoiceID)
	REFERENCES dbo.Invoice (InvoiceID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ProcessorCriteria_ConditionalRO_FSAppropriateID_dbo_FSAppropriate_FSAppropriateID')
BEGIN
ALTER TABLE dbo.ProcessorCriteria_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ProcessorCriteria_ConditionalRO_FSAppropriateID_dbo_FSAppropriate_FSAppropriateID FOREIGN KEY (FSAppropriateID)
	REFERENCES dbo.FSAppropriate (FSAppropriateID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ProcessorCriteria_ConditionalRO_FSConditionID_dbo_FSCondition_FSConditionID')
BEGIN
ALTER TABLE dbo.ProcessorCriteria_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ProcessorCriteria_ConditionalRO_FSConditionID_dbo_FSCondition_FSConditionID FOREIGN KEY (FSConditionID)
	REFERENCES dbo.FSCondition (FSConditionID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ProcessorCriteria_ConditionalRO_FSIndicationID_dbo_FSIndication_FSIndicationID')
BEGIN
ALTER TABLE dbo.ProcessorCriteria_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ProcessorCriteria_ConditionalRO_FSIndicationID_dbo_FSIndication_FSIndicationID FOREIGN KEY (FSIndicationID)
	REFERENCES dbo.FSIndication (FSIndicationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ProcessorCriteria_ConditionalRO_SubCriteriaID_dbo_SubCriteria_SubCriteriaID')
BEGIN
ALTER TABLE dbo.ProcessorCriteria_ConditionalRO
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ProcessorCriteria_ConditionalRO_SubCriteriaID_dbo_SubCriteria_SubCriteriaID FOREIGN KEY (SubCriteriaID)
	REFERENCES dbo.SubCriteria (SubCriteriaID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLocation_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QAErrorLocation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLocation_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLocation_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QAErrorLocation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLocation_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID FOREIGN KEY (QAErrorLocationID)
	REFERENCES dbo.QAErrorLocation (QAErrorLocationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QAErrorLogHowIdentifiedID_dbo_QAErrorLogHowIdentified_QAErrorLogHowIdentifiedID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QAErrorLogHowIdentifiedID_dbo_QAErrorLogHowIdentified_QAErrorLogHowIdentifiedID FOREIGN KEY (QAErrorLogHowIdentifiedID)
	REFERENCES dbo.QAErrorLogHowIdentified (QAErrorLogHowIdentifiedID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QAErrorStatusID_dbo_QAErrorStatus_QAErrorStatusID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QAErrorStatusID_dbo_QAErrorStatus_QAErrorStatusID FOREIGN KEY (QAErrorStatusID)
	REFERENCES dbo.QAErrorStatus (QAErrorStatusID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID FOREIGN KEY (QAErrorTypeID)
	REFERENCES dbo.QAErrorType (QAErrorTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QAMonitoringFormTemplateID_dbo_QAMonitoringFormTemplate_QAMonitoringFormTemplateID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QAMonitoringFormTemplateID_dbo_QAMonitoringFormTemplate_QAMonitoringFormTemplateID FOREIGN KEY (QAMonitoringFormTemplateID)
	REFERENCES dbo.QAMonitoringFormTemplate (QAMonitoringFormTemplateID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID FOREIGN KEY (QAProcessStepID)
	REFERENCES dbo.QAProcessStep (QAProcessStepID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorLog_QATrackingID_dbo_QATracking_QATrackingID')
BEGIN
ALTER TABLE dbo.QAErrorLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorLog_QATrackingID_dbo_QATracking_QATrackingID FOREIGN KEY (QATrackingID)
	REFERENCES dbo.QATracking (QATrackingID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QAErrorType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorType_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QAErrorType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorType_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorType_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID')
BEGIN
ALTER TABLE dbo.QAErrorType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorType_QAErrorLocationID_dbo_QAErrorLocation_QAErrorLocationID FOREIGN KEY (QAErrorLocationID)
	REFERENCES dbo.QAErrorLocation (QAErrorLocationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAErrorType_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID')
BEGIN
ALTER TABLE dbo.QAErrorType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAErrorType_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID FOREIGN KEY (QATrackingTypeID)
	REFERENCES dbo.QATrackingType (QATrackingTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QALogos_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QALogos
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QALogos_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAMonitoringForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QAMonitoringForm
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAMonitoringForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAMonitoringForm_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QAMonitoringForm
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAMonitoringForm_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAMonitoringForm_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID')
BEGIN
ALTER TABLE dbo.QAMonitoringForm
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAMonitoringForm_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID FOREIGN KEY (QATrackingTypeID)
	REFERENCES dbo.QATrackingType (QATrackingTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAMonitoringFormTemplate_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QAMonitoringFormTemplate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAMonitoringFormTemplate_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAMonitoringFormTemplate_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID')
BEGIN
ALTER TABLE dbo.QAMonitoringFormTemplate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAMonitoringFormTemplate_QAErrorTypeID_dbo_QAErrorType_QAErrorTypeID FOREIGN KEY (QAErrorTypeID)
	REFERENCES dbo.QAErrorType (QAErrorTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAMonitoringFormTemplate_QAMonitoringFormID_dbo_QAMonitoringForm_QAMonitoringFormID')
BEGIN
ALTER TABLE dbo.QAMonitoringFormTemplate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAMonitoringFormTemplate_QAMonitoringFormID_dbo_QAMonitoringForm_QAMonitoringFormID FOREIGN KEY (QAMonitoringFormID)
	REFERENCES dbo.QAMonitoringForm (QAMonitoringFormID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAProcessStep_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QAProcessStep
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAProcessStep_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QAProcessStep_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QAProcessStep
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QAProcessStep_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATracking_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QATracking
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATracking_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATracking_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QATracking
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATracking_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATracking_QATrackingStatusID_dbo_QATrackingStatus_QATrackingStatusID')
BEGIN
ALTER TABLE dbo.QATracking
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATracking_QATrackingStatusID_dbo_QATrackingStatus_QATrackingStatusID FOREIGN KEY (QATrackingStatusID)
	REFERENCES dbo.QATrackingStatus (QATrackingStatusID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATracking_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID')
BEGIN
ALTER TABLE dbo.QATracking
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATracking_QATrackingTypeID_dbo_QATrackingType_QATrackingTypeID FOREIGN KEY (QATrackingTypeID)
	REFERENCES dbo.QATrackingType (QATrackingTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QATrackingForm
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingForm_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingForm_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.QATrackingForm
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingForm_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingForm_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID')
BEGIN
ALTER TABLE dbo.QATrackingForm
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingForm_QAProcessStepID_dbo_QAProcessStep_QAProcessStepID FOREIGN KEY (QAProcessStepID)
	REFERENCES dbo.QAProcessStep (QAProcessStepID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingFormErrors_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QATrackingFormErrors
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingFormErrors_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingFormErrors_QAErrorLogID_dbo_QAErrorLog_QAErrorLogID')
BEGIN
ALTER TABLE dbo.QATrackingFormErrors
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingFormErrors_QAErrorLogID_dbo_QAErrorLog_QAErrorLogID FOREIGN KEY (QAErrorLogID)
	REFERENCES dbo.QAErrorLog (QAErrorLogID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingFormErrors_QATrackingFormID_dbo_QATrackingForm_QATrackingFormID')
BEGIN
ALTER TABLE dbo.QATrackingFormErrors
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingFormErrors_QATrackingFormID_dbo_QATrackingForm_QATrackingFormID FOREIGN KEY (QATrackingFormID)
	REFERENCES dbo.QATrackingForm (QATrackingFormID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QATrackingStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.QATrackingType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_QATrackingType_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.QATrackingType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_QATrackingType_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO

/** These may be added at a later date
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AlphaPage_CallId_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.AlphaPage
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AlphaPage_CallId_dbo_Call_CallID FOREIGN KEY (CallId)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AppropriateCounts_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.AppropriateCounts
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AppropriateCounts_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_AutoResponseCode_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.AutoResponseCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_AutoResponseCode_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CallIncompleteDate_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.CallIncompleteDate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CallIncompleteDate_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_CODCaller_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.CODCaller
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_CODCaller_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_DonorData_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.DonorData
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_DonorData_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FsbCaseStatus_CallId_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.FsbCaseStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FsbCaseStatus_CallId_dbo_Call_CallID FOREIGN KEY (CallId)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_FSCase_CallId_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.FSCase
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_FSCase_CallId_dbo_Call_CallID FOREIGN KEY (CallId)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_NoCall_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.NoCall
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_NoCall_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_RegistryStatus_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.RegistryStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_RegistryStatus_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryDisposition_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.SecondaryDisposition
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryDisposition_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryMedication_CallId_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.SecondaryMedication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryMedication_CallId_dbo_Call_CallID FOREIGN KEY (CallId)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryMedicationOther_CallId_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.SecondaryMedicationOther
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryMedicationOther_CallId_dbo_Call_CallID FOREIGN KEY (CallId)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_CallId_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_CallId_dbo_Call_CallID FOREIGN KEY (CallId)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_LogEvent_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.LogEvent
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_LogEvent_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_CallID_dbo_Call_CallID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_CallID_dbo_Call_CallID FOREIGN KEY (CallID)
	REFERENCES dbo.Call (CallID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralApproachedByPersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralApproachedByPersonID_dbo_Person_PersonID FOREIGN KEY (ReferralApproachedByPersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralApproachTypeID_dbo_ApproachType_ApproachTypeID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralApproachTypeID_dbo_ApproachType_ApproachTypeID FOREIGN KEY (ReferralApproachTypeID)
	REFERENCES dbo.ApproachType (ApproachTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralBoneApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralBoneApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralBoneApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralBoneAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralBoneAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralBoneAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralBoneConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralBoneConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralBoneConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralBoneConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralBoneConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralBoneConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralCallerOrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralCallerOrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (ReferralCallerOrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralCallerPersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralCallerPersonID_dbo_Person_PersonID FOREIGN KEY (ReferralCallerPersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralCallerPhoneID_dbo_Phone_PhoneID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralCallerPhoneID_dbo_Phone_PhoneID FOREIGN KEY (ReferralCallerPhoneID)
	REFERENCES dbo.Phone (PhoneID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralCallerSubLocationID_dbo_SubLocation_SubLocationID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralCallerSubLocationID_dbo_SubLocation_SubLocationID FOREIGN KEY (ReferralCallerSubLocationID)
	REFERENCES dbo.SubLocation (SubLocationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralDonorCauseOfDeathID_dbo_CauseOfDeath_CauseOfDeathID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralDonorCauseOfDeathID_dbo_CauseOfDeath_CauseOfDeathID FOREIGN KEY (ReferralDonorCauseOfDeathID)
	REFERENCES dbo.CauseOfDeath (CauseOfDeathID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralDonorRaceID_dbo_Race_RaceID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralDonorRaceID_dbo_Race_RaceID FOREIGN KEY (ReferralDonorRaceID)
	REFERENCES dbo.Race (RaceID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesRschApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesRschApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralEyesRschApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesRschAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesRschAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralEyesRschAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesRschConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesRschConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralEyesRschConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesRschConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesRschConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralEyesRschConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesTransApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesTransApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralEyesTransApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesTransAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesTransAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralEyesTransAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesTransConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesTransConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralEyesTransConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralEyesTransConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralEyesTransConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralEyesTransConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralNOKID_dbo_NOK_NOKID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralNOKID_dbo_NOK_NOKID FOREIGN KEY (ReferralNOKID)
	REFERENCES dbo.NOK (NOKID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralOrganApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralOrganApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralOrganApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralOrganAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralOrganAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralOrganAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralOrganConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralOrganConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralOrganConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralOrganConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralOrganConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralOrganConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralSkinApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralSkinApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralSkinApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralSkinAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralSkinAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralSkinAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralSkinConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralSkinConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralSkinConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralSkinConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralSkinConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralSkinConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralTissueApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralTissueApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralTissueApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralTissueAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralTissueAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralTissueAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralTissueConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralTissueConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralTissueConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralTissueConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralTissueConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralTissueConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralTypeID_dbo_ReferralType_ReferralTypeID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralTypeID_dbo_ReferralType_ReferralTypeID FOREIGN KEY (ReferralTypeID)
	REFERENCES dbo.ReferralType (ReferralTypeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralValvesApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralValvesApproachID_dbo_Approach_ApproachID FOREIGN KEY (ReferralValvesApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralValvesAppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralValvesAppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (ReferralValvesAppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralValvesConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralValvesConsentID_dbo_Consent_ConsentID FOREIGN KEY (ReferralValvesConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Referral_ReferralValvesConversionID_dbo_Conversion_ConversionID')
BEGIN
ALTER TABLE dbo.Referral
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Referral_ReferralValvesConversionID_dbo_Conversion_ConversionID FOREIGN KEY (ReferralValvesConversionID)
	REFERENCES dbo.Conversion (ConversionID)
	NOT FOR REPLICATION;
END
GO
**/   


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReferralSecondaryData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.ReferralSecondaryData
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReferralSecondaryData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_RegistryStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.RegistryStatus
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_RegistryStatus_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportControl_ReportParamSectionID_dbo_ReportParamSection_ReportParamSectionID')
BEGIN
ALTER TABLE dbo.ReportControl
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportControl_ReportParamSectionID_dbo_ReportParamSection_ReportParamSectionID FOREIGN KEY (ReportParamSectionID)
	REFERENCES dbo.ReportParamSection (ReportParamSectionID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportDateTimeConfiguration_ReportDateTimeID_dbo_ReportDateTime_ReportDateTimeID')
BEGIN
ALTER TABLE dbo.ReportDateTimeConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportDateTimeConfiguration_ReportDateTimeID_dbo_ReportDateTime_ReportDateTimeID FOREIGN KEY (ReportDateTimeID)
	REFERENCES dbo.ReportDateTime (ReportDateTimeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportDateTimeConfiguration_ReportID_dbo_Report_ReportID')
BEGIN
ALTER TABLE dbo.ReportDateTimeConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportDateTimeConfiguration_ReportID_dbo_Report_ReportID FOREIGN KEY (ReportID)
	REFERENCES dbo.Report (ReportID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportDateTypeConfiguration_ReportDateTypeID_dbo_ReportDateType_ReportDateTypeID')
BEGIN
ALTER TABLE dbo.ReportDateTypeConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportDateTypeConfiguration_ReportDateTypeID_dbo_ReportDateType_ReportDateTypeID FOREIGN KEY (ReportDateTypeID)
	REFERENCES dbo.ReportDateType (ReportDateTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportDateTypeConfiguration_ReportID_dbo_Report_ReportID')
BEGIN
ALTER TABLE dbo.ReportDateTypeConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportDateTypeConfiguration_ReportID_dbo_Report_ReportID FOREIGN KEY (ReportID)
	REFERENCES dbo.Report (ReportID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportLog_ReportID_dbo_Report_ReportID')
BEGIN
ALTER TABLE dbo.ReportLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportLog_ReportID_dbo_Report_ReportID FOREIGN KEY (ReportID)
	REFERENCES dbo.Report (ReportID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportLog_WebPersonID_dbo_WebPerson_WebPersonID')
BEGIN
ALTER TABLE dbo.ReportLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportLog_WebPersonID_dbo_WebPerson_WebPersonID FOREIGN KEY (WebPersonID)
	REFERENCES dbo.WebPerson (WebPersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportParamConfiguration_ReportControlID_dbo_ReportControl_ReportControlID')
BEGIN
ALTER TABLE dbo.ReportParamConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportParamConfiguration_ReportControlID_dbo_ReportControl_ReportControlID FOREIGN KEY (ReportControlID)
	REFERENCES dbo.ReportControl (ReportControlID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportParamConfiguration_ReportID_dbo_Report_ReportID')
BEGIN
ALTER TABLE dbo.ReportParamConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportParamConfiguration_ReportID_dbo_Report_ReportID FOREIGN KEY (ReportID)
	REFERENCES dbo.Report (ReportID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.ReportRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportRule_ReportID_dbo_Report_ReportID')
BEGIN
ALTER TABLE dbo.ReportRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportRule_ReportID_dbo_Report_ReportID FOREIGN KEY (ReportID)
	REFERENCES dbo.Report (ReportID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportRule_RoleID_dbo_Roles_RoleID')
BEGIN
ALTER TABLE dbo.ReportRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportRule_RoleID_dbo_Roles_RoleID FOREIGN KEY (RoleID)
	REFERENCES dbo.Roles (RoleID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportSortTypeConfiguration_ReportID_dbo_Report_ReportID')
BEGIN
ALTER TABLE dbo.ReportSortTypeConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportSortTypeConfiguration_ReportID_dbo_Report_ReportID FOREIGN KEY (ReportID)
	REFERENCES dbo.Report (ReportID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ReportSortTypeConfiguration_ReportSortTypeID_dbo_ReportSortType_ReportSortTypeID')
BEGIN
ALTER TABLE dbo.ReportSortTypeConfiguration
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ReportSortTypeConfiguration_ReportSortTypeID_dbo_ReportSortType_ReportSortTypeID FOREIGN KEY (ReportSortTypeID)
	REFERENCES dbo.ReportSortType (ReportSortTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Roles_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Roles
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Roles_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_RotationAlerts_AlertID_dbo_Alert_AlertID')
BEGIN
ALTER TABLE dbo.RotationAlerts
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_RotationAlerts_AlertID_dbo_Alert_AlertID FOREIGN KEY (AlertID)
	REFERENCES dbo.Alert (AlertID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_RotationOrganization_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.RotationOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_RotationOrganization_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Schedule_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.Schedule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Schedule_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Schedule_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.Schedule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Schedule_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Schedule_ScheduleShiftID_dbo_ScheduleShift_ScheduleShiftID')
BEGIN
ALTER TABLE dbo.Schedule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Schedule_ScheduleShiftID_dbo_ScheduleShift_ScheduleShiftID FOREIGN KEY (ScheduleShiftID)
	REFERENCES dbo.ScheduleShift (ScheduleShiftID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroup_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.ScheduleGroup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroup_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroupOrganization_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.ScheduleGroupOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroupOrganization_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroupOrganization_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.ScheduleGroupOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroupOrganization_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroupPerson_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.ScheduleGroupPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroupPerson_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroupPerson_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.ScheduleGroupPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroupPerson_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroupSourceCode_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.ScheduleGroupSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroupSourceCode_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleGroupSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.ScheduleGroupSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleGroupSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleItem_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.ScheduleItem
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleItem_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleItemPerson_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.ScheduleItemPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleItemPerson_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix		  
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleItemPerson_ScheduleItemID_dbo_ScheduleItem_ScheduleItemID')
BEGIN
ALTER TABLE dbo.ScheduleItemPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleItemPerson_ScheduleItemID_dbo_ScheduleItem_ScheduleItemID FOREIGN KEY (ScheduleItemID)
	REFERENCES dbo.ScheduleItem (ScheduleItemID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleLog_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.ScheduleLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleLog_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleLog_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.ScheduleLog
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleLog_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleShift_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.ScheduleShift
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleShift_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ScheduleShift_WeekdayID_dbo_Weekday_WeekdayID')
BEGIN
ALTER TABLE dbo.ScheduleShift
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ScheduleShift_WeekdayID_dbo_Weekday_WeekdayID FOREIGN KEY (WeekdayID)
	REFERENCES dbo.Weekday (WeekdayID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SCScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID')
BEGIN
ALTER TABLE dbo.SCScheduleGroup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SCScheduleGroup_ScheduleGroupID_dbo_ScheduleGroup_ScheduleGroupID FOREIGN KEY (ScheduleGroupID)
	REFERENCES dbo.ScheduleGroup (ScheduleGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SCScheduleGroup_SubCriteriaID_dbo_SubCriteria_SubCriteriaID')
BEGIN
ALTER TABLE dbo.SCScheduleGroup
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SCScheduleGroup_SubCriteriaID_dbo_SubCriteria_SubCriteriaID FOREIGN KEY (SubCriteriaID)
	REFERENCES dbo.SubCriteria (SubCriteriaID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Secondary_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Secondary
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Secondary_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Secondary2_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.Secondary2
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Secondary2_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryApproach_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SecondaryApproach
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryApproach_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryDisposition_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SecondaryDisposition
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryDisposition_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryDisposition_SubCriteriaID_dbo_SubCriteria_SubCriteriaID')
BEGIN
ALTER TABLE dbo.SecondaryDisposition
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryDisposition_SubCriteriaID_dbo_SubCriteria_SubCriteriaID FOREIGN KEY (SubCriteriaID)
	REFERENCES dbo.SubCriteria (SubCriteriaID)
	NOT FOR REPLICATION;
END
GO
*/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryMedication_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SecondaryMedication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryMedication_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryMedication_MedicationId_dbo_Medication_MedicationId')
BEGIN
ALTER TABLE dbo.SecondaryMedication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryMedication_MedicationId_dbo_Medication_MedicationId FOREIGN KEY (MedicationId)
	REFERENCES dbo.Medication (MedicationId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryMedicationOther_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SecondaryMedicationOther
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryMedicationOther_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryMedicationOther_MedicationId_dbo_Medication_MedicationId')
BEGIN
ALTER TABLE dbo.SecondaryMedicationOther
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryMedicationOther_MedicationId_dbo_Medication_MedicationId FOREIGN KEY (MedicationId)
	REFERENCES dbo.Medication (MedicationId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecondaryTBI_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SecondaryTBI
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecondaryTBI_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SecurityRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SecurityRule
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SecurityRule_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevel30Organization_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.ServiceLevel30Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevel30Organization_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevel30Organization_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID')
BEGIN
ALTER TABLE dbo.ServiceLevel30Organization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevel30Organization_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID FOREIGN KEY (ServiceLevelID)
	REFERENCES dbo.ServiceLevel (ServiceLevelID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevelCustomList_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID')
BEGIN
ALTER TABLE dbo.ServiceLevelCustomList
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevelCustomList_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID FOREIGN KEY (ServiceLevelID)
	REFERENCES dbo.ServiceLevel (ServiceLevelID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevelDRDSN_DRDSNID_dbo_DRDSN_DRDSNID')
BEGIN
ALTER TABLE dbo.ServiceLevelDRDSN
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevelDRDSN_DRDSNID_dbo_DRDSN_DRDSNID FOREIGN KEY (DRDSNID)
	REFERENCES dbo.DRDSN (DRDSNID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevelDRDSN_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID')
BEGIN
ALTER TABLE dbo.ServiceLevelDRDSN
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevelDRDSN_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID FOREIGN KEY (ServiceLevelID)
	REFERENCES dbo.ServiceLevel (ServiceLevelID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevelSecondaryCtls_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID')
BEGIN
ALTER TABLE dbo.ServiceLevelSecondaryCtls
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevelSecondaryCtls_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID FOREIGN KEY (ServiceLevelID)
	REFERENCES dbo.ServiceLevel (ServiceLevelID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevelSourceCode_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID')
BEGIN
ALTER TABLE dbo.ServiceLevelSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevelSourceCode_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID FOREIGN KEY (ServiceLevelID)
	REFERENCES dbo.ServiceLevel (ServiceLevelID)
	NOT FOR REPLICATION;
END
GO
*/  

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_ServiceLevelSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.ServiceLevelSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_ServiceLevelSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SetDisposition_ApproachID_dbo_Approach_ApproachID')
BEGIN
ALTER TABLE dbo.SetDisposition
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SetDisposition_ApproachID_dbo_Approach_ApproachID FOREIGN KEY (ApproachID)
	REFERENCES dbo.Approach (ApproachID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SetDisposition_AppropriateID_dbo_Appropriate_AppropriateID')
BEGIN
ALTER TABLE dbo.SetDisposition
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SetDisposition_AppropriateID_dbo_Appropriate_AppropriateID FOREIGN KEY (AppropriateID)
	REFERENCES dbo.Appropriate (AppropriateID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SetDisposition_ConsentID_dbo_Consent_ConsentID')
BEGIN
ALTER TABLE dbo.SetDisposition
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SetDisposition_ConsentID_dbo_Consent_ConsentID FOREIGN KEY (ConsentID)
	REFERENCES dbo.Consent (ConsentID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCode_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCode_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeASP_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SourceCodeASP
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeASP_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeASP_SourceCodeId_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.SourceCodeASP
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeASP_SourceCodeId_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeId)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SourceCodeOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeOrganization_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeOrganization_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.SourceCodeOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeOrganization_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeOrganization_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.SourceCodeOrganization
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeOrganization_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeTransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SourceCodeTransplantCenter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeTransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeTransplantCenter_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.SourceCodeTransplantCenter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeTransplantCenter_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeTransplantCenter_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.SourceCodeTransplantCenter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeTransplantCenter_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SourceCodeType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.SourceCodeType
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SourceCodeType_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_StagingLifeBreacharchive_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.StagingLifeBreacharchive
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_StagingLifeBreacharchive_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_StagingLifeBreacharchive_ReferralID_dbo_Referral_ReferralID')
BEGIN
ALTER TABLE dbo.StagingLifeBreacharchive
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_StagingLifeBreacharchive_ReferralID_dbo_Referral_ReferralID FOREIGN KEY (ReferralID)
	REFERENCES dbo.Referral (ReferralID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_StatEmployee_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.StatEmployee
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_StatEmployee_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_StatEmployee_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.StatEmployee
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_StatEmployee_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SubCriteria_CriteriaID_dbo_Criteria_CriteriaID')
BEGIN
ALTER TABLE dbo.SubCriteria
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SubCriteria_CriteriaID_dbo_Criteria_CriteriaID FOREIGN KEY (CriteriaID)
	REFERENCES dbo.Criteria (CriteriaID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SubCriteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID')
BEGIN
ALTER TABLE dbo.SubCriteria
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SubCriteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID FOREIGN KEY (DonorCategoryID)
	REFERENCES dbo.DonorCategory (DonorCategoryID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SubCriteria_SubtypeID_dbo_SubType_SubTypeID')
BEGIN
ALTER TABLE dbo.SubCriteria
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SubCriteria_SubtypeID_dbo_SubType_SubTypeID FOREIGN KEY (SubtypeID)
	REFERENCES dbo.SubType (SubTypeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_SystemAlert_StatEmployeeID_dbo_StatEmployee_StatEmployeeID')
BEGIN
ALTER TABLE dbo.SystemAlert
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_SystemAlert_StatEmployeeID_dbo_StatEmployee_StatEmployeeID FOREIGN KEY (StatEmployeeID)
	REFERENCES dbo.StatEmployee (StatEmployeeID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorAbg_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorAbg
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorAbg_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorAbg_TcssListVentSettingModeId_dbo_TcssListVentSettingMode_TcssListVentSettingModeId')
BEGIN
ALTER TABLE dbo.TcssDonorAbg
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorAbg_TcssListVentSettingModeId_dbo_TcssListVentSettingMode_TcssListVentSettingModeId FOREIGN KEY (TcssListVentSettingModeId)
	REFERENCES dbo.TcssListVentSettingMode (TcssListVentSettingModeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorAbgSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorAbgSummary
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorAbgSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorCompleteBloodCount_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorCompleteBloodCount
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorCompleteBloodCount_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorContactInformation_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorContactInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorContactInformation_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorContactInformation_DaylightSavingsObservedId_dbo_TcssListDaylightSavingsObserved')
BEGIN
ALTER TABLE dbo.TcssDonorContactInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorContactInformation_DaylightSavingsObservedId_dbo_TcssListDaylightSavingsObserved FOREIGN KEY (TcssListDaylightSavingsObservedId)
	REFERENCES dbo.TcssListDaylightSavingsObserved (TcssListDaylightSavingsObservedId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorContactInformation_TcssListTimeZoneId_dbo_TcssListTimeZone_TcssListTimeZoneId')
BEGIN
ALTER TABLE dbo.TcssDonorContactInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorContactInformation_TcssListTimeZoneId_dbo_TcssListTimeZone_TcssListTimeZoneId FOREIGN KEY (TcssListTimeZoneId)
	REFERENCES dbo.TcssListTimeZone (TcssListTimeZoneId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorCulture_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorCulture
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorCulture_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorCulture_TcssListCultureResultId_dbo_TcssListCultureResult_TcssListCultureResultId')
BEGIN
ALTER TABLE dbo.TcssDonorCulture
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorCulture_TcssListCultureResultId_dbo_TcssListCultureResult_TcssListCultureResultId FOREIGN KEY (TcssListCultureResultId)
	REFERENCES dbo.TcssListCultureResult (TcssListCultureResultId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorCulture_TcssListCultureTypeId_dbo_TcssListCultureType_TcssListCultureTypeId')
BEGIN
ALTER TABLE dbo.TcssDonorCulture
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorCulture_TcssListCultureTypeId_dbo_TcssListCultureType_TcssListCultureTypeId FOREIGN KEY (TcssListCultureTypeId)
	REFERENCES dbo.TcssListCultureType (TcssListCultureTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisHeart_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisHeart
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisHeart_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_dbo_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisHeart
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_dbo_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId FOREIGN KEY (TcssListDiagnosisHeartMethodId)
	REFERENCES dbo.TcssListDiagnosisHeartMethod (TcssListDiagnosisHeartMethodId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisIntestine_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisIntestine
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisIntestine_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidney_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidney
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidney_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_dbo_TcssListKidneyBiopsy_TcssListKidneyBiopsyId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidney
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_dbo_TcssListKidneyBiopsy_TcssListKidneyBiopsyId FOREIGN KEY (TcssListKidneyBiopsyId)
	REFERENCES dbo.TcssListKidneyBiopsy (TcssListKidneyBiopsyId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidney
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId FOREIGN KEY (TcssListKidneyId)
	REFERENCES dbo.TcssListKidney (TcssListKidneyId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_dbo_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidney
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_dbo_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId FOREIGN KEY (TcssListKidneyPumpDeviceId)
	REFERENCES dbo.TcssListKidneyPumpDevice (TcssListKidneyPumpDeviceId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_dbo_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidney
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_dbo_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId FOREIGN KEY (TcssListKidneyPumpSolutionId)
	REFERENCES dbo.TcssListKidneyPumpSolution (TcssListKidneyPumpSolutionId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_dbo_TcssListKidneyArtery_TcssListKidneyArteryId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_dbo_TcssListKidneyArtery_TcssListKidneyArteryId FOREIGN KEY (TcssListKidneyArteryId)
	REFERENCES dbo.TcssListKidneyArtery (TcssListKidneyArteryId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId FOREIGN KEY (TcssListKidneyId)
	REFERENCES dbo.TcssListKidney (TcssListKidneyId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId FOREIGN KEY (TcssListKidneyId)
	REFERENCES dbo.TcssListKidney (TcssListKidneyId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_dbo_TcssListKidneyUreter_TcssListKidneyUreterId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_dbo_TcssListKidneyUreter_TcssListKidneyUreterId FOREIGN KEY (TcssListKidneyUreterId)
	REFERENCES dbo.TcssListKidneyUreter (TcssListKidneyUreterId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyVein_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyVein_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_dbo_TcssListKidney_TcssListKidneyId FOREIGN KEY (TcssListKidneyId)
	REFERENCES dbo.TcssListKidney (TcssListKidneyId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_dbo_TcssListKidneyVein_TcssListKidneyVeinId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_dbo_TcssListKidneyVein_TcssListKidneyVeinId FOREIGN KEY (TcssListKidneyVeinId)
	REFERENCES dbo.TcssListKidneyVein (TcssListKidneyVeinId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisLiver_TcssListLiverBiopsyId_dbo_TcssListLiverBiopsy_TcssListLiverBiopsyId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisLiver_TcssListLiverBiopsyId_dbo_TcssListLiverBiopsy_TcssListLiverBiopsyId FOREIGN KEY (TcssListLiverBiopsyId)
	REFERENCES dbo.TcssListLiverBiopsy (TcssListLiverBiopsyId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisLung_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisLung
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisLung_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorDiagnosisPancreas_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorDiagnosisPancreas
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorDiagnosisPancreas_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListAntihypertensiveId_dbo_TcssListAntihypertensive_TcssListAntihypertensiveId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListAntihypertensiveId_dbo_TcssListAntihypertensive_TcssListAntihypertensiveId FOREIGN KEY (TcssListAntihypertensiveId)
	REFERENCES dbo.TcssListAntihypertensive (TcssListAntihypertensiveId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListArginineVasopressinId_dbo_TcssListArginineVasopressin_TcssListArginineVasopressinId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListArginineVasopressinId_dbo_TcssListArginineVasopressin_TcssListArginineVasopressinId FOREIGN KEY (TcssListArginineVasopressinId)
	REFERENCES dbo.TcssListArginineVasopressin (TcssListArginineVasopressinId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListDdavpId_dbo_TcssListDdavp_TcssListDdavpId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListDdavpId_dbo_TcssListDdavp_TcssListDdavpId FOREIGN KEY (TcssListDdavpId)
	REFERENCES dbo.TcssListDdavp (TcssListDdavpId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_dbo_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_dbo_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId FOREIGN KEY (TcssListDextroseInIvFluidsId)
	REFERENCES dbo.TcssListDextroseInIvFluids (TcssListDextroseInIvFluidsId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListDiureticId_dbo_TcssListDiuretic_TcssListDiureticId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListDiureticId_dbo_TcssListDiuretic_TcssListDiureticId FOREIGN KEY (TcssListDiureticId)
	REFERENCES dbo.TcssListDiuretic (TcssListDiureticId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListHeparinId_dbo_TcssListHeparin_TcssListHeparinId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListHeparinId_dbo_TcssListHeparin_TcssListHeparinId FOREIGN KEY (TcssListHeparinId)
	REFERENCES dbo.TcssListHeparin (TcssListHeparinId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListInsulinId_dbo_TcssListInsulin_TcssListInsulinId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListInsulinId_dbo_TcssListInsulin_TcssListInsulinId FOREIGN KEY (TcssListInsulinId)
	REFERENCES dbo.TcssListInsulin (TcssListInsulinId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_dbo_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_dbo_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId FOREIGN KEY (TcssListNumberOfTransfusionId)
	REFERENCES dbo.TcssListNumberOfTransfusion (TcssListNumberOfTransfusionId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListOtherBloodProductId_dbo_TcssListOtherBloodProduct_TcssListOtherBloodProductId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListOtherBloodProductId_dbo_TcssListOtherBloodProduct_TcssListOtherBloodProductId FOREIGN KEY (TcssListOtherBloodProductId)
	REFERENCES dbo.TcssListOtherBloodProduct (TcssListOtherBloodProductId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListSteroidId_dbo_TcssListSteroid_TcssListSteroidId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListSteroidId_dbo_TcssListSteroid_TcssListSteroidId FOREIGN KEY (TcssListSteroidId)
	REFERENCES dbo.TcssListSteroid (TcssListSteroidId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListT3Id_dbo_TcssListT3_TcssListT3Id')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListT3Id_dbo_TcssListT3_TcssListT3Id FOREIGN KEY (TcssListT3Id)
	REFERENCES dbo.TcssListT3 (TcssListT3Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListT4Id_dbo_TcssListT4_TcssListT4Id')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListT4Id_dbo_TcssListT4_TcssListT4Id FOREIGN KEY (TcssListT4Id)
	REFERENCES dbo.TcssListT4 (TcssListT4Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorFluidBlood_TcssListVasodilatorId_dbo_TcssListVasodilator_TcssListVasodilatorId')
BEGIN
ALTER TABLE dbo.TcssDonorFluidBlood
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorFluidBlood_TcssListVasodilatorId_dbo_TcssListVasodilator_TcssListVasodilatorId FOREIGN KEY (TcssListVasodilatorId)
	REFERENCES dbo.TcssListVasodilator (TcssListVasodilatorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListAboId_dbo_TcssListAbo_TcssListAboId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListAboId_dbo_TcssListAbo_TcssListAboId FOREIGN KEY (TcssListAboId)
	REFERENCES dbo.TcssListAbo (TcssListAboId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListAgeUnitId_dbo_TcssListAgeUnit_TcssListAgeUnitId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListAgeUnitId_dbo_TcssListAgeUnit_TcssListAgeUnitId FOREIGN KEY (TcssListAgeUnitId)
	REFERENCES dbo.TcssListAgeUnit (TcssListAgeUnitId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListCardiacArrestDownTimeId_dbo_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListCardiacArrestDownTimeId_dbo_TcssListCardiacArrestDownTime_TcssListCardiacArrestDownTimeId FOREIGN KEY (TcssListCardiacArrestDownTimeId)
	REFERENCES dbo.TcssListCardiacArrestDownTime (TcssListCardiacArrestDownTimeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListCauseOfDeathId_dbo_TcssListCauseOfDeath_TcssListCauseOfDeathId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListCauseOfDeathId_dbo_TcssListCauseOfDeath_TcssListCauseOfDeathId FOREIGN KEY (TcssListCauseOfDeathId)
	REFERENCES dbo.TcssListCauseOfDeath (TcssListCauseOfDeathId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListCircumstancesOfDeathId_dbo_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListCircumstancesOfDeathId_dbo_TcssListCircumstancesOfDeath_TcssListCircumstancesOfDeathId FOREIGN KEY (TcssListCircumstancesOfDeathId)
	REFERENCES dbo.TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListCprAdministeredId_dbo_TcssListCprAdministered_TcssListCprAdministeredId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListCprAdministeredId_dbo_TcssListCprAdministered_TcssListCprAdministeredId FOREIGN KEY (TcssListCprAdministeredId)
	REFERENCES dbo.TcssListCprAdministered (TcssListCprAdministeredId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListDonorDbdSubDefinitionId_dbo_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListDonorDbdSubDefinitionId_dbo_TcssListDonorDbdSubDefinition_TcssListDonorDbdSubDefinitionId FOREIGN KEY (TcssListDonorDbdSubDefinitionId)
	REFERENCES dbo.TcssListDonorDbdSubDefinition (TcssListDonorDbdSubDefinitionId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListDonorDcdSubDefinitionId_dbo_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListDonorDcdSubDefinitionId_dbo_TcssListDonorDcdSubDefinition_TcssListDonorDcdSubDefinitionId FOREIGN KEY (TcssListDonorDcdSubDefinitionId)
	REFERENCES dbo.TcssListDonorDcdSubDefinition (TcssListDonorDcdSubDefinitionId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListDonorDefinitionId_dbo_TcssListDonorDefinition_TcssListDonorDefinitionId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListDonorDefinitionId_dbo_TcssListDonorDefinition_TcssListDonorDefinitionId FOREIGN KEY (TcssListDonorDefinitionId)
	REFERENCES dbo.TcssListDonorDefinition (TcssListDonorDefinitionId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_dbo_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListDonorMeetsDcdCriteriaId_dbo_TcssListDonorMeetsDcdCriteria_TcssListDonorMeetsDcdCriteriaId FOREIGN KEY (TcssListDonorMeetsDcdCriteriaId)
	REFERENCES dbo.TcssListDonorMeetsDcdCriteria (TcssListDonorMeetsDcdCriteriaId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_dbo_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListDonorMeetsEcdCriteriaId_dbo_TcssListDonorMeetsEcdCriteria_TcssListDonorMeetsEcdCriteriaId FOREIGN KEY (TcssListDonorMeetsEcdCriteriaId)
	REFERENCES dbo.TcssListDonorMeetsEcdCriteria (TcssListDonorMeetsEcdCriteriaId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListEthnicityId_dbo_TcssListEthnicity_TcssListEthnicityId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListEthnicityId_dbo_TcssListEthnicity_TcssListEthnicityId FOREIGN KEY (TcssListEthnicityId)
	REFERENCES dbo.TcssListEthnicity (TcssListEthnicityId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListGenderId_dbo_TcssListGender_TcssListGenderId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListGenderId_dbo_TcssListGender_TcssListGenderId FOREIGN KEY (TcssListGenderId)
	REFERENCES dbo.TcssListGender (TcssListGenderId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListMechanismOfDeathId_dbo_TcssListMechanismOfDeath_TcssListMechanismOfDeathId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListMechanismOfDeathId_dbo_TcssListMechanismOfDeath_TcssListMechanismOfDeathId FOREIGN KEY (TcssListMechanismOfDeathId)
	REFERENCES dbo.TcssListMechanismOfDeath (TcssListMechanismOfDeathId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHla_TcssListRaceId_dbo_TcssListRace_TcssListRaceId')
BEGIN
ALTER TABLE dbo.TcssDonorHla
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHla_TcssListRaceId_dbo_TcssListRace_TcssListRaceId FOREIGN KEY (TcssListRaceId)
	REFERENCES dbo.TcssListRace (TcssListRaceId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaA1Id_dbo_TcssListHlaA1_TcssListHlaA1Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaA1Id_dbo_TcssListHlaA1_TcssListHlaA1Id FOREIGN KEY (TcssListHlaA1Id)
	REFERENCES dbo.TcssListHlaA1 (TcssListHlaA1Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaA2Id_dbo_TcssListHlaA2_TcssListHlaA2Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaA2Id_dbo_TcssListHlaA2_TcssListHlaA2Id FOREIGN KEY (TcssListHlaA2Id)
	REFERENCES dbo.TcssListHlaA2 (TcssListHlaA2Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaB1Id_dbo_TcssListHlaB1_TcssListHlaB1Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaB1Id_dbo_TcssListHlaB1_TcssListHlaB1Id FOREIGN KEY (TcssListHlaB1Id)
	REFERENCES dbo.TcssListHlaB1 (TcssListHlaB1Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaB2Id_dbo_TcssListHlaB2_TcssListHlaB2Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaB2Id_dbo_TcssListHlaB2_TcssListHlaB2Id FOREIGN KEY (TcssListHlaB2Id)
	REFERENCES dbo.TcssListHlaB2 (TcssListHlaB2Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaBw4Id_dbo_TcssListHlaBw4_TcssListHlaBw4Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaBw4Id_dbo_TcssListHlaBw4_TcssListHlaBw4Id FOREIGN KEY (TcssListHlaBw4Id)
	REFERENCES dbo.TcssListHlaBw4 (TcssListHlaBw4Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaBw6Id_dbo_TcssListHlaBw6_TcssListHlaBw6Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaBw6Id_dbo_TcssListHlaBw6_TcssListHlaBw6Id FOREIGN KEY (TcssListHlaBw6Id)
	REFERENCES dbo.TcssListHlaBw6 (TcssListHlaBw6Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaC1Id_dbo_TcssListHlaC1_TcssListHlaC1Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaC1Id_dbo_TcssListHlaC1_TcssListHlaC1Id FOREIGN KEY (TcssListHlaC1Id)
	REFERENCES dbo.TcssListHlaC1 (TcssListHlaC1Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaC2Id_dbo_TcssListHlaC2_TcssListHlaC2Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaC2Id_dbo_TcssListHlaC2_TcssListHlaC2Id FOREIGN KEY (TcssListHlaC2Id)
	REFERENCES dbo.TcssListHlaC2 (TcssListHlaC2Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDq1Id_dbo_TcssListHlaDq1_TcssListHlaDq1Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDq1Id_dbo_TcssListHlaDq1_TcssListHlaDq1Id FOREIGN KEY (TcssListHlaDq1Id)
	REFERENCES dbo.TcssListHlaDq1 (TcssListHlaDq1Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDq2Id_dbo_TcssListHlaDq2_TcssListHlaDq2Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDq2Id_dbo_TcssListHlaDq2_TcssListHlaDq2Id FOREIGN KEY (TcssListHlaDq2Id)
	REFERENCES dbo.TcssListHlaDq2 (TcssListHlaDq2Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDr1Id_dbo_TcssListHlaDr1_TcssListHlaDr1Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDr1Id_dbo_TcssListHlaDr1_TcssListHlaDr1Id FOREIGN KEY (TcssListHlaDr1Id)
	REFERENCES dbo.TcssListHlaDr1 (TcssListHlaDr1Id)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDr2Id_dbo_TcssListHlaDr2_TcssListHlaDr2Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDr2Id_dbo_TcssListHlaDr2_TcssListHlaDr2Id FOREIGN KEY (TcssListHlaDr2Id)
	REFERENCES dbo.TcssListHlaDr2 (TcssListHlaDr2Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDr51Id_dbo_TcssListHlaDr51_TcssListHlaDr51Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDr51Id_dbo_TcssListHlaDr51_TcssListHlaDr51Id FOREIGN KEY (TcssListHlaDr51Id)
	REFERENCES dbo.TcssListHlaDr51 (TcssListHlaDr51Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDr52Id_dbo_TcssListHlaDr52_TcssListHlaDr52Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDr52Id_dbo_TcssListHlaDr52_TcssListHlaDr52Id FOREIGN KEY (TcssListHlaDr52Id)
	REFERENCES dbo.TcssListHlaDr52 (TcssListHlaDr52Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListHlaDr53Id_dbo_TcssListHlaDr53_TcssListHlaDr53Id')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListHlaDr53Id_dbo_TcssListHlaDr53_TcssListHlaDr53Id FOREIGN KEY (TcssListHlaDr53Id)
	REFERENCES dbo.TcssListHlaDr53 (TcssListHlaDr53Id)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_dbo_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId')
BEGIN
ALTER TABLE dbo.TcssDonorHlaLiver
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_dbo_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId FOREIGN KEY (TcssListPreliminaryCrossmatchId)
	REFERENCES dbo.TcssListPreliminaryCrossmatch (TcssListPreliminaryCrossmatchId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLab_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorLab
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLab_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLab_TcssListToxicologyScreenId_dbo_TcssListToxicologyScreen_TcssListToxicologyScreenId')
BEGIN
ALTER TABLE dbo.TcssDonorLab
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLab_TcssListToxicologyScreenId_dbo_TcssListToxicologyScreen_TcssListToxicologyScreenId FOREIGN KEY (TcssListToxicologyScreenId)
	REFERENCES dbo.TcssListToxicologyScreen (TcssListToxicologyScreenId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLabProfile_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorLabProfile
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLabProfile_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLabProfileDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorLabProfileDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLabProfileDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLabProfileDetail_TcssDonorLabProfileId_dbo_TcssDonorLabProfile_TcssDonorLabProfileId')
BEGIN
ALTER TABLE dbo.TcssDonorLabProfileDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLabProfileDetail_TcssDonorLabProfileId_dbo_TcssDonorLabProfile_TcssDonorLabProfileId FOREIGN KEY (TcssDonorLabProfileId)
	REFERENCES dbo.TcssDonorLabProfile (TcssDonorLabProfileId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLabProfileDetail_TcssListLabId_dbo_TcssListLab_TcssListLabId')
BEGIN
ALTER TABLE dbo.TcssDonorLabProfileDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLabProfileDetail_TcssListLabId_dbo_TcssListLab_TcssListLabId FOREIGN KEY (TcssListLabId)
	REFERENCES dbo.TcssListLab (TcssListLabId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLabProfileSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorLabProfileSummary
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLabProfileSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorLabValues_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorLabValues
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorLabValues_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedication_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorMedication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedication_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedication_TcssListMedicationDoseUnitId_dbo_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId')
BEGIN
ALTER TABLE dbo.TcssDonorMedication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedication_TcssListMedicationDoseUnitId_dbo_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId FOREIGN KEY (TcssListMedicationDoseUnitId)
	REFERENCES dbo.TcssListMedicationDoseUnit (TcssListMedicationDoseUnitId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedication_TcssListMedicationId_dbo_TcssListMedication_TcssListMedicationId')
BEGIN
ALTER TABLE dbo.TcssDonorMedication
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedication_TcssListMedicationId_dbo_TcssListMedication_TcssListMedicationId FOREIGN KEY (TcssListMedicationId)
	REFERENCES dbo.TcssListMedication (TcssListMedicationId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListChestTraumaId_dbo_TcssListChestTrauma_TcssListChestTraumaId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListChestTraumaId_dbo_TcssListChestTrauma_TcssListChestTraumaId FOREIGN KEY (TcssListChestTraumaId)
	REFERENCES dbo.TcssListChestTrauma (TcssListChestTraumaId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_dbo_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_dbo_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId FOREIGN KEY (TcssListCigaretteUseContinuedId)
	REFERENCES dbo.TcssListCigaretteUseContinued (TcssListCigaretteUseContinuedId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseId_dbo_TcssListCigaretteUse_TcssListCigaretteUseId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListCigaretteUseId_dbo_TcssListCigaretteUse_TcssListCigaretteUseId FOREIGN KEY (TcssListCigaretteUseId)
	REFERENCES dbo.TcssListCigaretteUse (TcssListCigaretteUseId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_dbo_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_dbo_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId FOREIGN KEY (TcssListCompliantWithTreatmentId)
	REFERENCES dbo.TcssListCompliantWithTreatment (TcssListCompliantWithTreatmentId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_dbo_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_dbo_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId FOREIGN KEY (TcssListDonorMeetCdcGuidelinesId)
	REFERENCES dbo.TcssListDonorMeetCdcGuidelines (TcssListDonorMeetCdcGuidelinesId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_dbo_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_dbo_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId FOREIGN KEY (TcssListHeavyAlcoholUseId)
	REFERENCES dbo.TcssListHeavyAlcoholUse (TcssListHeavyAlcoholUseId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListHistoryOfCancerId_dbo_TcssListHistoryOfCancer_TcssListHistoryOfCancerId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListHistoryOfCancerId_dbo_TcssListHistoryOfCancer_TcssListHistoryOfCancerId FOREIGN KEY (TcssListHistoryOfCancerId)
	REFERENCES dbo.TcssListHistoryOfCancer (TcssListHistoryOfCancerId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_HistoryOfCoronaryArteryDiseaseId_dbo_TcssListHistoryOfCoronaryArteryDisease')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_HistoryOfCoronaryArteryDiseaseId_dbo_TcssListHistoryOfCoronaryArteryDisease FOREIGN KEY (TcssListHistoryOfCoronaryArteryDiseaseId)
	REFERENCES dbo.TcssListHistoryOfCoronaryArteryDisease (TcssListHistoryOfCoronaryArteryDiseaseId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_dbo_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_dbo_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId FOREIGN KEY (TcssListHistoryOfDiabetesId)
	REFERENCES dbo.TcssListHistoryOfDiabetes (TcssListHistoryOfDiabetesId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_dbo_TcssListHistoryOfGastrointestinalDisease')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_dbo_TcssListHistoryOfGastrointestinalDisease FOREIGN KEY (TcssListHistoryOfGastrointestinalDiseaseId)
	REFERENCES dbo.TcssListHistoryOfGastrointestinalDisease (TcssListHistoryOfGastrointestinalDiseaseId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListHypertensionHistoryId_dbo_TcssListHypertensionHistory_TcssListHypertensionHistoryId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListHypertensionHistoryId_dbo_TcssListHypertensionHistory_TcssListHypertensionHistoryId FOREIGN KEY (TcssListHypertensionHistoryId)
	REFERENCES dbo.TcssListHypertensionHistory (TcssListHypertensionHistoryId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorMedSoc_TcssListOtherDrugUseId_dbo_TcssListOtherDrugUse_TcssListOtherDrugUseId')
BEGIN
ALTER TABLE dbo.TcssDonorMedSoc
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorMedSoc_TcssListOtherDrugUseId_dbo_TcssListOtherDrugUse_TcssListOtherDrugUseId FOREIGN KEY (TcssListOtherDrugUseId)
	REFERENCES dbo.TcssListOtherDrugUse (TcssListOtherDrugUseId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorSerologies_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorSerologies
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorSerologies_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorSerologies_TcssListSerologyAnswerId_dbo_TcssListSerologyAnswer_TcssListSerologyAnswerId')
BEGIN
ALTER TABLE dbo.TcssDonorSerologies
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorSerologies_TcssListSerologyAnswerId_dbo_TcssListSerologyAnswer_TcssListSerologyAnswerId FOREIGN KEY (TcssListSerologyAnswerId)
	REFERENCES dbo.TcssListSerologyAnswer (TcssListSerologyAnswerId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorSerologies_TcssListSerologyQuestionId_dbo_TcssListSerologyQuestion_TcssListSerologyQuestionId')
BEGIN
ALTER TABLE dbo.TcssDonorSerologies
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorSerologies_TcssListSerologyQuestionId_dbo_TcssListSerologyQuestion_TcssListSerologyQuestionId FOREIGN KEY (TcssListSerologyQuestionId)
	REFERENCES dbo.TcssListSerologyQuestion (TcssListSerologyQuestionId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorTest_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorTest
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorTest_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorTest_TcssListTestTypeId_dbo_TcssListTestType_TcssListTestTypeId')
BEGIN
ALTER TABLE dbo.TcssDonorTest
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorTest_TcssListTestTypeId_dbo_TcssListTestType_TcssListTestTypeId FOREIGN KEY (TcssListTestTypeId)
	REFERENCES dbo.TcssListTestType (TcssListTestTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorToRecipient_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorToRecipient
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorToRecipient_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorToRecipient_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId')
BEGIN
ALTER TABLE dbo.TcssDonorToRecipient
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorToRecipient_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId FOREIGN KEY (TcssRecipientId)
	REFERENCES dbo.TcssRecipient (TcssRecipientId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_dbo_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_dbo_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId FOREIGN KEY (TcssListUrinalysisBacteriaId)
	REFERENCES dbo.TcssListUrinalysisBacteria (TcssListUrinalysisBacteriaId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBloodId_dbo_TcssListUrinalysisBlood_TcssListUrinalysisBloodId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisBloodId_dbo_TcssListUrinalysisBlood_TcssListUrinalysisBloodId FOREIGN KEY (TcssListUrinalysisBloodId)
	REFERENCES dbo.TcssListUrinalysisBlood (TcssListUrinalysisBloodId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisCastId_dbo_TcssListUrinalysisCast_TcssListUrinalysisCastId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisCastId_dbo_TcssListUrinalysisCast_TcssListUrinalysisCastId FOREIGN KEY (TcssListUrinalysisCastId)
	REFERENCES dbo.TcssListUrinalysisCast (TcssListUrinalysisCastId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisEpithId_dbo_TcssListUrinalysisEpith_TcssListUrinalysisEpithId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisEpithId_dbo_TcssListUrinalysisEpith_TcssListUrinalysisEpithId FOREIGN KEY (TcssListUrinalysisEpithId)
	REFERENCES dbo.TcssListUrinalysisEpith (TcssListUrinalysisEpithId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_dbo_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_dbo_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId FOREIGN KEY (TcssListUrinalysisGlucoseId)
	REFERENCES dbo.TcssListUrinalysisGlucose (TcssListUrinalysisGlucoseId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_dbo_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_dbo_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId FOREIGN KEY (TcssListUrinalysisLeukocyteId)
	REFERENCES dbo.TcssListUrinalysisLeukocyte (TcssListUrinalysisLeukocyteId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisProteinId_dbo_TcssListUrinalysisProtein_TcssListUrinalysisProteinId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisProteinId_dbo_TcssListUrinalysisProtein_TcssListUrinalysisProteinId FOREIGN KEY (TcssListUrinalysisProteinId)
	REFERENCES dbo.TcssListUrinalysisProtein (TcssListUrinalysisProteinId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisRbcId_dbo_TcssListUrinalysisRbc_TcssListUrinalysisRbcId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisRbcId_dbo_TcssListUrinalysisRbc_TcssListUrinalysisRbcId FOREIGN KEY (TcssListUrinalysisRbcId)
	REFERENCES dbo.TcssListUrinalysisRbc (TcssListUrinalysisRbcId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisWbcId_dbo_TcssListUrinalysisWbc_TcssListUrinalysisWbcId')
BEGIN
ALTER TABLE dbo.TcssDonorUrinalysis
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorUrinalysis_TcssListUrinalysisWbcId_dbo_TcssListUrinalysisWbc_TcssListUrinalysisWbcId FOREIGN KEY (TcssListUrinalysisWbcId)
	REFERENCES dbo.TcssListUrinalysisWbc (TcssListUrinalysisWbcId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorVitalSign_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorVitalSign
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorVitalSign_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorVitalSignDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorVitalSignDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorVitalSignDetail_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorVitalSignDetail_TcssDonorVitalSignId_dbo_TcssDonorVitalSign_TcssDonorVitalSignId')
BEGIN
ALTER TABLE dbo.TcssDonorVitalSignDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorVitalSignDetail_TcssDonorVitalSignId_dbo_TcssDonorVitalSign_TcssDonorVitalSignId FOREIGN KEY (TcssDonorVitalSignId)
	REFERENCES dbo.TcssDonorVitalSign (TcssDonorVitalSignId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorVitalSignDetail_TcssListVitalSignId_dbo_TcssListVitalSign_TcssListVitalSignId')
BEGIN
ALTER TABLE dbo.TcssDonorVitalSignDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorVitalSignDetail_TcssListVitalSignId_dbo_TcssListVitalSign_TcssListVitalSignId FOREIGN KEY (TcssListVitalSignId)
	REFERENCES dbo.TcssListVitalSign (TcssListVitalSignId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssDonorVitalSignSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId')
BEGIN
ALTER TABLE dbo.TcssDonorVitalSignSummary
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssDonorVitalSignSummary_TcssDonorId_dbo_TcssDonor_TcssDonorId FOREIGN KEY (TcssDonorId)
	REFERENCES dbo.TcssDonor (TcssDonorId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_dbo_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId')
BEGIN
ALTER TABLE dbo.TcssRecipientCandidate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_dbo_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId FOREIGN KEY (TcssListRefusedByOtherCenterId)
	REFERENCES dbo.TcssListRefusedByOtherCenter (TcssListRefusedByOtherCenterId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientCandidate_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId')
BEGIN
ALTER TABLE dbo.TcssRecipientCandidate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientCandidate_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId FOREIGN KEY (TcssRecipientId)
	REFERENCES dbo.TcssRecipient (TcssRecipientId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientCandidateDetail_TcssListOfferStatusId_dbo_TcssListOfferStatus_TcssListOfferStatusId')
BEGIN
ALTER TABLE dbo.TcssRecipientCandidateDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientCandidateDetail_TcssListOfferStatusId_dbo_TcssListOfferStatus_TcssListOfferStatusId FOREIGN KEY (TcssListOfferStatusId)
	REFERENCES dbo.TcssListOfferStatus (TcssListOfferStatusId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientCandidateDetail_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId')
BEGIN
ALTER TABLE dbo.TcssRecipientCandidateDetail
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientCandidateDetail_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId FOREIGN KEY (TcssRecipientId)
	REFERENCES dbo.TcssRecipient (TcssRecipientId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_TcssListKidneyTypeId_dbo_TcssListKidneyType_TcssListKidneyTypeId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_TcssListKidneyTypeId_dbo_TcssListKidneyType_TcssListKidneyTypeId FOREIGN KEY (TcssListKidneyTypeId)
	REFERENCES dbo.TcssListKidneyType (TcssListKidneyTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_TcssListLiverTypeId_dbo_TcssListLiverType_TcssListLiverTypeId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_TcssListLiverTypeId_dbo_TcssListLiverType_TcssListLiverTypeId FOREIGN KEY (TcssListLiverTypeId)
	REFERENCES dbo.TcssListLiverType (TcssListLiverTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_TcssListLungTypeId_dbo_TcssListLungType_TcssListLungTypeId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_TcssListLungTypeId_dbo_TcssListLungType_TcssListLungTypeId FOREIGN KEY (TcssListLungTypeId)
	REFERENCES dbo.TcssListLungType (TcssListLungTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_TcssListOrganTypeId_dbo_TcssListOrganType_TcssListOrganTypeId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_TcssListOrganTypeId_dbo_TcssListOrganType_TcssListOrganTypeId FOREIGN KEY (TcssListOrganTypeId)
	REFERENCES dbo.TcssListOrganType (TcssListOrganTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_dbo_TcssListStatusOfImportData_TcssListStatusOfImportDataId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_dbo_TcssListStatusOfImportData_TcssListStatusOfImportDataId FOREIGN KEY (TcssListStatusOfImportDataId)
	REFERENCES dbo.TcssListStatusOfImportData (TcssListStatusOfImportDataId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId FOREIGN KEY (TcssRecipientId)
	REFERENCES dbo.TcssRecipient (TcssRecipientId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferStatusInformation_TcssListStatusId_dbo_TcssListStatus_TcssListStatusId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferStatusInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferStatusInformation_TcssListStatusId_dbo_TcssListStatus_TcssListStatusId FOREIGN KEY (TcssListStatusId)
	REFERENCES dbo.TcssListStatus (TcssListStatusId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TcssRecipientOfferStatusInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId')
BEGIN
ALTER TABLE dbo.TcssRecipientOfferStatusInformation
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TcssRecipientOfferStatusInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId FOREIGN KEY (TcssRecipientId)
	REFERENCES dbo.TcssRecipient (TcssRecipientId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TimeZone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.TimeZone
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TimeZone_AuditLogTypeId_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeId)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TrainedRequestor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.TrainedRequestor
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TrainedRequestor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_TransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.TransplantCenter
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_TransplantCenter_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_UserRoles_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.UserRoles
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_UserRoles_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_UserRoles_RoleID_dbo_Roles_RoleID')
BEGIN
ALTER TABLE dbo.UserRoles
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_UserRoles_RoleID_dbo_Roles_RoleID FOREIGN KEY (RoleID)
	REFERENCES dbo.Roles (RoleID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_UserRoles_WebPersonID_dbo_WebPerson_WebPersonID')
BEGIN
ALTER TABLE dbo.UserRoles
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_UserRoles_WebPersonID_dbo_WebPerson_WebPersonID FOREIGN KEY (WebPersonID)
	REFERENCES dbo.WebPerson (WebPersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebPerson_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.WebPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebPerson_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebPerson_PersonID_dbo_Person_PersonID')
BEGIN
ALTER TABLE dbo.WebPerson
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebPerson_PersonID_dbo_Person_PersonID FOREIGN KEY (PersonID)
	REFERENCES dbo.Person (PersonID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebPersonPermission_PERMISSIONID_dbo_Permission_PERMISSIONID')
BEGIN
ALTER TABLE dbo.WebPersonPermission
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebPersonPermission_PERMISSIONID_dbo_Permission_PERMISSIONID FOREIGN KEY (PERMISSIONID)
	REFERENCES dbo.Permission (PERMISSIONID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebPersonPermission_WEBPERSONID_dbo_WebPerson_WebPersonID')
BEGIN
ALTER TABLE dbo.WebPersonPermission
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebPersonPermission_WEBPERSONID_dbo_WebPerson_WebPersonID FOREIGN KEY (WEBPERSONID)
	REFERENCES dbo.WebPerson (WebPersonID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebReportGroupAccessDate_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID')
BEGIN
ALTER TABLE dbo.WebReportGroupAccessDate
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebReportGroupAccessDate_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID FOREIGN KEY (WebReportGroupID)
	REFERENCES dbo.WebReportGroup (WebReportGroupID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebReportGroupOrg_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId')
BEGIN
ALTER TABLE dbo.WebReportGroupOrg
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebReportGroupOrg_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId FOREIGN KEY (AuditLogTypeID)
	REFERENCES dbo.AuditLogType (AuditLogTypeId)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebReportGroupOrg_OrganizationID_dbo_Organization_OrganizationID')
BEGIN
ALTER TABLE dbo.WebReportGroupOrg
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebReportGroupOrg_OrganizationID_dbo_Organization_OrganizationID FOREIGN KEY (OrganizationID)
	REFERENCES dbo.Organization (OrganizationID)
	NOT FOR REPLICATION;
END
GO


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebReportGroupOrg_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID')
BEGIN
ALTER TABLE dbo.WebReportGroupOrg
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebReportGroupOrg_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID FOREIGN KEY (WebReportGroupID)
	REFERENCES dbo.WebReportGroup (WebReportGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Data fix
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebReportGroupSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID')
BEGIN
ALTER TABLE dbo.WebReportGroupSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebReportGroupSourceCode_SourceCodeID_dbo_SourceCode_SourceCodeID FOREIGN KEY (SourceCodeID)
	REFERENCES dbo.SourceCode (SourceCodeID)
	NOT FOR REPLICATION;
END
GO
*/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_WebReportGroupSourceCode_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID')
BEGIN
ALTER TABLE dbo.WebReportGroupSourceCode
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_WebReportGroupSourceCode_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID FOREIGN KEY (WebReportGroupID)
	REFERENCES dbo.WebReportGroup (WebReportGroupID)
	NOT FOR REPLICATION;
END
GO


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE [Type] = 'F' AND [Name] = 'FK_dbo_Zip_StateID_dbo_State_StateID')
BEGIN
ALTER TABLE dbo.Zip
	WITH NOCHECK
	ADD CONSTRAINT FK_dbo_Zip_StateID_dbo_State_StateID FOREIGN KEY (StateID)
	REFERENCES dbo.State (StateID)
	NOT FOR REPLICATION;
END
GO

