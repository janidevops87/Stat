  /***************************************************************************************************
**	Name: SourceCode
**	Desc: Add Foreign keys to SourceCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll	Initial Key Creation
**	11/05/2009	ccarroll	added FK for CallType and Organization (FullName) 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCode_SourceCodeCallTypeID_CallType_CallTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCode_SourceCodeCallTypeID_CallType_CallTypeId'
		ALTER TABLE dbo.SourceCode ADD CONSTRAINT FK_SourceCode_SourceCodeCallTypeID_CallType_CallTypeId
			FOREIGN KEY(SourceCodeCallTypeID) REFERENCES dbo.CallType(CallTypeId) 
	END
	
/*
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_SourceCode_SourceCodeOrgID_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_SourceCode_SourceCodeOrgID_Organization_OrganizationId'
		ALTER TABLE dbo.SourceCode ADD CONSTRAINT FK_SourceCode_SourceCodeOrgID_Organization_OrganizationId
			FOREIGN KEY(SourceCodeOrgID) REFERENCES dbo.Organization(OrganizationId) 
	END
*/	
GO

