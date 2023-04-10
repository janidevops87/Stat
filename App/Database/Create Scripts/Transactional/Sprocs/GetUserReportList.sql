IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetUserReportList')
BEGIN
	PRINT 'Dropping Procedure GetUserReportList';
	DROP  Procedure  GetUserReportList;
END
GO

PRINT 'Creating Procedure GetUserReportList';
GO

CREATE Procedure GetUserReportList
	@userID int,
	@reportID int = null,
	@reportDisplayname varchar(50) = null
AS

/******************************************************************************
**		File: 
**		Name: GetUserReportList
**		Desc: 
**
**		Retrieves the list of reports a user has access to.
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		userID int
**		Auth: Bret Knoll
**		Date: 3/15/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------
**    03/15/2007	Bret Knoll			Created
**		12/18/2020	Mike Berenson		Added to source control in App\Database
**		12/18/2020	Mike Berenson		Only include old reports: ReportID < 300
*******************************************************************************/
IF @reportID = 0		
BEGIN			
	SET @reportID = null;
END

SELECT     
	Report.ReportID, 
	Report.ReportDisplayName, 
	ReportType.REPORTTYPENAME,
	Report.ReportVirtualURL
FROM         
	Report 
	INNER JOIN ReportType ON Report.ReportTypeID = ReportType.REPORTTYPEID 
WHERE     
	(Report.ReportID = ISNULL(@reportID, Report.ReportID))
	AND (Report.ReportID IN (
							SELECT ReportID 
							FROM ReportRule
							JOIN UserRoles ON ReportRule.RoleID = UserRoles.RoleID
							WHERE (UserRoles.WebPersonID = @userID)
							)
		)

	AND reportid > 194 -- ONLY LOOK AT NEW REPORTS
	AND reportID < 300 -- But don't look at the really new reports

	AND ISNULL(PATINDEX(@reportDisplayname + '%', 
					ISNULL(ReportDisplayName, 0) 
				), -1) <> 0 
ORDER BY 	
	Report.ReportDisplayName;
GO

GRANT EXEC ON GetUserReportList TO PUBLIC;
GO
