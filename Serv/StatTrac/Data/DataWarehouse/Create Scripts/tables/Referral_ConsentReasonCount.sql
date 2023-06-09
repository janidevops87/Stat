if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_ConsentReasonCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_ConsentReasonCount]
GO

CREATE TABLE [dbo].[Referral_ConsentReasonCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[AllTypes] [int] NULL ,
	[ConsentOrgan] [int] NULL ,
	[ConsentBone] [int] NULL ,
	[ConsentTissue] [int] NULL ,
	[ConsentSkin] [int] NULL ,
	[ConsentValves] [int] NULL ,
	[ConsentEyes] [int] NULL ,
	[ConsentOther] [int] NULL ,
	[ConsentAllTissue] [int] NULL ,
	[ConsentOrganNotConsented] [int] NULL ,
	[ConsentBoneNotConsented] [int] NULL ,
	[ConsentTissueNotConsented] [int] NULL ,
	[ConsentSkinNotConsented] [int] NULL ,
	[ConsentValvesNotConsented] [int] NULL ,
	[ConsentEyesNotConsented] [int] NULL ,
	[ConsentOtherNotConsented] [int] NULL ,
	[ConsentAllTissueNotConsented] [int] NULL ,
	[ConsentOrganEthnic] [int] NULL ,
	[ConsentBoneEthnic] [int] NULL ,
	[ConsentTissueEthnic] [int] NULL ,
	[ConsentSkinEthnic] [int] NULL ,
	[ConsentValvesEthnic] [int] NULL ,
	[ConsentEyesEthnic] [int] NULL ,
	[ConsentOtherEthnic] [int] NULL ,
	[ConsentAllTissueEthnic] [int] NULL ,
	[ConsentOrganReligious] [int] NULL ,
	[ConsentBoneReligious] [int] NULL ,
	[ConsentTissueReligious] [int] NULL ,
	[ConsentSkinReligious] [int] NULL ,
	[ConsentValvesReligious] [int] NULL ,
	[ConsentEyesReligious] [int] NULL ,
	[ConsentOtherReligious] [int] NULL ,
	[ConsentAllTissueReligious] [int] NULL ,
	[ConsentOrganEmotional] [int] NULL ,
	[ConsentBoneEmotional] [int] NULL ,
	[ConsentTissueEmotional] [int] NULL ,
	[ConsentSkinEmotional] [int] NULL ,
	[ConsentValvesEmotional] [int] NULL ,
	[ConsentEyesEmotional] [int] NULL ,
	[ConsentOtherEmotional] [int] NULL ,
	[ConsentAllTissueEmotional] [int] NULL ,
	[ConsentOrganUnknown] [int] NULL ,
	[ConsentBoneUnknown] [int] NULL ,
	[ConsentTissueUnknown] [int] NULL ,
	[ConsentSkinUnknown] [int] NULL ,
	[ConsentValvesUnknown] [int] NULL ,
	[ConsentEyesUnknown] [int] NULL ,
	[ConsentOtherUnknown] [int] NULL ,
	[ConsentAllTissueUnknown] [int] NULL ,
	[ConsentOrganPrevDiscussion] [int] NULL ,
	[ConsentBonePrevDiscussion] [int] NULL ,
	[ConsentTissuePrevDiscussion] [int] NULL ,
	[ConsentSkinPrevDiscussion] [int] NULL ,
	[ConsentValvesPrevDiscussion] [int] NULL ,
	[ConsentEyesPrevDiscussion] [int] NULL ,
	[ConsentOtherPrevDiscussion] [int] NULL ,
	[ConsentAllTissuePrevDiscussion] [int] NULL ,
	[AppropriateRO] [int] NULL ,
	[RegConsentOrgan] [int] NULL ,
	[RegConsentBone] [int] NULL ,
	[RegConsentTissue] [int] NULL ,
	[RegConsentSkin] [int] NULL ,
	[RegConsentValves] [int] NULL ,
	[RegConsentEyes] [int] NULL ,
	[RegConsentOther] [int] NULL ,
	[RegConsentAllTissue] [int] NULL ,
	[RegConsentOrganDMVReg] [int] NULL ,
	[RegConsentBoneDMVReg] [int] NULL ,
	[RegConsentTissueDMVReg] [int] NULL ,
	[RegConsentSkinDMVReg] [int] NULL ,
	[RegConsentValvesDMVReg] [int] NULL ,
	[RegConsentEyesDMVReg] [int] NULL ,
	[RegConsentOtherDMVReg] [int] NULL ,
	[RegConsentAllTissueDMVReg] [int] NULL ,
	[RegConsentOrganDRReg] [int] NULL ,
	[RegConsentBoneDRReg] [int] NULL ,
	[RegConsentTissueDRReg] [int] NULL ,
	[RegConsentSkinDRReg] [int] NULL ,
	[RegConsentValvesDRReg] [int] NULL ,
	[RegConsentEyesDRReg] [int] NULL ,
	[RegConsentOtherDRReg] [int] NULL ,
	[RegConsentAllTissueDRReg] [int] NULL ,
	[RegConsentOrganNotConsented] [int] NULL ,
	[RegConsentBoneNotConsented] [int] NULL ,
	[RegConsentTissueNotConsented] [int] NULL ,
	[RegConsentSkinNotConsented] [int] NULL ,
	[RegConsentValvesNotConsented] [int] NULL ,
	[RegConsentEyesNotConsented] [int] NULL ,
	[RegConsentOtherNotConsented] [int] NULL ,
	[RegConsentAllTissueNotConsented] [int] NULL ,
	[RegConsentOrganEthnic] [int] NULL ,
	[RegConsentBoneEthnic] [int] NULL ,
	[RegConsentTissueEthnic] [int] NULL ,
	[RegConsentSkinEthnic] [int] NULL ,
	[RegConsentValvesEthnic] [int] NULL ,
	[RegConsentEyesEthnic] [int] NULL ,
	[RegConsentOtherEthnic] [int] NULL ,
	[RegConsentAllTissueEthnic] [int] NULL ,
	[RegConsentOrganReligious] [int] NULL ,
	[RegConsentBoneReligious] [int] NULL ,
	[RegConsentTissueReligious] [int] NULL ,
	[RegConsentSkinReligious] [int] NULL ,
	[RegConsentValvesReligious] [int] NULL ,
	[RegConsentEyesReligious] [int] NULL ,
	[RegConsentOtherReligious] [int] NULL ,
	[RegConsentAllTissueReligious] [int] NULL ,
	[RegConsentOrganEmotional] [int] NULL ,
	[RegConsentBoneEmotional] [int] NULL ,
	[RegConsentTissueEmotional] [int] NULL ,
	[RegConsentSkinEmotional] [int] NULL ,
	[RegConsentValvesEmotional] [int] NULL ,
	[RegConsentEyesEmotional] [int] NULL ,
	[RegConsentOtherEmotional] [int] NULL ,
	[RegConsentAllTissueEmotional] [int] NULL ,
	[RegConsentOrganUnknown] [int] NULL ,
	[RegConsentBoneUnknown] [int] NULL ,
	[RegConsentTissueUnknown] [int] NULL ,
	[RegConsentSkinUnknown] [int] NULL ,
	[RegConsentValvesUnknown] [int] NULL ,
	[RegConsentEyesUnknown] [int] NULL ,
	[RegConsentOtherUnknown] [int] NULL ,
	[RegConsentAllTissueUnknown] [int] NULL ,
	[RegConsentOrganPrevDiscussion] [int] NULL ,
	[RegConsentBonePrevDiscussion] [int] NULL ,
	[RegConsentTissuePrevDiscussion] [int] NULL ,
	[RegConsentSkinPrevDiscussion] [int] NULL ,
	[RegConsentValvesPrevDiscussion] [int] NULL ,
	[RegConsentEyesPrevDiscussion] [int] NULL ,
	[RegConsentOtherPrevDiscussion] [int] NULL ,
	[RegConsentAllTissuePrevDiscussion] [int] NULL ,
	[ConsentOrganNotPronounced] [int] NULL ,
	[ConsentBoneNotPronounced] [int] NULL ,
	[ConsentTissueNotPronounced] [int] NULL ,
	[ConsentSkinNotPronounced] [int] NULL ,
	[ConsentValvesNotPronounced] [int] NULL ,
	[ConsentEyesNotPronounced] [int] NULL ,
	[ConsentOtherNotPronounced] [int] NULL ,
	[ConsentAllTissueNotPronounced] [int] NULL ,
	[ConsentOrganNoJurisdiction] [int] NULL ,
	[ConsentBoneNoJurisdiction] [int] NULL ,
	[ConsentTissueNoJurisdiction] [int] NULL ,
	[ConsentSkinNoJurisdiction] [int] NULL ,
	[ConsentValvesNoJurisdiction] [int] NULL ,
	[ConsentEyesNoJurisdiction] [int] NULL ,
	[ConsentOtherNoJurisdiction] [int] NULL ,
	[ConsentAllTissueNoJurisdiction] [int] NULL ,
	[ConsentOrganDidNotDie] [int] NULL ,
	[ConsentBoneDidNotDie] [int] NULL ,
	[ConsentTissueDidNotDie] [int] NULL ,
	[ConsentSkinDidNotDie] [int] NULL ,
	[ConsentValvesDidNotDie] [int] NULL ,
	[ConsentEyesDidNotDie] [int] NULL ,
	[ConsentOtherDidNotDie] [int] NULL ,
	[ConsentAllTissueDidNotDie] [int] NULL ,
	[RegConsentOrganNotPronounced] [int] NULL ,
	[RegConsentBoneNotPronounced] [int] NULL ,
	[RegConsentTissueNotPronounced] [int] NULL ,
	[RegConsentSkinNotPronounced] [int] NULL ,
	[RegConsentValvesNotPronounced] [int] NULL ,
	[RegConsentEyesNotPronounced] [int] NULL ,
	[RegConsentOtherNotPronounced] [int] NULL ,
	[RegConsentAllTissueNotPronounced] [int] NULL ,
	[RegConsentOrganNoJurisdiction] [int] NULL ,
	[RegConsentBoneNoJurisdiction] [int] NULL ,
	[RegConsentTissueNoJurisdiction] [int] NULL ,
	[RegConsentSkinNoJurisdiction] [int] NULL ,
	[RegConsentValvesNoJurisdiction] [int] NULL ,
	[RegConsentEyesNoJurisdiction] [int] NULL ,
	[RegConsentOtherNoJurisdiction] [int] NULL ,
	[RegConsentAllTissueNoJurisdiction] [int] NULL ,
	[RegConsentOrganDidNotDie] [int] NULL ,
	[RegConsentBoneDidNotDie] [int] NULL ,
	[RegConsentTissueDidNotDie] [int] NULL ,
	[RegConsentSkinDidNotDie] [int] NULL ,
	[RegConsentValvesDidNotDie] [int] NULL ,
	[RegConsentEyesDidNotDie] [int] NULL ,
	[RegConsentOtherDidNotDie] [int] NULL ,
	[RegConsentAllTissueDidNotDie] [int] NULL 
) ON [PRIMARY]
GO


