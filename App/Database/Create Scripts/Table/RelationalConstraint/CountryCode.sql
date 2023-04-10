   /***************************************************************************************************
**	Name: CountryCode
**	Desc: Add Foreign keys to CountryCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_CountryCode_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_CountryCode_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.CountryCode ADD CONSTRAINT FK_CountryCode_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_CountryCode_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_CountryCode_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.CountryCode ADD CONSTRAINT FK_CountryCode_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_CountryCode_CountryId_Country_CountryId')
	BEGIN
		PRINT 'Adding Foreign Key FK_CountryCode_CountryId_Country_CountryId'
		ALTER TABLE dbo.CountryCode ADD CONSTRAINT FK_CountryCode_CountryId_Country_CountryId
			FOREIGN KEY(CountryId) REFERENCES dbo.Country(CountryId) 
	END
GO



 