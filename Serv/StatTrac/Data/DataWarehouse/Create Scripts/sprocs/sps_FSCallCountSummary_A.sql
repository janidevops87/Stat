SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCallCountSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSCallCountSummary_A]
GO





CREATE PROCEDURE sps_FSCallCountSummary_A

	@vReportGroupID		int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int 		= 0,
	@vOrgID			int		= 0

AS
-- sp_help Referral_FSCallCountSummary
IF	@vOrgID = 0



    	SELECT 		SUM(NoSecondaryOTE) AS 'NoSecondary OTE', 
			SUM(NoSecondaryTissue) AS 'NoSecondary Tissue', 
			SUM(NoSecondaryTE) AS 'NoSecondary T/E', 
			SUM(NoSecondaryEye) AS 'NoSecondary Eye', 
			SUM(NoSecondaryAgeRO + NoSecondaryMedRO) AS 'NoSecondary Total RO', 
			SUM(NoSecondaryAgeRO) AS 'NoSecondary Age RO', 
			SUM(NoSecondaryMedRO) AS 'NoSecondary Med RO', 
			SUM(NoSecondaryOther) AS 'NoSecondary Other', 
			SUM(NoSecondaryOtherEye) AS 'NoSecondary Other Eye', 
			SUM(NoSecondaryOTE + NoSecondaryTissue + NoSecondaryTE + NoSecondaryEye + NoSecondaryAgeRO + NoSecondaryMedRO + NoSecondaryOther + NoSecondaryOtherEye) AS 'NoSecondary Totals', 
			SUM(SecondaryOTE) AS 'Secondary OTE', 
			SUM(SecondaryTissue) AS 'Secondary Tissue', 
			SUM(SecondaryTE) AS 'Secondary T/E', 
			SUM(SecondaryEye) AS 'Secondary Eye', 
			SUM(SecondaryAgeRO + SecondaryMedRO) AS 'Secondary Total RO', 
			SUM(SecondaryAgeRO) AS 'Secondary Age RO', 
			SUM(SecondaryMedRO) AS 'Secondary Med RO', 
			SUM(SecondaryOther) AS 'Secondary Other', 
			SUM(SecondaryOtherEye) AS 'Secondary Other Eye', 
			SUM(SecondaryOTE + SecondaryTissue + SecondaryTE + SecondaryEye + SecondaryAgeRO + SecondaryMedRO + SecondaryOther + SecondaryOtherEye) AS 'Secondary Totals', 
			SUM(FamilyApproachOTE) AS 'FamilyApproach OTE', 
			SUM(FamilyApproachTissue) AS 'FamilyApproach Tissue', 
			SUM(FamilyApproachTE) AS 'FamilyApproach T/E', 
			SUM(FamilyApproachEye) AS 'FamilyApproach Eye', 
			SUM(FamilyApproachAgeRO + FamilyApproachMedRO) AS 'Total FamilyApproach RO', 
			SUM(FamilyApproachAgeRO) AS 'FamilyApproach Age RO', 
			SUM(FamilyApproachMedRO) AS 'FamilyApproach Med RO', 
			SUM(FamilyApproachOther) AS 'FamilyApproach Other', 
			SUM(FamilyApproachOtherEye) AS 'FamilyApproach Other Eye', 
			SUM(FamilyApproachOTE + FamilyApproachTissue + FamilyApproachTE + FamilyApproachEye + FamilyApproachAgeRO + FamilyApproachMedRO + FamilyApproachOther + FamilyApproachOtherEye  ) AS 'FamilyApproach Totals', 
			SUM(MedSocOTE) AS 'MedSoc OTE', 
			SUM(MedSocTissue) AS 'MedSoc Tissue', 
			SUM(MedSocTE) AS 'MedSoc TE', 
			SUM(MedSocEye) AS 'MedSoc Eye', 
			SUM(MedSocAgeRO + MedSocMedRO) AS 'MedSoc Total RO', 
			SUM(MedSocAgeRO) AS 'MedSoc Age RO', 
			SUM(MedSocMedRO) AS 'MedSoc Med RO', 
			SUM(MedSocOther) AS 'MedSoc Other', 
			SUM(MedSocOtherEye) AS 'MedSoc Other Eye', 
			SUM(MedSocOTE + MedSocTissue + MedSocTE + MedSocEye + MedSocAgeRO + MedSocMedRO + MedSocOther + MedSocOtherEye  ) AS 'MedSoc Totals'

    	FROM 		Referral_FSCallCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_FSCallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
   	WHERE 		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_FSCallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_FSCallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_FSCallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_FSCallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND 		SourceCodeID = @vSourceCodeID

