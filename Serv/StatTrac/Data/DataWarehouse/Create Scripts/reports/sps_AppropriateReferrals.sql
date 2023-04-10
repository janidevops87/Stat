IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'sps_AppropriateReferrals')
BEGIN
	PRINT 'Dropping Procedure sps_AppropriateReferrals';
	DROP PROCEDURE sps_AppropriateReferrals;
END
GO

PRINT 'Creating Procedure sps_AppropriateReferrals';
GO

CREATE PROCEDURE sps_AppropriateReferrals
(
	@ReportGroupID 	int,
	@OrganizationID	int,
	@StartMonth		int,
	@StartYear		int,
	@EndMonth		int,
	@EndYear		int
)
AS

/******************************************************************************
**		File: sps_AppropriateReferrals.sql
**		Name: sps_AppropriateReferrals
**		Desc: Returns referral counts of Appropriate Organ/Tissue categories
**
**
**		Return values:
**
**		Called by:   AppropriateReferrals.rdl
**
**		Auth: Unknown
**		Date: Unknown
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-----------------------------------
**		12/10/2020		James Gerberich		Eliminated Unit breakdown. TFS 71354
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

--DECLARE
--	@ReportGroupID	int	= 36,
--	@OrganizationID	int	= NULL,
--	@StartMonth		int	= 11,
--	@StartYear		int	= 2020,
--	@EndMonth		int	= 11,
--	@EndYear		int	= 2020
----------------------------------------------------------------

SELECT
	sumCnt.OrganizationID,
	org.OrganizationName,
	SUM(sumCnt.AllTypes) AS TotalReferrals,
	SUM(sumCnt.AppropriateOrgan) AS AppropriateOrgan,
	SUM(sumCnt.AppropriateAllTissue) AS AppropriateAllTissue,
	SUM(sumCnt.AppropriateEyes) AS AppropriateEyes,
	SUM(sumCnt.AppropriateRO) AS AppropriateRO
FROM
	Referral_UnitSummaryCount sumCnt
    JOIN _ReferralProdReport.dbo.Organization org ON org.OrganizationID = sumCnt.OrganizationID
	JOIN _ReferralProdReport.dbo.WebReportGroupOrg rgo ON rgo.OrganizationID = org.OrganizationID
WHERE
	rgo.WebReportGroupID = @ReportGroupID
AND	(
		@OrganizationID IS NULL
	OR	org.OrganizationID = @OrganizationID
	)
AND (
		sumCnt.YearID > @StartYear
	OR	(
			sumCnt.YearID = @StartYear
		AND	sumCnt.MonthID >= @StartMonth
		)
	)
AND (
		sumCnt.YearID < @EndYear
	OR	(
			sumCnt.YearID = @EndYear
		AND	sumCnt.MonthID <= @EndMonth
		)
	)
GROUP BY
	sumCnt.OrganizationID,
	org.OrganizationName
ORDER BY
	OrganizationName;