SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE ID = Object_Id(N'[dbo].[sps_Referral_CMSReport]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure sps_Referral_CMSReport'
		DROP Procedure [dbo].[sps_Referral_CMSReport]
	END
GO

PRINT 'Creating Procedure sps_Referral_CMSReport'
GO

CREATE PROCEDURE [dbo].[sps_Referral_CMSReport]
	@vReportGroupID		int			= 0,
	@vStartDate			datetime	= null,
	@vEndDate			datetime	= null,
	@vOrgID				int			= 0

AS

DECLARE @SourceCodeList varchar(50)		--drh 09/26/03

--Create the temp table
CREATE TABLE #_Temp_CMSReport
	(
		YearID					Int NULL DEFAULT (0),
		MonthID					Int NULL DEFAULT (0),
		MonthYear				VarChar(14) NULL DEFAULT (0),
		OrganizationID			Int NOT NULL ,
		OrganizationName		VarChar(80) NOT NULL,
		Deaths					Int NULL DEFAULT (0),
		DeathsReported			Int NULL DEFAULT (0),
		Approached				Int NULL DEFAULT (0),
		Approached_NonDR		Int NULL DEFAULT (0),
		BDMSuitable				Int NULL DEFAULT (0),
		VentedNotification		Int NULL DEFAULT (0),
		Referral_CT				Int NULL DEFAULT (0),
		Approach_Organ_CT		Int NULL DEFAULT (0),
		Consent_Organ_CT		Int NULL DEFAULT (0),
		Recovery_Organ_CT		Int NULL DEFAULT (0),
		Recovery_Organ_All_CT	Int NULL DEFAULT (0)
	)

--Clean temp tables
DELETE #_Temp_CMSReport

--drh 09/26/03 Get the SourceCode List for this Report Group
EXEC
	sps_GetReportGroupSourceCodeList
		@vReportGroupID,
		@SourceCodeList
OUTPUT

--Check if there's an org id and populate the temp table with the appropriate orgs
IF @vOrgID = 0
	BEGIN
--Get the base data
		INSERT INTO #_Temp_CMSReport
			(
				OrganizationID,
				OrganizationName
			)
    	SELECT
    		_ReferralProdReport.dbo.Organization.OrganizationID,
    		OrganizationName
    	FROM
    		_ReferralProdReport.dbo.Organization
			LEFT JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON
				_ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
		WHERE
			WebReportGroupID = @vReportGroupID
  		ORDER BY
  			OrganizationName
	END
ELSE
	BEGIN
--Get the base data
		INSERT INTO #_Temp_CMSReport
			(
				OrganizationID,
				OrganizationName
			)
    	SELECT
    		_ReferralProdReport.dbo.Organization.OrganizationID,
    		OrganizationName
    	FROM
    		_ReferralProdReport.dbo.Organization
			LEFT JOIN	_ReferralProdReport.dbo.WebReportGroupOrg ON
				_ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
		WHERE
			WebReportGroupID = @vReportGroupID	
		AND	_ReferralProdReport.dbo.Organization.OrganizationID = @vOrgID
  		ORDER BY
  			OrganizationName
	END

--See if there is referral count data and update the temp table
UPDATE
	#_Temp_CMSReport
SET
	DeathsReported			= CountTable.DeathsReported,
	Approached				= CountTable.Approached,
	Approached_NonDR		= CountTable.Approached_NonDR,
	BDMSuitable				= CountTable.BDMSuitable,
	VentedNotification		= CountTable.VentedNotification,
	Referral_CT				= CountTable.Referral_CT,
	Approach_Organ_CT		= CountTable.Approach_Organ_CT,
	Consent_Organ_CT		= CountTable.Consent_Organ_CT,
	Recovery_Organ_CT		= CountTable.Recovery_Organ_CT,
	Recovery_Organ_All_CT	= CountTable.Recovery_Organ_All_CT			
FROM		
	(
		SELECT
			Referral_CMSReport.OrganizationID,
			SUM(DeathsReported)			AS 'DeathsReported',
			SUM(Approached)				AS 'Approached',
			SUM(Approached_NonDR)		AS 'Approached_NonDR',
			SUM(BDMSuitable)			AS 'BDMSuitable', 
			SUM(VentedNotification)		AS 'VentedNotification', 
			SUM(Referral_CT)			AS 'Referral_CT',
			SUM(Approach_Organ_CT)		AS 'Approach_Organ_CT',
			SUM(Consent_Organ_CT)		AS 'Consent_Organ_CT',
			SUM(Recovery_Organ_CT)		AS 'Recovery_Organ_CT',
			SUM(Recovery_Organ_All_CT)	AS 'Recovery_Organ_All_CT'
		FROM
			Referral_CMSReport
			JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_CMSReport.SourceCodeID
			JOIN _ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
			JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CMSReport.OrganizationID
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
		WHERE
			_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
		AND _ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND
			CAST
				(
					CAST(Referral_CMSReport.MonthID AS VarChar(2))
				+	'/1/'
				+	CAST(Referral_CMSReport.YearID AS VarChar(4))
				AS SmallDateTime
				) >= @vStartDate
		AND
			CAST
				(
					CAST(Referral_CMSReport.MonthID AS VarChar(2))
				+	'/1/'
				+	CAST(Referral_CMSReport.YearID AS VarChar(4))
				AS SmallDateTime
				) <= @vEndDate
		GROUP BY
			Referral_CMSReport.OrganizationID
	) AS CountTable
WHERE
	#_Temp_CMSReport.OrganizationID = CountTable.OrganizationID

--See if there is death data and update the temp table
UPDATE
	#_Temp_CMSReport
SET
	Deaths = CountTable.TotalDeaths
FROM		
	(
		SELECT
			OrganizationDeaths.OrganizationID,
			Sum(TotalDeaths) As TotalDeaths
		FROM
			OrganizationDeaths
			JOIN _ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = OrganizationDeaths.OrganizationID
		WHERE
			WebReportGroupID = @vReportGroupID	
		AND	OrganizationDeaths.SourceCodeList = @SourceCodeList	--drh 09/26/03
		AND
			CAST
				(
					CAST(MonthID AS VarChar(2))
				+	'/1/'
				+	CAST(YearID AS VarChar(4))
				AS SmallDateTime
				)  >= @vStartDate
		AND
			CAST
				(
					CAST(MonthID AS VarChar(2))
				+	'/1/'
				+	CAST(YearID AS VarChar(4))
				AS SmallDateTime
				)  <= @vEndDate
		GROUP BY
			OrganizationDeaths.OrganizationID
	) AS CountTable
WHERE
	#_Temp_CMSReport.OrganizationID = CountTable.OrganizationID


--Select final list
SELECT
	OrganizationID,
	OrganizationName,
	SUM(Deaths)					AS 'Deaths',
	SUM(DeathsReported)			AS 'DeathsReported',
	SUM(Approached)				AS 'Approached',
	SUM(Approached_NonDR)		AS 'Approached_NonDR',
	SUM(BDMSuitable)			AS 'BDMSuitable', 
	SUM(VentedNotification)		AS 'VentedNotification', 
	SUM(Referral_CT)			AS 'Referral_CT',
	SUM(Approach_Organ_CT)		AS 'Approach_Organ_CT',
	SUM(Consent_Organ_CT)		AS 'Consent_Organ_CT',
	SUM(Recovery_Organ_CT)		AS 'Recovery_Organ_CT',
	SUM(Recovery_Organ_All_CT)	AS 'Recovery_Organ_All_CT'
FROM
	#_Temp_CMSReport
GROUP BY
	OrganizationID,
	OrganizationName
ORDER BY
	OrganizationName
GO