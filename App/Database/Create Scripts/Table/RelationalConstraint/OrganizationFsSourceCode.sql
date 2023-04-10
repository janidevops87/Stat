  /***************************************************************************************************
**	Name: OrganizationFsSourceCode
**	Desc: Add Foreign keys to OrganizationFsSourceCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationFsSourceCode_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationFsSourceCode_OrganizationId_Organization_OrganizationId'
		ALTER TABLE dbo.OrganizationFsSourceCode ADD CONSTRAINT FK_OrganizationFsSourceCode_OrganizationId_Organization_OrganizationId
			FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationFsSourceCode_SourceCodeId_SourceCode_SourceCodeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationFsSourceCode_SourceCodeId_SourceCode_SourceCodeId'
		ALTER TABLE dbo.OrganizationFsSourceCode ADD CONSTRAINT FK_OrganizationFsSourceCode_SourceCodeId_SourceCode_SourceCodeId
			FOREIGN KEY(SourceCodeId) REFERENCES dbo.SourceCode(SourceCodeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationFsSourceCode_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationFsSourceCode_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.OrganizationFsSourceCode ADD CONSTRAINT FK_OrganizationFsSourceCode_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationFsSourceCode_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationFsSourceCode_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.OrganizationFsSourceCode ADD CONSTRAINT FK_OrganizationFsSourceCode_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 