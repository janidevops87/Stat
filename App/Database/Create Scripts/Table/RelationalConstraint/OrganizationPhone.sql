
		/******************************************************************************
		**	File: OrganizationPhoneRelation.sql
		**	Name: AlterOrganizationPhone
		**	Desc: Creates all the Foreign Key Relationships for the table OrganizationPhone
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationPhone_OrganizationID_Organization_OrganizationID')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationPhone_OrganizationID_Organization_OrganizationID'
		ALTER TABLE dbo.OrganizationPhone
			ADD CONSTRAINT FK_OrganizationPhone_OrganizationID_Organization_OrganizationID FOREIGN KEY(OrganizationID) REFERENCES dbo.Organization(OrganizationID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationPhone_PhoneID_Phone_PhoneID')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationPhone_PhoneID_Phone_PhoneID'
		ALTER TABLE dbo.OrganizationPhone
			ADD CONSTRAINT FK_OrganizationPhone_PhoneID_Phone_PhoneID FOREIGN KEY(PhoneID) REFERENCES dbo.Phone(PhoneID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationPhone_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationPhone_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.OrganizationPhone
			ADD CONSTRAINT FK_OrganizationPhone_LastStatEmployeeId_StatEmployee_StatEmployeeId FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationPhone_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationPhone_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.OrganizationPhone
			ADD CONSTRAINT FK_OrganizationPhone_AuditLogTypeId_AuditLogType_AuditLogTypeId FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId)
	END
	GO
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationPhone_SubLocationLevelId_SubLocationLevel_SubLocationLevelId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationPhone_SubLocationLevelId_SubLocationLevel_SubLocationLevelId'
		ALTER TABLE dbo.OrganizationPhone
			ADD CONSTRAINT FK_OrganizationPhone_SubLocationLevelId_SubLocationLevel_SubLocationLevelId FOREIGN KEY(SubLocationLevelId) REFERENCES dbo.SubLocationLevel(SubLocationLevelId)
	END
	GO
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationPhone_SubLocationId_SubLocation_SubLocationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationPhone_SubLocationId_SubLocation_SubLocationId'
		ALTER TABLE dbo.OrganizationPhone
			ADD CONSTRAINT FK_OrganizationPhone_SubLocationId_SubLocation_SubLocationId FOREIGN KEY(SubLocationId) REFERENCES dbo.SubLocation(SubLocationId)
	END
	GO

				
		if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationPhone SET (LOCK_ESCALATION = TABLE) END			
			