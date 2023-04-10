
		/******************************************************************************
		**	File: Person(Relation).sql
		**	Name: AlterPerson
		**	Desc: Creates all the Foreign Key Relationships for the table Person
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_PersonTypeID_PersonType_PersonTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_PersonTypeID_PersonType_PersonTypeID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_PersonTypeID_PersonType_PersonTypeID FOREIGN KEY(PersonTypeID) REFERENCES dbo.PersonType(PersonTypeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_OrganizationID_Organization_OrganizationID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_OrganizationID_Organization_OrganizationID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_OrganizationID_Organization_OrganizationID FOREIGN KEY(OrganizationID) REFERENCES dbo.Organization(OrganizationID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_GenderID_Gender_GenderID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_GenderID_Gender_GenderID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_GenderID_Gender_GenderID FOREIGN KEY(GenderID) REFERENCES dbo.Gender(GenderID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_RaceID_Race_RaceID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_RaceID_Race_RaceID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_RaceID_Race_RaceID FOREIGN KEY(RaceID) REFERENCES dbo.Race(RaceID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Person_TrainedRequestorID_TrainedRequestor_TrainedRequestorID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Person_TrainedRequestorID_TrainedRequestor_TrainedRequestorID'
		ALTER TABLE dbo.Person
			ADD CONSTRAINT FK_Person_TrainedRequestorID_TrainedRequestor_TrainedRequestorID FOREIGN KEY(TrainedRequestorID) REFERENCES dbo.TrainedRequestor(TrainedRequestorID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Person SET (LOCK_ESCALATION = TABLE)
		END
