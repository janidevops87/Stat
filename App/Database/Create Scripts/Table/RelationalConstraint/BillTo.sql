     /***************************************************************************************************
**	Name: BillTo
**	Desc: Add Foreign keys to BillTo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_BillTo_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_BillTo_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.BillTo ADD CONSTRAINT FK_BillTo_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_BillTo_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_BillTo_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.BillTo ADD CONSTRAINT FK_BillTo_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_BillTo_StateId_State_StateId')
	BEGIN
		PRINT 'Adding Foreign Key FK_BillTo_StateId_State_StateId'
		ALTER TABLE dbo.BillTo ADD CONSTRAINT FK_BillTo_StateId_State_StateId
			FOREIGN KEY(StateId) REFERENCES dbo.State(StateId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_BillTo_CountryId_Country_CountryId')
	BEGIN
		PRINT 'Adding Foreign Key FK_BillTo_CountryId_Country_CountryId'
		ALTER TABLE dbo.BillTo ADD CONSTRAINT FK_BillTo_CountryId_Country_CountryId
			FOREIGN KEY(CountryId) REFERENCES dbo.Country(CountryId) 
	END
GO 
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_BillTo_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_BillTo_OrganizationId_Organization_OrganizationId'
		ALTER TABLE dbo.BillTo ADD CONSTRAINT FK_BillTo_OrganizationId_Organization_OrganizationId
			FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO 