IF OBJECT_ID('Api.[fn_QAProcessor.GetHighRiskWithCrossClampNotesCallReferrals]') IS NOT NULL 
DROP FUNCTION Api.[fn_QAProcessor.GetHighRiskWithCrossClampNotesCallReferrals];
GO

CREATE FUNCTION Api.[fn_QAProcessor.GetHighRiskWithCrossClampNotesCallReferrals]
(
	@StartDate datetime,
	@EndDate datetime
)
RETURNS TABLE
AS

RETURN(
--if preliminary type is OTE and current referral type is T/E or E
--and there is an outgoing event after crossclamp event

Select Distinct
	r.ReferralID,
	evnt.LogEventID
From
	LogEvent evnt
	INNER JOIN [Call] c
			INNER JOIN SourceCode sc ON c.SourceCodeId = sc.SourceCodeId
			INNER JOIN Referral r ON c.CallID = r.CallID
		ON evnt.CallID = c.CallID
	INNER JOIN LogEvent evnt2 ON evnt.CallID = evnt2.CallID
							AND	evnt.LogEventNumber < evnt2.LogEventNumber
							AND (
									evnt2.LogEventTypeID = 3 --Outgoing Call
								OR	evnt2.LogEventTypeID = 6 --Page Pending
								OR	evnt2.LogEventTypeID = 21--Email Pending
								)
Where
	r.ReferralTypeID = 1 -- OTE
AND	(
		r.CurrentReferralTypeID = 2 --TE
	OR	r.CurrentReferralTypeID = 3 --E
	)
AND	evnt2.LogEventDateTime >= @StartDate
AND	evnt2.LogEventDateTime < @EndDate
AND	(
		evnt.LogEventTypeID = 1	--Note
	OR	evnt.LogEventTypeID = 2	--Incoming Call
	OR	evnt.LogEventTypeID = 3	--Outgoing Call
	OR	evnt.LogEventTypeID = 8	--Recovery Outcome
	OR	evnt.LogEventTypeID = 24	--Case Update
	)
AND	(
		PATINDEX('%crossclamp%', evnt.LogEventDesc) > 0
	OR	PATINDEX('%cross-clamp%', evnt.LogEventDesc) > 0
	OR	PATINDEX('%clamp%', evnt.LogEventDesc) > 0
	OR	PATINDEX('%CCT%', evnt.LogEventDesc) > 0
	)
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