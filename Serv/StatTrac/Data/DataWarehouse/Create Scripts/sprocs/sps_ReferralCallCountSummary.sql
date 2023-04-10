SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_ReferralCallCountSummary]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_ReferralCallCountSummary];
GO

CREATE PROCEDURE sps_ReferralCallCountSummary
	@vReportGroupID		INT			= 0,
	@vStartDate			DATETIME	= NULL,
	@vEndDate			DATETIME	= NULL,
	@vOrgID				INT			= NULL,
	@vSourceCodeName 	VARCHAR(50)	= NULL

AS
/******************************************************************************
**		File: 
**		Name: sps_ReferralCallCountSummary
**		Desc: sql for billable account report...the triage part.
**			Built to replace sps_CallCountMessageSummary1
**
** 
**		Called by:   BillableCallCount report
**              
**
**		Auth: Bret Knoll
**		Date: 05/27/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		5/27/08		Bret Knoll			Initial to replace sps_CallCountMessageSummary1
*******************************************************************************/
BEGIN
	
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DECLARE
		@StartYear	INT = YEAR(@vStartDate),
		@StartMonth INT = MONTH(@vStartDate),
		@StartDay	INT = DAY(@vStartDate),
		@EndYear	INT = YEAR(@vEndDate),
		@EndMonth	INT = MONTH(@vEndDate),
		@EndDay		INT = DAY(@vEndDate);
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #Referral_CallCountSummary_Filtered;

	-- Load #SourceCodes
	SELECT SourceCodeId 
	INTO #SourceCodes
	FROM dbo.fnDataWarehousefn_SourceCodeList (@vReportGroupID, @vSourceCodeName);
	
	-- Load #Referral_CallCountSummary_Filtered
	SELECT rccs.*		
	INTO #Referral_CallCountSummary_Filtered
	FROM 
		Referral_CallCountSummary rccs
		INNER JOIN #SourceCodes SC ON rccs.SourceCodeID = SC.SourceCodeId
	WHERE
		(
			rccs.YearID > @StartYear
			OR (rccs.YearID = @StartYear AND rccs.MonthID > @StartMonth)
			OR (rccs.YearID = @StartYear AND rccs.MonthID = @StartMonth AND rccs.DayID >= @StartDay)
		)
		AND		
		(
			rccs.YearID < @EndYear
			OR (rccs.YearID = @EndYear AND rccs.MonthID < @EndMonth)
			OR (rccs.YearID = @EndYear AND rccs.MonthID = @EndMonth AND rccs.DayID <= @EndDay)
		)
		AND		
		(
			@vOrgID IS NULL 
			OR rccs.OrganizationID = @vOrgID
		);

	SELECT 		
		SUM(ISNULL(UnknownOTE, 0)) AS 'Unknown OTE', 
		SUM(ISNULL(UnknownTissue, 0)) AS 'Unknown Tissue', 
		SUM(ISNULL(UnknownTE, 0)) AS 'Unknown T/E', 
		SUM(ISNULL(UnknownEye, 0)) AS 'Unknown Eye', 

		SUM(ISNULL(UnknownAgeRO, 0) + ISNULL(UnknownMedRO, 0)) AS 'Unknown Total RO', 
		SUM(ISNULL(UnknownAgeRO, 0)) AS 'Unknown Age RO', 
		SUM(ISNULL(UnknownMedRO, 0)) AS 'Unknown Med RO', 
		SUM(ISNULL(UnknownOther, 0)) AS 'Unknown Other', 
		SUM(ISNULL(UnknownOtherEye, 0)) AS 'Unknown Other/Eye', 

		SUM(ISNULL(UnknownOTE, 0) + ISNULL(UnknownTE, 0) + ISNULL(UnknownEye, 0) + ISNULL(UnknownAgeRO, 0) + ISNULL(UnknownMedRO, 0)) AS 'Unknown Totals', 
		SUM(ISNULL(ConsentedOTE, 0)) AS 'Consented OTE', 
		SUM(ISNULL(ConsentedTissue, 0)) AS 'Consented Tissue', 
		SUM(ISNULL(ConsentedTE, 0)) AS 'Consented T/E', 
		SUM(ISNULL(ConsentedEye, 0)) AS 'Consented Eye', 
		SUM(ISNULL(ConsentedAgeRO, 0) + ISNULL(ConsentedMedRO, 0)) AS 'Consented Total RO', 
		SUM(ISNULL(ConsentedAgeRO, 0)) AS 'Consented Age RO', 
		SUM(ISNULL(ConsentedMedRO, 0)) AS 'Consented Med RO', 
		SUM(ISNULL(ConsentedOther, 0)) AS 'Consented Other', 
		SUM(ISNULL(ConsentedOtherEye, 0)) AS 'Consented Other/Eye', 

		SUM(ISNULL(ConsentedOTE, 0) + ISNULL(ConsentedTE, 0) + ISNULL(ConsentedEye, 0) + ISNULL(ConsentedAgeRO, 0) + ISNULL(ConsentedMedRO , 0)) AS 'Consented Totals', 
		SUM(ISNULL(DeniedOTE, 0)) AS 'Denied OTE', 
		SUM(ISNULL(DeniedTissue, 0)) AS 'Denied Tissue', 
		SUM(ISNULL(DeniedTE, 0)) AS 'Denied T/E', 
		SUM(ISNULL(DeniedEye, 0)) AS 'Denied Eye', 
		SUM(ISNULL(DeniedAgeRO, 0) + ISNULL(DeniedMedRO, 0)) AS 'Denied Total RO', 
		SUM(ISNULL(DeniedAgeRO, 0)) AS 'Denied Age RO', 
		SUM(ISNULL(DeniedMedRO, 0)) AS 'Denied Med RO', 
		SUM(ISNULL(DeniedOther, 0)) AS 'Denied Other', 
		SUM(ISNULL(DeniedOtherEye, 0)) AS 'Denied Other/Eye', 

		SUM(ISNULL(DeniedOTE, 0) + ISNULL(DeniedTE, 0) + ISNULL(DeniedEye, 0) + ISNULL(DeniedAgeRO, 0) + ISNULL(DeniedMedRO, 0)) AS 'Denied Totals', 
		SUM(ISNULL(NotApprchOTE, 0)) AS 'Not Approached OTE', 
		SUM(ISNULL(NotApprchTissue, 0)) AS 'Not Approached Tissue', 
		SUM(ISNULL(NotApprchTE, 0)) AS 'Not Approached T/E', 
		SUM(ISNULL(NotApprchEye, 0)) AS 'Not Approached Eye', 
		SUM(ISNULL(NotApprchAgeRO, 0) + ISNULL(NotApprchMedRO, 0)) AS 'Not Approached Total RO', 
		SUM(ISNULL(NotApprchAgeRO, 0)) AS 'Not Approached Age RO', 
		SUM(ISNULL(NotApprchMedRO, 0)) AS 'Not Approached Med RO', 
		SUM(ISNULL(NotApprchOther, 0)) AS 'Not Approached Other', 
		SUM(ISNULL(NotApprchOtherEye, 0)) AS 'Not Approached Other/Eye', 

		SUM(ISNULL(NotApprchOTE, 0) + ISNULL(NotApprchTE, 0) + ISNULL(NotApprchEye, 0) + ISNULL(NotApprchAgeRO, 0) + ISNULL(NotApprchMedRO , 0)) AS 'Not Approached Totals', 
		SUM(ISNULL(TotOTE, 0)) AS 'Total Referrals OTE',
		SUM(ISNULL(TotTissue, 0)) AS 'Total Referrals Tissue',
		SUM(ISNULL(TotTE, 0)) AS 'Total Referrals T/E',
		SUM(ISNULL(TotEye, 0)) AS 'Total Referrals Eye',
		SUM(ISNULL(TotRO, 0)) AS 'Total Referrals Total RO',
		SUM(ISNULL(TotAgeRO, 0)) AS 'Total Referrals Age RO',
		SUM(ISNULL(TotMedRO, 0)) AS 'Total Referrals Med RO',
		SUM(ISNULL(TotOther, 0)) AS 'Total Referrals Other',
		SUM(ISNULL(TotOtherEye, 0)) AS 'Total Other/Eye',
			
		SUM(ISNULL(TotOTE, 0) + ISNULL(TotTissue, 0) + ISNULL(TotTE, 0) + ISNULL(TotEye, 0) + ISNULL(TotAgeRO, 0) + ISNULL(TotMedRO, 0) + ISNULL(TotOther, 0) + ISNULL(TotOtherEye , 0)) AS 'Total Referrals Totals',
		ISNULL(sc.SourceCodeName, '') AS 'SourceName'
	
	FROM 		
		#Referral_CallCountSummary_Filtered AS Referral_CallCountSummary
		JOIN		vwDataWarehouseWebReportGroupOrg ON vwDataWarehouseWebReportGroupOrg.OrganizationID = Referral_CallCountSummary.OrganizationID
		JOIN		vwDataWarehouseSourceCode sc ON sc.SourceCodeID = Referral_CallCountSummary.SourceCodeID
	WHERE 		vwDataWarehouseWebReportGroupOrg.WebReportGroupID = @vReportGroupID
	GROUP BY	
		sc.SourceCodeName;
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #Referral_CallCountSummary_Filtered;

END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO