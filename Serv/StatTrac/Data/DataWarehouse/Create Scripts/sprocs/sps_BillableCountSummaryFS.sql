SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_BillableCountSummaryFS]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_BillableCountSummaryFS];
GO

CREATE PROCEDURE sps_BillableCountSummaryFS
	@vReportGroupID		INT,
	@vStartDate			DATETIME,
	@vEndDate			DATETIME,
	@vOrgID				INT			= NULL,
	@vSourceCodeName 	VARCHAR(50)	= NULL

AS
/******************************************************************************
**		File: 
**		Name: sps_BillableCountSummaryFS
**		Desc: this is a newer version for the billable report...returns data for that report from table Referral_FSCallCountSummary
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   BillableCountSummary.rdl
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: jth
**		Date: 3/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      11/09/2006		ccarroll			Added FSCaseBillOTE for billing OTE Screening
**		10/13/2020		Mike Berenson		Created a new version so I could drop parameter (SourceCodeID)
**												original filename: sps_FSCallCountSummary_A3.sql
**
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
	DROP TABLE IF EXISTS #BillableCountSummaryFS_Filtered;

	-- Load #SourceCodes
	SELECT SourceCodeId 
	INTO #SourceCodes
	FROM fnDataWarehousefn_SourceCodeList(@vReportGroupID, @vSourceCodeName);
	
	-- Load #Referral_FSCallCountSummary_Filtered
	SELECT rfccs.*		
	INTO #BillableCountSummaryFS_Filtered
	FROM 
		Referral_FSCallCountSummary rfccs
		INNER JOIN #SourceCodes SC ON rfccs.SourceCodeID = SC.SourceCodeId
	WHERE
		(
			rfccs.YearID > @StartYear
			OR (rfccs.YearID = @StartYear AND rfccs.MonthID > @StartMonth)
			OR (rfccs.YearID = @StartYear AND rfccs.MonthID = @StartMonth AND rfccs.DayID >= @StartDay)
		)
		AND		
		(
			rfccs.YearID < @EndYear
			OR (rfccs.YearID = @EndYear AND rfccs.MonthID < @EndMonth)
			OR (rfccs.YearID = @EndYear AND rfccs.MonthID = @EndMonth AND rfccs.DayID <= @EndDay)
		)
		AND		
		(
			@vOrgID IS NULL 
			OR rfccs.OrganizationID = @vOrgID
		);

	-- Run final select
    SELECT 
    	SUM(ISNULL(SecondaryOTE, 0)) AS 'Secondary OTE', 
		SUM(ISNULL(SecondaryTissue, 0)) AS 'Secondary Tissue', 
		SUM(ISNULL(SecondaryTE, 0)) AS 'Secondary T/E', 
		SUM(ISNULL(SecondaryEye, 0)) AS 'Secondary Eye', 
		SUM(ISNULL(SecondaryROTotal, 0)) AS 'Secondary Total RO', 
		SUM(ISNULL(SecondaryAgeRO, 0)) AS 'Secondary Age RO', 
		SUM(ISNULL(SecondaryMedRO, 0)) AS 'Secondary Med RO', 
		SUM(ISNULL(SecondaryOther, 0)) AS 'Secondary Other', 
		SUM(ISNULL(SecondaryOtherEye, 0)) AS 'Secondary Other Eye', 
		SUM(ISNULL(SecondaryOTE, 0) + ISNULL(SecondaryTissue, 0) + ISNULL(SecondaryTE, 0) + ISNULL(SecondaryEye, 0) + ISNULL(SecondaryROTotal, 0) + ISNULL(SecondaryOther, 0) + ISNULL(SecondaryOtherEye, 0)) AS 'Secondary Totals', 
			
		SUM(ISNULL(FamilyApproachOTE, 0)) AS 'FamilyApproach OTE', 
		SUM(ISNULL(FamilyApproachTissue, 0)) AS 'FamilyApproach Tissue', 
		SUM(ISNULL(FamilyApproachTE, 0)) AS 'FamilyApproach T/E', 
		SUM(ISNULL(FamilyApproachEye, 0)) AS 'FamilyApproach Eye', 
		SUM(ISNULL(FamilyApproachROTotal, 0)) AS 'Total FamilyApproach RO', 
		SUM(ISNULL(FamilyApproachAgeRO, 0)) AS 'FamilyApproach Age RO', 
		SUM(ISNULL(FamilyApproachMedRO, 0)) AS 'FamilyApproach Med RO', 
		SUM(ISNULL(FamilyApproachOther, 0)) AS 'FamilyApproach Other', 
		SUM(ISNULL(FamilyApproachOtherEye, 0)) AS 'FamilyApproach Other Eye', 
		SUM(ISNULL(FamilyApproachOTE, 0) + ISNULL(FamilyApproachTissue, 0) + ISNULL(FamilyApproachTE, 0) + ISNULL(FamilyApproachEye, 0) + ISNULL(FamilyApproachROTotal, 0) + ISNULL(FamilyApproachOther, 0) + ISNULL(FamilyApproachOtherEye, 0)) AS 'FamilyApproach Totals', 
			
		SUM(ISNULL(MedSocOTE, 0)) AS 'MedSoc OTE', 
		SUM(ISNULL(MedSocTissue, 0)) AS 'MedSoc Tissue', 
		SUM(ISNULL(MedSocTE, 0)) AS 'MedSoc TE', 
		SUM(ISNULL(MedSocEye, 0)) AS 'MedSoc Eye', 
		SUM(ISNULL(MedSocROTotal, 0)) AS 'MedSoc Total RO', 
		SUM(ISNULL(MedSocAgeRO, 0)) AS 'MedSoc Age RO', 
		SUM(ISNULL(MedSocMedRO, 0)) AS 'MedSoc Med RO', 
		SUM(ISNULL(MedSocOther, 0)) AS 'MedSoc Other', 
		SUM(ISNULL(MedSocOtherEye, 0)) AS 'MedSoc Other Eye', 
		SUM(ISNULL(MedSocOTE, 0) + ISNULL(MedSocTissue, 0) + ISNULL(MedSocTE, 0) + ISNULL(MedSocEye, 0) + ISNULL(MedSocROTotal, 0) + ISNULL(MedSocOther, 0) + ISNULL(MedSocOtherEye, 0)) AS 'MedSoc Totals',

		SUM(ISNULL(FamilyUnavailableOTE, 0)) AS 'FamilyUnavailable OTE', 
		SUM(ISNULL(FamilyUnavailableTissue, 0)) AS 'FamilyUnavailable Tissue', 
		SUM(ISNULL(FamilyUnavailableTE, 0)) AS 'FamilyUnavailable T/E', 
		SUM(ISNULL(FamilyUnavailableEye, 0)) AS 'FamilyUnavailable Eye', 
		SUM(ISNULL(FamilyUnavailableROTotal, 0)) AS 'Total FamilyUnavailable RO', 
		SUM(ISNULL(FamilyUnavailableAgeRO, 0)) AS 'FamilyUnavailable Age RO', 
		SUM(ISNULL(FamilyUnavailableMedRO, 0)) AS 'FamilyUnavailable Med RO', 
		SUM(ISNULL(FamilyUnavailableOther, 0)) AS 'FamilyUnavailable Other', 
		SUM(ISNULL(FamilyUnavailableOtherEye, 0)) AS 'FamilyUnavailable Other Eye', 
		SUM(ISNULL(FamilyUnavailableOTE, 0) + ISNULL(FamilyUnavailableTissue, 0) + ISNULL(FamilyUnavailableTE, 0) + ISNULL(FamilyUnavailableEye, 0) + ISNULL(FamilyUnavailableROTotal, 0) + ISNULL(FamilyUnavailableOther, 0) + ISNULL(FamilyUnavailableOtherEye, 0)) AS 'FamilyUnavailable Totals',

		SUM(ISNULL(CryolifeFormOTE, 0)) AS 'CryolifeForm OTE', 
		SUM(ISNULL(CryolifeFormTissue, 0)) AS 'CryolifeForm Tissue', 
		SUM(ISNULL(CryolifeFormTE, 0)) AS 'CryolifeForm T/E', 
		SUM(ISNULL(CryolifeFormEye, 0)) AS 'CryolifeForm Eye', 
		SUM(ISNULL(CryolifeFormROTotal, 0)) AS 'Total CryolifeForm RO', 
		SUM(ISNULL(CryolifeFormAgeRO, 0)) AS 'CryolifeForm Age RO', 
		SUM(ISNULL(CryolifeFormMedRO, 0)) AS 'CryolifeForm Med RO', 
		SUM(ISNULL(CryolifeFormOther, 0)) AS 'CryolifeForm Other', 
		SUM(ISNULL(CryolifeFormOtherEye, 0)) AS 'CryolifeForm Other Eye', 
		SUM(ISNULL(CryolifeFormOTE, 0) + ISNULL(CryolifeFormTissue, 0) + ISNULL(CryolifeFormTE, 0) + ISNULL(CryolifeFormEye, 0) + ISNULL(CryolifeFormROTotal, 0) + ISNULL(CryolifeFormOther, 0) + ISNULL(CryolifeFormOtherEye, 0)) AS 'CryolifeForm Totals',

		SUM(ISNULL(FamilyApproachOTECount, 0)) AS 'FamilyApproach OTE Count', 
		SUM(ISNULL(FamilyApproachTissueCount, 0)) AS 'FamilyApproach Tissue Count', 
		SUM(ISNULL(FamilyApproachTECount, 0)) AS 'FamilyApproach T/E Count', 
		SUM(ISNULL(FamilyApproachEyeCount, 0)) AS 'FamilyApproach Eye Count', 
		SUM(ISNULL(FamilyApproachROCountTotal, 0)) AS 'Total FamilyApproach RO Count', 
		SUM(ISNULL(FamilyApproachAgeROCount, 0)) AS 'FamilyApproach Age RO Count', 
		SUM(ISNULL(FamilyApproachMedROCount, 0)) AS 'FamilyApproach Med RO Count', 
		SUM(ISNULL(FamilyApproachOtherCount, 0)) AS 'FamilyApproach Other Count', 
		SUM(ISNULL(FamilyApproachOtherEyeCount, 0)) AS 'FamilyApproach Other Eye Count', 
		SUM(ISNULL(FamilyApproachOTECount, 0) + ISNULL(FamilyApproachTissueCount, 0) + ISNULL(FamilyApproachTECount, 0) + ISNULL(FamilyApproachEyeCount, 0) + ISNULL(FamilyApproachROCountTotal, 0) + ISNULL(FamilyApproachOtherCount, 0) + ISNULL(FamilyApproachOtherEyeCount, 0)) AS 'FamilyApproach Totals Count',

		SUM(ISNULL(MedSocOTECount, 0)) AS 'MedSoc OTE Count', 
		SUM(ISNULL(MedSocTissueCount, 0)) AS 'MedSoc Tissue Count', 
		SUM(ISNULL(MedSocTECount, 0)) AS 'MedSoc TE Count', 
		SUM(ISNULL(MedSocEyeCount, 0)) AS 'MedSoc Eye Count', 
		SUM(ISNULL(MedSocROCountTotal, 0)) AS 'MedSoc Total RO Count', 
		SUM(ISNULL(MedSocAgeROCount, 0)) AS 'MedSoc Age RO Count', 
		SUM(ISNULL(MedSocMedROCount, 0)) AS 'MedSoc Med RO Count', 
		SUM(ISNULL(MedSocOtherCount, 0)) AS 'MedSoc Other Count', 
		SUM(ISNULL(MedSocOtherEyeCount, 0)) AS 'MedSoc Other Eye Count', 
		SUM(ISNULL(MedSocOTECount, 0) + ISNULL(MedSocTissueCount, 0) + ISNULL(MedSocTECount, 0) + ISNULL(MedSocEyeCount, 0) + ISNULL(MedSocROCountTotal, 0) + ISNULL(MedSocOtherCount, 0) + ISNULL(MedSocOtherEyeCount, 0)) AS 'MedSoc Totals Count',
			
		SUM(ISNULL(CryolifeFormOTECount, 0)) AS 'CryolifeForm OTE Count', 
		SUM(ISNULL(CryolifeFormTissueCount, 0)) AS 'CryolifeForm Tissue Count', 
		SUM(ISNULL(CryolifeFormTECount, 0)) AS 'CryolifeForm T/E Count', 
		SUM(ISNULL(CryolifeFormEyeCount, 0)) AS 'CryolifeForm Eye Count', 
		SUM(ISNULL(CryolifeFormROCountTotal, 0)) AS 'Total CryolifeForm RO Count', 
		SUM(ISNULL(CryolifeFormAgeROCount, 0)) AS 'CryolifeForm Age RO Count', 
		SUM(ISNULL(CryolifeFormMedROCount, 0)) AS 'CryolifeForm Med RO Count', 
		SUM(ISNULL(CryolifeFormOtherCount, 0)) AS 'CryolifeForm Other Count', 
		SUM(ISNULL(CryolifeFormOtherEyeCount, 0)) AS 'CryolifeForm Other Eye Count', 
		SUM(ISNULL(CryolifeFormOTECount, 0) + ISNULL(CryolifeFormTissueCount, 0) + ISNULL(CryolifeFormTECount, 0) + ISNULL(CryolifeFormEyeCount, 0) + ISNULL(CryolifeFormROCountTotal, 0) + ISNULL(CryolifeFormOtherCount, 0) + ISNULL(CryolifeFormOtherEyeCount, 0)) AS 'CryolifeForm Totals Count',

		SUM(ISNULL(FSCaseBillOTE, 0)) AS 'FSCaseBillOTE',
		sc.SourceCodeName AS 'SourceName' 

    FROM 		
		#BillableCountSummaryFS_Filtered AS bcs
		JOIN		vwDataWarehouseWebReportGroupOrg wrgo ON wrgo.OrganizationID = bcs.OrganizationID
		JOIN		vwDataWarehouseSourceCode sc ON sc.SourceCodeID = bcs.SourceCodeID

   	WHERE 		wrgo.WebReportGroupID = @vReportGroupID
	GROUP BY sc.SourceCodeName;
	
	DROP TABLE IF EXISTS #SourceCodes;
	DROP TABLE IF EXISTS #BillableCountSummaryFS_Filtered;

END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

