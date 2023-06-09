SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_GOLM_UNOS_Monthly]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_GOLM_UNOS_Monthly]
GO


CREATE PROCEDURE sps_GOLM_UNOS_Monthly
	@vReportGroupID		int = 0,
	@vStartDate		datetime = null,
	@vEndDate		datetime = null,
	@vOrgID			int = 0

AS

------------------------------------------------------
IF	@vOrgID = 0

	SELECT 		Referral_CMSReport.OrganizationID, 
			_ReferralProdReport.dbo.Organization.OrganizationName, 
			SUM(Referral_TypeCount.AllTypes) AS 'Referral_Count',
			SUM(Referral_CMSReport.BDMSuitable) AS 'Potential_Organ_Donors_CT',
			SUM(Referral_CMSReport.Consent_Organ_CT) AS 'Consent_CT'

	FROM 		Referral_CMSReport 
	JOIN 		Referral_TypeCount ON Referral_TypeCount.OrganizationID = Referral_CMSReport.OrganizationID
				AND Referral_TypeCount.YearID = Referral_CMSReport.YearID
				AND Referral_TypeCount.MonthID = Referral_CMSReport.MonthID
				AND Referral_TypeCount.SourceCodeID = Referral_CMSReport.SourceCodeID	--drh 2/12/04 added
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_TypeCount.MonthID AS varchar(2)) + '/1/' + CAST(Referral_TypeCount.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_CMSReport.OrganizationID, OrganizationName
	ORDER BY 	OrganizationName


------------------------------------------------------
IF	@vOrgID > 0

	SELECT 		Referral_CMSReport.OrganizationID,
			--_ReferralProdReport.dbo.Organization.OrganizationName,	--drh 2/12/04 removed
			Referral_CMSReport.MonthID,
			Referral_CMSReport.YearID,
			SUM(Referral_TypeCount.AllTypes) AS 'Referral_Count',
			SUM(Referral_CMSReport.BDMSuitable) AS 'Potential_Organ_Donors_CT',
			SUM(Referral_CMSReport.Consent_Organ_CT) AS 'Consent_CT'

    	FROM 		Referral_CMSReport
	JOIN 		Referral_TypeCount ON Referral_TypeCount.OrganizationID = Referral_CMSReport.OrganizationID
				AND Referral_TypeCount.YearID = Referral_CMSReport.YearID
				AND Referral_TypeCount.MonthID = Referral_CMSReport.MonthID
				AND Referral_TypeCount.SourceCodeID = Referral_CMSReport.SourceCodeID
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_TypeCount.SourceCodeID	--drh 2/19/04 added
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_TypeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID

   	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		Referral_CMSReport.OrganizationID = @vOrgID
	AND		CAST(  CAST(Referral_CMSReport.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CMSReport.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CMSReport.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CMSReport.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY 	Referral_CMSReport.YearID,
			Referral_CMSReport.MonthID,
			--_ReferralProdReport.dbo.Organization.OrganizationName,	--drh 2/12/04 removed
			Referral_CMSReport.OrganizationID--, 
			--Referral_TypeCount.AllTypes,				--drh 2/12/04 removed
			--Referral_CMSReport.BDMSuitable,			--drh 2/12/04 removed
			--Referral_CMSReport.Consent_Organ_CT		--drh 2/12/04 removed

	ORDER BY	--_ReferralProdReport.dbo.Organization.OrganizationName, 	--drh 2/12/04 removed
			Referral_CMSReport.YearID, 
			Referral_CMSReport.MonthID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

