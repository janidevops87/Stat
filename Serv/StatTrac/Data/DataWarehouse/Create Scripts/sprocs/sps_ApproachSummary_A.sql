SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachSummary_A]
GO

CREATE PROCEDURE sps_ApproachSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vOrgID		int		= 0

AS

IF	@vOrgID = 0

    	SELECT 	Referral_TypeCount.OrganizationID, OrganizationName, 
			Sum(AllTypes) AS AllTypes,
			Sum(PreRefFamilyApproach + PreRefFacilityApproach + PostRefApproach) AS TotalApproached,
			Sum(PreRefFamilyApproach) AS PreRefFamilyApproach, Sum(PreRefFacilityApproach) AS PreRefFacilityApproach, 
			Sum(PostRefApproach) AS PostRefApproach, Sum(UnknownApproach) AS UnknownApproach, 
			Sum(NotApproached) AS NotApproached, Sum(RegistryApproach) AS RegistryApproach

    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_TypeCount.YearID = Referral_ApproachCount.YearID
	AND		Referral_TypeCount.MonthID = Referral_ApproachCount.MonthID
	AND		Referral_TypeCount.SourceCodeID = Referral_ApproachCount.SourceCodeID

	GROUP BY	Referral_TypeCount.OrganizationID, OrganizationName
    	ORDER BY 	OrganizationName

IF	@vOrgID > 0

    	SELECT 	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, CAST(Referral_TypeCount.YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			Referral_TypeCount.OrganizationID, OrganizationName, 
			Sum(AllTypes) AS AllTypes,
			Sum(PreRefFamilyApproach + PreRefFacilityApproach + PostRefApproach) AS TotalApproached,
			Sum(PreRefFamilyApproach) AS PreRefFamilyApproach, Sum(PreRefFacilityApproach) AS PreRefFacilityApproach, 
			Sum(PostRefApproach) AS PostRefApproach, Sum(UnknownApproach) AS UnknownApproach, 
			Sum(NotApproached) AS NotApproached, Sum(RegistryApproach) AS RegistryApproach

    	FROM 		Referral_TypeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_TypeCount.OrganizationID 
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_TypeCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_TypeCount.YearID = Referral_ApproachCount.YearID
	AND		Referral_TypeCount.MonthID = Referral_ApproachCount.MonthID
	AND		Referral_TypeCount.SourceCodeID = Referral_ApproachCount.SourceCodeID
	AND		Referral_TypeCount.OrganizationID = @vOrgID

	GROUP BY	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, CAST(Referral_TypeCount.YearID AS varchar(4)) + ' ' + RTrim(MonthName), Referral_TypeCount.OrganizationID, OrganizationName
    	ORDER BY 	Referral_TypeCount.YearID, Referral_TypeCount.MonthID, OrganizationName
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

