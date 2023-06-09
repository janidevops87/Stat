SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_FSCallCountSummary_A2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_FSCallCountSummary_A2]
GO





CREATE    PROCEDURE sps_FSCallCountSummary_A2

	@vReportGroupID		int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int 		= 0,
	@vOrgID			int		= 0

AS
/******************************************************************************
**		File: 
**		Name: sps_FSCallCountSummary_A3
**		Desc: this is a newer version for the billable report...returns data for that report from table Referral_FSCallCountSummary
**
** 
**		Called by:   
**              Billing System Invoice Preview
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Unknown
**		Date: 3/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      ccarroll	11/09/2006			Added FSCaseBillOTE for billing OTE Screening
**		jhawkins	2/2008				Modified for Billable Count Summary
*******************************************************************************/

-- sp_help Referral_FSCallCountSummary

    	SELECT 		
    		ISNULL(SUM(NoSecondaryOTE), 0) AS 'NoSecondary OTE', 
			ISNULL(SUM(NoSecondaryTissue), 0) AS 'NoSecondary Tissue', 
			ISNULL(SUM(NoSecondaryTE), 0) AS 'NoSecondary T/E', 
			ISNULL(SUM(NoSecondaryEye), 0) AS 'NoSecondary Eye', 
			ISNULL(SUM(NoSecondaryAgeRO + NoSecondaryMedRO), 0) AS 'NoSecondary Total RO', 
			ISNULL(SUM(NoSecondaryAgeRO), 0) AS 'NoSecondary Age RO', 
			ISNULL(SUM(NoSecondaryMedRO), 0) AS 'NoSecondary Med RO', 
			ISNULL(SUM(NoSecondaryOther), 0) AS 'NoSecondary Other', 
			ISNULL(SUM(NoSecondaryOtherEye), 0) AS 'NoSecondary Other Eye', 
			ISNULL(SUM(NoSecondaryOTE + NoSecondaryTissue + NoSecondaryTE + NoSecondaryEye + NoSecondaryAgeRO + NoSecondaryMedRO + NoSecondaryOther + NoSecondaryOtherEye), 0) AS 'NoSecondary Totals', 
			ISNULL(SUM(SecondaryOTE), 0) AS 'Secondary OTE', 
			ISNULL(SUM(SecondaryTissue), 0) AS 'Secondary Tissue', 
			ISNULL(SUM(SecondaryTE), 0) AS 'Secondary T/E', 
			ISNULL(SUM(SecondaryEye), 0) AS 'Secondary Eye', 
			ISNULL(SUM(SecondaryAgeRO + SecondaryMedRO), 0) AS 'Secondary Total RO', 
			ISNULL(SUM(SecondaryAgeRO), 0) AS 'Secondary Age RO', 
			ISNULL(SUM(SecondaryMedRO), 0) AS 'Secondary Med RO', 
			ISNULL(SUM(SecondaryOther), 0) AS 'Secondary Other', 
			ISNULL(SUM(SecondaryOtherEye), 0) AS 'Secondary Other Eye', 
			ISNULL(SUM(SecondaryOTE + SecondaryTissue + SecondaryTE + SecondaryEye + SecondaryAgeRO + SecondaryMedRO + SecondaryOther + SecondaryOtherEye), 0) AS 'Secondary Totals', 
			ISNULL(SUM(FamilyApproachOTE), 0) AS 'FamilyApproach OTE', 
			ISNULL(SUM(FamilyApproachTissue), 0) AS 'FamilyApproach Tissue', 
			ISNULL(SUM(FamilyApproachTE), 0) AS 'FamilyApproach T/E', 
			ISNULL(SUM(FamilyApproachEye), 0) AS 'FamilyApproach Eye', 
			ISNULL(SUM(FamilyApproachAgeRO + FamilyApproachMedRO), 0) AS 'Total FamilyApproach RO', 
			ISNULL(SUM(FamilyApproachAgeRO), 0) AS 'FamilyApproach Age RO', 
			ISNULL(SUM(FamilyApproachMedRO), 0) AS 'FamilyApproach Med RO', 
			ISNULL(SUM(FamilyApproachOther), 0) AS 'FamilyApproach Other', 
			ISNULL(SUM(FamilyApproachOtherEye), 0) AS 'FamilyApproach Other Eye', 
			ISNULL(SUM(FamilyApproachOTE + FamilyApproachTissue + FamilyApproachTE + FamilyApproachEye + FamilyApproachAgeRO + FamilyApproachMedRO + FamilyApproachOther + FamilyApproachOtherEye  ), 0) AS 'FamilyApproach Totals', 
			ISNULL(SUM(MedSocOTE), 0) AS 'MedSoc OTE', 
			ISNULL(SUM(MedSocTissue), 0) AS 'MedSoc Tissue', 
			ISNULL(SUM(MedSocTE), 0) AS 'MedSoc TE', 
			ISNULL(SUM(MedSocEye), 0) AS 'MedSoc Eye', 
			ISNULL(SUM(MedSocAgeRO + MedSocMedRO), 0) AS 'MedSoc Total RO', 
			ISNULL(SUM(MedSocAgeRO), 0) AS 'MedSoc Age RO', 
			ISNULL(SUM(MedSocMedRO), 0) AS 'MedSoc Med RO', 
			ISNULL(SUM(MedSocOther), 0) AS 'MedSoc Other', 
			ISNULL(SUM(MedSocOtherEye), 0) AS 'MedSoc Other Eye', 
			ISNULL(SUM(MedSocOTE + MedSocTissue + MedSocTE + MedSocEye + MedSocAgeRO + MedSocMedRO + MedSocOther + MedSocOtherEye  ), 0) AS 'MedSoc Totals',

			--1/20/03 drh
			ISNULL(SUM(FamilyUnavailableOTE), 0) AS 'FamilyUnavailable OTE', 
			ISNULL(SUM(FamilyUnavailableTissue), 0) AS 'FamilyUnavailable Tissue', 
			ISNULL(SUM(FamilyUnavailableTE), 0) AS 'FamilyUnavailable T/E', 
			ISNULL(SUM(FamilyUnavailableEye), 0) AS 'FamilyUnavailable Eye', 
			ISNULL(SUM(FamilyUnavailableAgeRO + FamilyUnavailableMedRO), 0) AS 'Total FamilyUnavailable RO', 
			ISNULL(SUM(FamilyUnavailableAgeRO), 0) AS 'FamilyUnavailable Age RO', 
			ISNULL(SUM(FamilyUnavailableMedRO), 0) AS 'FamilyUnavailable Med RO', 
			ISNULL(SUM(FamilyUnavailableOther), 0) AS 'FamilyUnavailable Other', 
			ISNULL(SUM(FamilyUnavailableOtherEye), 0) AS 'FamilyUnavailable Other Eye', 
			ISNULL(SUM(FamilyUnavailableOTE + FamilyUnavailableTissue + FamilyUnavailableTE + FamilyUnavailableEye + FamilyUnavailableAgeRO + FamilyUnavailableMedRO + FamilyUnavailableOther + FamilyUnavailableOtherEye  ), 0) AS 'FamilyUnavailable Totals',

			ISNULL(SUM(CryolifeFormOTE), 0) AS 'CryolifeForm OTE', 
			ISNULL(SUM(CryolifeFormTissue), 0) AS 'CryolifeForm Tissue', 
			ISNULL(SUM(CryolifeFormTE), 0) AS 'CryolifeForm T/E', 
			ISNULL(SUM(CryolifeFormEye), 0) AS 'CryolifeForm Eye', 
			ISNULL(SUM(CryolifeFormAgeRO + CryolifeFormMedRO), 0) AS 'Total CryolifeForm RO', 
			ISNULL(SUM(CryolifeFormAgeRO), 0) AS 'CryolifeForm Age RO', 
			ISNULL(SUM(CryolifeFormMedRO), 0) AS 'CryolifeForm Med RO', 
			ISNULL(SUM(CryolifeFormOther), 0) AS 'CryolifeForm Other', 
			ISNULL(SUM(CryolifeFormOtherEye), 0) AS 'CryolifeForm Other Eye', 
			ISNULL(SUM(CryolifeFormOTE + CryolifeFormTissue + CryolifeFormTE + CryolifeFormEye + CryolifeFormAgeRO + CryolifeFormMedRO + CryolifeFormOther + CryolifeFormOtherEye  ), 0) AS 'CryolifeForm Totals',

			ISNULL(SUM(FamilyApproachOTECount), 0) AS 'FamilyApproach OTE Count', 
			ISNULL(SUM(FamilyApproachTissueCount), 0) AS 'FamilyApproach Tissue Count', 
			ISNULL(SUM(FamilyApproachTECount), 0) AS 'FamilyApproach T/E Count', 
			ISNULL(SUM(FamilyApproachEyeCount), 0) AS 'FamilyApproach Eye Count', 
			ISNULL(SUM(FamilyApproachAgeROCount + FamilyApproachMedROCount), 0) AS 'Total FamilyApproach RO Count', 
			ISNULL(SUM(FamilyApproachAgeROCount), 0) AS 'FamilyApproach Age RO Count', 
			ISNULL(SUM(FamilyApproachMedROCount), 0) AS 'FamilyApproach Med RO Count', 
			ISNULL(SUM(FamilyApproachOtherCount), 0) AS 'FamilyApproach Other Count', 
			ISNULL(SUM(FamilyApproachOtherEyeCount), 0) AS 'FamilyApproach Other Eye Count', 
			ISNULL(SUM(FamilyApproachOTECount + FamilyApproachTissueCount + FamilyApproachTECount + FamilyApproachEyeCount + FamilyApproachAgeROCount + FamilyApproachMedROCount + FamilyApproachOtherCount + FamilyApproachOtherEyeCount  ), 0) AS 'FamilyApproach Totals Count',

			ISNULL(SUM(MedSocOTECount), 0) AS 'MedSoc OTE Count', 
			ISNULL(SUM(MedSocTissueCount), 0) AS 'MedSoc Tissue Count', 
			ISNULL(SUM(MedSocTECount), 0) AS 'MedSoc TE Count', 
			ISNULL(SUM(MedSocEyeCount), 0) AS 'MedSoc Eye Count', 
			ISNULL(SUM(MedSocAgeROCount + MedSocMedROCount), 0) AS 'MedSoc Total RO Count', 
			ISNULL(SUM(MedSocAgeROCount), 0) AS 'MedSoc Age RO Count', 
			ISNULL(SUM(MedSocMedROCount), 0) AS 'MedSoc Med RO Count', 
			ISNULL(SUM(MedSocOtherCount), 0) AS 'MedSoc Other Count', 
			ISNULL(SUM(MedSocOtherEyeCount), 0) AS 'MedSoc Other Eye Count', 
			ISNULL(SUM(MedSocOTECount + MedSocTissueCount + MedSocTECount + MedSocEyeCount + MedSocAgeROCount + MedSocMedROCount + MedSocOtherCount + MedSocOtherEyeCount  ), 0) AS 'MedSoc Totals Count',
			
			ISNULL(SUM(CryolifeFormOTECount), 0) AS 'CryolifeForm OTE Count', 
			ISNULL(SUM(CryolifeFormTissueCount), 0) AS 'CryolifeForm Tissue Count', 
			ISNULL(SUM(CryolifeFormTECount), 0) AS 'CryolifeForm T/E Count', 
			ISNULL(SUM(CryolifeFormEyeCount), 0) AS 'CryolifeForm Eye Count', 
			ISNULL(SUM(CryolifeFormAgeROCount + CryolifeFormMedROCount), 0) AS 'Total CryolifeForm RO Count', 
			ISNULL(SUM(CryolifeFormAgeROCount), 0) AS 'CryolifeForm Age RO Count', 
			ISNULL(SUM(CryolifeFormMedROCount), 0) AS 'CryolifeForm Med RO Count', 
			ISNULL(SUM(CryolifeFormOtherCount), 0) AS 'CryolifeForm Other Count', 
			ISNULL(SUM(CryolifeFormOtherEyeCount), 0) AS 'CryolifeForm Other Eye Count', 
			ISNULL(SUM(CryolifeFormOTECount + CryolifeFormTissueCount + CryolifeFormTECount + CryolifeFormEyeCount + CryolifeFormAgeROCount + CryolifeFormMedROCount + CryolifeFormOtherCount + CryolifeFormOtherEyeCount  ), 0) AS 'CryolifeForm Totals Count',

			-- 5/19/2003 DEO			
			ISNULL(SUM(SecondaryApproachOTE), 0) AS 'SecondaryApproachOTE',
			ISNULL(SUM(SecondaryApproachTissue), 0) AS 'SecondaryApproachTissue', 
			ISNULL(SUM(SecondaryApproachTE), 0) AS 'SecondaryApproachTE', 
			ISNULL(SUM(SecondaryApproachEye), 0) AS 'SecondaryApproachEye', 
			ISNULL(SUM(SecondaryApproachAgeRO + SecondaryApproachMedRO), 0) AS 'Total SecondaryApproach RO Count', 
			ISNULL(SUM(SecondaryApproachAgeRO), 0) AS 'SecondaryApproachAgeRO', 
			ISNULL(SUM(SecondaryApproachMedRO), 0) AS 'SecondaryApproachMedRO', 
			ISNULL(SUM(SecondaryApproachOther), 0) AS 'SecondaryApproachOther', 
			ISNULL(SUM(SecondaryApproachOtherEye), 0) AS 'SecondaryApproachOtherEye', 
			ISNULL(SUM(SecondaryApproachOTE + SecondaryApproachTissue + SecondaryApproachTE + SecondaryApproachEye + SecondaryApproachAgeRO + SecondaryApproachMedRO + SecondaryApproachOther + SecondaryApproachOtherEye), 0) AS 'SecondaryApproach Totals Count',

			ISNULL(SUM(SecondaryNoApproachOTE), 0) AS 'SecondaryNoApproachOTE', 
			ISNULL(SUM(SecondaryNoApproachTissue), 0) AS 'SecondaryNoApproachTissue', 
			ISNULL(SUM(SecondaryNoApproachTE), 0) AS 'SecondaryNoApproachTE', 
			ISNULL(SUM(SecondaryNoApproachEye), 0) AS 'SecondaryNoApproachEye', 
			ISNULL(SUM(SecondaryNoApproachAgeRO + SecondaryNoApproachMedRO), 0) AS 'Total SecondaryNoApproach RO Count', 
			ISNULL(SUM(SecondaryNoApproachAgeRO), 0) AS 'SecondaryNoApproachAgeRO', 
			ISNULL(SUM(SecondaryNoApproachMedRO), 0) AS 'SecondaryNoApproachMedRO', 
			ISNULL(SUM(SecondaryNoApproachOther), 0) AS 'SecondaryNoApproachOther', 
			ISNULL(SUM(SecondaryNoApproachOtherEye), 0) AS 'SecondaryNoApproachOtherEye', 
			ISNULL(SUM(SecondaryNoApproachOTE + SecondaryNoApproachTissue + SecondaryNoApproachTE + SecondaryNoApproachEye + SecondaryNoApproachAgeRO + SecondaryNoApproachMedRO + SecondaryNoApproachOther + SecondaryNoApproachOtherEye), 0) AS 'SecondaryNoApproach Totals Count', 

			ISNULL(SUM(NoSecondaryApproachOTE), 0) AS 'NoSecondaryApproachOTE', 
			ISNULL(SUM(NoSecondaryApproachTissue), 0) AS 'NoSecondaryApproachTissue', 
			ISNULL(SUM(NoSecondaryApproachTE), 0) AS 'NoSecondaryApproachTE', 
			ISNULL(SUM(NoSecondaryApproachEye), 0) AS 'NoSecondaryApproachEye', 
			ISNULL(SUM(NoSecondaryApproachAgeRO + NoSecondaryApproachMedRO), 0) AS 'Total NoSecondaryApproach RO Count', 
			ISNULL(SUM(NoSecondaryApproachAgeRO), 0) AS 'NoSecondaryApproachAgeRO', 
			ISNULL(SUM(NoSecondaryApproachMedRO), 0) AS 'NoSecondaryApproachMedRO', 
			ISNULL(SUM(NoSecondaryApproachOther), 0) AS 'NoSecondaryApproachOther', 
			ISNULL(SUM(NoSecondaryApproachOtherEye), 0) AS 'NoSecondaryApproachOtherEye',
			ISNULL(SUM(NoSecondaryApproachOTE + NoSecondaryApproachTissue + NoSecondaryApproachTE + NoSecondaryApproachEye + NoSecondaryApproachAgeRO + NoSecondaryApproachMedRO + NoSecondaryApproachOther + NoSecondaryApproachOtherEye), 0) AS 'NoSecondaryApproach Totals Count',			
			--ccarroll 11/09/2006 Added FSCaseBillOTE
			ISNULL(SUM(FSCaseBillOTE), 0) AS 'FSCaseBillOTE' 


    	FROM 		Referral_FSCallCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_FSCallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
   	WHERE 		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_FSCallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_FSCallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_FSCallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_FSCallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND 		SourceCodeID = @vSourceCodeID
	AND		Referral_FSCallCountSummary.OrganizationID = ISNULL(@vOrgID, Referral_FSCallCountSummary.OrganizationID)



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

