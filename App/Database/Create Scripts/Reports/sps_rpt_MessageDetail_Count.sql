IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_MessageDetail_Count')
BEGIN
	DROP PROCEDURE sps_rpt_MessageDetail_Count;
	PRINT 'sps_rpt_MessageDetail_Count';
END
GO
PRINT 'Creating Procedure: sps_rpt_MessageDetail_Count';
GO

CREATE PROCEDURE [dbo].[sps_rpt_MessageDetail_Count]
	@UserOrgID		INT = NULL,
	@ReportGroupID	INT = NULL,
	@CallID			INT = NULL,
	@StartDateTime	DATETIME = NULL ,
	@EndDateTime	DATETIME = NULL,
	@SourceCodeName VARCHAR(50) ,
	@OrganizationID INT = NULL,
	@DisplayMT		INT = NULL
	
AS

/******************************************************************************
**		File: 
**		Name: sps_rpt_MessageDetail_Count
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**		10/28/2020	Mike Berenson		Refactored and eliminated call to sps_rpt_MessageDetail_count_select.sql
**		10/28/2020	Mike Berenson		Fixed table aliases
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
**		02/24/2021	James Gerberich		Added check to make sure we have enough params to work with
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED;

DECLARE @MessageOrganizationID INT;

-- CHECK FOR STATLINE AND SET PARAM
SELECT @MessageOrganizationID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

-- Make sure we have enough params to work with
IF @CallID IS NULL AND @StartDateTime IS NULL AND @EndDateTime IS NULL
BEGIN
	SELECT 0 AS 'RecordCount';
	RETURN;
END

-- If CallID is provided, set Start & End DateTimes to NULL
IF @CallID IS NOT NULL
BEGIN
    SELECT
		@StartDateTime = NULL,
		@EndDateTime = NULL;
END

-- Load #FilteredCalls
SELECT 		
	CallID, 
	CallDateTime
INTO #FilteredCalls
FROM
	dbo.fn_rpt_MessageDateTimeConversion 
		(
			@CallID,
			@StartDateTime,
			@EndDateTime,
			@DisplayMT
		);

-- Load #SourceCodes
SELECT 
	SourceCodeID
INTO #SourceCodes
FROM 
	dbo.fn_SourceCodeList
		(
			@ReportGroupID	, 
			@SourceCodeName
		);

-- Run Final Select
SELECT  
	COUNT(DISTINCT c.CallID) 'RecordCount'											
FROM
	[Call] c
	INNER JOIN #FilteredCalls fc ON fc.CallID = c.CallID
	INNER JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeID
	INNER JOIN Message m ON m.CallID = c.CallID
	INNER JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = m.OrganizationID 
WHERE
	wrgo.WebReportGroupID = @ReportGroupID
	AND	(@CallID IS NULL OR @CallID = c.CallID)
	AND (@MessageOrganizationID IS NULL OR @MessageOrganizationID = m.OrganizationID)
	AND m.MessageTypeID <> 2;	
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

GO

