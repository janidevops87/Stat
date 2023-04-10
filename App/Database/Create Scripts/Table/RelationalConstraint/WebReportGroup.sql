
		/******************************************************************************
		**	File: WebReportGroup.sql
		**	Name: AlterWebReportGroup
		**	Desc: Creates all the Foreign Key Relationships for the table WebReportGroup
		**	Auth: Bret Knoll
		**	Date: 7/22/2009
		****************************************************************************************************
		**	Change History
		****************************************************************************************************
		**	Date			Author			Description
		**	----------	------------	--------------------------------------------------------------------
		**	7/13/2010	Bret Knoll		Resaving to readd Person Relation
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroup_OrgHierarchyParentID_Organization_OrganizationID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroup_OrgHierarchyParentID_Organization_OrganizationID'
		ALTER TABLE dbo.WebReportGroup
			ADD CONSTRAINT FK_WebReportGroup_OrgHierarchyParentID_Organization_OrganizationID FOREIGN KEY(OrgHierarchyParentID) REFERENCES dbo.Organization(OrganizationID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroup_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroup_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.WebReportGroup
			ADD CONSTRAINT FK_WebReportGroup_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_WebReportGroup_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_WebReportGroup_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.WebReportGroup
			ADD CONSTRAINT FK_WebReportGroup_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE WebReportGroup SET (LOCK_ESCALATION = TABLE)
		END
