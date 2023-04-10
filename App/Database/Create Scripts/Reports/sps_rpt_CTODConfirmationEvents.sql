IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_CTODConfirmationEvents')
	DROP  Procedure  sps_rpt_CTODConfirmationEvents;
	PRINT 'Dropping Procedure: sps_rpt_CTODConfirmationEvents'
GO
	PRINT 'Creating Procedure: sps_rpt_CTODConfirmationEvents'
GO

CREATE Procedure dbo.sps_rpt_CTODConfirmationEvents
(
	@StartDate	datetime,
	@EndDate	datetime
)
AS
/******************************************************************************
**		File: sps_rpt_CTODConfirmationEvents.sql
**		Name: sps_rpt_CTODConfirmationEvents
**		Desc: This report identifies referrals that have a Declared CTOD Confirmed
**				event in the Event Log.
**              
**		Called by:	CTODConfirmationEvents.rdl
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-----------------------------------
**      07/27/2022		James Gebreich		Initial release. #81448
******************************************************************************/
--DECLARE
--	@StartDate	datetime = DATEADD(day, -1, GETDATE()),
--	@EndDate	datetime = GETDATE()

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	ref.CallID,
	eventType.LogEventTypeName,
	eventLog.LogEventDateTime,
	emp.StatEmployeeFirstName,
	emp.StatEmployeeLastName
FROM
	dbo.Referral ref
	INNER JOIN dbo.[Call] c
			INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
		ON c.CallID = ref.CallID
	INNER JOIN dbo.LogEvent eventLog
			INNER JOIN dbo.LogEventType eventType ON eventLog.LogEventTypeID = eventType.LogEventTypeID AND eventType.LogEventTypeName = 'Declared CTOD Confirmed'
			LEFT JOIN dbo.StatEmployee emp ON eventLog.StatEmployeeID = emp.StatEmployeeID
		ON ref.CallID = eventLog.CallID
WHERE
	eventLog.LogEventDateTime >= @StartDate
AND	eventLog.LogEventDateTime < @EndDate
AND	(-- exlcude transplant source codes
		PATINDEX('CASF[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('CASJ[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('COPM[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('COSL[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('CPMC[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('MIUM[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('OHCC[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('PATJ[A-Z][A-Z]', sc.SourceCodeName) = 0
);