IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_PageResponseTimes')
	BEGIN
		DROP  Procedure  sps_rpt_PageResponseTimes
		PRINT 'Dropping Procedure: sps_rpt_PageResponseTimes'
	END
GO
PRINT 'Creating Procedure: sps_rpt_PageResponseTimes'
GO

CREATE Procedure sps_rpt_PageResponseTimes
	@StartDateTime		DATETIME,
	@EndDateTime		DATETIME,
	@OrganizationID		INT,
	@ScheduleGroupID	INT,
	@DisplayMT			INT			= NULL 

AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	
/******************************************************************************
**		File: sps_rpt_PageResponseTimes.sql
**		Name: sps_rpt_PageResponseTimes
**		Desc: 
**
**		Return values:
** 
**		Parameters:	See Above
**
**		Auth: Mike Berenson
**		Date: 05/11/2022
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:		Description:
**		--------		--------	-------------------------------------------
**		05/11/2022		mberenson	Initial Release
**		05/13/2022		mberenson	Refactored with temp table & update statements
**		
****************************************************************************/

BEGIN

	DECLARE
		@vtimeZoneOffset		SMALLINT		= NULL,
		@vtimeZoneAbbreviation	VARCHAR(2)		= NULL;	

	-- Lookup Organization's TimeZoneAbbreviation
	SELECT	@vtimeZoneAbbreviation = TimeZone.TimeZoneAbbreviation
	FROM Organization 
		LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
	WHERE 	Organization.OrganizationID = @OrganizationID;

	-- Use the TimeZoneAbbreviation to get the TimeZoneOffset (in hours)
	EXEC spf_TZDif @vtimeZoneAbbreviation, @vtimeZoneOffset OUTPUT, @StartDateTime;

	-- Load #LogEventData
	DROP TABLE IF EXISTS #LogEventData
	SELECT 	
		LogEvent.LogEventID,
		LogEvent.CallID, 
		LogEvent.LogEventDateTime,
		LogEventType.LogEventTypeName,
		LogEvent.LogEventNumber,
		LogEvent.PersonID,
		CONVERT(CHAR(8), DATEADD(hour, @vtimeZoneOffset, LogEventDateTime), 1) + ' ' +
		CONVERT(CHAR(5), DATEADD(hour, @vtimeZoneOffset, LogEventDateTime), 8) AS DateTime,
		PersonFirst + ' ' + PersonLast AS Person,
		ScheduleGroup.ScheduleGroupName,
		CallType.CallTypeName, 
		CAST('' AS VARCHAR(10)) AS Duration
	INTO #LogEventData
	FROM 	LogEvent
		JOIN	Person ON Person.PersonID = LogEvent.PersonID
		JOIN	Call ON Call.CallID = LogEvent.CallID
		JOIN	CallType ON Call.CallTypeID = CallType.CallTypeID
		JOIN	LogEventType ON LogEvent.LogEventTypeID = LogEventType.LogEventTypeID
		JOIN	ScheduleGroup ON LogEvent.ScheduleGroupID = ScheduleGroup.ScheduleGroupID

	WHERE 	LogEvent.OrganizationID = @OrganizationID
		AND LogEvent.ScheduleGroupID = @ScheduleGroupID
		AND 
		(
			LogEvent.LogEventTypeID = 6		-- Page Pending
			OR LogEvent.LogEventTypeID = 9	-- Page Response
			OR LogEvent.LogEventTypeID = 12	-- No Page Response
			OR LogEvent.LogEventTypeID = 21 -- Email Pending
			OR LogEvent.LogEventTypeID = 22	-- Email Response
			OR LogEvent.LogEventTypeID = 51	-- Email Sent
			OR LogEvent.LogEventTypeID = 52	-- Page Sent
		)
		AND	LogEvent.LogEventDateTime >= @StartDateTime 
		AND LogEvent.LogEventDateTime <= @EndDateTime
		AND	
		(
			Call.CallTypeID = 1		-- Referral
			OR Call.CallTypeID = 2	-- Message
			OR Call.CallTypeID = 4	-- Import						
		)

	-- Update with Email Durations
	UPDATE leResponse
	SET leResponse.Duration = (
								SELECT 
									CAST(
										DATEDIFF("MINUTE", MAX(lePending.DateTime), leResponse.DateTime)
										AS VARCHAR(10)
										)
								FROM #LogEventData lePending
								WHERE lePending.CallID = leResponse.CallID
								AND lePending.PersonID = leResponse.PersonID
								AND lePending.LogEventTypeName = 'Email Pending'
								AND lePending.LogEventNumber < leResponse.LogEventNumber
								)
	FROM #LogEventData leResponse
	WHERE LogEventTypeName = 'Email Response'
	AND EXISTS (
					SELECT 1
					FROM #LogEventData lePending
					WHERE lePending.CallID = leResponse.CallID
					AND lePending.PersonID = leResponse.PersonID
					AND lePending.LogEventTypeName = 'Email Pending'
					AND lePending.LogEventNumber < leResponse.LogEventNumber
				);

	-- Update with Page Durations
	UPDATE leResponse
	SET leResponse.Duration = (
								SELECT 
									CAST(
										DATEDIFF("MINUTE", MAX(lePending.DateTime), leResponse.DateTime)
										AS VARCHAR(10)
										)
								FROM #LogEventData lePending
								WHERE lePending.CallID = leResponse.CallID
								AND lePending.PersonID = leResponse.PersonID
								AND lePending.LogEventTypeName = 'Page Pending'
								AND lePending.LogEventNumber < leResponse.LogEventNumber
								)
	FROM #LogEventData leResponse
	WHERE 
	(
		LogEventTypeName = 'Page Response' 
		OR LogEventTypeName = 'No Page Response'
	)
	AND EXISTS (
					SELECT 1
					FROM #LogEventData lePending
					WHERE lePending.CallID = leResponse.CallID
					AND lePending.PersonID = leResponse.PersonID
					AND lePending.LogEventTypeName = 'Page Pending'
					AND lePending.LogEventNumber < leResponse.LogEventNumber
				);

	SELECT * FROM #LogEventData;
	
	DROP TABLE IF EXISTS #LogEventData

END
GO


