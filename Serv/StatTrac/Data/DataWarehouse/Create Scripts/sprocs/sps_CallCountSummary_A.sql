SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_CallCountSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_CallCountSummary_A]
GO



CREATE PROCEDURE sps_CallCountSummary_A

	@vReportGroupID		int		= 0,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int 		= 0,
	@vOrgID			int		= 0

AS

IF	@vOrgID = 0

    	SELECT 		--Referral_CallCountSummary.OrganizationID, 
    			--OrganizationName, 
			SUM(UnknownOTE) AS 'Unknown OTE', 
			SUM(UnknownTissue) AS 'Unknown Tissue', 
			SUM(UnknownTE) AS 'Unknown T/E', 
			SUM(UnknownEye) AS 'Unknown Eye', 
			SUM(UnknownAgeRO + UnknownMedRO) AS 'Unknown Total RO', 
			SUM(UnknownAgeRO) AS 'Unknown Age RO', 
			SUM(UnknownMedRO) AS 'Unknown Med RO', 
			SUM(UnknownOther) AS 'Unknown Other', 
			SUM(UnknownOtherEye) AS 'Unknown Other Eye', 
			SUM(UnknownOTE +  UnknownTE +  UnknownEye +  UnknownAgeRO +  UnknownMedRO ) AS 'Unknown Totals', 
			SUM(ConsentedOTE) AS 'Consented OTE', 
			SUM(ConsentedTissue) AS 'Consented Tissue', 
			SUM(ConsentedTE) AS 'Consented T/E', 
			SUM(ConsentedEye) AS 'Consented Eye', 
			SUM(ConsentedAgeRO + ConsentedMedRO) AS 'Consented Total RO', 
			SUM(ConsentedAgeRO) AS 'Consented Age RO', 
			SUM(ConsentedMedRO) AS 'Consented Med RO', 
			SUM(ConsentedOther) AS 'Consented Other', 
			SUM(ConsentedOtherEye) AS 'Consented Other Eye', 
			SUM(ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO ) AS 'Consented Totals', 
			SUM(DeniedOTE) AS 'Denied OTE', 
			SUM(DeniedTissue) AS 'Denied Tissue', 
			SUM(DeniedTE) AS 'Denied T/E', 
			SUM(DeniedEye) AS 'Denied Eye', 
			SUM(DeniedAgeRO + DeniedMedRO) AS 'Total Denied RO', 
			SUM(DeniedAgeRO) AS 'Denied Age RO', 
			SUM(DeniedMedRO) AS 'Denied Med RO', 
			SUM(DeniedOther) AS 'Denied Other', 
			SUM(DeniedOtherEye) AS 'Denied Other Eye', 
			SUM(DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO ) AS 'Denied Totals', 
			SUM(NotApprchOTE) AS 'Not Approached OTE', 
			SUM(NotApprchTissue) AS 'Not Approached Tissue', 
			SUM(NotApprchTE) AS 'Not Approached TE', 
			SUM(NotApprchEye) AS 'Not Approached Eye', 
			SUM(NotApprchAgeRO + NotApprchMedRO) AS 'Not Approached Total RO', 
			SUM(NotApprchAgeRO) AS 'Not Approached Age RO', 
			SUM(NotApprchMedRO) AS 'Not Approached Med RO', 
			SUM(NotApprchOther) AS 'Not Approached Other', 
			SUM(NotApprchOtherEye) AS 'Not Approached Other Eye', 
			SUM(NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ) AS 'Not Approached Totals', 
			
			SUM(UnknownOTE + ConsentedOTE + DeniedOTE + NotApprchOTE) AS 'Total Referrals OTE', 
			SUM(UnknownTissue + ConsentedTissue + DeniedTissue + NotApprchTissue ) AS 'Total Referrals Tissue', 
			SUM(UnknownTE + ConsentedTE + DeniedTE + NotApprchTE) AS 'Total Referrals T/E',  
			SUM(UnknownEye + ConsentedEye + DeniedEye + NotApprchEye) AS 'Total Referrals Eye',  
			SUM(UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO + UnknownAgeRO + ConsentedAgeRO + NotApprchAgeRO + DeniedAgeRO) AS 'Total Referrals Total RO',  
			SUM(UnknownAgeRO + ConsentedAgeRO + NotApprchAgeRO + DeniedAgeRO) AS 'Total Referrals Age RO',  
			SUM(UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO) AS 'Total Referrals Med RO', 
			SUM(UnknownOther + ConsentedOther + DeniedOther + NotApprchOther) AS 'Total Referrals Other', 

			SUM(UnknownOTE + UnknownTE + UnknownEye + UnknownAgeRO + UnknownMedRO +  
				ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO  + 
				DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO + 
				NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ) AS 'Total Referrals Totals',
			SUM(UnknownOtherEye + ConsentedOtherEye + DeniedOtherEye + NotApprchOtherEye) AS 'Total Other Eye'				
    	FROM 		Referral_CallCountSummary
	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN 		_ReferralProdReport.dbo.SourceCodeOrganization ON _ReferralProdReport.dbo.SourceCodeOrganization.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	--JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCodeOrganization.SourceCodeID
   	WHERE 		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND 		SourceCodeID = @vSourceCodeID
	--_ReferralProdReport.dbo.SourceCode.
	--GROUP BY	Referral_CallCountSummary.OrganizationID, OrganizationName
    	--ORDER BY 	OrganizationName

