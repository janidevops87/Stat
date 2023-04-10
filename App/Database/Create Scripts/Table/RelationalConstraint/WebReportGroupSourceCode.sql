
		/******************************************************************************
		**	File: WebReportGroupSourceCode.sql
		**	Name: AlterWebReportGroupSourceCode
		**	Desc: Creates all the Foreign Key Relationships for the table WebReportGroupSourceCode
		**	Auth: Bret Knoll
		**	Date: 7/22/2009
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroupSourceCode_WebReportGroupID_WebReportGroup_WebReportGroupID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroupSourceCode_WebReportGroupID_WebReportGroup_WebReportGroupID'
		ALTER TABLE dbo.WebReportGroupSourceCode
			ADD CONSTRAINT FK_WebReportGroupSourceCode_WebReportGroupID_WebReportGroup_WebReportGroupID FOREIGN KEY(WebReportGroupID) REFERENCES dbo.WebReportGroup(WebReportGroupID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroupSourceCode_SourceCodeID_SourceCode_SourceCodeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroupSourceCode_SourceCodeID_SourceCode_SourceCodeID'
		ALTER TABLE dbo.WebReportGroupSourceCode
			ADD CONSTRAINT FK_WebReportGroupSourceCode_SourceCodeID_SourceCode_SourceCodeID FOREIGN KEY(SourceCodeID) REFERENCES dbo.SourceCode(SourceCodeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroupSourceCode_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroupSourceCode_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.WebReportGroupSourceCode
			ADD CONSTRAINT FK_WebReportGroupSourceCode_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroupSourceCode_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroupSourceCode_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.WebReportGroupSourceCode
			ADD CONSTRAINT FK_WebReportGroupSourceCode_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebReportGroupSourceCode SET (LOCK_ESCALATION = TABLE)
		END
