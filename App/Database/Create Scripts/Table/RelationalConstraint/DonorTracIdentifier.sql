
		/******************************************************************************
		**	File: DonorTracIdentifier(Relation).sql
		**	Name: AlterDonorTracIdentifier
		**	Desc: Creates all the Foreign Key Relationships for the table DonorTracIdentifier
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************
		**  07/11/2011	ccarroll	removed invalid FK
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DonorTracIdentifier_SourceCodeID_SourceCode_SourceCodeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_DonorTracIdentifier_SourceCodeID_SourceCode_SourceCodeID'
		ALTER TABLE dbo.DonorTracIdentifier
			ADD CONSTRAINT FK_DonorTracIdentifier_SourceCodeID_SourceCode_SourceCodeID FOREIGN KEY(SourceCodeID) REFERENCES dbo.SourceCode(SourceCodeID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DonorTracIdentifier_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_DonorTracIdentifier_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.DonorTracIdentifier
			ADD CONSTRAINT FK_DonorTracIdentifier_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DonorTracIdentifier_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_DonorTracIdentifier_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.DonorTracIdentifier
			ADD CONSTRAINT FK_DonorTracIdentifier_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END

		
	IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
	BEGIN
		ALTER TABLE DonorTracIdentifier SET (LOCK_ESCALATION = TABLE)
	END
