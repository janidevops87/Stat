IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationAliasSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationAliasSelect'
		DROP Procedure OrganizationAliasSelect
	END
GO

PRINT 'Creating Procedure OrganizationAliasSelect'
GO
CREATE Procedure OrganizationAliasSelect
(
		@OrganizationAliasId int = null,
		@OrganizationId int = null					
)
AS
/******************************************************************************
**	File: OrganizationAliasSelect.sql
**	Name: OrganizationAliasSelect
**	Desc: Selects multiple rows of OrganizationAlias Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		OrganizationAlias.OrganizationAliasId,
		OrganizationAlias.OrganizationId,
		OrganizationAlias.OrganizationAliasName,
		OrganizationAlias.LastModified,
		OrganizationAlias.LastStatEmployeeId,
		OrganizationAlias.AuditLogTypeId
	FROM 
		dbo.OrganizationAlias 
	WHERE 
		OrganizationAlias.OrganizationAliasId = ISNULL(@OrganizationAliasId, OrganizationAliasId)
	AND
		OrganizationAlias.OrganizationId = ISNULL(@OrganizationId, OrganizationAlias.OrganizationId)				
	ORDER BY OrganizationAlias.OrganizationAliasName
GO

GRANT EXEC ON OrganizationAliasSelect TO PUBLIC
GO
