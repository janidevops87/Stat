IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportStatTracUserDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportStatTracUserDropDown';
		DROP Procedure sps_ReportStatTracUserDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportStatTracUserDropDown';
GO

CREATE PROCEDURE [dbo].[sps_ReportStatTracUserDropDown]
	@UserOrgID INT = NULL,
	@webReportGroupID INT = NULL
/******************************************************************************
**	File: sps_ReportStatTracUserDropDown.sql
**	Name: sps_ReportStatTracUserDropDown
**	Desc: Populates dropdown for stattrac useres in reporting.
**	Auth: Pam Scheichenost
**	Date: 12/02/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	12/02/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/
AS

SET NOCOUNT ON;


SELECT
	s.StatEmployeeID as [value], 
	s.StatEmployeeLastName + ', ' + s.StatEmployeeFirstName as [label]
FROM
	Statemployee s
JOIN	
	Person p ON p.PersonID = s.PersonID
WHERE
	p.Inactive = 0
AND
	(
		p.OrganizationID = ISNULL(@UserOrgID, p.OrganizationID)	
		OR
		p.OrganizationID IN 
			(
			SELECT 
				OrgHierarchyParentID
			FROM
				WebReportGroup
			WHERE
				( 
					WebReportGroupID = @webReportGroupID
				or
					OrgHierarchyParentID = @UserOrgID
				)
			)
	)
ORDER BY
	s.StatEmployeeLastName, 
	s.StatEmployeeFirstName;	

GO

GRANT EXEC ON sps_ReportStatTracUserDropDown TO PUBLIC;
GO
