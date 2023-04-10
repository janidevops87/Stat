

IF EXISTS (SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'SelectRefQueryOrganization')
	BEGIN
		PRINT 'Dropping Procedure SelectRefQueryOrganization';
		DROP Procedure SelectRefQueryOrganization;
	END
GO

PRINT 'Creating Procedure SelectRefQueryOrganization';
GO
CREATE Procedure SelectRefQueryOrganization
(
		@OrganizationID INT = NULL,
		@OrganizationName VARCHAR(80) = NULL,
		@OrganizationTypeID INT = NULL
)
AS
/******************************************************************************
**	File: SelectRefQueryOrganization.sql
**	Name: SelectRefQueryOrganization
**	Desc: Selects Org name, id, & type 
**	Auth: Mike Berenson
**	Date: 10/14/2018
**	Called By: StatQuery.RefQueryOrganization
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/14/2019		Mike Berenson		Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT DISTINCT 
		Organization.OrganizationID, 
		Organization.OrganizationName, 
		Organization.OrganizationTypeID 
	FROM 
		Organization
	WHERE
		(@OrganizationID IS NULL OR OrganizationID = @OrganizationID)
		AND (@OrganizationName IS NULL OR OrganizationName = @OrganizationName)
		AND (@OrganizationTypeID IS NULL OR OrganizationTypeID = @OrganizationTypeID);
GO

GRANT EXEC ON SelectRefQueryOrganization TO PUBLIC;
GO
