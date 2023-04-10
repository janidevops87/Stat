IF OBJECT_ID('Api.[fn_QAProcessor.GetHighRiskCTODEventsNoCTODCallReferrals]') IS NOT NULL 
DROP FUNCTION Api.[fn_QAProcessor.GetHighRiskCTODEventsNoCTODCallReferrals];
GO

CREATE FUNCTION Api.[fn_QAProcessor.GetHighRiskCTODEventsNoCTODCallReferrals]
(
	@StartDate datetime,
	@EndDate datetime
)
RETURNS TABLE
AS

RETURN(
SELECT
	ref.ReferralID,
	eventLog.LogEventID
FROM
	dbo.Referral ref
	INNER JOIN dbo.[Call] c
			INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
		ON c.CallID = ref.CallID
	INNER JOIN dbo.LogEvent eventLog
			INNER JOIN dbo.LogEventType eventType ON eventLog.LogEventTypeID = eventType.LogEventTypeID AND eventType.LogEventTypeName IN ('Incoming Call', 'Case Update')
			LEFT JOIN dbo.StatEmployee emp ON eventLog.StatEmployeeID = emp.StatEmployeeID
		ON ref.CallID = eventLog.CallID AND PATINDEX('%CTOD%', eventLog.LogEventDesc) > 0
										AND	PATINDEX('%[0-9][0-9]%', eventLog.LogEventDesc) > 0
										AND	PATINDEX('% call with CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% call back with CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% c/b with CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% call w/CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% call back w/CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% c/b w/CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% call w/ CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% call back w/ CTOD%', eventLog.LogEventDesc) = 0
										AND	PATINDEX('% c/b w/ CTOD%', eventLog.LogEventDesc) = 0
WHERE
	ref.ReferralDonorDeathTime IS NULL
AND	eventLog.LogEventDateTime >= @StartDate
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
	)
);

GO