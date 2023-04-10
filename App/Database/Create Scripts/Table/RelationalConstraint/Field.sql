
		/******************************************************************************
		**	File: Field(Relation).sql
		**	Name: AlterField
		**	Desc: Creates all the Foreign Key Relationships for the table Field
		**	Auth: Bret Knoll
		**	Date: 12/7/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Field_FieldID_Field_FieldID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Field_FieldID_Field_FieldID'
		ALTER TABLE dbo.Field
			ADD CONSTRAINT FK_Field_FieldID_Field_FieldID FOREIGN KEY(FieldID) REFERENCES dbo.Field(FieldID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Field_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Field_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.Field
			ADD CONSTRAINT FK_Field_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Field_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Field_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.Field
			ADD CONSTRAINT FK_Field_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Field SET (LOCK_ESCALATION = TABLE)
		END
