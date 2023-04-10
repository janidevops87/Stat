
		/******************************************************************************
		**	File: SecurityRule(Relation).sql
		**	Name: AlterSecurityRule
		**	Desc: Creates all the Foreign Key Relationships for the table SecurityRule
		**	Auth: Bret Knoll
		**	Date: 9/4/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SecurityRule_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SecurityRule_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.SecurityRule
			ADD CONSTRAINT FK_SecurityRule_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SecurityRule_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SecurityRule_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.SecurityRule
			ADD CONSTRAINT FK_SecurityRule_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SecurityRule SET (LOCK_ESCALATION = TABLE)
		END
