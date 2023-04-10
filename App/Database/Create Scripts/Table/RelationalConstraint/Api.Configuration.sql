/******************************************************************************
		**	File: Api.Configuration.sql
		**	Name: Api.Configuration
		**	Desc: Foreign Key(s) of table Api.Configuration
		**	Auth: iosipov
		**	Date: 08/14/2017
		*******************************************************************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Configuration_DocumentTypeID_DocumentType_DocumentTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Configuration_DocumentTypeID_DocumentType_DocumentTypeID'
		ALTER TABLE Api.Configuration ADD CONSTRAINT FK_Configuration_DocumentTypeID_DocumentType_DocumentTypeID
			FOREIGN KEY(DocumentTypeId) REFERENCES Api.DocumentType(DocumentTypeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Configuration_WebReportGroupID_WebReportGroup_WebReportGroupID')
BEGIN
	PRINT 'Adding Foreign Key FK_Configuration_WebReportGroupID_WebReportGroup_WebReportGroupID'
	ALTER TABLE Api.Configuration
		ADD CONSTRAINT FK_Configuration_WebReportGroupID_WebReportGroup_WebReportGroupID FOREIGN KEY(WebReportGroupId) REFERENCES dbo.WebReportGroup(WebReportGroupId)
END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Configuration_OrganizationId_Organization_OrganizationId')
BEGIN
	PRINT 'Adding Foreign Key FK_Configuration_OrganizationId_Organization_OrganizationId'
	ALTER TABLE Api.Configuration
		ADD CONSTRAINT FK_Configuration_OrganizationId_Organization_OrganizationId FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId)
END
GO