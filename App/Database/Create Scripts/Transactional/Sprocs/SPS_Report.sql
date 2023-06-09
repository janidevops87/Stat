
PRINT 'Dropping Procedure SPS_Report';
DROP PROCEDURE IF EXISTS SPS_Report;
GO

PRINT 'Creating Procedure SPS_Report';
GO

CREATE PROCEDURE SPS_Report
    @ReportID INT = NULL
AS

/******************************************************************************
**		File: SPS_Report.sql
**		Name: SPS_Report
**		Desc: returns a list of Reports
**              
**		Return values:
** 
**		Called by:   Old Reporting Site (Weblogin)
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**		See above
**
**		Auth: ? 
**		Date: ?
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		?			?					Initial Creation
**		12/15/2020	Mike Berenson		Refactored to improve readability & conform with coding standards
**		12/15/2020	Mike Berenson		Added where clause statement to make sure we only show old reports
**                                          (ReportID < 300) in our old website
**		12/16/2020	Mike Berenson		Removed QUOTED_IDENTIFIER and ANSI_NULLS statements
**
*******************************************************************************/

BEGIN

    DECLARE  @intRetCode    INT = 0,
             @intRowcount   INT,
             @intError      INT;

    IF @ReportID IS NOT NULL
    BEGIN

        SELECT
            ReportID ,
            ReportDisplayName,
            ISNULL(LastModified,0) LastModified,
            ISNULL(ReportLocalOnly,0) ReportLocalOnly,
            ReportVirtualURL,
            ISNULL(ReportTypeID,0) ReportTypeID,
            Unused,
            ReportDescFileName,
            ISNULL(UpdatedFlag,0) UpdatedFlag,
            ISNULL(ReportSortOrderID,0) ReportSortOrderID,
            ISNULL(ReportInDevelopment,0) ReportInDevelopment,
            ISNULL(ReportFromDate,0) ReportFromDate,
            ISNULL(ReportToDate,0) ReportToDate,
            ISNULL(ReportGroup,0) ReportGroup,
            ISNULL(ReportOrganization,0) ReportOrganization
        FROM          
            Report
        WHERE         
            ReportID = @ReportID;

    END
    ELSE
    BEGIN
	    SELECT * 
        FROM Report
		WHERE ReportID < 300
	    ORDER BY ReportDisplayName;
    END

    SELECT 
        @intRowCount = @@rowcount, 
        @intError = @@error;

    IF @intRowCount = 0 OR @intError <> 0
    BEGIN
        -- Insert error handling
        SELECT @intRetcode = 6;
        RETURN -(@intRetcode);
    END

    RETURN @intRetCode;
END
GO

