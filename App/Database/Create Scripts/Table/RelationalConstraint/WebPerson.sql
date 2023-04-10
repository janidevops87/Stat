
		/******************************************************************************
		**	File: WebPerson(Relation).sql
		**	Name: AlterWebPerson
		**	Desc: Creates all the Foreign Key Relationships for the table WebPerson
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebPerson_PersonID_Person_PersonID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebPerson_PersonID_Person_PersonID'
		ALTER TABLE dbo.WebPerson
			ADD CONSTRAINT FK_WebPerson_PersonID_Person_PersonID FOREIGN KEY(PersonID) REFERENCES dbo.Person(PersonID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebPerson_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebPerson_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.WebPerson
			ADD CONSTRAINT FK_WebPerson_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebPerson_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebPerson_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.WebPerson
			ADD CONSTRAINT FK_WebPerson_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebPerson SET (LOCK_ESCALATION = TABLE)
		END
