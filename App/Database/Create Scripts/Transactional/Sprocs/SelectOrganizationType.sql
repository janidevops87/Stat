

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectOrganizationType')
	BEGIN
		PRINT 'Dropping Procedure SelectOrganizationType'
		PRINT GETDATE()
		DROP Procedure SelectOrganizationType
	END
GO

PRINT 'Creating Procedure SelectOrganizationType'
PRINT GETDATE()
GO
CREATE Procedure SelectOrganizationType
(
		@OrganizationTypeID int = null output					
)
AS
/******************************************************************************
**	File: SelectOrganizationType.sql
**	Name: SelectOrganizationType
**	Desc: Selects multiple rows of OrganizationType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		OrganizationType.OrganizationTypeID,
		OrganizationType.OrganizationTypeName,
		OrganizationType.Verified,
		OrganizationType.Inactive,
		OrganizationType.LastModified,
		OrganizationType.UpdatedFlag
	FROM 
		dbo.OrganizationType 

	WHERE 
		OrganizationType.OrganizationTypeID = ISNULL(@OrganizationTypeID, OrganizationType.OrganizationTypeID)				

GO

GRANT EXEC ON SelectOrganizationType TO PUBLIC
GO
