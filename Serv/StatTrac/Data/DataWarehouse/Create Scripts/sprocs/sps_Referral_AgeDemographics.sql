SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_Referral_AgeDemographics]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[sps_Referral_AgeDemographics];
GO


CREATE PROCEDURE sps_Referral_AgeDemographics

	@ReportGroupID	INT,
	@OrganizationID	INT = NULL,
	@StartMonth		INT,
	@StartYear		INT,
	@EndMonth		INT,
	@EndYear		INT

AS
/******************************************************************************
**		File: sps_Referral_AgeDemographics.sql
**		Name: sps_Referral_AgeDemographics
**		Desc: Returns detail & summary data for the Age Demographics report
**
**              
**		Return values:
** 
**		Called by:   'AgeDemographics.rdl'
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: Mike Berenson
**		Date: 9/1/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      
**		
*******************************************************************************/
BEGIN
	SET NOCOUNT ON;

	DROP TABLE IF EXISTS #AgeRangeGenderRows;
	DROP TABLE IF EXISTS #AgeRangeGenderDetails;
	DROP TABLE IF EXISTS #GenderAverages;
	DROP TABLE IF EXISTS #GenderTotals;

	-- Load #AgeRangeGenderRows
	SELECT AgeRangeID, AgeRangeName, 'M' AS DonorGender
	INTO #AgeRangeGenderRows
	FROM AgeRange
	UNION ALL
	SELECT 101, 'Totals', 'M'
	UNION ALL
	SELECT 102, 'Average', 'M'
	UNION ALL
	SELECT AgeRangeID, AgeRangeName, 'F' AS DonorGender
	FROM AgeRange
	UNION ALL
	SELECT 103, 'Totals', 'F'
	UNION ALL
	SELECT 104, 'Average', 'F';

	-- Load #AgeRangeGenderDetails
	SELECT 		
		adc.AgeRangeID,
		adc.DonorGender,
		SUM(ISNULL(adc.AllTypes, 0))				AS 'AllTypes',
		SUM(ISNULL(adc.AppropriateOrgan, 0))		AS 'Organs', 
		SUM(ISNULL(adc.AppropriateAllTissue, 0))	AS 'Tissues',
		SUM(ISNULL(adc.AppropriateEyes, 0))			AS 'Eyes',  
		SUM(ISNULL(adc.AppropriateRO, 0))			AS 'RuleOuts'
	INTO #AgeRangeGenderDetails
	FROM 		
		Referral_AgeDemoCount adc
		JOIN _ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = adc.SourceCodeID
		JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode rgsc ON rgsc.SourceCodeID = sc.SourceCodeID
		JOIN _ReferralProdReport.dbo.WebReportGroupOrg rgo ON rgo.OrganizationID = adc.OrganizationID
	WHERE
		rgsc.WebReportGroupID = @ReportGroupID
		AND	rgo.WebReportGroupID = @ReportGroupID	
		AND (
				(adc.YearID > @StartYear)
				OR (adc.YearID = @StartYear AND adc.MonthID >= @StartMonth)
			)
		AND (
				(adc.YearID < @EndYear)
				OR (adc.YearID = @EndYear AND adc.MonthID <= @EndMonth)
			)	
		AND	(@OrganizationID IS NULL OR adc.OrganizationID = @OrganizationID)
	GROUP BY 
		adc.AgeRangeID,
		adc.DonorGender;
	
	-- Load #GenderTotals
	SELECT
		DonorGender,
		SUM(ISNULL(AllTypes, 0))	AS 'AllTypes',
		SUM(ISNULL(Organs, 0))		AS 'Organs', 
		SUM(ISNULL(Tissues, 0))		AS 'Tissues',
		SUM(ISNULL(Eyes, 0))		AS 'Eyes',  
		SUM(ISNULL(Ruleouts, 0))	AS 'RuleOuts'
	INTO #GenderTotals
	FROM 
		#AgeRangeGenderDetails
	GROUP BY 
		DonorGender;

	-- Load #GenderAverages
	SELECT 	        
		aac.DonorGender,
		AVG(aac.AllTypesAge)				AS 'AllTypes',
		AVG(aac.AppropriateOrganAge)		AS 'Organs',
		AVG(aac.AppropriateAllTissueAge)	AS 'Tissues',
		AVG(aac.AppropriateEyesAge)			AS 'Eyes',
		AVG(aac.AppropriateROAge)			AS 'RuleOuts'
	INTO #GenderAverages
	FROM 		
		Referral_AverageAgeCount aac
		JOIN _ReferralProdReport.dbo.SourceCode sc ON sc.SourceCodeID = aac.SourceCodeID
		JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode rgsc ON rgsc.SourceCodeID = sc.SourceCodeID
		JOIN _ReferralProdReport.dbo.WebReportGroupOrg rgo ON rgo.OrganizationID = aac.OrganizationID
	WHERE
		rgsc.WebReportGroupID = @ReportGroupID
		AND	rgo.WebReportGroupID = @ReportGroupID
		AND	(@OrganizationID IS NULL OR aac.OrganizationID = @OrganizationID)		
		AND (
				(aac.YearID > @StartYear)
				OR (aac.YearID = @StartYear AND aac.MonthID >= @StartMonth)
			)
		AND (
				(aac.YearID < @EndYear)
				OR (aac.YearID = @EndYear AND aac.MonthID <= @EndMonth)
			)	
	GROUP BY
		aac.DonorGender;

	-- Run final select
	SELECT
		ROW_NUMBER() OVER(ORDER BY argr.DonorGender DESC, argr.AgeRangeID) AS SortOrder,
		argr.AgeRangeID,
		argr.AgeRangeName,
		argr.DonorGender,	
		CASE argr.AgeRangeName WHEN 'Average' THEN av.AllTypes	WHEN 'Totals' THEN ttl.AllTypes	ELSE ISNULL(dtl.AllTypes, 0)	END AS TotalReferrals,
		CASE argr.AgeRangeName WHEN 'Average' THEN av.Organs	WHEN 'Totals' THEN ttl.Organs	ELSE ISNULL(dtl.Organs, 0)		END AS Organs,
		CASE argr.AgeRangeName WHEN 'Average' THEN av.Tissues	WHEN 'Totals' THEN ttl.Tissues	ELSE ISNULL(dtl.Tissues, 0)		END AS Tissues,
		CASE argr.AgeRangeName WHEN 'Average' THEN av.Eyes		WHEN 'Totals' THEN ttl.Eyes		ELSE ISNULL(dtl.Eyes, 0)		END AS Eyes,
		CASE argr.AgeRangeName WHEN 'Average' THEN av.RuleOuts	WHEN 'Totals' THEN ttl.RuleOuts	ELSE ISNULL(dtl.RuleOuts, 0)	END AS RuleOuts
	FROM
		#AgeRangeGenderRows argr
		LEFT JOIN #GenderAverages av ON av.DonorGender = argr.DonorGender
		LEFT JOIN #GenderTotals ttl ON ttl.DonorGender = argr.DonorGender
		LEFT JOIN #AgeRangeGenderDetails dtl ON dtl.AgeRangeID = argr.AgeRangeID AND dtl.DonorGender = argr.DonorGender;
	
	DROP TABLE IF EXISTS #AgeRangeGenderRows;
	DROP TABLE IF EXISTS #AgeRangeGenderDetails;
	DROP TABLE IF EXISTS #GenderAverages;
	DROP TABLE IF EXISTS #GenderTotals;

END
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

