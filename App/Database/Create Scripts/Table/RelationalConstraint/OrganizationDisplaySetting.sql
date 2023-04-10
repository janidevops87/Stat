  /***************************************************************************************************
**	Name: OrganizationDisplaySettingDisplaySetting
**	Desc: Add Foreign keys to OrganizationDisplaySetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDisplaySetting_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDisplaySetting_OrganizationId_Organization_OrganizationId'
		ALTER TABLE dbo.OrganizationDisplaySetting ADD CONSTRAINT FK_OrganizationDisplaySetting_OrganizationId_Organization_OrganizationId
			FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDisplaySetting_DashBoardDisplaySettingId_DashBoardDisplaySetting_DashBoardDisplaySettingId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDisplaySetting_DashBoardDisplaySettingId_DashBoardDisplaySetting_DashBoardDisplaySettingId'
		ALTER TABLE dbo.OrganizationDisplaySetting ADD CONSTRAINT FK_OrganizationDisplaySetting_DashBoardDisplaySettingId_DashBoardDisplaySetting_DashBoardDisplaySettingId
			FOREIGN KEY(DashBoardDisplaySettingId) REFERENCES dbo.DashBoardDisplaySetting(DashBoardDisplaySettingId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDisplaySetting_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDisplaySetting_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.OrganizationDisplaySetting ADD CONSTRAINT FK_OrganizationDisplaySetting_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDisplaySetting_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDisplaySetting_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.OrganizationDisplaySetting ADD CONSTRAINT FK_OrganizationDisplaySetting_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 