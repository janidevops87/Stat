

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sps_ReportOrganizationDropDown')
	BEGIN
		PRINT 'Dropping Procedure sps_ReportOrganizationDropDown';
		DROP Procedure sps_ReportOrganizationDropDown;
	END
GO

PRINT 'Creating Procedure sps_ReportOrganizationDropDown';
GO


 CREATE PROCEDURE [dbo].[sps_ReportOrganizationDropDown]
	@ReportGroupId INT = NULL,
	@LastRowId INT = 0,
	@SearchTerm nvarchar(100) = NULL
 AS 
 /******************************************************************************
**	File: sps_ReportOrganizationDropDown.sql
**	Name: sps_ReportOrganizationDropDown
**	Desc: Populates dropdown for report organization dropdown in reporting.
**	Auth: Pam Scheichenost
**	Date: 11/15/2020
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					------------------------------
**	11/15/2020		Pam Scheichenost			Initial Sproc Creation
**	12/16/2020		Mike Berenson				Moved Order By statement to the outer
**													query to avoid build error
*******************************************************************************/
WITH OrganizationRecords AS
(
SELECT Row_Number() OVER(ORDER BY OrganizationName) AS RowNum,
		Organization.OrganizationID as [value], 
		OrganizationName as [label]
    FROM WebReportGroupOrg
    JOIN Organization ON Organization.OrganizationID = WebReportGroupOrg.OrganizationID
    WHERE WebReportGroupID = @ReportGroupID
	AND (@SearchTerm IS NULL OR @SearchTerm = '' OR (PATINDEX(@SearchTerm + '%', OrganizationName ) > 0))

)
SELECT [Value], [label]
FROM OrganizationRecords
WHERE RowNum > @LastRowId
AND RowNum < @LastRowId + 250
ORDER BY [label];
GO

GRANT EXEC ON sps_ReportOrganizationDropDown TO PUBLIC;
GO
