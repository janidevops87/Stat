SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_NWLEB_1_AllReferrals]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_NWLEB_1_AllReferrals]
GO


CREATE PROCEDURE sps_NWLEB_1_AllReferrals

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

/********************************************************************************************************************************************************
***** Date: 1/16/04                                                          
***** mds: This stored procedure was created by copying the sps_AppropriateReasonSummary_A stored proc and eliminating  
***** non-eye information to create a report very similar to Reason Summary
********************************************************************************************************************************************************/

IF	@vOrgID = 0

    	SELECT 	
			Sum(AppropriateEyes) AS AppropriateEyes,
			Sum(AppropriateEyesUnAppropriate) AS AppropriateEyesUnAppropriate,
			Sum(AppropriateEyesAge) AS AppropriateEyesAge,
			Sum(AppropriateEyesHighRisk) AS AppropriateEyesHighRisk,
			Sum(AppropriateEyesMedRO) AS AppropriateEyesMedRO,
			Sum(AppropriateEyesNotAppropriate) AS AppropriateEyesNtAppropriate,
			Sum(AppropriateEyesPreviousVent) AS AppropriateEyesPreviousVent

    	FROM 		Referral_AppropriateReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate


IF	@vOrgID > 0

    	SELECT 	
			Sum(AppropriateEyes) AS AppropriateEyes,
			Sum(AppropriateEyesUnAppropriate) AS AppropriateEyesUnAppropriate,
			Sum(AppropriateEyesAge) AS AppropriateEyesAge,
			Sum(AppropriateEyesHighRisk) AS AppropriateEyesHighRisk,
			Sum(AppropriateEyesMedRO) AS AppropriateEyesMedRO,
			Sum(AppropriateEyesNotAppropriate) AS AppropriateEyesNtAppropriate,
			Sum(AppropriateEyesPreviousVent) AS AppropriateEyesPreviousVent

    	FROM 		Referral_AppropriateReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_AppropriateReasonCount.MonthID

	WHERE 	_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_AppropriateReasonCount.OrganizationID = @vOrgID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

