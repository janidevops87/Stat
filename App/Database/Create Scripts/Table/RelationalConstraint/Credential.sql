
		/******************************************************************************
		**	File: Credential(Relation).sql
		**	Name: AlterCredential
		**	Desc: Creates all the Foreign Key Relationships for the table Credential
		**	Auth: Bret Knoll
		**	Date: 9/14/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Credential_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Credential_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.Credential
			ADD CONSTRAINT FK_Credential_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Credential_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Credential_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.Credential
			ADD CONSTRAINT FK_Credential_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Credential SET (LOCK_ESCALATION = TABLE)
		END
