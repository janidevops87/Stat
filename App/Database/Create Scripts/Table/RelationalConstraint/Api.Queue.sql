/******************************************************************************
		**	File: Api.Queue.sql
		**	Name: Api.Queue
		**	Desc: Foreign Key(s) of table Api.Queue
		**	Auth: iosipov
		**	Date: 08/14/2017
		*******************************************************************************/
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Queue_DocumentTypeID_DocumentType_DocumentTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_Queue_DocumentTypeID_DocumentType_DocumentTypeID'
		ALTER TABLE Api.Queue ADD CONSTRAINT FK_Queue_DocumentTypeID_DocumentType_DocumentTypeID
			FOREIGN KEY(DocumentTypeId) REFERENCES Api.DocumentType(DocumentTypeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Queue_WebReportGroupID_WebReportGroup_WebReportGroupID')
BEGIN
	PRINT 'Adding Foreign Key FK_Queue_WebReportGroupID_WebReportGroup_WebReportGroupID'
	ALTER TABLE Api.Queue
		ADD CONSTRAINT FK_Queue_WebReportGroupID_WebReportGroup_WebReportGroupID FOREIGN KEY(WebReportGroupId) REFERENCES dbo.WebReportGroup(WebReportGroupId)
END
GO
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_Queue_OrganizationId_Organization_OrganizationId')
BEGIN
	PRINT 'Adding Foreign Key FK_Queue_OrganizationId_Organization_OrganizationId'
	ALTER TABLE Api.[Queue]
		ADD CONSTRAINT FK_Queue_OrganizationId_Organization_OrganizationId FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId)
END
GO