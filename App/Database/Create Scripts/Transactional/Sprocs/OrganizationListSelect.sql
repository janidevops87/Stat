IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationListSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationListSelect'
		DROP Procedure OrganizationListSelect
	END
GO

PRINT 'Creating Procedure OrganizationListSelect'
GO
CREATE Procedure OrganizationListSelect
(		
		@SourceCodeID int = null
)
AS
/******************************************************************************
**	File: OrganizationListSelect.sql
**	Name: OrganizationListSelect
**	Desc: Selects multiple rows of Organization Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/21/2009		Bret Knoll			Initial Sproc Creation
**	10/12/2009		ccarroll			added parameter to select organization by @SourceCodeID
**	12/09/2009		Bret				remvode SourcCodeParameter
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**  07/13/2010		ccarroll			added @ListId for default parameter
**  6/2011			jth					added distinct clause
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT distinct
		Organization.OrganizationID AS ListId,
		Organization.OrganizationName AS FieldValue
	FROM 
		dbo.Organization
		LEFT JOIN SourceCodeOrganization On SourceCodeOrganization.OrganizationID = Organization.OrganizationID 

	WHERE
		Organization.Inactive = 0 AND
		SourceCodeOrganization.SourceCodeID = IsNull(@SourceCodeID, SourceCodeOrganization.SourceCodeID)
		
	ORDER BY 2
GO

GRANT EXEC ON OrganizationListSelect TO PUBLIC
GO
