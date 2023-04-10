
		/******************************************************************************
		**	File: OrganizationSourceCode(Relation).sql
		**	Name: AlterOrganizationSourceCode
		**	Desc: Creates all the Foreign Key Relationships for the table OrganizationSourceCode
		**	Auth: Bret Knoll
		**	Date: 11/12/2010
		*******************************************************************************/

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationSourceCode_OrganizationID_Organization_OrganizationID')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationSourceCode_OrganizationID_Organization_OrganizationID'
		ALTER TABLE dbo.OrganizationSourceCode
			ADD CONSTRAINT FK_OrganizationSourceCode_OrganizationID_Organization_OrganizationID FOREIGN KEY(OrganizationID) REFERENCES dbo.Organization(OrganizationID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationSourceCode_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationSourceCode_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.OrganizationSourceCode
			ADD CONSTRAINT FK_OrganizationSourceCode_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationSourceCode_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationSourceCode_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.OrganizationSourceCode
			ADD CONSTRAINT FK_OrganizationSourceCode_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE OrganizationSourceCode SET (LOCK_ESCALATION = TABLE)
		END
