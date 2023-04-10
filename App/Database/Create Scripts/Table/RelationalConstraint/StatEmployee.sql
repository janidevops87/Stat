
		/******************************************************************************
		**	File: StatEmployee(Relation).sql
		**	Name: AlterStatEmployee
		**	Desc: Creates all the Foreign Key Relationships for the table StatEmployee
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_StatEmployee_PersonID_Person_PersonID')
	BEGIN
		PRINT 'Adding Foreign Key FK_StatEmployee_PersonID_Person_PersonID'
		ALTER TABLE dbo.StatEmployee
			ADD CONSTRAINT FK_StatEmployee_PersonID_Person_PersonID FOREIGN KEY(PersonID) REFERENCES dbo.Person(PersonID)
	END
	GO
	
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_StatEmployee_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_StatEmployee_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.StatEmployee
			ADD CONSTRAINT FK_StatEmployee_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE StatEmployee SET (LOCK_ESCALATION = TABLE)
		END
