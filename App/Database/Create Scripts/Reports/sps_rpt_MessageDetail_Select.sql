IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_MessageDetail_Select')
BEGIN
	DROP PROCEDURE sps_rpt_MessageDetail_Select;
	PRINT 'sps_rpt_MessageDetail_Select';
END
GO
PRINT 'Creating Procedure: sps_rpt_MessageDetail_Select';
GO

CREATE PROCEDURE [dbo].[sps_rpt_MessageDetail_Select]
	@UserOrgID      INT  = NULL,
	@ReportGroupID  INT  = NULL,
	@CallID         INT  = NULL,
	@StartDateTime  DATETIME  = NULL,
	@EndDateTime    DATETIME  = NULL,
	@SourceCodeName VARCHAR(50) = NULL,
	@DisplayMT      INT  = NULL
AS

 /******************************************************************************
**		File: sps_rpt_MessageDetail_Select.sql
**		Name: sps_rpt_MessageDetail_Select
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
**		Date: 2/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				----------------------------------------
**		10/01/2008	ccarroll			Added for Archive and Production databases
**      02/09       JTH                 limit message org id to user org id
**		03/14/2010	James Gerberich		Added phone extension to MessageCallerPhone
**										column. HS #22712
**		06/16/2010	Bret				Modified to Include in Release
**		10/28/2020	Mike Berenson		Refactored and eliminated need for sps_rpt_MessageDetail.sql
**		10/28/2020	Mike Berenson		Fixed 2 table alias issues
**      11/03/2020	Mike Berenson       Removed CustomCode logic
**		02/18/2021	James Gerberich		Added column alias for phone number. TFS 72874
**		02/19/2021	James Gerberich		Applied Report Group parameter to limit records. TFS 72897
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED;

DECLARE @MessageOrganizationID	INT;	

-- If CallID is provided, set Start & End DateTimes to NULL
IF @CallID IS NOT NULL
BEGIN
    SELECT
		@StartDateTime = NULL,
		@EndDateTime = NULL;
END

-- CHECK FOR STATLINE AND SET PARAM
SELECT @MessageOrganizationID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;
	
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

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

-- Final Select
SELECT DISTINCT
	c.CallID,
	mt.MessageTypeName,
	c.CallNumber,
	o.OrganizationName,
	m.MessageCallerName,
	m.MessageCallerOrganization,
	m.MessageCallerPhone + ISNULL(' x' + CAST(m.MessageExtension AS VARCHAR(5)), ' No Ext') AS MessageCallerPhone,
	fc.CallDateTime AS CallDateTime,
	m.MessageUrgent,
	m.MessageDescription,
	p.PersonLast AS MessageForLastName,
	pt.PersonTypeName,
	p.PersonFirst + ' ' + p.PersonLast	AS PersonName,
	sc.SourceCodeName,
	(
		SELECT TOP (1)
			Person.PersonFirst + ' ' + Person.PersonLast
		FROM
			LogEvent
			LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
			LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
		WHERE
			LogEvent.CallID = c.CallID
	) AS TriageCoord
FROM
	[Call] c
	INNER JOIN #FilteredCalls fc		ON fc.CallID = c.CallID
	INNER JOIN #SourceCodes fsc			ON fsc.SourceCodeID = c.SourceCodeID
	INNER JOIN Message m				ON m.CallID = c.CallID
	INNER JOIN Organization o			ON o.OrganizationID = m.OrganizationID
	INNER JOIN MessageType mt			ON mt.MessageTypeID = m.MessageTypeID
	LEFT JOIN Person p					ON p.PersonID = m.PersonID
	LEFT JOIN PersonType pt			ON p.PersonTypeID = pt.PersonTypeID
	INNER JOIN WebReportGroupOrg wrgo	ON wrgo.OrganizationID = m.OrganizationID 
	INNER JOIN SourceCode sc			ON sc.SourceCodeID = c.SourceCodeID
WHERE
	wrgo.WebReportGroupID = @ReportGroupID
	AND	(@CallID IS NULL OR @CallID = c.CallID)
	AND (@MessageOrganizationID IS NULL OR @MessageOrganizationID = m.OrganizationID)
	AND m.MessageTypeID <> 2;
		
DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

GO