IF OBJECT_ID('Api.[fn_QAProcessor.GetHighRiskVentedHeartBeatCallReferrals]') IS NOT NULL 
DROP FUNCTION Api.[fn_QAProcessor.GetHighRiskVentedHeartBeatCallReferrals];
GO

CREATE FUNCTION Api.[fn_QAProcessor.GetHighRiskVentedHeartBeatCallReferrals]
(
	@StartDate datetime,
	@EndDate datetime
)
RETURNS TABLE
AS

RETURN(

SELECT DISTINCT
	r.ReferralID,
	evnt.LogEventID
FROM
	dbo.[Call] c
	INNER JOIN dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
	INNER JOIN dbo.LogEvent evnt ON c.CallID = evnt.CallID AND evnt.LogEventNumber = 1 -- First event is creating referral (Incoming Call)
	INNER JOIN dbo.Referral r
			LEFT JOIN dbo.Organization refFac ON r.ReferralCallerOrganizationID = refFac.OrganizationID
			LEFT JOIN dbo.SubLocation unit ON r.ReferralCallerSubLocationID = unit.SubLocationID
		ON c.CallID = r.CallID
WHERE
	c.CallDateTime >= @StartDate
AND	c.CallDateTime <= @EndDate
AND	r.ReferralDonorHeartBeat = 1 -- Yes
AND	(
		r.ReferralDonorOnVentilator = 'Never'
	OR	r.ReferralDonorOnVentilator = 'Previously'
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