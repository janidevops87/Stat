IF OBJECT_ID('[Api].[sps_QAProcessor.GetHighRiskCallReferrals]', 'P') IS NOT NULL
	DROP PROCEDURE [Api].[sps_QAProcessor.GetHighRiskCallReferrals];
GO

CREATE PROCEDURE [Api].[sps_QAProcessor.GetHighRiskCallReferrals]
	@StartDate datetime,
	@EndDate datetime
AS

 /******************************************************************************
 ** File: Api.sps_QAProcessor.GetHighRiskCallReferrals.sql 
 ** Name: sps_QAProcessor.GetHighRiskCallReferrals
 ** Desc: For a given time range returns list of risky referrals.
 ** Auth: Andrey Savin
 ** Date: 7/15/2021
 ** Called By: StatTrac API
 *******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET NOCOUNT ON;

SELECT *, 'Cancer' AS RiskType FROM [Api].[fn_QAProcessor.GetHighRiskCancerCallReferrals](@StartDate, @EndDate)
UNION
SELECT *, 'FacilityAddedInMedHx' AS RiskType  FROM [Api].[fn_QAProcessor.GetHighRiskFacilityAddedInMedHxCallReferrals](@StartDate, @EndDate)
UNION
SELECT *, 'DeathTimeAnomalies' AS RiskType  FROM [Api].[fn_QAProcessor.GetHighRiskDeathTimeAnomaliesCallReferrals](@StartDate, @EndDate)
UNION
SELECT *, 'WithCrossClampNotes' AS RiskType  FROM [Api].[fn_QAProcessor.GetHighRiskWithCrossClampNotesCallReferrals](@StartDate, @EndDate)
UNION
SELECT *, 'VentedHeartBeat' AS RiskType  FROM [Api].[fn_QAProcessor.GetHighRiskVentedHeartBeatCallReferrals](@StartDate, @EndDate);

GO