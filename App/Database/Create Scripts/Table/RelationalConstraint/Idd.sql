   /***************************************************************************************************
**	Name: Idd
**	Desc: Add Foreign keys to Idd
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Idd_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Idd_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.Idd ADD CONSTRAINT FK_Idd_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Idd_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Idd_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.Idd ADD CONSTRAINT FK_Idd_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Idd_CountryId_Country_CountryId')
	BEGIN
		PRINT 'Adding Foreign Key FK_Idd_CountryId_Country_CountryId'
		ALTER TABLE dbo.Idd ADD CONSTRAINT FK_Idd_CountryId_Country_CountryId
			FOREIGN KEY(CountryId) REFERENCES dbo.Country(CountryId) 
	END
GO



 