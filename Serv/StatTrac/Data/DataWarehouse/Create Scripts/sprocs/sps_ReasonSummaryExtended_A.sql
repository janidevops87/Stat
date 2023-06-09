SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReasonSummaryExtended_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReasonSummaryExtended_A]
GO




CREATE PROCEDURE sps_ReasonSummaryExtended_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS

IF	@vOrgID = 0

    	SELECT 		Referral_AppropriateReasonExtendedCount.OrganizationID,
			OrganizationName, 
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateBone) AS AppropriateBone,
			Sum(AppropriateTissue) AS AppropriateTissue,
			Sum(AppropriateSkin) AS AppropriateSkin,
			Sum(AppropriateValves) AS AppropriateValves,
			Sum(AppropriateEyes) AS AppropriateEyes,

			Sum(AppropriateOrganAge) AS AppropriateOrganAge, 
			Sum(AppropriateBoneAge) AS AppropriateBoneAge,
			Sum(AppropriateTissueAge) AS AppropriateTissueAge,
			Sum(AppropriateSkinAge) AS AppropriateSkinAge,
			Sum(AppropriateValvesAge) AS AppropriateValvesAge,
			Sum(AppropriateEyesAge) AS AppropriateEyesAge,
	
			Sum(AppropriateOrganHighRisk) AS AppropriateOrganHighRisk, 
			Sum(AppropriateBoneHighRisk) AS AppropriateBoneHighRisk,
			Sum(AppropriateTissueHighRisk) AS AppropriateTissueHighRisk,
			Sum(AppropriateSkinHighRisk) AS AppropriateSkinHighRisk,
			Sum(AppropriateValvesHighRisk) AS AppropriateValvesHighRisk,
			Sum(AppropriateEyesHighRisk) AS AppropriateEyesHighRisk,

			Sum(AppropriateOrganMedRO) AS AppropriateOrganMedRO, 
			Sum(AppropriateBoneMedRO) AS AppropriateBoneMedRO,
			Sum(AppropriateTissueMedRO) AS AppropriateTissueMedRO,
			Sum(AppropriateSkinMedRO) AS AppropriateSkinMedRO,
			Sum(AppropriateValvesMedRO) AS AppropriateValvesMedRO,
			Sum(AppropriateEyesMedRO) AS AppropriateEyesMedRO,

			Sum(AppropriateOrganNotAppropriate) AS AppropriateOrganNotAppropriate, 
			Sum(AppropriateBoneNotAppropriate) AS AppropriateBoneNotAppropriate,
			Sum(AppropriateTissueNotAppropriate) AS AppropriateTissueNotAppropriate,
			Sum(AppropriateSkinNotAppropriate) AS AppropriateSkinNotAppropriate,
			Sum(AppropriateValvesNotAppropriate) AS AppropriateValvesNotAppropriate,
			Sum(AppropriateEyesNotAppropriate) AS AppropriateEyesNotAppropriate,

			Sum(AppropriateOrganPreviousVent) AS AppropriateOrganPreviousVent, 
			Sum(AppropriateBonePreviousVent) AS AppropriateBonePreviousVent,
			Sum(AppropriateTissuePreviousVent) AS AppropriateTissuePreviousVent,
			Sum(AppropriateSkinPreviousVent) AS AppropriateSkinPreviousVent,
			Sum(AppropriateValvesPreviousVent) AS AppropriateValvesPreviousVent,
			Sum(AppropriateEyesPreviousVent) AS AppropriateEyesPreviousVent


    	FROM 		Referral_AppropriateReasonExtendedCount
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonExtendedCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

	GROUP BY	Referral_AppropriateReasonExtendedCount.OrganizationID, OrganizationName
    	ORDER BY 	OrganizationName

IF	@vOrgID > 0

    	SELECT 		YearID, Referral_AppropriateReasonExtendedCount.MonthID AS MonthID, 
			CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear,
			OrganizationName, 
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateBone) AS AppropriateBone,
			Sum(AppropriateTissue) AS AppropriateTissue,
			Sum(AppropriateSkin) AS AppropriateSkin,
			Sum(AppropriateValves) AS AppropriateValves,
			Sum(AppropriateEyes) AS AppropriateEyes,

			Sum(AppropriateOrganAge) AS AppropriateOrganAge, 
			Sum(AppropriateBoneAge) AS AppropriateBoneAge,
			Sum(AppropriateTissueAge) AS AppropriateTissueAge,
			Sum(AppropriateSkinAge) AS AppropriateSkinAge,
			Sum(AppropriateValvesAge) AS AppropriateValvesAge,

			Sum(AppropriateEyesAge) AS AppropriateEyesAge,
	
			Sum(AppropriateOrganHighRisk) AS AppropriateOrganHighRisk, 
			Sum(AppropriateBoneHighRisk) AS AppropriateBoneHighRisk,
			Sum(AppropriateTissueHighRisk) AS AppropriateTissueHighRisk,
			Sum(AppropriateSkinHighRisk) AS AppropriateSkinHighRisk,
			Sum(AppropriateValvesHighRisk) AS AppropriateValvesHighRisk,
			Sum(AppropriateEyesHighRisk) AS AppropriateEyesHighRisk,

			Sum(AppropriateOrganMedRO) AS AppropriateOrganMedRO, 
			Sum(AppropriateBoneMedRO) AS AppropriateBoneMedRO,
			Sum(AppropriateTissueMedRO) AS AppropriateTissueMedRO,
			Sum(AppropriateSkinMedRO) AS AppropriateSkinMedRO,
			Sum(AppropriateValvesMedRO) AS AppropriateValvesMedRO,
			Sum(AppropriateEyesMedRO) AS AppropriateEyesMedRO,

			Sum(AppropriateOrganNotAppropriate) AS AppropriateOrganNotAppropriate, 
			Sum(AppropriateBoneNotAppropriate) AS AppropriateBoneNotAppropriate,
			Sum(AppropriateTissueNotAppropriate) AS AppropriateTissueNotAppropriate,
			Sum(AppropriateSkinNotAppropriate) AS AppropriateSkinNotAppropriate,
			Sum(AppropriateValvesNotAppropriate) AS AppropriateValvesNotAppropriate,
			Sum(AppropriateEyesNotAppropriate) AS AppropriateEyesNotAppropriate,

			Sum(AppropriateOrganPreviousVent) AS AppropriateOrganPreviousVent, 
			Sum(AppropriateBonePreviousVent) AS AppropriateBonePreviousVent,
			Sum(AppropriateTissuePreviousVent) AS AppropriateTissuePreviousVent,
			Sum(AppropriateSkinPreviousVent) AS AppropriateSkinPreviousVent,
			Sum(AppropriateValvesPreviousVent) AS AppropriateValvesPreviousVent,
			Sum(AppropriateEyesPreviousVent) AS AppropriateEyesPreviousVent


    	FROM 		Referral_AppropriateReasonExtendedCount
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonExtendedCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_AppropriateReasonExtendedCount.MonthID

   	WHERE 		WebReportGroupID = @vReportGroupID	
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_AppropriateReasonExtendedCount.OrganizationID = @vOrgID

	GROUP BY	YearID, Referral_AppropriateReasonExtendedCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_AppropriateReasonExtendedCount.OrganizationID, OrganizationName 
    	ORDER BY 	YearID, Referral_AppropriateReasonExtendedCountReferral_AppropriateReasonExtendedCount.MonthID, OrganizationName







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

