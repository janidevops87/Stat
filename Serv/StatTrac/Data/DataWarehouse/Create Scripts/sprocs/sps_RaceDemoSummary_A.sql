SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RaceDemoSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RaceDemoSummary_A]
GO






CREATE PROCEDURE sps_RaceDemoSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

CREATE TABLE #Temp_Race
   (
   RaceID [int],
   RaceName varchar (80)
   )
   
INSERT #Temp_Race
   (RaceID, RaceName)
   SELECT RaceID, RaceName
   FROM   _ReferralProdReport.dbo.Race

INSERT #Temp_Race
   (RaceID, RaceName)
   Values(-1, 'Unknown')   



IF	@vOrgID = 0

    	SELECT          Referral_RaceDemoCount.RaceID AS RaceID,  
          		RaceName,
                        DonorGender,
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, 
			Sum(AppropriateRO) AS AppropriateRO,

			--drh 2/15/02
			Sum(AllTypes_Reg) AS AllTypes_Reg,
			Sum(AppropriateOrgan_Reg) AS AppropriateOrgan_Reg, 
			Sum(AppropriateAllTissue_Reg) AS AppropriateAllTissue_Reg,
			Sum(AppropriateEyes_Reg) AS AppropriateEyes_Reg, 
			Sum(AppropriateRO_Reg) AS AppropriateRO_Reg

    	FROM 		Referral_RaceDemoCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_RaceDemoCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_RaceDemoCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN            #Temp_Race ON #Temp_Race.RaceID =  Referral_RaceDemoCount.RaceID
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	DonorGender, RaceName, Referral_RaceDemoCount.RaceID
    	ORDER BY 	DonorGender desc, RaceName

IF	@vOrgID > 0

    	SELECT          Referral_RaceDemoCount.RaceID AS RaceID,  
          		RaceName,                         
                        DonorGender,
			Sum(AllTypes) AS AllTypes,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateAllTissue) AS AppropriateAllTissue,
			Sum(AppropriateEyes) AS AppropriateEyes, 
			Sum(AppropriateRO) AS AppropriateRO,

			--drh 2/15/02
			Sum(AllTypes_Reg) AS AllTypes_Reg,
			Sum(AppropriateOrgan_Reg) AS AppropriateOrgan_Reg, 
			Sum(AppropriateAllTissue_Reg) AS AppropriateAllTissue_Reg,
			Sum(AppropriateEyes_Reg) AS AppropriateEyes_Reg, 
			Sum(AppropriateRO_Reg) AS AppropriateRO_Reg

    	FROM 		Referral_RaceDemoCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_RaceDemoCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_RaceDemoCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN            #Temp_Race ON #Temp_Race.RaceID =  Referral_RaceDemoCount.RaceID
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_RaceDemoCount.OrganizationID = @vOrgID

	GROUP BY	DonorGender, RaceName,Referral_RaceDemoCount.RaceID
    	ORDER BY 	DonorGender desc, RaceName


DROP TABLE #Temp_Race







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