IF	@vOrgID > 0

    	SELECT 		--Referral_CallCountSummary.YearID, 
    			--Referral_CallCountSummary.MonthID, 
    			--CAST(Referral_CallCountSummary.YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear, 
			--Referral_CallCountSummary.OrganizationID, 
			--OrganizationName, 
			SUM(UnknownOTE) AS 'Unknown OTE', 
			SUM(UnknownTissue) AS 'Unknown Tissue', 
			SUM(UnknownTE) AS 'Unknown T/E', 
			SUM(UnknownEye) AS 'Unknown Eye', 
			SUM(UnknownAgeRO + UnknownMedRO) AS 'Unknown Total RO', 
			SUM(UnknownAgeRO) AS 'Unknown Age RO', 
			SUM(UnknownMedRO) AS 'Unknown Med RO', 
			SUM(UnknownOther) AS 'Unknown Other', 
			SUM(UnknownOTE +  UnknownTE +  UnknownEye +  UnknownAgeRO +  UnknownMedRO ) AS 'Unknown Totals', 
			SUM(ConsentedOTE) AS 'Consented OTE', 
			SUM(ConsentedTissue) AS 'Consented Tissue', 
			SUM(ConsentedTE) AS 'Consented T/E', 
			SUM(ConsentedEye) AS 'Consented Eye', 
			SUM(ConsentedAgeRO + ConsentedMedRO) AS 'Consented Total RO', 
			SUM(ConsentedAgeRO) AS 'Consented Age RO', 
			SUM(ConsentedMedRO) AS 'Consented Med RO', 
			SUM(ConsentedOther) AS 'Consented Other', 
			SUM(ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO ) AS 'Consented Totals', 
			SUM(DeniedOTE) AS 'Denied OTE', 
			SUM(DeniedTissue) AS 'Denied Tissue', 
			SUM(DeniedTE) AS 'Denied T/E', 
			SUM(DeniedEye) AS 'Denied Eye', 
			SUM(DeniedAgeRO + DeniedMedRO) AS 'Total Denied RO', 
			SUM(DeniedAgeRO) AS 'Denied Age RO', 
			SUM(DeniedMedRO) AS 'Denied Med RO', 
			SUM(DeniedOther) AS 'Denied Other', 
			SUM(DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO ) AS 'Denied Totals', 
			SUM(NotApprchOTE) AS 'Not Approached OTE', 
			SUM(NotApprchTissue) AS 'Not Approached Tissue', 
			SUM(NotApprchTE) AS 'Not Approached TE', 
			SUM(NotApprchEye) AS 'Not Approached Eye', 
			SUM(NotApprchAgeRO + NotApprchMedRO) AS 'Not Approached Total RO', 
			SUM(NotApprchAgeRO) AS 'Not Approached Age RO', 
			SUM(NotApprchMedRO) AS 'Not Approached Med RO', 
			SUM(NotApprchOther) AS 'Not Approached Other', 
			SUM(NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ) AS 'Not Approached Totals', 
			
			SUM(UnknownOTE + ConsentedOTE + DeniedOTE + NotApprchOTE) AS 'Total Referrals OTE', 
			SUM(UnknownTissue + ConsentedTissue + DeniedTissue + NotApprchTissue ) AS 'Total Referrals Tissue', 
			SUM(UnknownTE + ConsentedTE + DeniedTE + NotApprchTE) AS 'Total Referrals T/E',  
			SUM(UnknownEye + ConsentedEye + DeniedEye + NotApprchEye) AS 'Total Referrals Eye',  
			SUM(UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO + UnknownAgeRO + ConsentedAgeRO + NotApprchAgeRO + DeniedAgeRO) AS 'Total Referrals Total RO',  
			SUM(UnknownAgeRO + ConsentedAgeRO + NotApprchAgeRO + DeniedAgeRO) AS 'Total Referrals Age RO',  
			SUM(UnknownMedRO + ConsentedMedRO + DeniedMedRO + NotApprchMedRO) AS 'Total Referrals Med RO', 

			SUM(UnknownOther + ConsentedOther + DeniedOther + NotApprchOther) AS 'Total Referrals Other', 

			SUM(UnknownOTE + UnknownTE + UnknownEye + UnknownAgeRO + UnknownMedRO +  
				ConsentedOTE + ConsentedTE + ConsentedEye + ConsentedAgeRO + ConsentedMedRO  + 
				DeniedOTE + DeniedTE + DeniedEye + DeniedAgeRO + DeniedMedRO + 
				NotApprchOTE + NotApprchTE + NotApprchEye + NotApprchAgeRO + NotApprchMedRO ) AS 'Total Referrals Totals' 
    	FROM 		Referral_CallCountSummary
	LEFT JOIN	Referral_ApproachCount ON Referral_ApproachCount.OrganizationID = Referral_CallCountSummary.OrganizationID 
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_CallCountSummary.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_CallCountSummary.MonthID
	JOIN 		_ReferralProdReport.dbo.SourceCodeOrganization ON _ReferralProdReport.dbo.SourceCodeOrganization.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCodeOrganization.SourceCodeID

   	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Referral_CallCountSummary.MonthID AS varchar(2)) + '/1/' + CAST(Referral_CallCountSummary.YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_CallCountSummary.OrganizationID = @vOrgID
	AND 		_ReferralProdReport.dbo.SourceCode.SourceCodeID = @vSourceCodeID

	--GROUP BY	Referral_CallCountSummary.YearID, Referral_CallCountSummary.MonthID, CAST(Referral_CallCountSummary.YearID AS varchar(4)) + ' ' + RTrim(MonthName), Referral_CallCountSummary.OrganizationID, OrganizationName
    	--ORDER BY 	Referral_CallCountSummary.YearID, Referral_CallCountSummary.MonthID, OrganizationName













GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

