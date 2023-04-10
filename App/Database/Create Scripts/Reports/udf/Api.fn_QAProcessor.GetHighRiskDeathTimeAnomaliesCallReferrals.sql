IF OBJECT_ID('Api.[fn_QAProcessor.GetHighRiskDeathTimeAnomaliesCallReferrals]') IS NOT NULL 
DROP FUNCTION Api.[fn_QAProcessor.GetHighRiskDeathTimeAnomaliesCallReferrals];
GO

CREATE FUNCTION Api.[fn_QAProcessor.GetHighRiskDeathTimeAnomaliesCallReferrals]
(
	@StartDate	datetime,
	@EndDate	datetime
)
RETURNS @IDs TABLE
(
	ReferralID	int,
	LogeEventID	int
)
AS
BEGIN

DECLARE @Calls TABLE
(
	CallID			int,
	ReferralID		int,
	LastModified	datetime
);
DECLARE @Referrals TABLE
(
	CallID			int,
	ReferralID		int,
	HoursDifference	decimal(8,2)
);

INSERT @Calls
	SELECT DISTINCT
		CallID,
		ReferralID,
		LastModified
	FROM _ReferralAuditTrail.dbo.Referral
	WHERE
		LastModified >= @StartDate
	AND	LastModified < @EndDate
	AND	ReferralDonorDeathTime IS NOT NULL;

INSERT @Referrals
	SELECT
		r.CallID,
		r.ReferralID,
		CONVERT(decimal(8,2), DATEDIFF(MINUTE, CONVERT(smalldatetime, CONVERT(char(10), atr.ReferralDonorDeathDate, 101) + ' ' + LEFT(atr.ReferralDonorDeathTime, 5), 120), _ReferralAuditTrail.dbo.AuditTrailfn_rpt_ConvertDateTime(atr.ReferralCallerOrganizationID, r.LastModified, 0))/60.00) AS HoursDifference
	FROM
		@Calls r
		INNER JOIN _ReferralAuditTrail.dbo.vwAuditTrailReferral atr
		ON r.CallID = atr.CallID;

INSERT @IDs
	SELECT
		ReferralID,
		evnt.LogEventID
	FROM @Referrals r
		INNER JOIN _ReferralProdReport.dbo.[Call] c
				INNER JOIN _ReferralProdReport.dbo.SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
				INNER JOIN _ReferralProdReport.dbo.LogEvent evnt ON c.CallID = evnt.CallID
																AND	(evnt.LogEventTypeID = 2 OR evnt.LogEventTypeID = 24) --Incoming Call or Case Update

			ON r.CallID = c.CallID
	WHERE
		(
			HoursDifference >= 6.00
		OR	HoursDifference < 0
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

RETURN
END
	
GO