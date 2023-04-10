IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_EventLog')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_EventLog';
		DROP  PROCEDURE  sps_rpt_AuditTrail_EventLog;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_EventLog';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_EventLog
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_EventLog.sql
**		Name: sps_rpt_AuditTrail_EventLog
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
**		Date: 08/08/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**      08/08/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality in Update sproc
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		04/10/2018		mberenson				Replaced some IsNull functions in where clause (for performance)
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #LogInfo;


/* Check for matching Start-End datetimes and make NULL if true */
IF @ChangeStartDateTime = @ChangeEndDateTime
	BEGIN
		SELECT
			@ChangeStartDateTime = NULL,
			@ChangeEndDateTime = NULL;
	END

/* Give StatLine(194) full organization access, else restrict by ReferralCallerReferralCallerOrganizationID*/
IF @UserOrgID = 194
	BEGIN
		SET @UserOrgID = NULL
	END 


SELECT DISTINCT
/* LogEvent * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, LogEvent.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	LogEventChangePerson.PersonFirst + ' ' + LogEventChangePerson.PersonLast AS 'ChangeUser',
	LogEventChangeType.AuditLogTypeName AS 'ChangeType',
	LogEvent.LogEventNumber,
	LogEventType.LogEventTypeName AS 'EventType',
	CASE
		WHEN LogEvent.LogEventDateTime = '01/01/1900'
		THEN 'ILB'
		ELSE LogEvent.LogEventDateTime
	END AS 'Date/time',
	LogEvent.LogEventName AS 'NameOfContact',
	LogEvent.LogEventOrg AS 'Organization',
	LogEvent.LogEventPhone AS 'Phone',
	LogEvent.LogEventDesc AS 'Description'
INTO #LogInfo
FROM
	LogEvent
	JOIN vwAuditTrailLogEvent RefLogEvent ON RefLogEvent.CallID = LogEvent.CallID
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = LogEvent.CallID
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee LogEventChangeEmployee ON LogEventChangeEmployee.StatEmployeeID = LogEvent.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson LogEventChangePerson ON LogEventChangePerson.PersonID = LogEventChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType LogEventChangeType ON LogEventChangeType.AuditLogTypeID = LogEvent.AuditLogTypeID
	LEFT JOIN vwAuditTrailLogEventType LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID
WHERE
	LogEvent.CallID = @CallID
AND LogEvent.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN LogEvent.LastStatEmployeeID
			ELSE @CoordinatorID
		END
AND RefLogEvent.OrganizationID =
		CASE
			WHEN @UserOrgID IS NULL
			THEN RefLogEvent.OrganizationID
			ELSE @UserOrgID
		END;

/* Final Results */
SELECT *
FROM #LogInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	LogEventNumber IS NOT NULL
	OR	[Date/time] IS NOT NULL
	OR	NameOfContact IS NOT NULL
	OR	Organization IS NOT NULL
	OR	Phone IS NOT NULL
	OR	[Description] IS NOT NULL
	)
AND	ChangeDT >= 
		CASE
			WHEN @ChangeStartDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeStartDateTime
		END
AND	ChangeDT <=
		CASE
			WHEN @ChangeEndDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeEndDateTime
		END;

DROP TABLE IF EXISTS #LogInfo;