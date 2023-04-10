IF OBJECT_ID('Api.[fn_QAProcessor.GetHighRiskFacilityAddedInMedHxCallReferrals]') IS NOT NULL 
DROP FUNCTION Api.[fn_QAProcessor.GetHighRiskFacilityAddedInMedHxCallReferrals];
GO

CREATE FUNCTION [Api].[fn_QAProcessor.GetHighRiskFacilityAddedInMedHxCallReferrals]
(
	@StartDate datetime ,
	@EndDate datetime
)
RETURNS TABLE
AS

RETURN(

SELECT DISTINCT
	r.ReferralID,
	evnt.LogEventID
FROM
	Referral r
	INNER JOIN [Call] c ON r.CallID = c.CallID
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
	INNER JOIN dbo.LogEvent evnt ON c.CallID = evnt.CallID AND evnt.LogEventNumber = 1 -- First event is creating referral (Incoming Call)
WHERE
	c.CallDateTime >= @StartDate
AND c.CallDateTime < @EndDate
AND	(
		PATINDEX('%[0-9][0-9]%', ReferralNotesCase) > 0
	)
AND	(
		PATINDEX('% location %', ReferralNotesCase) > 0
	OR	PATINDEX('% facility %', ReferralNotesCase) > 0
	OR	PATINDEX('% campus %', ReferralNotesCase) > 0
	OR	PATINDEX('% hospital %', ReferralNotesCase) > 0
	OR	PATINDEX('% medical center %', ReferralNotesCase) > 0
	OR	PATINDEX('% medical ctr %', ReferralNotesCase) > 0
	OR	PATINDEX('% med center %', ReferralNotesCase) > 0
	OR	PATINDEX('% med ctr %', ReferralNotesCase) > 0
	OR	PATINDEX('% patient is at %', ReferralNotesCase) > 0
	OR	PATINDEX('% patient is located %', ReferralNotesCase) > 0
	)
AND	(
		(
			PATINDEX('% ave[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% avenue %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% blvd[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% bvl[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% boulevard %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% cir[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% circle %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% ct[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% court %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% dr[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% drive %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% expy[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% expressway %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% hwy[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% highway %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% ln[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% lane %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% pkwy[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% parkway %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% pl[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% place %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% rd[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% road %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% st[,. ]%', ReferralNotesCase) > 0
		OR	PATINDEX('% street %', ReferralNotesCase) > 0
		)
	OR	(
			PATINDEX('% way %', ReferralNotesCase) > 0
		)
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
UNION
SELECT DISTINCT
	r.ReferralID,
	evnt.LogEventID
FROM
	[Call] c
	INNER JOIN Referral r ON c.CallID = r.CallID
	INNER JOIN LogEvent evnt ON c.CallID = evnt.CallID
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
WHERE
	(
		LogEventTypeID = 1 -- Note
	OR	LogEventTypeID = 2 -- Incoming Call
	OR	LogEventTypeID = 24-- Case Update
	)
AND	evnt.LogEventDateTime >= @StartDate
AND evnt.LogEventDateTime < @EndDate
AND	(
		PATINDEX('%[0-9][0-9]%', LogEventDesc) > 0
	)
AND	(
		PATINDEX('% location %', LogEventDesc) > 0
	OR	PATINDEX('% facility %', LogEventDesc) > 0
	OR	PATINDEX('% campus %', LogEventDesc) > 0
	OR	PATINDEX('% hospital %', LogEventDesc) > 0
	OR	PATINDEX('% medical center %', LogEventDesc) > 0
	OR	PATINDEX('% medical ctr %', LogEventDesc) > 0
	OR	PATINDEX('% med center %', LogEventDesc) > 0
	OR	PATINDEX('% med ctr %', LogEventDesc) > 0
	OR	PATINDEX('% patient is at %', LogEventDesc) > 0
	OR	PATINDEX('% patient is located %', LogEventDesc) > 0
	)
AND	(
		(
			PATINDEX('% ave[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% avenue %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% blvd[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% bvl[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% boulevard %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% cir[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% circle %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% ct[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% court %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% dr[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% drive %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% expy[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% expressway %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% hwy[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% highway %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% ln[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% lane %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% pkwy[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% parkway %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% pl[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% place %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% rd[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% road %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% st[,. ]%', LogEventDesc) > 0
		OR	PATINDEX('% street %', LogEventDesc) > 0
		)
	OR	(
			PATINDEX('% way %', LogEventDesc) > 0
		)
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