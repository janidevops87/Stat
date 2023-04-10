  /***************************************************************************************************
**	Name: Organization
**	Desc: Add Foreign keys to Organization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Organization_OrganizationTypeId_OrganizationType_OrganizationTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Organization_OrganizationTypeId_OrganizationType_OrganizationTypeId'
		ALTER TABLE dbo.Organization ADD CONSTRAINT FK_Organization_OrganizationTypeId_OrganizationType_OrganizationTypeId
			FOREIGN KEY(OrganizationTypeId) REFERENCES dbo.OrganizationType(OrganizationTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Organization_StateId_State_StateId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Organization_StateId_State_StateId'
		ALTER TABLE dbo.Organization ADD CONSTRAINT FK_Organization_StateId_State_StateId
			FOREIGN KEY(StateId) REFERENCES dbo.State(StateId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Organization_CountyId_County_CountyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Organization_CountyId_County_CountyId'
		ALTER TABLE dbo.Organization ADD CONSTRAINT FK_Organization_CountyId_County_CountyId
			FOREIGN KEY(CountyId) REFERENCES dbo.County(CountyId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Organization_PhoneId_Phone_PhoneId')
	BEGIN		
		PRINT 'Adding Foreign Key FK_Organization_PhoneId_Phone_PhoneId'
		ALTER TABLE dbo.Organization ADD CONSTRAINT FK_Organization_PhoneId_Phone_PhoneId
			FOREIGN KEY(PhoneId) REFERENCES dbo.Phone(PhoneId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Organization_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Organization_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.Organization ADD CONSTRAINT FK_Organization_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Organization_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Organization_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.Organization ADD CONSTRAINT FK_Organization_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 