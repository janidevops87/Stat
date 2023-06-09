SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_AppropriateReasonSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_AppropriateReasonSummary_A]
GO




CREATE   PROCEDURE sps_AppropriateReasonSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS
/* ccarroll 11/17/2006	added No Neuro Injury*/

IF	@vOrgID = 0

    	SELECT 		/*Referral_AppropriateReasonCount.OrganizationID,
			OrganizationName, */
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateBone) AS AppropriateBone,
			Sum(AppropriateTissue) AS AppropriateTissue,
			Sum(AppropriateSkin) AS AppropriateSkin,
			Sum(AppropriateValves) AS AppropriateValves,
			Sum(AppropriateEyes) AS AppropriateEyes,

			Sum(AppropriateOrganUnappropriate) AS AppropriateOrganUnAppropriate, 
			Sum(AppropriateBoneUnAppropriate) AS AppropriateBoneUnAppropriate,
			Sum(AppropriateTissueUnAppropriate) AS AppropriateTissueUnAppropriate,
			Sum(AppropriateSkinUnAppropriate) AS AppropriateSkinUnAppropriate,
			Sum(AppropriateValvesUnAppropriate) AS AppropriateValvesUnAppropriate,
			Sum(AppropriateEyesUnAppropriate) AS AppropriateEyesUnAppropriate,

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

			Sum(AppropriateOrganNotAppropriate) AS AppropriateOrganNtAppropriate, 
			Sum(AppropriateBoneNotAppropriate) AS AppropriateBoneNtAppropriate,
			Sum(AppropriateTissueNotAppropriate) AS AppropriateTissueNtAppropriate,
			Sum(AppropriateSkinNotAppropriate) AS AppropriateSkinNtAppropriate,
			Sum(AppropriateValvesNotAppropriate) AS AppropriateValvesNtAppropriate,
			Sum(AppropriateEyesNotAppropriate) AS AppropriateEyesNtAppropriate,

			Sum(AppropriateOrganPreviousVent) AS AppropriateOrganPreviousVent, 
			Sum(AppropriateBonePreviousVent) AS AppropriateBonePreviousVent,
			Sum(AppropriateTissuePreviousVent) AS AppropriateTissuePreviousVent,
			Sum(AppropriateSkinPreviousVent) AS AppropriateSkinPreviousVent,
			Sum(AppropriateValvesPreviousVent) AS AppropriateValvesPreviousVent,
			Sum(AppropriateEyesPreviousVent) AS AppropriateEyesPreviousVent,

			--ccarroll 11/17/2006	added No Neuro Injury
			Sum(AppropriateOrganNoNeuroInjury) AS AppropriateOrganNoNeuroInjury, 
			Sum(AppropriateBoneNoNeuroInjury) AS AppropriateBoneNoNeuroInjury,
			Sum(AppropriateTissueNoNeuroInjury) AS AppropriateTissueNoNeuroInjury,
			Sum(AppropriateSkinNoNeuroInjury) AS AppropriateSkinNoNeuroInjury,
			Sum(AppropriateValvesNoNeuroInjury) AS AppropriateValvesNoNeuroInjury,
			Sum(AppropriateEyesNoNeuroInjury) AS AppropriateEyesNoNeuroInjury,

			Sum(AppropriateOrganReg) AS AppropriateOrganReg, 
			Sum(AppropriateBoneReg) AS AppropriateBoneReg,
			Sum(AppropriateTissueReg) AS AppropriateTissueReg,
			Sum(AppropriateSkinReg) AS AppropriateSkinReg,
			Sum(AppropriateValvesReg) AS AppropriateValvesReg,
			Sum(AppropriateEyesReg) AS AppropriateEyesReg,

			Sum(AppropriateOrganNReg) AS AppropriateOrganNReg, 
			Sum(AppropriateBoneNReg) AS AppropriateBoneNReg,
			Sum(AppropriateTissueNReg) AS AppropriateTissueNReg,
			Sum(AppropriateSkinNReg) AS AppropriateSkinNReg,
			Sum(AppropriateValvesNReg) AS AppropriateValvesNReg,
			Sum(AppropriateEyesNReg) AS AppropriateEyesNReg


    	FROM 		Referral_AppropriateReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

--	GROUP BY	Referral_AppropriateReasonCount.OrganizationID, OrganizationName
--    	ORDER BY 	OrganizationName

