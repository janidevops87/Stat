

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertOrganizationSelect')
	BEGIN
		PRINT 'Dropping Procedure AlertOrganizationSelect'
		DROP Procedure AlertOrganizationSelect
	END
GO

PRINT 'Creating Procedure AlertOrganizationSelect'
GO
CREATE Procedure AlertOrganizationSelect
(
		@AlertOrganizationID int = null output,
		@AlertID int = null,
		@OrganizationID int = null					
)
AS
/******************************************************************************
**	File: AlertOrganizationSelect.sql
**	Name: AlertOrganizationSelect
**	Desc: Selects multiple rows of AlertOrganization Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 1/26/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AlertOrganization.AlertOrganizationID,
		AlertOrganization.AlertID,
		AlertOrganization.OrganizationID,
		AlertOrganization.LastModified,
		AlertOrganization.UpdatedFlag
	FROM 
		dbo.AlertOrganization 
	JOIN
		Organization ON Organization.OrganizationID = AlertOrganization.OrganizationID
	WHERE 
		AlertOrganization.AlertOrganizationID = ISNULL(@AlertOrganizationID, AlertOrganization.AlertOrganizationID)
	AND
		AlertOrganization.AlertID = ISNULL(@AlertID, AlertOrganization.AlertID)
	AND
		AlertOrganization.OrganizationID = ISNULL(@OrganizationID, AlertOrganization.OrganizationID)				
	ORDER BY 1
GO

GRANT EXEC ON AlertOrganizationSelect TO PUBLIC
GO
