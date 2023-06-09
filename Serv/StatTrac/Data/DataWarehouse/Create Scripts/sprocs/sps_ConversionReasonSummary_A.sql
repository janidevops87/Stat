SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ConversionReasonSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ConversionReasonSummary_A]
GO




CREATE   PROCEDURE sps_ConversionReasonSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS
/* ccarroll 11/20/2006 Added conversion options StatTrac 8.2 */

IF	@vOrgID = 0

    	SELECT 		
			Sum(ConversionOrgan) AS ConversionOrgan, 
			Sum(ConversionBone) AS ConversionBone,
			Sum(ConversionTissue) AS ConversionTissue,
			Sum(ConversionSkin) AS ConversionSkin,
			Sum(ConversionValves) AS ConversionValves,
			Sum(ConversionEyes) AS ConversionEyes,

			Sum(ConversionOrganNotRecovered) AS ConversionOrganNotRecovered, 
			Sum(ConversionBoneNotRecovered) AS ConversionBoneNotRecovered,
			Sum(ConversionTissueNotRecovered) AS ConversionTissueNotRecovered,
			Sum(ConversionSkinNotRecovered) AS ConversionSkinNotRecovered,
			Sum(ConversionValvesNotRecovered) AS ConversionValvesNotRecovered,
			Sum(ConversionEyesNotRecovered) AS ConversionEyesNotRecovered,

			Sum(ConversionOrganCoronerRuleout) AS ConversionOrganCoronerRuleout, 
			Sum(ConversionBoneCoronerRuleout) AS ConversionBoneCoronerRuleout,
			Sum(ConversionTissueCoronerRuleout) AS ConversionTissueCoronerRuleout,
			Sum(ConversionSkinCoronerRuleout) AS ConversionSkinCoronerRuleout,
			Sum(ConversionValvesCoronerRuleout) AS ConversionValvesCoronerRuleout,
			Sum(ConversionEyesCoronerRuleout) AS ConversionEyesCoronerRuleout,
	
			Sum(ConversionOrganArrest) AS ConversionOrganArrest, 
			Sum(ConversionBoneArrest) AS ConversionBoneArrest,
			Sum(ConversionTissueArrest) AS ConversionTissueArrest,
			Sum(ConversionSkinArrest) AS ConversionSkinArrest,
			Sum(ConversionValvesArrest) AS ConversionValvesArrest,
			Sum(ConversionEyesArrest) AS ConversionEyesArrest,

			Sum(ConversionOrganNeverBrainDead) AS ConversionOrganNeverBrainDead, 
			Sum(ConversionBoneNeverBrainDead) AS ConversionBoneNeverBrainDead,
			Sum(ConversionTissueNeverBrainDead) AS ConversionTissueNeverBrainDead,
			Sum(ConversionSkinNeverBrainDead) AS ConversionSkinNeverBrainDead,
			Sum(ConversionValvesNeverBrainDead) AS ConversionValvesNeverBrainDead,
			Sum(ConversionEyesNeverBrainDead) AS ConversionEyesNeverBrainDead,

			Sum(ConversionOrganMedRO) AS ConversionOrganMedRO, 
			Sum(ConversionBoneMedRO) AS ConversionBoneMedRO,
			Sum(ConversionTissueMedRO) AS ConversionTissueMedRO,
			Sum(ConversionSkinMedRO) AS ConversionSkinMedRO,
			Sum(ConversionValvesMedRO) AS ConversionValvesMedRO,
			Sum(ConversionEyesMedRO) AS ConversionEyesMedRO,

			Sum(ConversionOrganHighRisk) AS ConversionOrganHighRisk, 
			Sum(ConversionBoneHighRisk) AS ConversionBoneHighRisk,
			Sum(ConversionTissueHighRisk) AS ConversionTissueHighRisk,
			Sum(ConversionSkinHighRisk) AS ConversionSkinHighRisk,
			Sum(ConversionValvesHighRisk) AS ConversionValvesHighRisk,
			Sum(ConversionEyesHighRisk) AS ConversionEyesHighRisk,

			Sum(ConversionOrganTimeLogistics) AS ConversionOrganTimeLogistics, 
			Sum(ConversionBoneTimeLogistics) AS ConversionBoneTimeLogistics,
			Sum(ConversionTissueTimeLogistics) AS ConversionTissueTimeLogistics,
			Sum(ConversionSkinTimeLogistics) AS ConversionSkinTimeLogistics,
			Sum(ConversionValvesTimeLogistics) AS ConversionValvesTimeLogistics,
			Sum(ConversionEyesTimeLogistics) AS ConversionEyesTimeLogistics,

			Sum(ConversionOrganHeartTxable) AS ConversionOrganHeartTxable, 
			Sum(ConversionBoneHeartTxable) AS ConversionBoneHeartTxable,
			Sum(ConversionTissueHeartTxable) AS ConversionTissueHeartTxable,
			Sum(ConversionSkinHeartTxable) AS ConversionSkinHeartTxable,
			Sum(ConversionValvesHeartTxable) AS ConversionValvesHeartTxable,
			Sum(ConversionEyesHeartTxable) AS ConversionEyesHeartTxable,

			Sum(ConversionOrganUnknown) AS ConversionOrganUnknown, 
			Sum(ConversionBoneUnknown) AS ConversionBoneUnknown,
			Sum(ConversionTissueUnknown) AS ConversionTissueUnknown,
			Sum(ConversionSkinUnknown) AS ConversionSkinUnknown,
			Sum(ConversionValvesUnknown) AS ConversionValvesUnknown,
			Sum(ConversionEyesUnknown) AS ConversionEyesUnknown,

			--drh 10/31/01
			Sum(RegConversionOrgan) AS RegConversionOrgan, 
			Sum(RegConversionBone) AS RegConversionBone,
			Sum(RegConversionTissue) AS RegConversionTissue,
			Sum(RegConversionSkin) AS RegConversionSkin,
			Sum(RegConversionValves) AS RegConversionValves,
			Sum(RegConversionEyes) AS RegConversionEyes,

			Sum(RegConversionOrganNotRecovered) AS RegConversionOrganNotRecovered, 
			Sum(RegConversionBoneNotRecovered) AS RegConversionBoneNotRecovered,
			Sum(RegConversionTissueNotRecovered) AS RegConversionTissueNotRecovered,
			Sum(RegConversionSkinNotRecovered) AS RegConversionSkinNotRecovered,
			Sum(RegConversionValvesNotRecovered) AS RegConversionValvesNotRecovered,
			Sum(RegConversionEyesNotRecovered) AS RegConversionEyesNotRecovered,

			Sum(RegConversionOrganCoronerRuleout) AS RegConversionOrganCoronerRuleout, 
			Sum(RegConversionBoneCoronerRuleout) AS RegConversionBoneCoronerRuleout,
			Sum(RegConversionTissueCoronerRuleout) AS RegConversionTissueCoronerRuleout,
			Sum(RegConversionSkinCoronerRuleout) AS RegConversionSkinCoronerRuleout,
			Sum(RegConversionValvesCoronerRuleout) AS RegConversionValvesCoronerRuleout,
			Sum(RegConversionEyesCoronerRuleout) AS RegConversionEyesCoronerRuleout,
	
			Sum(RegConversionOrganArrest) AS RegConversionOrganArrest, 
			Sum(RegConversionBoneArrest) AS RegConversionBoneArrest,
			Sum(RegConversionTissueArrest) AS RegConversionTissueArrest,
			Sum(RegConversionSkinArrest) AS RegConversionSkinArrest,
			Sum(RegConversionValvesArrest) AS RegConversionValvesArrest,
			Sum(RegConversionEyesArrest) AS RegConversionEyesArrest,

			Sum(RegConversionOrganNeverBrainDead) AS RegConversionOrganNeverBrainDead, 
			Sum(RegConversionBoneNeverBrainDead) AS RegConversionBoneNeverBrainDead,
			Sum(RegConversionTissueNeverBrainDead) AS RegConversionTissueNeverBrainDead,
			Sum(RegConversionSkinNeverBrainDead) AS RegConversionSkinNeverBrainDead,
			Sum(RegConversionValvesNeverBrainDead) AS RegConversionValvesNeverBrainDead,
			Sum(RegConversionEyesNeverBrainDead) AS RegConversionEyesNeverBrainDead,

			Sum(RegConversionOrganMedRO) AS RegConversionOrganMedRO, 
			Sum(RegConversionBoneMedRO) AS RegConversionBoneMedRO,
			Sum(RegConversionTissueMedRO) AS RegConversionTissueMedRO,
			Sum(RegConversionSkinMedRO) AS RegConversionSkinMedRO,
			Sum(RegConversionValvesMedRO) AS RegConversionValvesMedRO,
			Sum(RegConversionEyesMedRO) AS RegConversionEyesMedRO,

			Sum(RegConversionOrganHighRisk) AS RegConversionOrganHighRisk, 
			Sum(RegConversionBoneHighRisk) AS RegConversionBoneHighRisk,
			Sum(RegConversionTissueHighRisk) AS RegConversionTissueHighRisk,
			Sum(RegConversionSkinHighRisk) AS RegConversionSkinHighRisk,
			Sum(RegConversionValvesHighRisk) AS RegConversionValvesHighRisk,
			Sum(RegConversionEyesHighRisk) AS RegConversionEyesHighRisk,

			Sum(RegConversionOrganTimeLogistics) AS RegConversionOrganTimeLogistics, 
			Sum(RegConversionBoneTimeLogistics) AS RegConversionBoneTimeLogistics,
			Sum(RegConversionTissueTimeLogistics) AS RegConversionTissueTimeLogistics,
			Sum(RegConversionSkinTimeLogistics) AS RegConversionSkinTimeLogistics,
			Sum(RegConversionValvesTimeLogistics) AS RegConversionValvesTimeLogistics,
			Sum(RegConversionEyesTimeLogistics) AS RegConversionEyesTimeLogistics,

			Sum(RegConversionOrganHeartTxable) AS RegConversionOrganHeartTxable, 
			Sum(RegConversionBoneHeartTxable) AS RegConversionBoneHeartTxable,
			Sum(RegConversionTissueHeartTxable) AS RegConversionTissueHeartTxable,
			Sum(RegConversionSkinHeartTxable) AS RegConversionSkinHeartTxable,
			Sum(RegConversionValvesHeartTxable) AS RegConversionValvesHeartTxable,
			Sum(RegConversionEyesHeartTxable) AS RegConversionEyesHeartTxable,

			Sum(RegConversionOrganUnknown) AS RegConversionOrganUnknown, 
			Sum(RegConversionBoneUnknown) AS RegConversionBoneUnknown,
			Sum(RegConversionTissueUnknown) AS RegConversionTissueUnknown,
			Sum(RegConversionSkinUnknown) AS RegConversionSkinUnknown,
			Sum(RegConversionValvesUnknown) AS RegConversionValvesUnknown,
			Sum(RegConversionEyesUnknown) AS RegConversionEyesUnknown,

			--drh 11/20/01
			Sum(ConversionOrganFamilyRO) AS ConversionOrganFamilyRO, 
			Sum(ConversionBoneFamilyRO) AS ConversionBoneFamilyRO,
			Sum(ConversionTissueFamilyRO) AS ConversionTissueFamilyRO,
			Sum(ConversionSkinFamilyRO) AS ConversionSkinFamilyRO,
			Sum(ConversionValvesFamilyRO) AS ConversionValvesFamilyRO,
			Sum(ConversionEyesFamilyRO) AS ConversionEyesFamilyRO,

			Sum(RegConversionOrganFamilyRO) AS RegConversionOrganFamilyRO, 
			Sum(RegConversionBoneFamilyRO) AS RegConversionBoneFamilyRO,
			Sum(RegConversionTissueFamilyRO) AS RegConversionTissueFamilyRO,
			Sum(RegConversionSkinFamilyRO) AS RegConversionSkinFamilyRO,
			Sum(RegConversionValvesFamilyRO) AS RegConversionValvesFamilyRO,
			Sum(RegConversionEyesFamilyRO) AS RegConversionEyesFamilyRO,

			Sum(ConversionOrganCNR) AS ConversionOrganCNR,
			Sum(ConversionBoneCNR) AS ConversionBoneCNR,
			Sum(ConversionTissueCNR) AS ConversionTissueCNR,
			Sum(ConversionSkinCNR) AS ConversionSkinCNR,
			Sum(ConversionValvesCNR) AS ConversionValvesCNR,
			Sum(ConversionEyesCNR) AS ConversionEyesCNR,

			Sum(RegConversionOrganCNR) AS RegConversionOrganCNR,
			Sum(RegConversionBoneCNR) AS RegConversionBoneCNR,
			Sum(RegConversionTissueCNR) AS RegConversionTissueCNR,
			Sum(RegConversionSkinCNR) AS RegConversionSkinCNR,
			Sum(RegConversionValvesCNR) AS RegConversionValvesCNR,
			Sum(RegConversionEyesCNR) AS RegConversionEyesCNR,

			-- ccarroll 11/20/2006 Added conversion options StatTrac 8.2
			Sum(ConversionOrganNotPronounced) AS ConversionOrganNotPronounced,
			Sum(ConversionBoneNotPronounced) AS ConversionBoneNotPronounced,
			Sum(ConversionTissueNotPronounced) AS ConversionTissueNotPronounced,
			Sum(ConversionSkinNotPronounced) AS ConversionSkinNotPronounced,
			Sum(ConversionValvesNotPronounced) AS ConversionValvesNotPronounced,
			Sum(ConversionEyesNotPronounced) AS ConversionEyesNotPronounced,

			Sum(ConversionOrganNoJurisdiction) AS ConversionOrganNoJurisdiction,
			Sum(ConversionBoneNoJurisdiction) AS ConversionBoneNoJurisdiction,
			Sum(ConversionTissueNoJurisdiction) AS ConversionTissueNoJurisdiction,
			Sum(ConversionSkinNoJurisdiction) AS ConversionSkinNoJurisdiction,
			Sum(ConversionValvesNoJurisdiction) AS ConversionValvesNoJurisdiction,
			Sum(ConversionEyesNoJurisdiction) AS ConversionEyesNoJurisdiction,

			Sum(ConversionOrganDidNotDie) AS ConversionOrganDidNotDie,
			Sum(ConversionBoneDidNotDie) AS ConversionBoneDidNotDie,
			Sum(ConversionTissueDidNotDie) AS ConversionTissueDidNotDie,
			Sum(ConversionSkinDidNotDie) AS ConversionSkinDidNotDie,
			Sum(ConversionValvesDidNotDie) AS ConversionValvesDidNotDie,
			Sum(ConversionEyesDidNotDie) AS ConversionEyesDidNotDie,

			Sum(ConversionOrganHemodiluted) AS ConversionOrganHemodiluted,
			Sum(ConversionBoneHemodiluted) AS ConversionBoneHemodiluted,
			Sum(ConversionTissueHemodiluted) AS ConversionTissueHemodiluted,
			Sum(ConversionSkinHemodiluted) AS ConversionSkinHemodiluted,
			Sum(ConversionValvesHemodiluted) AS ConversionValvesHemodiluted,
			Sum(ConversionEyesHemodiluted) AS ConversionEyesHemodiluted,

			Sum(ConversionOrganTeamLogistics) AS ConversionOrganTeamLogistics,
			Sum(ConversionBoneTeamLogistics) AS ConversionBoneTeamLogistics,
			Sum(ConversionTissueTeamLogistics) AS ConversionTissueTeamLogistics,
			Sum(ConversionSkinTeamLogistics) AS ConversionSkinTeamLogistics,
			Sum(ConversionValvesTeamLogistics) AS ConversionValvesTeamLogistics,
			Sum(ConversionEyesTeamLogistics) AS ConversionEyesTeamLogistics,

			Sum(ConversionOrganConsentRetracted) AS ConversionOrganConsentRetracted,
			Sum(ConversionBoneConsentRetracted) AS ConversionBoneConsentRetracted,
			Sum(ConversionTissueConsentRetracted) AS ConversionTissueConsentRetracted,
			Sum(ConversionSkinConsentRetracted) AS ConversionSkinConsentRetracted,
			Sum(ConversionValvesConsentRetracted) AS ConversionValvesConsentRetracted,
			Sum(ConversionEyesConsentRetracted) AS ConversionEyesConsentRetracted,

			Sum(ConversionOrganDeclinedByProcessors) AS ConversionOrganDeclinedByProcessors,
			Sum(ConversionBoneDeclinedByProcessors) AS ConversionBoneDeclinedByProcessors,
			Sum(ConversionTissueDeclinedByProcessors) AS ConversionTissueDeclinedByProcessors,
			Sum(ConversionSkinDeclinedByProcessors) AS ConversionSkinDeclinedByProcessors,
			Sum(ConversionValvesDeclinedByProcessors) AS ConversionValvesDeclinedByProcessors,
			Sum(ConversionEyesDeclinedByProcessors) AS ConversionEyesDeclinedByProcessors,

			Sum(ConversionOrganUnapproachable) AS ConversionOrganUnapproachable,
			Sum(ConversionBoneUnapproachable) AS ConversionBoneUnapproachable,
			Sum(ConversionTissueUnapproachable) AS ConversionTissueUnapproachable,
			Sum(ConversionSkinUnapproachable) AS ConversionSkinUnapproachable,
			Sum(ConversionValvesUnapproachable) AS ConversionValvesUnapproachable,
			Sum(ConversionEyesUnapproachable) AS ConversionEyesUnapproachable,

			-- Registry
			Sum(RegConversionOrganNotPronounced) AS RegConversionOrganNotPronounced,
			Sum(RegConversionBoneNotPronounced) AS RegConversionBoneNotPronounced,
			Sum(RegConversionTissueNotPronounced) AS RegConversionTissueNotPronounced,
			Sum(RegConversionSkinNotPronounced) AS RegConversionSkinNotPronounced,
			Sum(RegConversionValvesNotPronounced) AS RegConversionValvesNotPronounced,
			Sum(RegConversionEyesNotPronounced) AS RegConversionEyesNotPronounced,

			Sum(RegConversionOrganNoJurisdiction) AS RegConversionOrganNoJurisdiction,
			Sum(RegConversionBoneNoJurisdiction) AS RegConversionBoneNoJurisdiction,
			Sum(RegConversionTissueNoJurisdiction) AS RegConversionTissueNoJurisdiction,
			Sum(RegConversionSkinNoJurisdiction) AS RegConversionSkinNoJurisdiction,
			Sum(RegConversionValvesNoJurisdiction) AS RegConversionValvesNoJurisdiction,
			Sum(RegConversionEyesNoJurisdiction) AS RegConversionEyesNoJurisdiction,

			Sum(RegConversionOrganDidNotDie) AS RegConversionOrganDidNotDie,
			Sum(RegConversionBoneDidNotDie) AS RegConversionBoneDidNotDie,
			Sum(RegConversionTissueDidNotDie) AS RegConversionTissueDidNotDie,
			Sum(RegConversionSkinDidNotDie) AS RegConversionSkinDidNotDie,
			Sum(RegConversionValvesDidNotDie) AS RegConversionValvesDidNotDie,
			Sum(RegConversionEyesDidNotDie) AS RegConversionEyesDidNotDie,

			Sum(RegConversionOrganHemodiluted) AS RegConversionOrganHemodiluted,
			Sum(RegConversionBoneHemodiluted) AS RegConversionBoneHemodiluted,
			Sum(RegConversionTissueHemodiluted) AS RegConversionTissueHemodiluted,
			Sum(RegConversionSkinHemodiluted) AS RegConversionSkinHemodiluted,
			Sum(RegConversionValvesHemodiluted) AS RegConversionValvesHemodiluted,
			Sum(RegConversionEyesHemodiluted) AS RegConversionEyesHemodiluted,

			Sum(RegConversionOrganTeamLogistics) AS RegConversionOrganTeamLogistics,
			Sum(RegConversionBoneTeamLogistics) AS RegConversionBoneTeamLogistics,
			Sum(RegConversionTissueTeamLogistics) AS RegConversionTissueTeamLogistics,
			Sum(RegConversionSkinTeamLogistics) AS RegConversionSkinTeamLogistics,
			Sum(RegConversionValvesTeamLogistics) AS RegConversionValvesTeamLogistics,
			Sum(RegConversionEyesTeamLogistics) AS RegConversionEyesTeamLogistics,

			Sum(RegConversionOrganConsentRetracted) AS RegConversionOrganConsentRetracted,
			Sum(RegConversionBoneConsentRetracted) AS RegConversionBoneConsentRetracted,
			Sum(RegConversionTissueConsentRetracted) AS RegConversionTissueConsentRetracted,
			Sum(RegConversionSkinConsentRetracted) AS RegConversionSkinConsentRetracted,
			Sum(RegConversionValvesConsentRetracted) AS RegConversionValvesConsentRetracted,
			Sum(RegConversionEyesConsentRetracted) AS RegConversionEyesConsentRetracted,

			Sum(RegConversionOrganDeclinedByProcessors) AS RegConversionOrganDeclinedByProcessors,
			Sum(RegConversionBoneDeclinedByProcessors) AS RegConversionBoneDeclinedByProcessors,
			Sum(RegConversionTissueDeclinedByProcessors) AS RegConversionTissueDeclinedByProcessors,
			Sum(RegConversionSkinDeclinedByProcessors) AS RegConversionSkinDeclinedByProcessors,
			Sum(RegConversionValvesDeclinedByProcessors) AS RegConversionValvesDeclinedByProcessors,
			Sum(RegConversionEyesDeclinedByProcessors) AS RegConversionEyesDeclinedByProcessors,

			Sum(RegConversionOrganUnapproachable) AS RegConversionOrganUnapproachable,
			Sum(RegConversionBoneUnapproachable) AS RegConversionBoneUnapproachable,
			Sum(RegConversionTissueUnapproachable) AS RegConversionTissueUnapproachable,
			Sum(RegConversionSkinUnapproachable) AS RegConversionSkinUnapproachable,
			Sum(RegConversionValvesUnapproachable) AS RegConversionValvesUnapproachable,
			Sum(RegConversionEyesUnapproachable) AS RegConversionEyesUnapproachable



    	FROM 		Referral_ConversionReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConversionReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConversionReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

