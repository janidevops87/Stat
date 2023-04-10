  /***************************************************************************************************
**	Name: OrganizationAspSetting
**	Desc: Add Foreign keys to OrganizationAspSetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationAspSetting_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationAspSetting_OrganizationId_Organization_OrganizationId'
		ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT FK_OrganizationAspSetting_OrganizationId_Organization_OrganizationId
			FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationAspSetting_AspSettingTypeId_AspSettingType_AspSettingTypeId')
	BEGIN		
		PRINT 'Adding Foreign Key FK_OrganizationAspSetting_AspSettingTypeId_AspSettingType_AspSettingTypeId'
		ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT FK_OrganizationAspSetting_AspSettingTypeId_AspSettingType_AspSettingTypeId
			FOREIGN KEY(AspSettingTypeId) REFERENCES dbo.AspSettingType(AspSettingTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationAspSetting_AutoDisplaySourceCodeId_SourceCode_SourceCodeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationAspSetting_AutoDisplaySourceCodeId_SourceCode_SourceCodeId'
		ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT FK_OrganizationAspSetting_AutoDisplaySourceCodeId_SourceCode_SourceCodeId
			FOREIGN KEY(AutoDisplaySourceCodeId) REFERENCES dbo.SourceCode(SourceCodeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationAspSetting_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationAspSetting_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT FK_OrganizationAspSetting_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationAspSetting_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationAspSetting_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT FK_OrganizationAspSetting_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 