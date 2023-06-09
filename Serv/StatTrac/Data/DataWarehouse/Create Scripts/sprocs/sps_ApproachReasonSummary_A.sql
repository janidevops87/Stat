SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApproachReasonSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApproachReasonSummary_A]
GO



CREATE   PROCEDURE sps_ApproachReasonSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS
/* ccarroll 11/17/2006 added options */

IF	@vOrgID = 0

    	SELECT 		
			Sum(ApproachOrgan) AS ApproachOrgan, 
			Sum(ApproachBone) AS ApproachBone,
			Sum(ApproachTissue) AS ApproachTissue,
			Sum(ApproachSkin) AS ApproachSkin,
			Sum(ApproachValves) AS ApproachValves,
			Sum(ApproachEyes) AS ApproachEyes,

			Sum(ApproachOrganNotApproached) AS ApproachOrganNotApproached, 
			Sum(ApproachBoneNotApproached) AS ApproachBoneNotApproached,
			Sum(ApproachTissueNotApproached) AS ApproachTissueNotApproached,
			Sum(ApproachSkinNotApproached) AS ApproachSkinNotApproached,
			Sum(ApproachValvesNotApproached) AS ApproachValvesNotApproached,
			Sum(ApproachEyesNotApproached) AS ApproachEyesNotApproached,

			Sum(ApproachOrganUnknown) AS ApproachOrganUnknown, 
			Sum(ApproachBoneUnknown) AS ApproachBoneUnknown,
			Sum(ApproachTissueUnknown) AS ApproachTissueUnknown,
			Sum(ApproachSkinUnknown) AS ApproachSkinUnknown,
			Sum(ApproachValvesUnknown) AS ApproachValvesUnknown,
			Sum(ApproachEyesUnknown) AS ApproachEyesUnknown,
	
			Sum(ApproachOrganFamilyUnavailable) AS ApproachOrganFamilyUnavail, 
			Sum(ApproachBoneFamilyUnavailable) AS ApproachBoneFamilyUnavail,
			Sum(ApproachTissueFamilyUnavailable) AS ApproachTissueFamilyUnavail,
			Sum(ApproachSkinFamilyUnavailable) AS ApproachSkinFamilyUnavail,
			Sum(ApproachValvesFamilyUnavailable) AS ApproachValvesFamilyUnavail,
			Sum(ApproachEyesFamilyUnavailable) AS ApproachEyesFamilyUnavail,

			Sum(ApproachOrganCoronerRuleout) AS ApproachOrganCoronerRuleout, 
			Sum(ApproachBoneCoronerRuleout) AS ApproachBoneCoronerRuleout,
			Sum(ApproachTissueCoronerRuleout) AS ApproachTissueCoronerRuleout,
			Sum(ApproachSkinCoronerRuleout) AS ApproachSkinCoronerRuleout,
			Sum(ApproachValvesCoronerRuleout) AS ApproachValvesCoronerRuleout,
			Sum(ApproachEyesCoronerRuleout) AS ApproachEyesCoronerRuleout,

			Sum(ApproachOrganArrest) AS ApproachOrganArrest, 
			Sum(ApproachBoneArrest) AS ApproachBoneArrest,
			Sum(ApproachTissueArrest) AS ApproachTissueArrest,
			Sum(ApproachSkinArrest) AS ApproachSkinArrest,
			Sum(ApproachValvesArrest) AS ApproachValvesArrest,
			Sum(ApproachEyesArrest) AS ApproachEyesArrest,

			Sum(ApproachOrganMedRO) AS ApproachOrganMedRO, 
			Sum(ApproachBoneMedRO) AS ApproachBoneMedRO,
			Sum(ApproachTissueMedRO) AS ApproachTissueMedRO,
			Sum(ApproachSkinMedRO) AS ApproachSkinMedRO,
			Sum(ApproachValvesMedRO) AS ApproachValvesMedRO,
			Sum(ApproachEyesMedRO) AS ApproachEyesMedRO,

			Sum(ApproachOrganTimeLogistics) AS ApproachOrganTimeLogistics, 
			Sum(ApproachBoneTimeLogistics) AS ApproachBoneTimeLogistics,
			Sum(ApproachTissueTimeLogistics) AS ApproachTissueTimeLogistics,
			Sum(ApproachSkinTimeLogistics) AS ApproachSkinTimeLogistics,
			Sum(ApproachValvesTimeLogistics) AS ApproachValvesTimeLogistics,
			Sum(ApproachEyesTimeLogistics) AS ApproachEyesTimeLogistics,

			Sum(ApproachOrganNeverBrainDead) AS ApproachOrganNeverBrainDead, 
			Sum(ApproachBoneNeverBrainDead) AS ApproachBoneNeverBrainDead,
			Sum(ApproachTissueNeverBrainDead) AS ApproachTissueNeverBrainDead,
			Sum(ApproachSkinNeverBrainDead) AS ApproachSkinNeverBrainDead,
			Sum(ApproachValvesNeverBrainDead) AS ApproachValvesNeverBrainDead,
			Sum(ApproachEyesNeverBrainDead) AS ApproachEyesNeverBrainDead,

			Sum(ApproachOrganHighRisk) AS ApproachOrganHighRisk, 
			Sum(ApproachBoneHighRisk) AS ApproachBoneHighRisk,
			Sum(ApproachTissueHighRisk) AS ApproachTissueHighRisk,
			Sum(ApproachSkinHighRisk) AS ApproachSkinHighRisk,
			Sum(ApproachValvesHighRisk) AS ApproachValvesHighRisk,
			Sum(ApproachEyesHighRisk) AS ApproachEyesHighRisk,

			Sum(ApproachOrganUnapproachable) AS ApproachOrganUnapproachable, 
			Sum(ApproachBoneUnapproachable) AS ApproachBoneUnapproachable,
			Sum(ApproachTissueUnapproachable) AS ApproachTissueUnapproachable,
			Sum(ApproachSkinUnapproachable) AS ApproachSkinUnapproachable,
			Sum(ApproachValvesUnapproachable) AS ApproachValvesUnapproachable,
			Sum(ApproachEyesUnapproachable) AS ApproachEyesUnapproachable,
			Sum(AppropriateRO) AS AppropriateRO,

			Sum(ApproachOrganReg) AS ApproachOrganReg, 
			Sum(ApproachBoneReg) AS ApproachBoneReg,
			Sum(ApproachTissueReg) AS ApproachTissueReg,
			Sum(ApproachSkinReg) AS ApproachSkinReg,
			Sum(ApproachValvesReg) AS ApproachValvesReg,
			Sum(ApproachEyesReg) AS ApproachEyesReg,

			Sum(ApproachOrganDMVReg) AS ApproachOrganDMVReg, 
			Sum(ApproachBoneDMVReg) AS ApproachBoneDMVReg,
			Sum(ApproachTissueDMVReg) AS ApproachTissueDMVReg,
			Sum(ApproachSkinDMVReg) AS ApproachSkinDMVReg,
			Sum(ApproachValvesDMVReg) AS ApproachValvesDMVReg,
			Sum(ApproachEyesDMVReg) AS ApproachEyesDMVReg,

			Sum(ApproachOrganDRReg) AS ApproachOrganDRReg, 
			Sum(ApproachBoneDRReg) AS ApproachBoneDRReg,
			Sum(ApproachTissueDRReg) AS ApproachTissueDRReg,
			Sum(ApproachSkinDRReg) AS ApproachSkinDRReg,
			Sum(ApproachValvesDRReg) AS ApproachValvesDRReg,
			Sum(ApproachEyesDRReg) AS ApproachEyesDRReg,

			Sum(ApproachOrganSecondaryRO) AS ApproachOrganSecondaryRO, 
			Sum(ApproachBoneSecondaryRO) AS ApproachBoneSecondaryRO, 
			Sum(ApproachTissueSecondaryRO) AS ApproachTissueSecondaryRO, 
			Sum(ApproachSkinSecondaryRO) AS ApproachSkinSecondaryRO, 
			Sum(ApproachValvesSecondaryRO) AS ApproachValvesSecondaryRO, 
			Sum(ApproachEyesSecondaryRO) AS ApproachEyesSecondaryRO,

			--ccarroll 11/17/2006 added options
			Sum(ApproachOrganPrevDiscussion) AS ApproachOrganPrevDiscussion, 
			Sum(ApproachBonePrevDiscussion) AS ApproachBonePrevDiscussion, 
			Sum(ApproachTissuePrevDiscussion) AS ApproachTissuePrevDiscussion, 
			Sum(ApproachSkinPrevDiscussion) AS ApproachSkinPrevDiscussion, 
			Sum(ApproachValvesPrevDiscussion) AS ApproachValvesPrevDiscussion, 
			Sum(ApproachEyesPrevDiscussion) AS ApproachEyesPrevDiscussion,

			Sum(ApproachOrganNotPronounced) AS ApproachOrganNotPronounced, 
			Sum(ApproachBoneNotPronounced) AS ApproachBoneNotPronounced, 
			Sum(ApproachTissueNotPronounced) AS ApproachTissueNotPronounced, 
			Sum(ApproachSkinNotPronounced) AS ApproachSkinNotPronounced, 
			Sum(ApproachValvesNotPronounced) AS ApproachValvesNotPronounced, 
			Sum(ApproachEyesNotPronounced) AS ApproachEyesNotPronounced,

			Sum(ApproachOrganNoJurisdiction) AS ApproachOrganNoJurisdiction, 
			Sum(ApproachBoneNoJurisdiction) AS ApproachBoneNoJurisdiction, 
			Sum(ApproachTissueNoJurisdiction) AS ApproachTissueNoJurisdiction, 
			Sum(ApproachSkinNoJurisdiction) AS ApproachSkinNoJurisdiction, 
			Sum(ApproachValvesNoJurisdiction) AS ApproachValvesNoJurisdiction, 
			Sum(ApproachEyesNoJurisdiction) AS ApproachEyesNoJurisdiction,

			Sum(ApproachOrganDidNotDie) AS ApproachOrganDidNotDie, 
			Sum(ApproachBoneDidNotDie) AS ApproachBoneDidNotDie, 
			Sum(ApproachTissueDidNotDie) AS ApproachTissueDidNotDie, 
			Sum(ApproachSkinDidNotDie) AS ApproachSkinDidNotDie, 
			Sum(ApproachValvesDidNotDie) AS ApproachValvesDidNotDie, 
			Sum(ApproachEyesDidNotDie) AS ApproachEyesDidNotDie,

			Sum(ApproachOrganHemodiluted) AS ApproachOrganHemodiluted, 
			Sum(ApproachBoneHemodiluted) AS ApproachBoneHemodiluted, 
			Sum(ApproachTissueHemodiluted) AS ApproachTissueHemodiluted, 
			Sum(ApproachSkinHemodiluted) AS ApproachSkinHemodiluted, 
			Sum(ApproachValvesHemodiluted) AS ApproachValvesHemodiluted, 
			Sum(ApproachEyesHemodiluted) AS ApproachEyesHemodiluted,

			Sum(ApproachOrganTeamLogistics) AS ApproachOrganTeamLogistics, 
			Sum(ApproachBoneTeamLogistics) AS ApproachBoneTeamLogistics, 
			Sum(ApproachTissueTeamLogistics) AS ApproachTissueTeamLogistics, 
			Sum(ApproachSkinTeamLogistics) AS ApproachSkinTeamLogistics, 
			Sum(ApproachValvesTeamLogistics) AS ApproachValvesTeamLogistics, 
			Sum(ApproachEyesTeamLogistics) AS ApproachEyesTeamLogistics,

			Sum(ApproachOrganConsentRetracted) AS ApproachOrganConsentRetracted, 
			Sum(ApproachBoneConsentRetracted) AS ApproachBoneConsentRetracted, 
			Sum(ApproachTissueConsentRetracted) AS ApproachTissueConsentRetracted, 
			Sum(ApproachSkinConsentRetracted) AS ApproachSkinConsentRetracted, 
			Sum(ApproachValvesConsentRetracted) AS ApproachValvesConsentRetracted, 
			Sum(ApproachEyesConsentRetracted) AS ApproachEyesConsentRetracted,

			Sum(ApproachOrganDeclinedByProcessors) AS ApproachOrganDeclinedByProcessors, 
			Sum(ApproachBoneDeclinedByProcessors) AS ApproachBoneDeclinedByProcessors, 
			Sum(ApproachTissueDeclinedByProcessors) AS ApproachTissueDeclinedByProcessors, 
			Sum(ApproachSkinDeclinedByProcessors) AS ApproachSkinDeclinedByProcessors, 
			Sum(ApproachValvesDeclinedByProcessors) AS ApproachValvesDeclinedByProcessors, 
			Sum(ApproachEyesDeclinedByProcessors) AS ApproachEyesDeclinedByProcessors

    	FROM 		Referral_ApproachReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate

