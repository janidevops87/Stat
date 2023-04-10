IF OBJECT_ID('Api.[fn_QAProcessor.GetHighRiskCancerCallReferrals]') IS NOT NULL 
DROP FUNCTION Api.[fn_QAProcessor.GetHighRiskCancerCallReferrals];
GO

CREATE FUNCTION Api.[fn_QAProcessor.GetHighRiskCancerCallReferrals]
(
	@StartDate datetime,
	@EndDate datetime
)
RETURNS TABLE
AS

RETURN(

SELECT
	ref.ReferralID,
	evnt.LogEventID
FROM
	dbo.[Call] c
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
	INNER JOIN dbo.LogEvent evnt ON c.CallID = evnt.CallID AND evnt.LogEventNumber = 1 -- First event is creating referral (Incoming Call)
	INNER JOIN dbo.Referral ref
			INNER JOIN dbo.CauseOfDeath cod ON ref.ReferralDonorCauseOfDeathID = cod.CauseOfDeathID AND cod.CauseOfDeathName = 'Cancer'
		ON c.CallID = ref.CallID
WHERE
	c.CallDateTime >= @StartDate
AND c.CallDateTime <= @EndDate
AND	(-- exlcude transplant source codes
		PATINDEX('CASF[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('CASJ[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('COPM[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('COSL[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('CPMC[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('MIUM[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('OHCC[A-Z][A-Z]', sc.SourceCodeName) = 0
	AND	PATINDEX('PATJ[A-Z][A-Z]', sc.SourceCodeName) = 0
	--Cancer not documented in the medical history
	AND	PATINDEX('% CA %', ref.ReferralNotesCase) = 0
	AND	PATINDEX('CA %', ref.ReferralNotesCase) = 0
	AND	PATINDEX('% CA', ref.ReferralNotesCase) = 0
	AND	PATINDEX('% CA%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('CA', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Lymphoma%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Leukemia%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Glioblastoma%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('% Mets %', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Melanoma%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Sarcoma%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Myeloma%', ref.ReferralNotesCase) = 0
	AND	PATINDEX('%Carcinoma%', ref.ReferralNotesCase) = 0
	));
	
GO