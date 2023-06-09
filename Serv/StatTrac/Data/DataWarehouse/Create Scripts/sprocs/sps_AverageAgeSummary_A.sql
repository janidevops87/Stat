SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AverageAgeSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AverageAgeSummary_A]
GO







CREATE PROCEDURE sps_AverageAgeSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

SET NOCOUNT ON 

IF	@vOrgID = 0

       SELECT 	        Referral_AverageAgeCount.DonorGender,
                        Avg(AllTypesAge) AS AllTypesAge,
                        Avg(AppropriateOrganAge) AS AppropriateOrganAge,
                        Avg(AppropriateAllTissueAge) AS AppropriateAllTissueAge,
                        Avg(AppropriateEyesAge) AS AppropriateEyesAge,
                        Avg(AppropriateROAge) AS AppropriateROAge,
		
	          --2/8/02 drh
	          Avg(AllTypesAge_Reg) AS AllTypesAge_Reg,
                        Avg(AppropriateOrganAge_Reg) AS AppropriateOrganAge_Reg,
                       Avg(AppropriateAllTissueAge_Reg) AS AppropriateAllTissueAge_Reg,
                        Avg(AppropriateEyesAge_Reg) AS AppropriateEyesAge_Reg,
                        Avg(AppropriateROAge_Reg) AS AppropriateROAge_Reg

    	FROM 		Referral_AverageAgeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AverageAgeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AverageAgeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	GROUP BY	Referral_AverageAgeCount.DonorGender
        
        --End Section @vOrgID = 0

IF	@vOrgID > 0
        --Begin Section @vOrgID >0
       SELECT 	        Referral_AverageAgeCount.DonorGender,
                        Avg(AllTypesAge) AS AllTypesAge,
                        Avg(AppropriateOrganAge) AS AppropriateOrganAge ,
                        Avg(AppropriateAllTissueAge) AS AppropriateAllTissueAge ,
                        Avg(AppropriateEyesAge) AS AppropriateEyesAge ,
                        Avg(AppropriateROAge) AS AppropriateROAge,
		
	          --2/8/02 drh
	          Avg(AllTypesAge_Reg) AS AllTypesAge_Reg,
                        Avg(AppropriateOrganAge_Reg) AS AppropriateOrganAge_Reg,
                       Avg(AppropriateAllTissueAge_Reg) AS AppropriateAllTissueAge_Reg,
                        Avg(AppropriateEyesAge_Reg) AS AppropriateEyesAge_Reg,
                        Avg(AppropriateROAge_Reg) AS AppropriateROAge_Reg

    	FROM 		Referral_AverageAgeCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AverageAgeCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AverageAgeCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
        AND		Referral_AverageAgeCount.OrganizationID = @vOrgID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	GROUP BY	Referral_AverageAgeCount.DonorGender

        --End Section @vOrgID > 0









GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