IF	@vOrgID > 0

    	SELECT 	--YearID, 
			--Referral_ApproachReasonCount.MonthID AS MonthID, 
			--CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear,
			--OrganizationName, 
			Sum(ApproachOrgan) AS ApproachOrgan, 
			Sum(ApproachBone) AS ApproachBone,
			Sum(ApproachTissue) AS ApproachTissue,
			Sum(ApproachSkin) AS ApproachSkin,
			Sum(ApproachValves) AS ApproachValves,
			Sum(ApproachEyes) AS ApproachEyes,

			Sum(ApproachOrganNotApproached) AS ApproachOrganNotApproached, 
			Sum(ApproachBoneNotApproached) AS ApproachBoneNotApproached,
			Sum(ApproachTissueNotApproached) AS ApproachTissueNotApproached,
			Sum(ApproachSkinNotApproached) AS ApproachSkinNotApproached,
			Sum(ApproachValvesNotApproached) AS ApproachValvesNotApproached,
			Sum(ApproachEyesNotApproached) AS ApproachEyesNotApproached,

			Sum(ApproachOrganUnknown) AS ApproachOrganUnknown, 
			Sum(ApproachBoneUnknown) AS ApproachBoneUnknown,
			Sum(ApproachTissueUnknown) AS ApproachTissueUnknown,
			Sum(ApproachSkinUnknown) AS ApproachSkinUnknown,
			Sum(ApproachValvesUnknown) AS ApproachValvesUnknown,
			Sum(ApproachEyesUnknown) AS ApproachEyesUnknown,
	
			Sum(ApproachOrganFamilyUnavailable) AS ApproachOrganFamilyUnavail, 
			Sum(ApproachBoneFamilyUnavailable) AS ApproachBoneFamilyUnavail,
			Sum(ApproachTissueFamilyUnavailable) AS ApproachTissueFamilyUnavail,
			Sum(ApproachSkinFamilyUnavailable) AS ApproachSkinFamilyUnavail,
			Sum(ApproachValvesFamilyUnavailable) AS ApproachValvesFamilyUnavail,
			Sum(ApproachEyesFamilyUnavailable) AS ApproachEyesFamilyUnavail,

			Sum(ApproachOrganCoronerRuleout) AS ApproachOrganCoronerRuleout, 
			Sum(ApproachBoneCoronerRuleout) AS ApproachBoneCoronerRuleout,
			Sum(ApproachTissueCoronerRuleout) AS ApproachTissueCoronerRuleout,
			Sum(ApproachSkinCoronerRuleout) AS ApproachSkinCoronerRuleout,
			Sum(ApproachValvesCoronerRuleout) AS ApproachValvesCoronerRuleout,
			Sum(ApproachEyesCoronerRuleout) AS ApproachEyesCoronerRuleout,

			Sum(ApproachOrganArrest) AS ApproachOrganArrest, 
			Sum(ApproachBoneArrest) AS ApproachBoneArrest,
			Sum(ApproachTissueArrest) AS ApproachTissueArrest,
			Sum(ApproachSkinArrest) AS ApproachSkinArrest,
			Sum(ApproachValvesArrest) AS ApproachValvesArrest,
			Sum(ApproachEyesArrest) AS ApproachEyesArrest,

			Sum(ApproachOrganMedRO) AS ApproachOrganMedRO, 
			Sum(ApproachBoneMedRO) AS ApproachBoneMedRO,
			Sum(ApproachTissueMedRO) AS ApproachTissueMedRO,
			Sum(ApproachSkinMedRO) AS ApproachSkinMedRO,
			Sum(ApproachValvesMedRO) AS ApproachValvesMedRO,
			Sum(ApproachEyesMedRO) AS ApproachEyesMedRO,

			Sum(ApproachOrganTimeLogistics) AS ApproachOrganTimeLogistics, 
			Sum(ApproachBoneTimeLogistics) AS ApproachBoneTimeLogistics,
			Sum(ApproachTissueTimeLogistics) AS ApproachTissueTimeLogistics,
			Sum(ApproachSkinTimeLogistics) AS ApproachSkinTimeLogistics,
			Sum(ApproachValvesTimeLogistics) AS ApproachValvesTimeLogistics,
			Sum(ApproachEyesTimeLogistics) AS ApproachEyesTimeLogistics,

			Sum(ApproachOrganNeverBrainDead) AS ApproachOrganNeverBrainDead, 
			Sum(ApproachBoneNeverBrainDead) AS ApproachBoneNeverBrainDead,
			Sum(ApproachTissueNeverBrainDead) AS ApproachTissueNeverBrainDead,
			Sum(ApproachSkinNeverBrainDead) AS ApproachSkinNeverBrainDead,
			Sum(ApproachValvesNeverBrainDead) AS ApproachValvesNeverBrainDead,
			Sum(ApproachEyesNeverBrainDead) AS ApproachEyesNeverBrainDead,

			Sum(ApproachOrganHighRisk) AS ApproachOrganHighRisk, 
			Sum(ApproachBoneHighRisk) AS ApproachBoneHighRisk,
			Sum(ApproachTissueHighRisk) AS ApproachTissueHighRisk,
			Sum(ApproachSkinHighRisk) AS ApproachSkinHighRisk,
			Sum(ApproachValvesHighRisk) AS ApproachValvesHighRisk,
			Sum(ApproachEyesHighRisk) AS ApproachEyesHighRisk,

			Sum(ApproachOrganUnapproachable) AS ApproachOrganUnapproachable, 
			Sum(ApproachBoneUnapproachable) AS ApproachBoneUnapproachable,
			Sum(ApproachTissueUnapproachable) AS ApproachTissueUnapproachable,
			Sum(ApproachSkinUnapproachable) AS ApproachSkinUnapproachable,
			Sum(ApproachValvesUnapproachable) AS ApproachValvesUnapproachable,
			Sum(ApproachEyesUnapproachable) AS ApproachEyesUnapproachable,
			Sum(AppropriateRO) AS AppropriateRO,

			Sum(ApproachOrganReg) AS ApproachOrganReg, 
			Sum(ApproachBoneReg) AS ApproachBoneReg,
			Sum(ApproachTissueReg) AS ApproachTissueReg,
			Sum(ApproachSkinReg) AS ApproachSkinReg,
			Sum(ApproachValvesReg) AS ApproachValvesReg,
			Sum(ApproachEyesReg) AS ApproachEyesReg,

			Sum(ApproachOrganDMVReg) AS ApproachOrganDMVReg, 
			Sum(ApproachBoneDMVReg) AS ApproachBoneDMVReg,
			Sum(ApproachTissueDMVReg) AS ApproachTissueDMVReg,
			Sum(ApproachSkinDMVReg) AS ApproachSkinDMVReg,
			Sum(ApproachValvesDMVReg) AS ApproachValvesDMVReg,
			Sum(ApproachEyesDMVReg) AS ApproachEyesDMVReg,

			Sum(ApproachOrganDRReg) AS ApproachOrganDRReg, 
			Sum(ApproachBoneDRReg) AS ApproachBoneDRReg,
			Sum(ApproachTissueDRReg) AS ApproachTissueDRReg,
			Sum(ApproachSkinDRReg) AS ApproachSkinDRReg,
			Sum(ApproachValvesDRReg) AS ApproachValvesDRReg,
			Sum(ApproachEyesDRReg) AS ApproachEyesDRReg,

			Sum(ApproachOrganSecondaryRO) AS ApproachOrganSecondaryRO, 
			Sum(ApproachBoneSecondaryRO) AS ApproachBoneSecondaryRO, 
			Sum(ApproachTissueSecondaryRO) AS ApproachTissueSecondaryRO, 
			Sum(ApproachSkinSecondaryRO) AS ApproachSkinSecondaryRO, 
			Sum(ApproachValvesSecondaryRO) AS ApproachValvesSecondaryRO, 
			Sum(ApproachEyesSecondaryRO) AS ApproachEyesSecondaryRO,

			--ccarroll 11/17/2006 added options
			Sum(ApproachOrganPrevDiscussion) AS ApproachOrganPrevDiscussion, 
			Sum(ApproachBonePrevDiscussion) AS ApproachBonePrevDiscussion, 
			Sum(ApproachTissuePrevDiscussion) AS ApproachTissuePrevDiscussion, 
			Sum(ApproachSkinPrevDiscussion) AS ApproachSkinPrevDiscussion, 
			Sum(ApproachValvesPrevDiscussion) AS ApproachValvesPrevDiscussion, 
			Sum(ApproachEyesPrevDiscussion) AS ApproachEyesPrevDiscussion,

			Sum(ApproachOrganNotPronounced) AS ApproachOrganNotPronounced, 
			Sum(ApproachBoneNotPronounced) AS ApproachBoneNotPronounced, 
			Sum(ApproachTissueNotPronounced) AS ApproachTissueNotPronounced, 
			Sum(ApproachSkinNotPronounced) AS ApproachSkinNotPronounced, 
			Sum(ApproachValvesNotPronounced) AS ApproachValvesNotPronounced, 
			Sum(ApproachEyesNotPronounced) AS ApproachEyesNotPronounced,

			Sum(ApproachOrganNoJurisdiction) AS ApproachOrganNoJurisdiction, 
			Sum(ApproachBoneNoJurisdiction) AS ApproachBoneNoJurisdiction, 
			Sum(ApproachTissueNoJurisdiction) AS ApproachTissueNoJurisdiction, 
			Sum(ApproachSkinNoJurisdiction) AS ApproachSkinNoJurisdiction, 
			Sum(ApproachValvesNoJurisdiction) AS ApproachValvesNoJurisdiction, 
			Sum(ApproachEyesNoJurisdiction) AS ApproachEyesNoJurisdiction,

			Sum(ApproachOrganDidNotDie) AS ApproachOrganDidNotDie, 
			Sum(ApproachBoneDidNotDie) AS ApproachBoneDidNotDie, 
			Sum(ApproachTissueDidNotDie) AS ApproachTissueDidNotDie, 
			Sum(ApproachSkinDidNotDie) AS ApproachSkinDidNotDie, 
			Sum(ApproachValvesDidNotDie) AS ApproachValvesDidNotDie, 
			Sum(ApproachEyesDidNotDie) AS ApproachEyesDidNotDie,

			Sum(ApproachOrganHemodiluted) AS ApproachOrganHemodiluted, 
			Sum(ApproachBoneHemodiluted) AS ApproachBoneHemodiluted, 
			Sum(ApproachTissueHemodiluted) AS ApproachTissueHemodiluted, 
			Sum(ApproachSkinHemodiluted) AS ApproachSkinHemodiluted, 
			Sum(ApproachValvesHemodiluted) AS ApproachValvesHemodiluted, 
			Sum(ApproachEyesHemodiluted) AS ApproachEyesHemodiluted,

			Sum(ApproachOrganTeamLogistics) AS ApproachOrganTeamLogistics, 
			Sum(ApproachBoneTeamLogistics) AS ApproachBoneTeamLogistics, 
			Sum(ApproachTissueTeamLogistics) AS ApproachTissueTeamLogistics, 
			Sum(ApproachSkinTeamLogistics) AS ApproachSkinTeamLogistics, 
			Sum(ApproachValvesTeamLogistics) AS ApproachValvesTeamLogistics, 
			Sum(ApproachEyesTeamLogistics) AS ApproachEyesTeamLogistics,

			Sum(ApproachOrganConsentRetracted) AS ApproachOrganConsentRetracted, 
			Sum(ApproachBoneConsentRetracted) AS ApproachBoneConsentRetracted, 
			Sum(ApproachTissueConsentRetracted) AS ApproachTissueConsentRetracted, 
			Sum(ApproachSkinConsentRetracted) AS ApproachSkinConsentRetracted, 
			Sum(ApproachValvesConsentRetracted) AS ApproachValvesConsentRetracted, 
			Sum(ApproachEyesConsentRetracted) AS ApproachEyesConsentRetracted,

			Sum(ApproachOrganDeclinedByProcessors) AS ApproachOrganDeclinedByProcessors, 
			Sum(ApproachBoneDeclinedByProcessors) AS ApproachBoneDeclinedByProcessors, 
			Sum(ApproachTissueDeclinedByProcessors) AS ApproachTissueDeclinedByProcessors, 
			Sum(ApproachSkinDeclinedByProcessors) AS ApproachSkinDeclinedByProcessors, 
			Sum(ApproachValvesDeclinedByProcessors) AS ApproachValvesDeclinedByProcessors, 
			Sum(ApproachEyesDeclinedByProcessors) AS ApproachEyesDeclinedByProcessors

    	FROM 		Referral_ApproachReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ApproachReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ApproachReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_ApproachReasonCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ApproachReasonCount.OrganizationID = @vOrgID

/*
	GROUP BY	YearID, Referral_ApproachReasonCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_ApproachReasonCount.OrganizationID, OrganizationName 
    	ORDER BY 	YearID, Referral_ApproachReasonCountReferral_ApproachReasonCount.MonthID, OrganizationName

*/



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

