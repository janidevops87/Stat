
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportOrgByStateAndTypeDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportOrgByStateAndTypeDropDown';
		DROP Procedure sps_ReportOrgByStateAndTypeDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportOrgByStateAndTypeDropDown';
GO

CREATE PROCEDURE sps_ReportOrgByStateAndTypeDropDown

@StateId int = null,
@OrganizationTypeId	int = null

AS
/******************************************************************************
**	File: sps_ReportOrgByStateAndTypeDropDown.sql
**	Name: sps_ReportOrgByStateAndTypeDropDown
**	Desc: Selects multiple rows of Organizations 
**	Auth: Pam Scheichenost
**	Date: 01/18/2021
**	Called By: Report Portal
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	01/18/2021		Pam Scheichenost		Initial Sproc Creation
*******************************************************************************/



	--Main Query
	SELECT DISTINCT
	Organization.OrganizationID as [value],
	Organization.OrganizationName as [label]
	
	FROM Organization
	JOIN	State ON State.StateID = Organization.StateID
	JOIN	OrganizationType ON OrganizationType.OrganizationTypeID = Organization.OrganizationTypeID
	
	WHERE (@StateId IS NULL OR State.StateID = @StateId) 
	AND
		(@OrganizationTypeId IS NULL OR OrganizationType.OrganizationTypeID = @OrganizationTypeId)

	
	ORDER BY OrganizationName ASC



GO

GRANT EXEC ON sps_ReportOrgByStateAndTypeDropDown TO PUBLIC;
GO

