

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectRotationOrganization')
	BEGIN
		PRINT 'Dropping Procedure SelectRotationOrganization'
		PRINT GETDATE()
		DROP Procedure SelectRotationOrganization
	END
GO

PRINT 'Creating Procedure SelectRotationOrganization'
PRINT GETDATE()
GO
CREATE Procedure SelectRotationOrganization
(
		@RotationGroupID char(10) = null,
		@OrganizationID int = null		
)
AS
/******************************************************************************
**	File: SelectRotationOrganization.sql
**	Name: SelectRotationOrganization
**	Desc: Selects multiple rows of RotationOrganization Based on Id  fields 
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
		RotationOrganization.RotationGroupID,
		RotationOrganization.OrganizationID,
		RotationOrganization.OrganizationName,
		RotationOrganization.OrganizationCity,
		RotationOrganization.OrganizationState,
		RotationOrganization.OrganizationType,
		RotationOrganization.ID
		  
	FROM 
		dbo.RotationOrganization 
	WHERE 
		RotationOrganization.RotationGroupID = ISNULL(@RotationGroupID, RotationOrganization.RotationGroupID)
	AND
		RotationOrganization.OrganizationID = ISNULL(@OrganizationID, RotationOrganization.OrganizationID)

GO

GRANT EXEC ON SelectRotationOrganization TO PUBLIC
GO