IF	@vOrgID > 0

    	SELECT 	--YearID, 
			--Referral_AppropriateReasonCount.MonthID AS MonthID, 
			--OrganizationName, 
			--CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear,
			Sum(AppropriateOrgan) AS AppropriateOrgan, 
			Sum(AppropriateBone) AS AppropriateBone,
			Sum(AppropriateTissue) AS AppropriateTissue,
			Sum(AppropriateSkin) AS AppropriateSkin,
			Sum(AppropriateValves) AS AppropriateValves,
			Sum(AppropriateEyes) AS AppropriateEyes,

			Sum(AppropriateOrganUnAppropriate) AS AppropriateOrganUnAppropriate, 
			Sum(AppropriateBoneUnAppropriate) AS AppropriateBoneUnAppropriate,
			Sum(AppropriateTissueUnAppropriate) AS AppropriateTissueUnAppropriate,
			Sum(AppropriateSkinUnAppropriate) AS AppropriateSkinUnAppropriate,
			Sum(AppropriateValvesUnAppropriate) AS AppropriateValvesUnAppropriate,
			Sum(AppropriateEyesUnAppropriate) AS AppropriateEyesUnAppropriate,

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

			Sum(AppropriateOrganNotAppropriate) AS AppropriateOrganNtAppropriate, 
			Sum(AppropriateBoneNotAppropriate) AS AppropriateBoneNtAppropriate,
			Sum(AppropriateTissueNotAppropriate) AS AppropriateTissueNtAppropriate,
			Sum(AppropriateSkinNotAppropriate) AS AppropriateSkinNtAppropriate,
			Sum(AppropriateValvesNotAppropriate) AS AppropriateValvesNtAppropriate,
			Sum(AppropriateEyesNotAppropriate) AS AppropriateEyesNtAppropriate,

			Sum(AppropriateOrganPreviousVent) AS AppropriateOrganPreviousVent, 
			Sum(AppropriateBonePreviousVent) AS AppropriateBonePreviousVent,
			Sum(AppropriateTissuePreviousVent) AS AppropriateTissuePreviousVent,
			Sum(AppropriateSkinPreviousVent) AS AppropriateSkinPreviousVent,
			Sum(AppropriateValvesPreviousVent) AS AppropriateValvesPreviousVent,
			Sum(AppropriateEyesPreviousVent) AS AppropriateEyesPreviousVent,

			--ccarroll 11/17/2006	added No Neuro Injury
			Sum(AppropriateOrganNoNeuroInjury) AS AppropriateOrganNoNeuroInjury, 
			Sum(AppropriateBoneNoNeuroInjury) AS AppropriateBoneNoNeuroInjury,
			Sum(AppropriateTissueNoNeuroInjury) AS AppropriateTissueNoNeuroInjury,
			Sum(AppropriateSkinNoNeuroInjury) AS AppropriateSkinNoNeuroInjury,
			Sum(AppropriateValvesNoNeuroInjury) AS AppropriateValvesNoNeuroInjury,
			Sum(AppropriateEyesNoNeuroInjury) AS AppropriateEyesNoNeuroInjury,

			Sum(AppropriateOrganReg) AS AppropriateOrganReg, 
			Sum(AppropriateBoneReg) AS AppropriateBoneReg,
			Sum(AppropriateTissueReg) AS AppropriateTissueReg,
			Sum(AppropriateSkinReg) AS AppropriateSkinReg,
			Sum(AppropriateValvesReg) AS AppropriateValvesReg,
			Sum(AppropriateEyesReg) AS AppropriateEyesReg,

			Sum(AppropriateOrganNReg) AS AppropriateOrganNReg, 
			Sum(AppropriateBoneNReg) AS AppropriateBoneNReg,
			Sum(AppropriateTissueNReg) AS AppropriateTissueNReg,
			Sum(AppropriateSkinNReg) AS AppropriateSkinNReg,
			Sum(AppropriateValvesNReg) AS AppropriateValvesNReg,
			Sum(AppropriateEyesNReg) AS AppropriateEyesNReg


    	FROM 		Referral_AppropriateReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_AppropriateReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_AppropriateReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_AppropriateReasonCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_AppropriateReasonCount.OrganizationID = @vOrgID

/*
	GROUP BY	YearID, Referral_AppropriateReasonCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_AppropriateReasonCount.OrganizationID, OrganizationName 

   	ORDER BY 	YearID, Referral_AppropriateReasonCountReferral_AppropriateReasonCount.MonthID, OrganizationName
*/





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

