if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_ConversionReasonCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_ConversionReasonCount]
GO

CREATE TABLE [dbo].[Referral_ConversionReasonCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[AllTypes] [int] NULL ,
	[ConversionOrgan] [int] NULL ,
	[ConversionBone] [int] NULL ,
	[ConversionTissue] [int] NULL ,
	[ConversionSkin] [int] NULL ,
	[ConversionValves] [int] NULL ,
	[ConversionEyes] [int] NULL ,
	[ConversionOther] [int] NULL ,
	[ConversionAllTissue] [int] NULL ,
	[ConversionOrganNotRecovered] [int] NULL ,
	[ConversionBoneNotRecovered] [int] NULL ,
	[ConversionTissueNotRecovered] [int] NULL ,
	[ConversionSkinNotRecovered] [int] NULL ,
	[ConversionValvesNotRecovered] [int] NULL ,
	[ConversionEyesNotRecovered] [int] NULL ,
	[ConversionOtherNotRecovered] [int] NULL ,
	[ConversionAllTissueNotRecovered] [int] NULL ,
	[ConversionOrganCoronerRuleout] [int] NULL ,
	[ConversionBoneCoronerRuleout] [int] NULL ,
	[ConversionTissueCoronerRuleout] [int] NULL ,
	[ConversionSkinCoronerRuleout] [int] NULL ,
	[ConversionValvesCoronerRuleout] [int] NULL ,
	[ConversionEyesCoronerRuleout] [int] NULL ,
	[ConversionOtherCoronerRuleout] [int] NULL ,
	[ConversionAllTissueCoronerRuleout] [int] NULL ,
	[ConversionOrganArrest] [int] NULL ,
	[ConversionBoneArrest] [int] NULL ,
	[ConversionTissueArrest] [int] NULL ,
	[ConversionSkinArrest] [int] NULL ,
	[ConversionValvesArrest] [int] NULL ,
	[ConversionEyesArrest] [int] NULL ,
	[ConversionOtherArrest] [int] NULL ,
	[ConversionAllTissueArrest] [int] NULL ,
	[ConversionOrganNeverBrainDead] [int] NULL ,
	[ConversionBoneNeverBrainDead] [int] NULL ,
	[ConversionTissueNeverBrainDead] [int] NULL ,
	[ConversionSkinNeverBrainDead] [int] NULL ,
	[ConversionValvesNeverBrainDead] [int] NULL ,
	[ConversionEyesNeverBrainDead] [int] NULL ,
	[ConversionOtherNeverBrainDead] [int] NULL ,
	[ConversionAllTissueNeverBrainDead] [int] NULL ,
	[ConversionOrganMedRO] [int] NULL ,
	[ConversionBoneMedRO] [int] NULL ,
	[ConversionTissueMedRO] [int] NULL ,
	[ConversionSkinMedRO] [int] NULL ,
	[ConversionValvesMedRO] [int] NULL ,
	[ConversionEyesMedRO] [int] NULL ,
	[ConversionOtherMedRO] [int] NULL ,
	[ConversionAllTissueMedRO] [int] NULL ,
	[ConversionOrganHighRisk] [int] NULL ,
	[ConversionBoneHighRisk] [int] NULL ,
	[ConversionTissueHighRisk] [int] NULL ,
	[ConversionSkinHighRisk] [int] NULL ,
	[ConversionValvesHighRisk] [int] NULL ,
	[ConversionEyesHighRisk] [int] NULL ,
	[ConversionOtherHighRisk] [int] NULL ,
	[ConversionAllTissueHighRisk] [int] NULL ,
	[ConversionOrganTimeLogistics] [int] NULL ,
	[ConversionBoneTimeLogistics] [int] NULL ,
	[ConversionTissueTimeLogistics] [int] NULL ,
	[ConversionSkinTimeLogistics] [int] NULL ,
	[ConversionValvesTimeLogistics] [int] NULL ,
	[ConversionEyesTimeLogistics] [int] NULL ,
	[ConversionOtherTimeLogistics] [int] NULL ,
	[ConversionAllTissueTimeLogistics] [int] NULL ,
	[ConversionOrganHeartTxable] [int] NULL ,
	[ConversionBoneHeartTxable] [int] NULL ,
	[ConversionTissueHeartTxable] [int] NULL ,
	[ConversionSkinHeartTxable] [int] NULL ,
	[ConversionValvesHeartTxable] [int] NULL ,
	[ConversionEyesHeartTxable] [int] NULL ,
	[ConversionOtherHeartTxable] [int] NULL ,
	[ConversionAllTissueHeartTxable] [int] NULL ,
	[ConversionOrganUnknown] [int] NULL ,
	[ConversionBoneUnknown] [int] NULL ,
	[ConversionTissueUnknown] [int] NULL ,
	[ConversionSkinUnknown] [int] NULL ,
	[ConversionValvesUnknown] [int] NULL ,
	[ConversionEyesUnknown] [int] NULL ,
	[ConversionOtherUnknown] [int] NULL ,
	[ConversionAllTissueUnknown] [int] NULL ,
	[AppropriateRO] [int] NULL ,
	[RegConversionOrgan] [int] NULL ,
	[RegConversionBone] [int] NULL ,
	[RegConversionTissue] [int] NULL ,
	[RegConversionSkin] [int] NULL ,
	[RegConversionValves] [int] NULL ,
	[RegConversionEyes] [int] NULL ,
	[RegConversionOther] [int] NULL ,
	[RegConversionAllTissue] [int] NULL ,
	[RegConversionOrganNotRecovered] [int] NULL ,
	[RegConversionBoneNotRecovered] [int] NULL ,
	[RegConversionTissueNotRecovered] [int] NULL ,
	[RegConversionSkinNotRecovered] [int] NULL ,
	[RegConversionValvesNotRecovered] [int] NULL ,
	[RegConversionEyesNotRecovered] [int] NULL ,
	[RegConversionOtherNotRecovered] [int] NULL ,
	[RegConversionAllTissueNotRecovered] [int] NULL ,
	[RegConversionOrganCoronerRuleout] [int] NULL ,
	[RegConversionBoneCoronerRuleout] [int] NULL ,
	[RegConversionTissueCoronerRuleout] [int] NULL ,
	[RegConversionSkinCoronerRuleout] [int] NULL ,
	[RegConversionValvesCoronerRuleout] [int] NULL ,
	[RegConversionEyesCoronerRuleout] [int] NULL ,
	[RegConversionOtherCoronerRuleout] [int] NULL ,
	[RegConversionAllTissueCoronerRuleout] [int] NULL ,
	[RegConversionOrganArrest] [int] NULL ,
	[RegConversionBoneArrest] [int] NULL ,
	[RegConversionTissueArrest] [int] NULL ,
	[RegConversionSkinArrest] [int] NULL ,
	[RegConversionValvesArrest] [int] NULL ,
	[RegConversionEyesArrest] [int] NULL ,
	[RegConversionOtherArrest] [int] NULL ,
	[RegConversionAllTissueArrest] [int] NULL ,
	[RegConversionOrganNeverBrainDead] [int] NULL ,
	[RegConversionBoneNeverBrainDead] [int] NULL ,
	[RegConversionTissueNeverBrainDead] [int] NULL ,
	[RegConversionSkinNeverBrainDead] [int] NULL ,
	[RegConversionValvesNeverBrainDead] [int] NULL ,
	[RegConversionEyesNeverBrainDead] [int] NULL ,
	[RegConversionOtherNeverBrainDead] [int] NULL ,
	[RegConversionAllTissueNeverBrainDead] [int] NULL ,
	[RegConversionOrganMedRO] [int] NULL ,
	[RegConversionBoneMedRO] [int] NULL ,
	[RegConversionTissueMedRO] [int] NULL ,
	[RegConversionSkinMedRO] [int] NULL ,
	[RegConversionValvesMedRO] [int] NULL ,
	[RegConversionEyesMedRO] [int] NULL ,
	[RegConversionOtherMedRO] [int] NULL ,
	[RegConversionAllTissueMedRO] [int] NULL ,
	[RegConversionOrganHighRisk] [int] NULL ,
	[RegConversionBoneHighRisk] [int] NULL ,
	[RegConversionTissueHighRisk] [int] NULL ,
	[RegConversionSkinHighRisk] [int] NULL ,
	[RegConversionValvesHighRisk] [int] NULL ,
	[RegConversionEyesHighRisk] [int] NULL ,
	[RegConversionOtherHighRisk] [int] NULL ,
	[RegConversionAllTissueHighRisk] [int] NULL ,
	[RegConversionOrganTimeLogistics] [int] NULL ,
	[RegConversionBoneTimeLogistics] [int] NULL ,
	[RegConversionTissueTimeLogistics] [int] NULL ,
	[RegConversionSkinTimeLogistics] [int] NULL ,
	[RegConversionValvesTimeLogistics] [int] NULL ,
	[RegConversionEyesTimeLogistics] [int] NULL ,
	[RegConversionOtherTimeLogistics] [int] NULL ,
	[RegConversionAllTissueTimeLogistics] [int] NULL ,
	[RegConversionOrganHeartTxable] [int] NULL ,
	[RegConversionBoneHeartTxable] [int] NULL ,
	[RegConversionTissueHeartTxable] [int] NULL ,
	[RegConversionSkinHeartTxable] [int] NULL ,
	[RegConversionValvesHeartTxable] [int] NULL ,
	[RegConversionEyesHeartTxable] [int] NULL ,
	[RegConversionOtherHeartTxable] [int] NULL ,
	[RegConversionAllTissueHeartTxable] [int] NULL ,
	[RegConversionOrganUnknown] [int] NULL ,
	[RegConversionBoneUnknown] [int] NULL ,
	[RegConversionTissueUnknown] [int] NULL ,
	[RegConversionSkinUnknown] [int] NULL ,
	[RegConversionValvesUnknown] [int] NULL ,
	[RegConversionEyesUnknown] [int] NULL ,
	[RegConversionOtherUnknown] [int] NULL ,
	[RegConversionAllTissueUnknown] [int] NULL ,
	[ConversionOrganFamilyRO] [int] NULL ,
	[ConversionBoneFamilyRO] [int] NULL ,
	[ConversionTissueFamilyRO] [int] NULL ,
	[ConversionSkinFamilyRO] [int] NULL ,
	[ConversionValvesFamilyRO] [int] NULL ,
	[ConversionEyesFamilyRO] [int] NULL ,
	[ConversionOtherFamilyRO] [int] NULL ,
	[ConversionAllTissueFamilyRO] [int] NULL ,
	[RegConversionOrganFamilyRO] [int] NULL ,
	[RegConversionBoneFamilyRO] [int] NULL ,
	[RegConversionTissueFamilyRO] [int] NULL ,
	[RegConversionSkinFamilyRO] [int] NULL ,
	[RegConversionValvesFamilyRO] [int] NULL ,
	[RegConversionEyesFamilyRO] [int] NULL ,
	[RegConversionOtherFamilyRO] [int] NULL ,
	[RegConversionAllTissueFamilyRO] [int] NULL ,
	[RegConversionAllTypes] [int] NULL ,
	[ConversionOrganCNR] [int] NULL ,
	[ConversionBoneCNR] [int] NULL ,
	[ConversionTissueCNR] [int] NULL ,
	[ConversionSkinCNR] [int] NULL ,
	[ConversionValvesCNR] [int] NULL ,
	[ConversionEyesCNR] [int] NULL ,
	[ConversionOtherCNR] [int] NULL ,
	[ConversionAllTissueCNR] [int] NULL ,
	[RegConversionOrganCNR] [int] NULL ,
	[RegConversionBoneCNR] [int] NULL ,
	[RegConversionTissueCNR] [int] NULL ,
	[RegConversionSkinCNR] [int] NULL ,
	[RegConversionValvesCNR] [int] NULL ,
	[RegConversionEyesCNR] [int] NULL ,
	[RegConversionOtherCNR] [int] NULL ,
	[RegConversionAllTissueCNR] [int] NULL ,
	[ConversionOrganNotPronounced] [int] NULL ,
	[ConversionBoneNotPronounced] [int] NULL ,
	[ConversionTissueNotPronounced] [int] NULL ,
	[ConversionSkinNotPronounced] [int] NULL ,
	[ConversionValvesNotPronounced] [int] NULL ,
	[ConversionEyesNotPronounced] [int] NULL ,
	[ConversionOtherNotPronounced] [int] NULL ,
	[ConversionAllTissueNotPronounced] [int] NULL ,
	[ConversionOrganNoJurisdiction] [int] NULL ,
	[ConversionBoneNoJurisdiction] [int] NULL ,
	[ConversionTissueNoJurisdiction] [int] NULL ,
	[ConversionSkinNoJurisdiction] [int] NULL ,
	[ConversionValvesNoJurisdiction] [int] NULL ,
	[ConversionEyesNoJurisdiction] [int] NULL ,
	[ConversionOtherNoJurisdiction] [int] NULL ,
	[ConversionAllTissueNoJurisdiction] [int] NULL ,
	[ConversionOrganDidNotDie] [int] NULL ,
	[ConversionBoneDidNotDie] [int] NULL ,
	[ConversionTissueDidNotDie] [int] NULL ,
	[ConversionSkinDidNotDie] [int] NULL ,
	[ConversionValvesDidNotDie] [int] NULL ,
	[ConversionEyesDidNotDie] [int] NULL ,
	[ConversionOtherDidNotDie] [int] NULL ,
	[ConversionAllTissueDidNotDie] [int] NULL ,
	[ConversionOrganHemodiluted] [int] NULL ,
	[ConversionBoneHemodiluted] [int] NULL ,
	[ConversionTissueHemodiluted] [int] NULL ,
	[ConversionSkinHemodiluted] [int] NULL ,
	[ConversionValvesHemodiluted] [int] NULL ,
	[ConversionEyesHemodiluted] [int] NULL ,
	[ConversionOtherHemodiluted] [int] NULL ,
	[ConversionAllTissueHemodiluted] [int] NULL ,
	[ConversionOrganTeamLogistics] [int] NULL ,
	[ConversionBoneTeamLogistics] [int] NULL ,
	[ConversionTissueTeamLogistics] [int] NULL ,
	[ConversionSkinTeamLogistics] [int] NULL ,
	[ConversionValvesTeamLogistics] [int] NULL ,
	[ConversionEyesTeamLogistics] [int] NULL ,
	[ConversionOtherTeamLogistics] [int] NULL ,
	[ConversionAllTissueTeamLogistics] [int] NULL ,
	[ConversionOrganConsentRetracted] [int] NULL ,
	[ConversionBoneConsentRetracted] [int] NULL ,
	[ConversionTissueConsentRetracted] [int] NULL ,
	[ConversionSkinConsentRetracted] [int] NULL ,
	[ConversionValvesConsentRetracted] [int] NULL ,
	[ConversionEyesConsentRetracted] [int] NULL ,
	[ConversionOtherConsentRetracted] [int] NULL ,
	[ConversionAllTissueConsentRetracted] [int] NULL ,
	[ConversionOrganDeclinedByProcessors] [int] NULL ,
	[ConversionBoneDeclinedByProcessors] [int] NULL ,
	[ConversionTissueDeclinedByProcessors] [int] NULL ,
	[ConversionSkinDeclinedByProcessors] [int] NULL ,
	[ConversionValvesDeclinedByProcessors] [int] NULL ,
	[ConversionEyesDeclinedByProcessors] [int] NULL ,
	[ConversionOtherDeclinedByProcessors] [int] NULL ,
	[ConversionAllTissueDeclinedByProcessors] [int] NULL ,
	[ConversionOrganUnapproachable] [int] NULL ,
	[ConversionBoneUnapproachable] [int] NULL ,
	[ConversionTissueUnapproachable] [int] NULL ,
	[ConversionSkinUnapproachable] [int] NULL ,
	[ConversionValvesUnapproachable] [int] NULL ,
	[ConversionEyesUnapproachable] [int] NULL ,
	[ConversionOtherUnapproachable] [int] NULL ,
	[ConversionAllTissueUnapproachable] [int] NULL ,
	[RegConversionOrganNotPronounced] [int] NULL ,
	[RegConversionBoneNotPronounced] [int] NULL ,
	[RegConversionTissueNotPronounced] [int] NULL ,
	[RegConversionSkinNotPronounced] [int] NULL ,
	[RegConversionValvesNotPronounced] [int] NULL ,
	[RegConversionEyesNotPronounced] [int] NULL ,
	[RegConversionOtherNotPronounced] [int] NULL ,
	[RegConversionAllTissueNotPronounced] [int] NULL ,
	[RegConversionOrganNoJurisdiction] [int] NULL ,
	[RegConversionBoneNoJurisdiction] [int] NULL ,
	[RegConversionTissueNoJurisdiction] [int] NULL ,
	[RegConversionSkinNoJurisdiction] [int] NULL ,
	[RegConversionValvesNoJurisdiction] [int] NULL ,
	[RegConversionEyesNoJurisdiction] [int] NULL ,
	[RegConversionOtherNoJurisdiction] [int] NULL ,
	[RegConversionAllTissueNoJurisdiction] [int] NULL ,
	[RegConversionOrganDidNotDie] [int] NULL ,
	[RegConversionBoneDidNotDie] [int] NULL ,
	[RegConversionTissueDidNotDie] [int] NULL ,
	[RegConversionSkinDidNotDie] [int] NULL ,
	[RegConversionValvesDidNotDie] [int] NULL ,
	[RegConversionEyesDidNotDie] [int] NULL ,
	[RegConversionOtherDidNotDie] [int] NULL ,
	[RegConversionAllTissueDidNotDie] [int] NULL ,
	[RegConversionOrganHemodiluted] [int] NULL ,
	[RegConversionBoneHemodiluted] [int] NULL ,
	[RegConversionTissueHemodiluted] [int] NULL ,
	[RegConversionSkinHemodiluted] [int] NULL ,
	[RegConversionValvesHemodiluted] [int] NULL ,
	[RegConversionEyesHemodiluted] [int] NULL ,
	[RegConversionOtherHemodiluted] [int] NULL ,
	[RegConversionAllTissueHemodiluted] [int] NULL ,
	[RegConversionOrganTeamLogistics] [int] NULL ,
	[RegConversionBoneTeamLogistics] [int] NULL ,
	[RegConversionTissueTeamLogistics] [int] NULL ,
	[RegConversionSkinTeamLogistics] [int] NULL ,
	[RegConversionValvesTeamLogistics] [int] NULL ,
	[RegConversionEyesTeamLogistics] [int] NULL ,
	[RegConversionOtherTeamLogistics] [int] NULL ,
	[RegConversionAllTissueTeamLogistics] [int] NULL ,
	[RegConversionOrganConsentRetracted] [int] NULL ,
	[RegConversionBoneConsentRetracted] [int] NULL ,
	[RegConversionTissueConsentRetracted] [int] NULL ,
	[RegConversionSkinConsentRetracted] [int] NULL ,
	[RegConversionValvesConsentRetracted] [int] NULL ,
	[RegConversionEyesConsentRetracted] [int] NULL ,
	[RegConversionOtherConsentRetracted] [int] NULL ,
	[RegConversionAllTissueConsentRetracted] [int] NULL ,
	[RegConversionOrganDeclinedByProcessors] [int] NULL ,
	[RegConversionBoneDeclinedByProcessors] [int] NULL ,
	[RegConversionTissueDeclinedByProcessors] [int] NULL ,
	[RegConversionSkinDeclinedByProcessors] [int] NULL ,
	[RegConversionValvesDeclinedByProcessors] [int] NULL ,
	[RegConversionEyesDeclinedByProcessors] [int] NULL ,
	[RegConversionOtherDeclinedByProcessors] [int] NULL ,
	[RegConversionAllTissueDeclinedByProcessors] [int] NULL ,
	[RegConversionOrganUnapproachable] [int] NULL ,
	[RegConversionBoneUnapproachable] [int] NULL ,
	[RegConversionTissueUnapproachable] [int] NULL ,
	[RegConversionSkinUnapproachable] [int] NULL ,
	[RegConversionValvesUnapproachable] [int] NULL ,
	[RegConversionEyesUnapproachable] [int] NULL ,
	[RegConversionOtherUnapproachable] [int] NULL ,
	[RegConversionAllTissueUnapproachable] [int] NULL 
) ON [PRIMARY]
GO


