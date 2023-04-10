IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Message_EventLog')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_AuditTrail_Message_EventLog';
	DROP  Procedure  sps_rpt_AuditTrail_Message_EventLog;
END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Message_EventLog';
GO

CREATE Procedure sps_rpt_AuditTrail_Message_EventLog
	@CallID					INT			= NULL,
	@User					INT			= NULL,
	@ChangeStartDateTime	DATETIME	= NULL,
	@ChangeEndDateTime		DATETIME	= NULL,
	@SourceCodeName			INT			= NULL,
	@UserOrgID				INT			= NULL,
	@DisplayMT				INT			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Message_EventLog.sql
**		Name: sps_rpt_AuditTrail_Message_EventLog
**		Desc: 
**
**		Return values:
**
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
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
**		05/29/2008		ccarroll				Added ILB functionality
**		06/25/2008		ccarroll				Added CallID
**		12/03/2008		ccarroll				Added reference to views
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

DROP TABLE IF EXISTS #ConvertedLogEvents;
DROP TABLE IF EXISTS #FilteredLogEvents;

-- Load #ConvertedLogEvents with converted LogEvent datetimes
SELECT
	le.CallID,
	le.LastModified,
	dbo.AuditTrailfn_rpt_ConvertDateTime(rm.OrganizationID, le.LastModified, @DisplayMT) AS 'ChangeDT'
INTO #ConvertedLogEvents
FROM 
	LogEvent le
	LEFT JOIN vwAuditTrailMessage rm ON rm.CallID = le.CallID
WHERE
	le.CallID = @CallID
	AND (rm.OrganizationID = CASE WHEN @userOrgID IS NULL THEN rm.OrganizationID ELSE @userOrgID END);

-- Load #FilteredLogEvents with LogEvents filtered by datetime
SELECT
	cle.CallID,
	cle.LastModified,
	cle.ChangeDT
INTO #FilteredLogEvents
FROM
	#ConvertedLogEvents cle
	LEFT JOIN vwAuditTrailMessage rm ON rm.CallID = cle.CallID
WHERE
	EXISTS (SELECT 1 FROM [Call] c WHERE c.CallID = cle.CallID)
	AND (
			@ChangeStartDateTime IS NULL
		OR	cle.ChangeDT >= @ChangeStartDateTime
		)
	AND (
			@ChangeStartDateTime IS NULL
		OR	cle.ChangeDT <= @ChangeEndDateTime
		);

-- Run final select
SELECT DISTINCT
	fle.CallID,
	/* LogEvent * - User Change Data */
	fle.ChangeDT,
	LogEventChangePerson.PersonFirst + ' ' + LogEventChangePerson.PersonLast	AS 'ChangeUser',
	LogEventChangeType.AuditLogTypeName AS 'ChangeType',
	le.LogEventNumber,
	CASE WHEN le.LogEventTypeID = -2 THEN 'ILB' 
		ELSE LogEventType.LogEventTypeName END 
										AS 'EventType',
	CASE WHEN le.LogEventDateTime = '01/01/1900' THEN 'ILB' 
		ELSE	CONVERT(VARCHAR, dbo.AuditTrailfn_rpt_ConvertDateTime(RefMessage.OrganizationID, le.LogEventDateTime, @DisplayMT), 101) + ' ' +
				CONVERT(VARCHAR, dbo.AuditTrailfn_rpt_ConvertDateTime(RefMessage.OrganizationID, le.LogEventDateTime, @DisplayMT), 108)
		END								AS 'LogEventDatetime',
	le.LogEventName						AS 'NameOfContact',
	le.LogEventOrg						AS 'Organization',
	le.LogEventPhone					AS 'Phone',
	le.LogEventDesc						AS 'Description',
	/* RS Fields included for sorting */
	LogEventChangePerson.PersonLast,
	LogEventChangePerson.PersonFirst,
	le.LogEventDatetime
FROM 
	LogEvent le
	JOIN #FilteredLogEvents fle									ON fle.CallID = le.CallID AND fle.LastModified = le.LastModified 
	LEFT JOIN vwAuditTrailLogEvent RefLogEvent					ON RefLogEvent.CallID = le.CallID
	LEFT JOIN vwAuditTrailMessage RefMessage					ON RefMessage.CallID = le.CallID
	/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee LogEventChangeEmployee	ON LogEventChangeEmployee.StatEmployeeID = le.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson LogEventChangePerson			ON LogEventChangePerson.PersonID = LogEventChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType LogEventChangeType		ON LogEventChangeType.AuditLogTypeID = le.AuditLogTypeID
	LEFT JOIN vwAuditTrailLogEventType LogEventType				ON LogEventType.LogEventTypeID = le.LogEventTypeID
ORDER BY
	le.LogEventDatetime,
	LogEventChangePerson.PersonLast,
	LogEventChangePerson.PersonFirst,
	LogEventChangeType.AuditLogTypeName;

DROP TABLE IF EXISTS #ConvertedLogEvents;
DROP TABLE IF EXISTS #FilteredLogEvents;

GO
