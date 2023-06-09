SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCallCountSummary_A1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSCallCountSummary_A1]
GO



CREATE PROCEDURE sps_FSCallCountSummary_A1

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
			SUM(MedSocOTE + MedSocTissue + MedSocTE + MedSocEye + MedSocAgeRO + MedSocMedRO + MedSocOther + MedSocOtherEye  ) AS 'MedSoc Totals',
			
			--1/20/03 drh
			SUM(FamilyUnavailableOTE) AS 'FamilyUnavailable OTE', 
			SUM(FamilyUnavailableTissue) AS 'FamilyUnavailable Tissue', 
			SUM(FamilyUnavailableTE) AS 'FamilyUnavailable T/E', 
			SUM(FamilyUnavailableEye) AS 'FamilyUnavailable Eye', 
			SUM(FamilyUnavailableAgeRO + FamilyUnavailableMedRO) AS 'Total FamilyUnavailable RO', 
			SUM(FamilyUnavailableAgeRO) AS 'FamilyUnavailable Age RO', 
			SUM(FamilyUnavailableMedRO) AS 'FamilyUnavailable Med RO', 
			SUM(FamilyUnavailableOther) AS 'FamilyUnavailable Other', 
			SUM(FamilyUnavailableOtherEye) AS 'FamilyUnavailable Other Eye', 
			SUM(FamilyUnavailableOTE + FamilyUnavailableTissue + FamilyUnavailableTE + FamilyUnavailableEye + FamilyUnavailableAgeRO + FamilyUnavailableMedRO + FamilyUnavailableOther + FamilyUnavailableOtherEye  ) AS 'FamilyUnavailable Totals',

			SUM(CryolifeFormOTE) AS 'CryolifeForm OTE', 
			SUM(CryolifeFormTissue) AS 'CryolifeForm Tissue', 
			SUM(CryolifeFormTE) AS 'CryolifeForm T/E', 
			SUM(CryolifeFormEye) AS 'CryolifeForm Eye', 
			SUM(CryolifeFormAgeRO + CryolifeFormMedRO) AS 'Total CryolifeForm RO', 
			SUM(CryolifeFormAgeRO) AS 'CryolifeForm Age RO', 
			SUM(CryolifeFormMedRO) AS 'CryolifeForm Med RO', 
			SUM(CryolifeFormOther) AS 'CryolifeForm Other', 
			SUM(CryolifeFormOtherEye) AS 'CryolifeForm Other Eye', 
			SUM(CryolifeFormOTE + CryolifeFormTissue + CryolifeFormTE + CryolifeFormEye + CryolifeFormAgeRO + CryolifeFormMedRO + CryolifeFormOther + CryolifeFormOtherEye  ) AS 'CryolifeForm Totals',

			SUM(FamilyApproachOTECount) AS 'FamilyApproach OTE Count', 
			SUM(FamilyApproachTissueCount) AS 'FamilyApproach Tissue Count', 
			SUM(FamilyApproachTECount) AS 'FamilyApproach T/E Count', 
			SUM(FamilyApproachEyeCount) AS 'FamilyApproach Eye Count', 
			SUM(FamilyApproachAgeROCount + FamilyApproachMedROCount) AS 'Total FamilyApproach RO Count', 
			SUM(FamilyApproachAgeROCount) AS 'FamilyApproach Age RO Count', 
			SUM(FamilyApproachMedROCount) AS 'FamilyApproach Med RO Count', 
			SUM(FamilyApproachOtherCount) AS 'FamilyApproach Other Count', 
			SUM(FamilyApproachOtherEyeCount) AS 'FamilyApproach Other Eye Count', 
			SUM(FamilyApproachOTECount + FamilyApproachTissueCount + FamilyApproachTECount + FamilyApproachEyeCount + FamilyApproachAgeROCount + FamilyApproachMedROCount + FamilyApproachOtherCount + FamilyApproachOtherEyeCount  ) AS 'FamilyApproach Totals Count',

			SUM(MedSocOTECount) AS 'MedSoc OTE Count', 
			SUM(MedSocTissueCount) AS 'MedSoc Tissue Count', 
			SUM(MedSocTECount) AS 'MedSoc TE Count', 
			SUM(MedSocEyeCount) AS 'MedSoc Eye Count', 
			SUM(MedSocAgeROCount + MedSocMedROCount) AS 'MedSoc Total RO Count', 
			SUM(MedSocAgeROCount) AS 'MedSoc Age RO Count', 
			SUM(MedSocMedROCount) AS 'MedSoc Med RO Count', 
			SUM(MedSocOtherCount) AS 'MedSoc Other Count', 
			SUM(MedSocOtherEyeCount) AS 'MedSoc Other Eye Count', 
			SUM(MedSocOTECount + MedSocTissueCount + MedSocTECount + MedSocEyeCount + MedSocAgeROCount + MedSocMedROCount + MedSocOtherCount + MedSocOtherEyeCount  ) AS 'MedSoc Totals Count',
			
			SUM(CryolifeFormOTECount) AS 'CryolifeForm OTE Count', 
			SUM(CryolifeFormTissueCount) AS 'CryolifeForm Tissue Count', 
			SUM(CryolifeFormTECount) AS 'CryolifeForm T/E Count', 
			SUM(CryolifeFormEyeCount) AS 'CryolifeForm Eye Count', 
			SUM(CryolifeFormAgeROCount + CryolifeFormMedROCount) AS 'Total CryolifeForm RO Count', 
			SUM(CryolifeFormAgeROCount) AS 'CryolifeForm Age RO Count', 
			SUM(CryolifeFormMedROCount) AS 'CryolifeForm Med RO Count', 
			SUM(CryolifeFormOtherCount) AS 'CryolifeForm Other Count', 
			SUM(CryolifeFormOtherEyeCount) AS 'CryolifeForm Other Eye Count', 
			SUM(CryolifeFormOTECount + CryolifeFormTissueCount + CryolifeFormTECount + CryolifeFormEyeCount + CryolifeFormAgeROCount + CryolifeFormMedROCount + CryolifeFormOtherCount + CryolifeFormOtherEyeCount  ) AS 'CryolifeForm Totals Count'
			
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
			SUM(MedSocOTE + MedSocTissue + MedSocTE + MedSocEye + MedSocAgeRO + MedSocMedRO + MedSocOther + MedSocOtherEye  ) AS 'MedSoc Totals',

			--1/20/03 drh
			SUM(FamilyUnavailableOTE) AS 'FamilyUnavailable OTE', 
			SUM(FamilyUnavailableTissue) AS 'FamilyUnavailable Tissue', 
			SUM(FamilyUnavailableTE) AS 'FamilyUnavailable T/E', 
			SUM(FamilyUnavailableEye) AS 'FamilyUnavailable Eye', 
			SUM(FamilyUnavailableAgeRO + FamilyUnavailableMedRO) AS 'Total FamilyUnavailable RO', 
			SUM(FamilyUnavailableAgeRO) AS 'FamilyUnavailable Age RO', 
			SUM(FamilyUnavailableMedRO) AS 'FamilyUnavailable Med RO', 
			SUM(FamilyUnavailableOther) AS 'FamilyUnavailable Other', 
			SUM(FamilyUnavailableOtherEye) AS 'FamilyUnavailable Other Eye', 
			SUM(FamilyUnavailableOTE + FamilyUnavailableTissue + FamilyUnavailableTE + FamilyUnavailableEye + FamilyUnavailableAgeRO + FamilyUnavailableMedRO + FamilyUnavailableOther + FamilyUnavailableOtherEye  ) AS 'FamilyUnavailable Totals',

			SUM(CryolifeFormOTE) AS 'CryolifeForm OTE', 
			SUM(CryolifeFormTissue) AS 'CryolifeForm Tissue', 
			SUM(CryolifeFormTE) AS 'CryolifeForm T/E', 
			SUM(CryolifeFormEye) AS 'CryolifeForm Eye', 
			SUM(CryolifeFormAgeRO + CryolifeFormMedRO) AS 'Total CryolifeForm RO', 
			SUM(CryolifeFormAgeRO) AS 'CryolifeForm Age RO', 
			SUM(CryolifeFormMedRO) AS 'CryolifeForm Med RO', 
			SUM(CryolifeFormOther) AS 'CryolifeForm Other', 
			SUM(CryolifeFormOtherEye) AS 'CryolifeForm Other Eye', 
			SUM(CryolifeFormOTE + CryolifeFormTissue + CryolifeFormTE + CryolifeFormEye + CryolifeFormAgeRO + CryolifeFormMedRO + CryolifeFormOther + CryolifeFormOtherEye  ) AS 'CryolifeForm Totals',

			SUM(FamilyApproachOTECount) AS 'FamilyApproach OTE Count', 
			SUM(FamilyApproachTissueCount) AS 'FamilyApproach Tissue Count', 
			SUM(FamilyApproachTECount) AS 'FamilyApproach T/E Count', 
			SUM(FamilyApproachEyeCount) AS 'FamilyApproach Eye Count', 
			SUM(FamilyApproachAgeROCount + FamilyApproachMedROCount) AS 'Total FamilyApproach RO Count', 
			SUM(FamilyApproachAgeROCount) AS 'FamilyApproach Age RO Count', 
			SUM(FamilyApproachMedROCount) AS 'FamilyApproach Med RO Count', 
			SUM(FamilyApproachOtherCount) AS 'FamilyApproach Other Count', 
			SUM(FamilyApproachOtherEyeCount) AS 'FamilyApproach Other Eye Count', 
			SUM(FamilyApproachOTECount + FamilyApproachTissueCount + FamilyApproachTECount + FamilyApproachEyeCount + FamilyApproachAgeROCount + FamilyApproachMedROCount + FamilyApproachOtherCount + FamilyApproachOtherEyeCount  ) AS 'FamilyApproach Totals Count',

			SUM(MedSocOTECount) AS 'MedSoc OTE Count', 
			SUM(MedSocTissueCount) AS 'MedSoc Tissue Count', 
			SUM(MedSocTECount) AS 'MedSoc TE Count', 
			SUM(MedSocEyeCount) AS 'MedSoc Eye Count', 
			SUM(MedSocAgeROCount + MedSocMedROCount) AS 'MedSoc Total RO Count', 
			SUM(MedSocAgeROCount) AS 'MedSoc Age RO Count', 
			SUM(MedSocMedROCount) AS 'MedSoc Med RO Count', 
			SUM(MedSocOtherCount) AS 'MedSoc Other Count', 
			SUM(MedSocOtherEyeCount) AS 'MedSoc Other Eye Count', 
			SUM(MedSocOTECount + MedSocTissueCount + MedSocTECount + MedSocEyeCount + MedSocAgeROCount + MedSocMedROCount + MedSocOtherCount + MedSocOtherEyeCount  ) AS 'MedSoc Totals Count',
			
			SUM(CryolifeFormOTECount) AS 'CryolifeForm OTE Count', 
			SUM(CryolifeFormTissueCount) AS 'CryolifeForm Tissue Count', 
			SUM(CryolifeFormTECount) AS 'CryolifeForm T/E Count', 
			SUM(CryolifeFormEyeCount) AS 'CryolifeForm Eye Count', 
			SUM(CryolifeFormAgeROCount + CryolifeFormMedROCount) AS 'Total CryolifeForm RO Count', 
			SUM(CryolifeFormAgeROCount) AS 'CryolifeForm Age RO Count', 
			SUM(CryolifeFormMedROCount) AS 'CryolifeForm Med RO Count', 
			SUM(CryolifeFormOtherCount) AS 'CryolifeForm Other Count', 
			SUM(CryolifeFormOtherEyeCount) AS 'CryolifeForm Other Eye Count', 
			SUM(CryolifeFormOTECount + CryolifeFormTissueCount + CryolifeFormTECount + CryolifeFormEyeCount + CryolifeFormAgeROCount + CryolifeFormMedROCount + CryolifeFormOtherCount + CryolifeFormOtherEyeCount  ) AS 'CryolifeForm Totals Count'
			
			

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

