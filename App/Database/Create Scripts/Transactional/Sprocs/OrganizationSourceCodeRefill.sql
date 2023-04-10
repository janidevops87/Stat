

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationSourceCodeReFill')
	BEGIN
		PRINT 'Dropping Procedure OrganizationSourceCodeReFill'
		DROP Procedure OrganizationSourceCodeReFill
	END
GO

PRINT 'Creating Procedure OrganizationSourceCodeReFill'
GO
CREATE Procedure OrganizationSourceCodeReFill
(
		@OrganizationSourceCodeID int = null,
		@OrganizationID int = null					
)
AS
/******************************************************************************
**	File: OrganizationSourceCodeReFill.sql
**	Name: OrganizationSourceCodeReFill
**	Desc: Selects multiple rows of OrganizationSourceCode Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 11/12/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/12/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	TRUNCATE TABLE [OrganizationSourceCode]

	INSERT INTO [OrganizationSourceCode]
           ([OrganizationID]
           ,[SourceCodeList]
           ,[LastModified]
           ,[LastStatEmployeeID]
           ,[AuditLogTypeID])

	SELECT 
		Organization.OrganizationID,
		dbo.fn_SourceCodeListByOrganizationID(Organization.OrganizationID) AS AssociatedSourceCodes,
		GETDATE(),
		45, --Bret
		1 -- insert
	FROM 
		Organization
	JOIN (SELECT DISTINCT OrganizationID FROM  SourceCodeOrganization) SourceCodeOrganization  ON Organization.OrganizationID = SourceCodeOrganization.OrganizationID


GRANT EXEC ON OrganizationSourceCodeReFill TO PUBLIC
GO
