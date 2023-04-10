IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ImportOfferActivity_count')
BEGIN
	DROP PROCEDURE [dbo].[sps_rpt_ImportOfferActivity_count];
	PRINT 'Dropping procedure: sps_rpt_ImportOfferActivity_count';
END

PRINT 'Creating procedure: sps_rpt_ImportOfferActivity_count';
GO

SET QUOTED_IDENTIFIER ON; 
GO

SET ANSI_NULLS ON;  
GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity_count
    @UserOrgID					INT			= NULL,
    @ReportGroupID				INT			= NULL,
    @CallID						INT			= NULL,
    @StartDateTime				DATETIME	= NULL,
    @EndDateTime				DATETIME	= NULL,
    @SourceCodeName				VARCHAR(50),
    @MessageCallerOrganization	VARCHAR(50),
    @MessageFor					VARCHAR(50),
    @MessageForOrganizationID	INT			= NULL,
    @DisplayMT					INT			= NULL
AS
/******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity_count
**		Desc: 
**
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
**      10/21/08    jth                 added  MessageForOrganizationID 
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**		11/02/2020	Mike Berenson		Restored, refactored and eliminated call to 
**											sps_rpt_ImportOfferActivity_count_select.sql
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
**		02/24/2021	James Gerberich		Added check to make sure we have enough params to work with
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED;

DECLARE 
	@MessageOrganizationID INT;

-- CHECK FOR STATLINE AND SET PARAM
SELECT @MessageOrganizationID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;
           
-- If CallerOrganization is provided, replace the wildcards
IF @MessageCallerOrganization IS NOT NULL
BEGIN
	SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%');
END

-- Make sure we have enough params to work with
IF @CallID IS NULL AND @StartDateTime IS NULL AND @EndDateTime IS NULL
BEGIN
	SELECT 0 AS 'RecordCount';
	RETURN;
END

-- If CallID is provided, set DateTimes & other params to NULL
IF ISNULL(@CallID,0) <> 0
BEGIN
    SELECT
        @StartDateTime = NULL,
        @EndDateTime = NULL,
        @MessageCallerOrganization = NULL,
        @MessageFor = NULL;
END
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

-- Load #SourceCodes
SELECT 
	SourceCodeID
INTO #SourceCodes
FROM 
	dbo.fn_SourceCodeList
		(
			@ReportGroupID, 
			@SourceCodeName
		);

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

-- Run Final Select   
SELECT COUNT(DISTINCT c.CallID) 'RecordCount'
FROM      
	[Call] c
	INNER JOIN #FilteredCalls fc		ON fc.CallID = c.CallID
	INNER JOIN #SourceCodes fsc			ON fsc.SourceCodeID = c.SourceCodeID
	INNER JOIN [Message] m				ON m.CallID = c.CallID 
	INNER JOIN WebReportGroupOrg wrgo	ON wrgo.OrganizationID = m.OrganizationID 
	LEFT JOIN Person p					ON p.PersonID = m.PersonID 
WHERE  
	wrgo.WebReportGroupID = @ReportGroupID
	AND	(@CallID IS NULL OR c.CallID = @CallID)
	-- Search - Organization message for
	AND (@MessageForOrganizationID IS NULL OR @MessageForOrganizationID = 0 OR m.OrganizationID = @MessageForOrganizationID)
	AND (@MessageCallerOrganization IS NULL OR (m.MessageCallerOrganization IS NOT NULL AND PATINDEX(@MessageCallerOrganization, m.MessageCallerOrganization) > 0))
    AND (@MessageFor IS NULL OR @MessageFor = 0 OR p.PersonID = @MessageFor)         
    -- LIMIT Message.OrganizationID
	AND (@MessageOrganizationID IS NULL OR m.OrganizationID = @MessageOrganizationID)                     
    AND m.MessageTypeID = 2;
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

GO