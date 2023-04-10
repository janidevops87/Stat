
		/******************************************************************************
		**	File: ContactCallInstruction(Relation).sql
		**	Name: AlterContactCallInstruction
		**	Desc: Creates all the Foreign Key Relationships for the table ContactCallInstruction
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:		Author:			Description:
		**	--------	--------		----------------------------------
		**  07/14/10	Bret Knoll		Adding to release 
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ContactCallInstruction_PersonPhoneID_PersonPhone_PersonPhoneID')
	BEGIN
		PRINT 'Adding Foreign Key FK_ContactCallInstruction_PersonPhoneID_PersonPhone_PersonPhoneID'
		ALTER TABLE dbo.ContactCallInstruction
			ADD CONSTRAINT FK_ContactCallInstruction_PersonPhoneID_PersonPhone_PersonPhoneID FOREIGN KEY(PersonPhoneID) REFERENCES dbo.PersonPhone(PersonPhoneID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ContactCallInstruction_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_ContactCallInstruction_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.ContactCallInstruction
			ADD CONSTRAINT FK_ContactCallInstruction_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ContactCallInstruction_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_ContactCallInstruction_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.ContactCallInstruction
			ADD CONSTRAINT FK_ContactCallInstruction_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE ContactCallInstruction SET (LOCK_ESCALATION = TABLE)
		END