IF	@vOrgID > 0

    	SELECT 	--YearID, 
			--Referral_ConversionReasonCount.MonthID AS MonthID, 
			--CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear,
			--OrganizationName, 
			Sum(ConversionOrgan) AS ConversionOrgan, 
			Sum(ConversionBone) AS ConversionBone,
			Sum(ConversionTissue) AS ConversionTissue,
			Sum(ConversionSkin) AS ConversionSkin,
			Sum(ConversionValves) AS ConversionValves,
			Sum(ConversionEyes) AS ConversionEyes,

			Sum(ConversionOrganNotRecovered) AS ConversionOrganNotRecovered, 
			Sum(ConversionBoneNotRecovered) AS ConversionBoneNotRecovered,
			Sum(ConversionTissueNotRecovered) AS ConversionTissueNotRecovered,
			Sum(ConversionSkinNotRecovered) AS ConversionSkinNotRecovered,
			Sum(ConversionValvesNotRecovered) AS ConversionValvesNotRecovered,
			Sum(ConversionEyesNotRecovered) AS ConversionEyesNotRecovered,

			Sum(ConversionOrganCoronerRuleout) AS ConversionOrganCoronerRuleout, 
			Sum(ConversionBoneCoronerRuleout) AS ConversionBoneCoronerRuleout,
			Sum(ConversionTissueCoronerRuleout) AS ConversionTissueCoronerRuleout,
			Sum(ConversionSkinCoronerRuleout) AS ConversionSkinCoronerRuleout,
			Sum(ConversionValvesCoronerRuleout) AS ConversionValvesCoronerRuleout,
			Sum(ConversionEyesCoronerRuleout) AS ConversionEyesCoronerRuleout,
	
			Sum(ConversionOrganArrest) AS ConversionOrganArrest, 
			Sum(ConversionBoneArrest) AS ConversionBoneArrest,
			Sum(ConversionTissueArrest) AS ConversionTissueArrest,
			Sum(ConversionSkinArrest) AS ConversionSkinArrest,
			Sum(ConversionValvesArrest) AS ConversionValvesArrest,
			Sum(ConversionEyesArrest) AS ConversionEyesArrest,

			Sum(ConversionOrganNeverBrainDead) AS ConversionOrganNeverBrainDead, 
			Sum(ConversionBoneNeverBrainDead) AS ConversionBoneNeverBrainDead,
			Sum(ConversionTissueNeverBrainDead) AS ConversionTissueNeverBrainDead,
			Sum(ConversionSkinNeverBrainDead) AS ConversionSkinNeverBrainDead,
			Sum(ConversionValvesNeverBrainDead) AS ConversionValvesNeverBrainDead,
			Sum(ConversionEyesNeverBrainDead) AS ConversionEyesNeverBrainDead,

			Sum(ConversionOrganMedRO) AS ConversionOrganMedRO, 
			Sum(ConversionBoneMedRO) AS ConversionBoneMedRO,
			Sum(ConversionTissueMedRO) AS ConversionTissueMedRO,
			Sum(ConversionSkinMedRO) AS ConversionSkinMedRO,
			Sum(ConversionValvesMedRO) AS ConversionValvesMedRO,
			Sum(ConversionEyesMedRO) AS ConversionEyesMedRO,

			Sum(ConversionOrganHighRisk) AS ConversionOrganHighRisk, 
			Sum(ConversionBoneHighRisk) AS ConversionBoneHighRisk,
			Sum(ConversionTissueHighRisk) AS ConversionTissueHighRisk,
			Sum(ConversionSkinHighRisk) AS ConversionSkinHighRisk,
			Sum(ConversionValvesHighRisk) AS ConversionValvesHighRisk,
			Sum(ConversionEyesHighRisk) AS ConversionEyesHighRisk,

			Sum(ConversionOrganTimeLogistics) AS ConversionOrganTimeLogistics, 
			Sum(ConversionBoneTimeLogistics) AS ConversionBoneTimeLogistics,
			Sum(ConversionTissueTimeLogistics) AS ConversionTissueTimeLogistics,
			Sum(ConversionSkinTimeLogistics) AS ConversionSkinTimeLogistics,
			Sum(ConversionValvesTimeLogistics) AS ConversionValvesTimeLogistics,
			Sum(ConversionEyesTimeLogistics) AS ConversionEyesTimeLogistics,

			Sum(ConversionOrganHeartTxable) AS ConversionOrganHeartTxable, 
			Sum(ConversionBoneHeartTxable) AS ConversionBoneHeartTxable,
			Sum(ConversionTissueHeartTxable) AS ConversionTissueHeartTxable,
			Sum(ConversionSkinHeartTxable) AS ConversionSkinHeartTxable,
			Sum(ConversionValvesHeartTxable) AS ConversionValvesHeartTxable,
			Sum(ConversionEyesHeartTxable) AS ConversionEyesHeartTxable,

			Sum(ConversionOrganUnknown) AS ConversionOrganUnknown, 
			Sum(ConversionBoneUnknown) AS ConversionBoneUnknown,
			Sum(ConversionTissueUnknown) AS ConversionTissueUnknown,
			Sum(ConversionSkinUnknown) AS ConversionSkinUnknown,
			Sum(ConversionValvesUnknown) AS ConversionValvesUnknown,
			Sum(ConversionEyesUnknown) AS ConversionEyesUnknown,

			--drh 10/31/01
			Sum(RegConversionOrgan) AS RegConversionOrgan, 
			Sum(RegConversionBone) AS RegConversionBone,
			Sum(RegConversionTissue) AS RegConversionTissue,
			Sum(RegConversionSkin) AS RegConversionSkin,
			Sum(RegConversionValves) AS RegConversionValves,
			Sum(RegConversionEyes) AS RegConversionEyes,

			Sum(RegConversionOrganNotRecovered) AS RegConversionOrganNotRecovered, 
			Sum(RegConversionBoneNotRecovered) AS RegConversionBoneNotRecovered,
			Sum(RegConversionTissueNotRecovered) AS RegConversionTissueNotRecovered,
			Sum(RegConversionSkinNotRecovered) AS RegConversionSkinNotRecovered,
			Sum(RegConversionValvesNotRecovered) AS RegConversionValvesNotRecovered,
			Sum(RegConversionEyesNotRecovered) AS RegConversionEyesNotRecovered,

			Sum(RegConversionOrganCoronerRuleout) AS RegConversionOrganCoronerRuleout, 
			Sum(RegConversionBoneCoronerRuleout) AS RegConversionBoneCoronerRuleout,
			Sum(RegConversionTissueCoronerRuleout) AS RegConversionTissueCoronerRuleout,
			Sum(RegConversionSkinCoronerRuleout) AS RegConversionSkinCoronerRuleout,
			Sum(RegConversionValvesCoronerRuleout) AS RegConversionValvesCoronerRuleout,
			Sum(RegConversionEyesCoronerRuleout) AS RegConversionEyesCoronerRuleout,
	
			Sum(RegConversionOrganArrest) AS RegConversionOrganArrest, 
			Sum(RegConversionBoneArrest) AS RegConversionBoneArrest,
			Sum(RegConversionTissueArrest) AS RegConversionTissueArrest,
			Sum(RegConversionSkinArrest) AS RegConversionSkinArrest,
			Sum(RegConversionValvesArrest) AS RegConversionValvesArrest,
			Sum(RegConversionEyesArrest) AS RegConversionEyesArrest,

			Sum(RegConversionOrganNeverBrainDead) AS RegConversionOrganNeverBrainDead, 
			Sum(RegConversionBoneNeverBrainDead) AS RegConversionBoneNeverBrainDead,
			Sum(RegConversionTissueNeverBrainDead) AS RegConversionTissueNeverBrainDead,
			Sum(RegConversionSkinNeverBrainDead) AS RegConversionSkinNeverBrainDead,
			Sum(RegConversionValvesNeverBrainDead) AS RegConversionValvesNeverBrainDead,
			Sum(RegConversionEyesNeverBrainDead) AS RegConversionEyesNeverBrainDead,

			Sum(RegConversionOrganMedRO) AS RegConversionOrganMedRO, 
			Sum(RegConversionBoneMedRO) AS RegConversionBoneMedRO,
			Sum(RegConversionTissueMedRO) AS RegConversionTissueMedRO,
			Sum(RegConversionSkinMedRO) AS RegConversionSkinMedRO,
			Sum(RegConversionValvesMedRO) AS RegConversionValvesMedRO,
			Sum(RegConversionEyesMedRO) AS RegConversionEyesMedRO,

			Sum(RegConversionOrganHighRisk) AS RegConversionOrganHighRisk, 
			Sum(RegConversionBoneHighRisk) AS RegConversionBoneHighRisk,
			Sum(RegConversionTissueHighRisk) AS RegConversionTissueHighRisk,
			Sum(RegConversionSkinHighRisk) AS RegConversionSkinHighRisk,
			Sum(RegConversionValvesHighRisk) AS RegConversionValvesHighRisk,
			Sum(RegConversionEyesHighRisk) AS RegConversionEyesHighRisk,

			Sum(RegConversionOrganTimeLogistics) AS RegConversionOrganTimeLogistics, 
			Sum(RegConversionBoneTimeLogistics) AS RegConversionBoneTimeLogistics,
			Sum(RegConversionTissueTimeLogistics) AS RegConversionTissueTimeLogistics,
			Sum(RegConversionSkinTimeLogistics) AS RegConversionSkinTimeLogistics,
			Sum(RegConversionValvesTimeLogistics) AS RegConversionValvesTimeLogistics,
			Sum(RegConversionEyesTimeLogistics) AS RegConversionEyesTimeLogistics,

			Sum(RegConversionOrganHeartTxable) AS RegConversionOrganHeartTxable, 
			Sum(RegConversionBoneHeartTxable) AS RegConversionBoneHeartTxable,
			Sum(RegConversionTissueHeartTxable) AS RegConversionTissueHeartTxable,
			Sum(RegConversionSkinHeartTxable) AS RegConversionSkinHeartTxable,
			Sum(RegConversionValvesHeartTxable) AS RegConversionValvesHeartTxable,
			Sum(RegConversionEyesHeartTxable) AS RegConversionEyesHeartTxable,

			Sum(RegConversionOrganUnknown) AS RegConversionOrganUnknown, 
			Sum(RegConversionBoneUnknown) AS RegConversionBoneUnknown,
			Sum(RegConversionTissueUnknown) AS RegConversionTissueUnknown,
			Sum(RegConversionSkinUnknown) AS RegConversionSkinUnknown,
			Sum(RegConversionValvesUnknown) AS RegConversionValvesUnknown,
			Sum(RegConversionEyesUnknown) AS RegConversionEyesUnknown,

			--drh 11/20/01
			Sum(ConversionOrganFamilyRO) AS ConversionOrganFamilyRO, 
			Sum(ConversionBoneFamilyRO) AS ConversionBoneFamilyRO,
			Sum(ConversionTissueFamilyRO) AS ConversionTissueFamilyRO,
			Sum(ConversionSkinFamilyRO) AS ConversionSkinFamilyRO,
			Sum(ConversionValvesFamilyRO) AS ConversionValvesFamilyRO,
			Sum(ConversionEyesFamilyRO) AS ConversionEyesFamilyRO,

			Sum(RegConversionOrganFamilyRO) AS RegConversionOrganFamilyRO, 
			Sum(RegConversionBoneFamilyRO) AS RegConversionBoneFamilyRO,
			Sum(RegConversionTissueFamilyRO) AS RegConversionTissueFamilyRO,
			Sum(RegConversionSkinFamilyRO) AS RegConversionSkinFamilyRO,
			Sum(RegConversionValvesFamilyRO) AS RegConversionValvesFamilyRO,
			Sum(RegConversionEyesFamilyRO) AS RegConversionEyesFamilyRO,

			Sum(ConversionOrganCNR) AS ConversionOrganCNR,
			Sum(ConversionBoneCNR) AS ConversionBoneCNR,
			Sum(ConversionTissueCNR) AS ConversionTissueCNR,
			Sum(ConversionSkinCNR) AS ConversionSkinCNR,
			Sum(ConversionValvesCNR) AS ConversionValvesCNR,
			Sum(ConversionEyesCNR) AS ConversionEyesCNR,

			Sum(RegConversionOrganCNR) AS RegConversionOrganCNR,
			Sum(RegConversionBoneCNR) AS RegConversionBoneCNR,
			Sum(RegConversionTissueCNR) AS RegConversionTissueCNR,
			Sum(RegConversionSkinCNR) AS RegConversionSkinCNR,
			Sum(RegConversionValvesCNR) AS RegConversionValvesCNR,
			Sum(RegConversionEyesCNR) AS RegConversionEyesCNR,

			-- ccarroll 11/20/2006 Added conversion options StatTrac 8.2
			Sum(ConversionOrganNotPronounced) AS ConversionOrganNotPronounced,
			Sum(ConversionBoneNotPronounced) AS ConversionBoneNotPronounced,
			Sum(ConversionTissueNotPronounced) AS ConversionTissueNotPronounced,
			Sum(ConversionSkinNotPronounced) AS ConversionSkinNotPronounced,
			Sum(ConversionValvesNotPronounced) AS ConversionValvesNotPronounced,
			Sum(ConversionEyesNotPronounced) AS ConversionEyesNotPronounced,

			Sum(ConversionOrganNoJurisdiction) AS ConversionOrganNoJurisdiction,
			Sum(ConversionBoneNoJurisdiction) AS ConversionBoneNoJurisdiction,
			Sum(ConversionTissueNoJurisdiction) AS ConversionTissueNoJurisdiction,
			Sum(ConversionSkinNoJurisdiction) AS ConversionSkinNoJurisdiction,
			Sum(ConversionValvesNoJurisdiction) AS ConversionValvesNoJurisdiction,
			Sum(ConversionEyesNoJurisdiction) AS ConversionEyesNoJurisdiction,

			Sum(ConversionOrganDidNotDie) AS ConversionOrganDidNotDie,
			Sum(ConversionBoneDidNotDie) AS ConversionBoneDidNotDie,
			Sum(ConversionTissueDidNotDie) AS ConversionTissueDidNotDie,
			Sum(ConversionSkinDidNotDie) AS ConversionSkinDidNotDie,
			Sum(ConversionValvesDidNotDie) AS ConversionValvesDidNotDie,
			Sum(ConversionEyesDidNotDie) AS ConversionEyesDidNotDie,

			Sum(ConversionOrganHemodiluted) AS ConversionOrganHemodiluted,
			Sum(ConversionBoneHemodiluted) AS ConversionBoneHemodiluted,
			Sum(ConversionTissueHemodiluted) AS ConversionTissueHemodiluted,
			Sum(ConversionSkinHemodiluted) AS ConversionSkinHemodiluted,
			Sum(ConversionValvesHemodiluted) AS ConversionValvesHemodiluted,
			Sum(ConversionEyesHemodiluted) AS ConversionEyesHemodiluted,

			Sum(ConversionOrganTeamLogistics) AS ConversionOrganTeamLogistics,
			Sum(ConversionBoneTeamLogistics) AS ConversionBoneTeamLogistics,
			Sum(ConversionTissueTeamLogistics) AS ConversionTissueTeamLogistics,
			Sum(ConversionSkinTeamLogistics) AS ConversionSkinTeamLogistics,
			Sum(ConversionValvesTeamLogistics) AS ConversionValvesTeamLogistics,
			Sum(ConversionEyesTeamLogistics) AS ConversionEyesTeamLogistics,

			Sum(ConversionOrganConsentRetracted) AS ConversionOrganConsentRetracted,
			Sum(ConversionBoneConsentRetracted) AS ConversionBoneConsentRetracted,
			Sum(ConversionTissueConsentRetracted) AS ConversionTissueConsentRetracted,
			Sum(ConversionSkinConsentRetracted) AS ConversionSkinConsentRetracted,
			Sum(ConversionValvesConsentRetracted) AS ConversionValvesConsentRetracted,
			Sum(ConversionEyesConsentRetracted) AS ConversionEyesConsentRetracted,

			Sum(ConversionOrganDeclinedByProcessors) AS ConversionOrganDeclinedByProcessors,
			Sum(ConversionBoneDeclinedByProcessors) AS ConversionBoneDeclinedByProcessors,
			Sum(ConversionTissueDeclinedByProcessors) AS ConversionTissueDeclinedByProcessors,
			Sum(ConversionSkinDeclinedByProcessors) AS ConversionSkinDeclinedByProcessors,
			Sum(ConversionValvesDeclinedByProcessors) AS ConversionValvesDeclinedByProcessors,
			Sum(ConversionEyesDeclinedByProcessors) AS ConversionEyesDeclinedByProcessors,

			Sum(ConversionOrganUnapproachable) AS ConversionOrganUnapproachable,
			Sum(ConversionBoneUnapproachable) AS ConversionBoneUnapproachable,
			Sum(ConversionTissueUnapproachable) AS ConversionTissueUnapproachable,
			Sum(ConversionSkinUnapproachable) AS ConversionSkinUnapproachable,
			Sum(ConversionValvesUnapproachable) AS ConversionValvesUnapproachable,
			Sum(ConversionEyesUnapproachable) AS ConversionEyesUnapproachable,

			-- Registry
			Sum(RegConversionOrganNotPronounced) AS RegConversionOrganNotPronounced,
			Sum(RegConversionBoneNotPronounced) AS RegConversionBoneNotPronounced,
			Sum(RegConversionTissueNotPronounced) AS RegConversionTissueNotPronounced,
			Sum(RegConversionSkinNotPronounced) AS RegConversionSkinNotPronounced,
			Sum(RegConversionValvesNotPronounced) AS RegConversionValvesNotPronounced,
			Sum(RegConversionEyesNotPronounced) AS RegConversionEyesNotPronounced,

			Sum(RegConversionOrganNoJurisdiction) AS RegConversionOrganNoJurisdiction,
			Sum(RegConversionBoneNoJurisdiction) AS RegConversionBoneNoJurisdiction,
			Sum(RegConversionTissueNoJurisdiction) AS RegConversionTissueNoJurisdiction,
			Sum(RegConversionSkinNoJurisdiction) AS RegConversionSkinNoJurisdiction,
			Sum(RegConversionValvesNoJurisdiction) AS RegConversionValvesNoJurisdiction,
			Sum(RegConversionEyesNoJurisdiction) AS RegConversionEyesNoJurisdiction,

			Sum(RegConversionOrganDidNotDie) AS RegConversionOrganDidNotDie,
			Sum(RegConversionBoneDidNotDie) AS RegConversionBoneDidNotDie,
			Sum(RegConversionTissueDidNotDie) AS RegConversionTissueDidNotDie,
			Sum(RegConversionSkinDidNotDie) AS RegConversionSkinDidNotDie,
			Sum(RegConversionValvesDidNotDie) AS RegConversionValvesDidNotDie,
			Sum(RegConversionEyesDidNotDie) AS RegConversionEyesDidNotDie,

			Sum(RegConversionOrganHemodiluted) AS RegConversionOrganHemodiluted,
			Sum(RegConversionBoneHemodiluted) AS RegConversionBoneHemodiluted,
			Sum(RegConversionTissueHemodiluted) AS RegConversionTissueHemodiluted,
			Sum(RegConversionSkinHemodiluted) AS RegConversionSkinHemodiluted,
			Sum(RegConversionValvesHemodiluted) AS RegConversionValvesHemodiluted,
			Sum(RegConversionEyesHemodiluted) AS RegConversionEyesHemodiluted,

			Sum(RegConversionOrganTeamLogistics) AS RegConversionOrganTeamLogistics,
			Sum(RegConversionBoneTeamLogistics) AS RegConversionBoneTeamLogistics,
			Sum(RegConversionTissueTeamLogistics) AS RegConversionTissueTeamLogistics,
			Sum(RegConversionSkinTeamLogistics) AS RegConversionSkinTeamLogistics,
			Sum(RegConversionValvesTeamLogistics) AS RegConversionValvesTeamLogistics,
			Sum(RegConversionEyesTeamLogistics) AS RegConversionEyesTeamLogistics,

			Sum(RegConversionOrganConsentRetracted) AS RegConversionOrganConsentRetracted,
			Sum(RegConversionBoneConsentRetracted) AS RegConversionBoneConsentRetracted,
			Sum(RegConversionTissueConsentRetracted) AS RegConversionTissueConsentRetracted,
			Sum(RegConversionSkinConsentRetracted) AS RegConversionSkinConsentRetracted,
			Sum(RegConversionValvesConsentRetracted) AS RegConversionValvesConsentRetracted,
			Sum(RegConversionEyesConsentRetracted) AS RegConversionEyesConsentRetracted,

			Sum(RegConversionOrganDeclinedByProcessors) AS RegConversionOrganDeclinedByProcessors,
			Sum(RegConversionBoneDeclinedByProcessors) AS RegConversionBoneDeclinedByProcessors,
			Sum(RegConversionTissueDeclinedByProcessors) AS RegConversionTissueDeclinedByProcessors,
			Sum(RegConversionSkinDeclinedByProcessors) AS RegConversionSkinDeclinedByProcessors,
			Sum(RegConversionValvesDeclinedByProcessors) AS RegConversionValvesDeclinedByProcessors,
			Sum(RegConversionEyesDeclinedByProcessors) AS RegConversionEyesDeclinedByProcessors,

			Sum(RegConversionOrganUnapproachable) AS RegConversionOrganUnapproachable,
			Sum(RegConversionBoneUnapproachable) AS RegConversionBoneUnapproachable,
			Sum(RegConversionTissueUnapproachable) AS RegConversionTissueUnapproachable,
			Sum(RegConversionSkinUnapproachable) AS RegConversionSkinUnapproachable,
			Sum(RegConversionValvesUnapproachable) AS RegConversionValvesUnapproachable,
			Sum(RegConversionEyesUnapproachable) AS RegConversionEyesUnapproachable

    	FROM 		Referral_ConversionReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConversionReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConversionReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_ConversionReasonCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ConversionReasonCount.OrganizationID = @vOrgID

/*	GROUP BY	YearID, Referral_ConversionReasonCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_ConversionReasonCount.OrganizationID, OrganizationName 
    	ORDER BY 	YearID, Referral_ConversionReasonCountReferral_ConversionReasonCount.MonthID, OrganizationName
*/





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

