  /***************************************************************************************************
**	Name: OrganizationDuplicateSearchRule
**	Desc: Add Foreign keys to OrganizationDuplicateSearchRule
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDuplicateSearchRule_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDuplicateSearchRule_OrganizationId_Organization_OrganizationId'
		ALTER TABLE dbo.OrganizationDuplicateSearchRule ADD CONSTRAINT FK_OrganizationDuplicateSearchRule_OrganizationId_Organization_OrganizationId
			FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_DuplicateSearchRule_DuplicateSearchRuleId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_DuplicateSearchRule_DuplicateSearchRuleId'
		ALTER TABLE dbo.OrganizationDuplicateSearchRule ADD CONSTRAINT FK_OrganizationDuplicateSearchRule_DuplicateSearchRuleId_DuplicateSearchRule_DuplicateSearchRuleId
			FOREIGN KEY(DuplicateSearchRuleId) REFERENCES dbo.DuplicateSearchRule(DuplicateSearchRuleId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDuplicateSearchRule_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDuplicateSearchRule_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.OrganizationDuplicateSearchRule ADD CONSTRAINT FK_OrganizationDuplicateSearchRule_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDuplicateSearchRule_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDuplicateSearchRule_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.OrganizationDuplicateSearchRule ADD CONSTRAINT FK_OrganizationDuplicateSearchRule_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 