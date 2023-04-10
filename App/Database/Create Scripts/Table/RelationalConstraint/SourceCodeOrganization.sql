   /***************************************************************************************************
**	Name: SourceCodeOrganization
**	Desc: Add Foreign keys to SourceCodeOrganization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeOrganization_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCodeOrganization_OrganizationId_Organization_OrganizationId'
			
		ALTER TABLE dbo.Organization SET (LOCK_ESCALATION = TABLE)
		
		ALTER TABLE dbo.SourceCodeOrganization ADD CONSTRAINT FK_SourceCodeOrganization_OrganizationId_Organization_OrganizationId 
			FOREIGN KEY (OrganizationID) REFERENCES dbo.Organization(OrganizationID) 
	
	
		ALTER TABLE dbo.SourceCodeOrganization SET (LOCK_ESCALATION = TABLE)			
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCodeOrganization_SourceCodeId_SourceCode_SourceCodeId')
	BEGIN
		
		PRINT 'Adding Foreign Key FK_SourceCodeOrganization_SourceCodeId_SourceCode_SourceCodeId'		
		ALTER TABLE dbo.SourceCodeOrganization ADD CONSTRAINT FK_SourceCodeOrganization_SourceCodeId_SourceCode_SourceCodeId
			FOREIGN KEY(SourceCodeId) REFERENCES dbo.SourceCode(SourceCodeId) 
	END
GO


