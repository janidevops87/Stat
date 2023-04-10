

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportCoordinatorDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportCoordinatorDropDown';
		DROP Procedure sps_ReportCoordinatorDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportCoordinatorDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportCoordinatorDropDown]
	@UserOrgId INT = NULL,
	@webReportGroupId INT = NULL
 AS 
 /******************************************************************************
**	File: sps_ReportCoordinatorDropDown.sql
**	Name: sps_ReportCoordinatorDropDown
**	Desc: Populates dropdown for report coordinator dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/15/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/15/2020		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/

SELECT
	s.StatEmployeeID as [value], 
	s.StatEmployeeLastName + ', ' + s.StatEmployeeFirstName  as [label] 
FROM
	Statemployee s
JOIN	
	Person p ON p.PersonID = s.PersonID
WHERE
	p.Inactive = 0
AND
	(
		p.OrganizationID = ISNULL(@UserOrgId, p.OrganizationID)	
		OR
		p.OrganizationID IN 
			(
			SELECT 
				OrgHierarchyParentID
			FROM
				WebReportGroup
			WHERE
				( 
					WebReportGroupID = @webReportGroupId
				or
					OrgHierarchyParentID = @UserOrgId
				)
			)
	)
ORDER BY
	s.StatEmployeeLastName, 
	s.StatEmployeeFirstName;	

GO

GRANT EXEC ON sps_ReportCoordinatorDropDown TO PUBLIC;
GO
