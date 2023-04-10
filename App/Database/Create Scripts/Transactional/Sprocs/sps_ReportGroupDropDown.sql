

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportGroupDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportGroupDropDown';
		DROP Procedure sps_ReportGroupDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportGroupDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportGroupDropDown]
	@UserOrganizationId INT = NULL
 AS 
 /******************************************************************************
**	File: sps_ReportGroupDropDown.sql
**	Name: sps_ReportGroupDropDown
**	Desc: Populates dropdown for report group dropdown in reporting.
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

IF	@UserOrganizationId = 194

	BEGIN

		SELECT	WebReportGroupID as [value], 
				WebReportGroupName  AS [label]
		FROM		WebReportGroup
		WHERE 	OrgHierarchyParentID = @UserOrganizationId

		UNION

       		SELECT DISTINCT 
				WebReportGroupID as [value], 
				OrganizationName + ' (' + WebReportGroupName + ') ' AS [label]
       		FROM WebReportGroup
       		JOIN Organization ON Organization.OrganizationID = WebReportGroup.OrgHierarchyParentID
        		WHERE WebReportGroupMaster = 1

		ORDER BY	WebReportGroupName;
	END
	
ELSE

	SELECT	WebReportGroupID as [value], 
			WebReportGroupName  AS [label]
	FROM		WebReportGroup
	WHERE 	OrgHierarchyParentID = @UserOrganizationId
	ORDER BY	WebReportGroupName;

GO

GRANT EXEC ON sps_ReportGroupDropDown TO PUBLIC;
GO
