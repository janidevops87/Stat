 
		/******************************************************************************
		**	File: SourceCodeASP(Relation).sql
		**	Name: AlterSourceCodeASP
		**	Desc: Creates all the Foreign Key Relationships for the table SourceCodeASP
		**	Auth: ccarroll
		**	Date: 7/26/2010
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeASP_SourceCodeASPId_SourceCodeASP_SourceCodeASPId')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeASP_SourceCodeASPId_SourceCodeASP_SourceCodeASPId'
		ALTER TABLE dbo.SourceCodeASP
			ADD CONSTRAINT FK_SourceCodeASP_SourceCodeASPId_SourceCodeASP_SourceCodeASPId FOREIGN KEY(SourceCodeASPId) REFERENCES dbo.SourceCodeASP(SourceCodeASPId)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeASP_SourceCodeId_SourceCode_SourceCodeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeASP_SourceCodeId_SourceCode_SourceCodeId'
		ALTER TABLE dbo.SourceCodeASP
			ADD CONSTRAINT FK_SourceCodeASP_SourceCodeId_SourceCode_SourceCodeId FOREIGN KEY(SourceCodeId) REFERENCES dbo.SourceCode(SourceCodeId)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeASP_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeASP_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.SourceCodeASP
			ADD CONSTRAINT FK_SourceCodeASP_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeASP_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeASP_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.SourceCodeASP
			ADD CONSTRAINT FK_SourceCodeASP_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCodeASP SET (LOCK_ESCALATION = TABLE)
		END