IF	@vOrgID > 0

    	SELECT 		SUM(NoSecondaryOTE) AS 'NoSecondary OTE', 
			SUM(NoSecondaryTissue) AS 'NoSecondary Tissue', 
			SUM(NoSecondaryTE) AS 'NoSecondary T/E', 
			SUM(NoSecondaryEye) AS 'NoSecondary Eye', 
			SUM(NoSecondaryAgeRO + NoSecondaryMedRO) AS 'NoSecondary Total RO', 
			SUM(NoSecondaryAgeRO) AS 'NoSecondary Age RO', 
			SUM(NoSecondaryMedRO) AS 'NoSecondary Med RO', 
			SUM(NoSecondaryOther) AS 'NoSecondary Other', 
			SUM(NoSecondaryOtherEye) AS 'NoSecondary Other Eye', 
			SUM(NoSecondaryOTE + NoSecondaryTissue + NoSecondaryTE + NoSecondaryEye + NoSecondaryAgeRO + NoSecondaryMedRO + NoSecondaryOther + NoSecondaryOtherEye) AS 'NoSecondary Totals', 
			SUM(SecondaryOTE) AS 'Secondary OTE', 
			SUM(SecondaryTissue) AS 'Secondary Tissue', 
			SUM(SecondaryTE) AS 'Secondary T/E', 
			SUM(SecondaryEye) AS 'Secondary Eye', 
			SUM(SecondaryAgeRO + SecondaryMedRO) AS 'Secondary Total RO', 
			SUM(SecondaryAgeRO) AS 'Secondary Age RO', 
			SUM(SecondaryMedRO) AS 'Secondary Med RO', 
			SUM(SecondaryOther) AS 'Secondary Other', 
			SUM(SecondaryOtherEye) AS 'Secondary Other Eye', 
			SUM(SecondaryOTE + SecondaryTissue + SecondaryTE + SecondaryEye + SecondaryAgeRO + SecondaryMedRO + SecondaryOther + SecondaryOtherEye) AS 'Secondary Totals', 
			SUM(FamilyApproachOTE) AS 'FamilyApproach OTE', 
			SUM(FamilyApproachTissue) AS 'FamilyApproach Tissue', 
			SUM(FamilyApproachTE) AS 'FamilyApproach T/E', 
			SUM(FamilyApproachEye) AS 'FamilyApproach Eye', 
			SUM(FamilyApproachAgeRO + FamilyApproachMedRO) AS 'Total FamilyApproach RO', 
			SUM(FamilyApproachAgeRO) AS 'FamilyApproach Age RO', 
			SUM(FamilyApproachMedRO) AS 'FamilyApproach Med RO', 
			SUM(FamilyApproachOther) AS 'FamilyApproach Other', 
			SUM(FamilyApproachOtherEye) AS 'FamilyApproach Other Eye', 
			SUM(FamilyApproachOTE + FamilyApproachTissue + FamilyApproachTE + FamilyApproachEye + FamilyApproachAgeRO + FamilyApproachMedRO + FamilyApproachOther + FamilyApproachOtherEye  ) AS 'FamilyApproach Totals', 
			SUM(MedSocOTE) AS 'MedSoc OTE', 
			SUM(MedSocTissue) AS 'MedSoc Tissue', 
			SUM(MedSocTE) AS 'MedSoc TE', 
			SUM(MedSocEye) AS 'MedSoc Eye', 
			SUM(MedSocAgeRO + MedSocMedRO) AS 'MedSoc Total RO', 
			SUM(MedSocAgeRO) AS 'MedSoc Age RO', 
			SUM(MedSocMedRO) AS 'MedSoc Med RO', 
			SUM(MedSocOther) AS 'MedSoc Other', 
			SUM(MedSocOtherEye) AS 'MedSoc Other Eye', 
			SUM(MedSocOTE + MedSocTissue + MedSocTE + MedSocEye + MedSocAgeRO + MedSocMedRO + MedSocOther + MedSocOtherEye  ) AS 'MedSoc Totals'
    	FROM 		Referral_FSCallCountSummary
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_FSCallCountSummary.OrganizationID 
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_FSCallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_FSCallCountSummary.MonthID
	JOIN 		_ReferralProdReport.dbo.SourceCodeOrganization ON _ReferralProdReport.dbo.SourceCodeOrganization.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCodeOrganization.SourceCodeID

   	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_FSCallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_FSCallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_FSCallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_FSCallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_FSCallCountSummary.OrganizationID = @vOrgID
	AND 		_ReferralProdReport.dbo.SourceCode.SourceCodeID = @vSourceCodeID

	



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

