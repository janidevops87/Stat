
		/******************************************************************************
		**	File: Gender(Relation).sql
		**	Name: AlterGender
		**	Desc: Creates all the Foreign Key Relationships for the table Gender
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Gender_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Gender_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.Gender
			ADD CONSTRAINT FK_Gender_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Gender_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Gender_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.Gender
			ADD CONSTRAINT FK_Gender_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Gender SET (LOCK_ESCALATION = TABLE)
		END
