
		/******************************************************************************
		**	File: PersonPhone(Relation).sql
		**	Name: AlterPersonPhone
		**	Desc: Creates all the Foreign Key Relationships for the table PersonPhone
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_PersonPhone_PersonID_Person_PersonID')
	BEGIN
		PRINT 'Adding Foreign Key FK_PersonPhone_PersonID_Person_PersonID'
		ALTER TABLE dbo.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_PersonID_Person_PersonID FOREIGN KEY(PersonID) REFERENCES dbo.Person(PersonID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_PersonPhone_PhoneID_Phone_PhoneID')
	BEGIN
		PRINT 'Adding Foreign Key FK_PersonPhone_PhoneID_Phone_PhoneID'
		ALTER TABLE dbo.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_PhoneID_Phone_PhoneID FOREIGN KEY(PhoneID) REFERENCES dbo.Phone(PhoneID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_PersonPhone_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_PersonPhone_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_PersonPhone_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_PersonPhone_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_PersonPhone_PagerTypeID_PagerType_PagerTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_PersonPhone_PagerTypeID_PagerType_PagerTypeID'
		ALTER TABLE dbo.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_PagerTypeID_PagerType_PagerTypeID FOREIGN KEY(PagerTypeID) REFERENCES dbo.PagerType(PagerTypeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_PersonPhone_EmailTypeID_EmailType_EmailTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_PersonPhone_EmailTypeID_EmailType_EmailTypeID'
		ALTER TABLE dbo.PersonPhone
			ADD CONSTRAINT FK_PersonPhone_EmailTypeID_EmailType_EmailTypeID FOREIGN KEY(EmailTypeID) REFERENCES dbo.EmailType(EmailTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE PersonPhone SET (LOCK_ESCALATION = TABLE)
		END
