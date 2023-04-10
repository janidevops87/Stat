IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationRegistryListSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationRegistryListSelect'
		DROP Procedure OrganizationRegistryListSelect
	END
GO

PRINT 'Creating Procedure OrganizationRegistryListSelect'
GO
CREATE Procedure OrganizationRegistryListSelect
(		
		@ServiceLevelID int = null
)
AS
/******************************************************************************
**	File: OrganizationRegistryListSelect.sql
**	Name: OrganizationRegistryListSelect
**	Desc: Selects multiple rows of Organization Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/31			jth					Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT distinct
		Organization.OrganizationID AS ListId,
		Organization.OrganizationName AS FieldValue
	FROM ServiceLevel30Organization, Organization

	WHERE 
	ServiceLevel30Organization.OrganizationID = Organization.OrganizationID
	AND ServiceLevel30Organization.ServiceLevelID = @ServiceLevelID
	AND	Organization.Inactive = 0 --AND
	--	SourceCodeOrganization.SourceCodeID = IsNull(@SourceCodeID, SourceCodeOrganization.SourceCodeID)
	and OrganizationName is not null
		
	ORDER BY 2
 