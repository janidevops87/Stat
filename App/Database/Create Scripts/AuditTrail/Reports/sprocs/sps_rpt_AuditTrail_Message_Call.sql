IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Message_Call')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_AuditTrail_Message_Call';
	DROP  Procedure  sps_rpt_AuditTrail_Message_Call;
END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Message_Call';
GO

CREATE Procedure sps_rpt_AuditTrail_Message_Call
	@CallID					INT			= NULL,
	@User					INT			= NULL,	
	@ChangeStartDateTime	DATETIME	= NULL,
	@ChangeEndDateTime		DATETIME	= NULL,
	@SourceCodeName			VARCHAR(10) = NULL,
	@UserOrgID				INT			= NULL,
	@DisplayMT				INT			= 1
	
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Message_Call.sql
**		Name: sps_rpt_AuditTrail_Message_Call
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 08/28/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/28/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		11/19/2007		ccarroll				added time zone search parameter
**		05/29/2008		ccarroll				Added ILB functionality
**		06/25/2008		ccarroll				Added CallID
**		12/03/2008		ccarroll				added reference to vwAuditTrail
**		10/30/2020		Mike Berenson			Refactored with temp tables to improve performance
**		01/14/2021		James Gerberich			Corrected date range filtering
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- If Start & End DateTimes match, set them to null
IF @ChangeStartDateTime = @ChangeEndDateTime
BEGIN
	SELECT
		@ChangeStartDateTime = NULL,
		@ChangeEndDateTime = NULL;
END

-- Give StatLine(194) full organization access, otherwise restrict by OrganizationID
SELECT @UserOrgID = CASE WHEN @UserOrgID = 194 THEN NULL ELSE @UserOrgID END;

DROP TABLE IF EXISTS #ConvertedCalls;
DROP TABLE IF EXISTS #FilteredCalls;
		
-- Load #ConvertedCalls with converted call DateTimes
SELECT
	c.CallID,
	c.LastModified,
	dbo.AuditTrailfn_rpt_ConvertDateTime(rm.OrganizationID, c.LastModified, @DisplayMT) AS 'ChangeDT'
INTO #ConvertedCalls
FROM 
	[Call] c
	LEFT JOIN vwAuditTrailMessage rm ON rm.CallID = c.CallID
WHERE
	c.CallID = @CallID
	AND (rm.OrganizationID = CASE WHEN @userOrgID IS NULL THEN rm.OrganizationID ELSE @userOrgID END)
	AND (c.CallSaveLastByID = CASE WHEN @User IS NULL THEN c.CallSaveLastByID ELSE @User END);

-- Load #FilteredCalls  with Calls filtered by datetime
SELECT
	cc.CallID,
	cc.LastModified,
	cc.ChangeDT
INTO #FilteredCalls
FROM
	#ConvertedCalls cc
WHERE
	(
		@ChangeStartDateTime IS NULL
	OR	cc.ChangeDT >= @ChangeStartDateTime
	)
AND (
		@ChangeStartDateTime IS NULL
	OR	cc.ChangeDT <= @ChangeEndDateTime
	);

-- Run final select
SELECT DISTINCT
	c.CallID,
	-- Call - User Change Data
	fc.ChangeDT,
	CallChangePerson.PersonFirst + ' ' + CallChangePerson.PersonLast	AS 'ChangeUser',
	CallChangeType.AuditLogTypeName										AS 'ChangeType',
	-- Call
	CASE WHEN c.StatEmployeeID = -2 THEN 'ILB' 
		ELSE ISNULL(CallStatPerson.PersonFirst, '') + ' ' + 
			ISNULL(CallStatPerson.PersonLast, '') END					AS 'User',
	CASE WHEN c.CallExtension = -2 THEN 'ILB' ELSE c.CallExtension END	AS 'UserExtension',
	c.CallTotalTime														AS 'Timer',
	CASE WHEN c.CallTemp = -1 THEN 'Yes' 
		WHEN c.CallTemp = 0 THEN 'No' 
		ELSE '' END														AS 'Incomplete',
	CASE WHEN c.CallTempExclusive = -1 THEN 'Yes' 
		WHEN c.CallTempExclusive = 0 THEN 'No' 
		ELSE '' END														AS 'Exclusive',
	CONVERT(VARCHAR, fc.ChangeDT, 101) + ' ' + 
		CONVERT(VARCHAR, fc.ChangeDT, 108)								AS 'CallDateTime',
	CASE WHEN c.SourceCodeID = -2 THEN 'ILB' 
		ELSE sc.SourceCodeName END										AS 'SourceCode',
	CallStatPerson.PersonLast,
	CallStatPerson.PersonFirst
FROM 
	[Call] c 
	JOIN #FilteredCalls fc									ON fc.CallID = c.CallID AND fc.LastModified = c.Lastmodified
	-- Call Lookups
	LEFT JOIN vwAuditTrailStatEmployee CallChangeEmployee	ON CallChangeEmployee.StatEmployeeID = c.CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson CallChangePerson			ON CallChangePerson.PersonID = CallChangeEmployee.PersonID 
	LEFT JOIN vwAuditTrailAuditLogType CallChangeType		ON CallChangeType.AuditLogTypeID = c.AuditLogTypeID
	LEFT JOIN vwAuditTrailSourceCode sc						ON sc.SourceCodeID = c.SourceCodeID 
	LEFT JOIN vwAuditTrailStatEmployee CallStatEmployee		ON CallStatEmployee.StatEmployeeID = c.StatEmployeeID 
	LEFT JOIN vwAuditTrailPerson CallStatPerson				ON CallStatPerson.PersonID = CallStatEmployee.PersonID 
ORDER BY
	CallDateTime,
	CallStatPerson.PersonLast,
	CallStatPerson.PersonFirst,
	CallChangeType.AuditLogTypeName;

DROP TABLE IF EXISTS #ConvertedCalls;
DROP TABLE IF EXISTS #FilteredCalls;

GO
