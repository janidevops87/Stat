
		/******************************************************************************
		**	File: DonorTracURL(Relation).sql
		**	Name: AlterDonorTracURL
		**	Desc: Creates all the Foreign Key Relationships for the table DonorTracURL
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DonorTracURL_SourceCodeID_SourceCode_SourceCodeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_DonorTracURL_SourceCodeID_SourceCode_SourceCodeID'
		ALTER TABLE dbo.DonorTracURL
			ADD CONSTRAINT FK_DonorTracURL_SourceCodeID_SourceCode_SourceCodeID FOREIGN KEY(SourceCodeID) REFERENCES dbo.SourceCode(SourceCodeID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DonorTracURL_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_DonorTracURL_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.DonorTracURL
			ADD CONSTRAINT FK_DonorTracURL_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DonorTracURL_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_DonorTracURL_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.DonorTracURL
			ADD CONSTRAINT FK_DonorTracURL_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END

		
	IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
	BEGIN
		ALTER TABLE DonorTracURL SET (LOCK_ESCALATION = TABLE)
	END
