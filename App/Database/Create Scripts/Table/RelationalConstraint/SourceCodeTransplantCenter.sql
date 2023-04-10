

		/******************************************************************************
		**	File: SourceCodeTransplantCenter(Relation).sql
		**	Name: AlterSourceCodeTransplantCenter
		**	Desc: Creates all the Foreign Key Relationships for the table SourceCodeTransplantCenter
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeTransplantCenter_SourceCodeID_SourceCode_SourceCodeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeTransplantCenter_SourceCodeID_SourceCode_SourceCodeID'
		ALTER TABLE dbo.SourceCodeTransplantCenter
			ADD CONSTRAINT FK_SourceCodeTransplantCenter_SourceCodeID_SourceCode_SourceCodeID FOREIGN KEY(SourceCodeID) REFERENCES dbo.SourceCode(SourceCodeID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeTransplantCenter_OrganizationID_Organization_OrganizationID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeTransplantCenter_OrganizationID_Organization_OrganizationID'
		ALTER TABLE dbo.SourceCodeTransplantCenter
			ADD CONSTRAINT FK_SourceCodeTransplantCenter_OrganizationID_Organization_OrganizationID FOREIGN KEY(OrganizationID) REFERENCES dbo.Organization(OrganizationID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeTransplantCenter_MessageOrganizationID_Organization_OrganizationID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeTransplantCenter_MessageOrganizationID_Organization_OrganizationID'
		ALTER TABLE dbo.SourceCodeTransplantCenter
			ADD CONSTRAINT FK_SourceCodeTransplantCenter_MessageOrganizationID_Organization_OrganizationID FOREIGN KEY(MessageOrganizationID) REFERENCES dbo.Organization(OrganizationID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeTransplantCenter_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeTransplantCenter_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.SourceCodeTransplantCenter
			ADD CONSTRAINT FK_SourceCodeTransplantCenter_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeTransplantCenter_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeTransplantCenter_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.SourceCodeTransplantCenter
			ADD CONSTRAINT FK_SourceCodeTransplantCenter_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END

		
	IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
	BEGIN
		ALTER TABLE SourceCodeTransplantCenter SET (LOCK_ESCALATION = TABLE)
	END
