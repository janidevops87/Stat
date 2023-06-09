SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ConsentReasonSummary_A]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ConsentReasonSummary_A]
GO




CREATE   PROCEDURE sps_ConsentReasonSummary_A

	@vReportGroupID	int		= 0,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vOrgID		int		= 0

AS
/* ccarroll 11/20/2006 added StatTrac 8.2 options */
IF	@vOrgID = 0

    	SELECT 		
			Sum(ConsentOrgan) AS ConsentOrgan, 
			Sum(ConsentBone) AS ConsentBone,
			Sum(ConsentTissue) AS ConsentTissue,
			Sum(ConsentSkin) AS ConsentSkin,
			Sum(ConsentValves) AS ConsentValves,
			Sum(ConsentEyes) AS ConsentEyes,

			Sum(ConsentOrganNotConsented) AS ConsentOrganNotConsented, 
			Sum(ConsentBoneNotConsented) AS ConsentBoneNotConsented,
			Sum(ConsentTissueNotConsented) AS ConsentTissueNotConsented,
			Sum(ConsentSkinNotConsented) AS ConsentSkinNotConsented,
			Sum(ConsentValvesNotConsented) AS ConsentValvesNotConsented,
			Sum(ConsentEyesNotConsented) AS ConsentEyesNotConsented,

			Sum(ConsentOrganEthnic) AS ConsentOrganEthnic, 
			Sum(ConsentBoneEthnic) AS ConsentBoneEthnic,
			Sum(ConsentTissueEthnic) AS ConsentTissueEthnic,
			Sum(ConsentSkinEthnic) AS ConsentSkinEthnic,
			Sum(ConsentValvesEthnic) AS ConsentValvesEthnic,
			Sum(ConsentEyesEthnic) AS ConsentEyesEthnic,

			Sum(ConsentOrganReligious) AS ConsentOrganReligious, 
			Sum(ConsentBoneReligious) AS ConsentBoneReligious,
			Sum(ConsentTissueReligious) AS ConsentTissueReligious,
			Sum(ConsentSkinReligious) AS ConsentSkinReligious,
			Sum(ConsentValvesReligious) AS ConsentValvesReligious,
			Sum(ConsentEyesReligious) AS ConsentEyesReligious,

			Sum(ConsentOrganEmotional) AS ConsentOrganEmotional, 
			Sum(ConsentBoneEmotional) AS ConsentBoneEmotional,
			Sum(ConsentTissueEmotional) AS ConsentTissueEmotional,
			Sum(ConsentSkinEmotional) AS ConsentSkinEmotional,
			Sum(ConsentValvesEmotional) AS ConsentValvesEmotional,
			Sum(ConsentEyesEmotional) AS ConsentEyesEmotional,

			Sum(ConsentOrganUnknown) AS ConsentOrganUnknown, 
			Sum(ConsentBoneUnknown) AS ConsentBoneUnknown,
			Sum(ConsentTissueUnknown) AS ConsentTissueUnknown,
			Sum(ConsentSkinUnknown) AS ConsentSkinUnknown,
			Sum(ConsentValvesUnknown) AS ConsentValvesUnknown,
			Sum(ConsentEyesUnknown) AS ConsentEyesUnknown,

			Sum(ConsentOrganPrevDiscussion) AS ConsentOrganPrevDiscussion, 
			Sum(ConsentBonePrevDiscussion) AS ConsentBonePrevDiscussion,
			Sum(ConsentTissuePrevDiscussion) AS ConsentTissuePrevDiscussion,
			Sum(ConsentSkinPrevDiscussion) AS ConsentSkinPrevDiscussion,
			Sum(ConsentValvesPrevDiscussion) AS ConsentValvesPrevDiscussion,
			Sum(ConsentEyesPrevDiscussion) AS ConsentEyesPrevDiscussion,

			--drh 10/31/01
			Sum(RegConsentOrgan) AS RegConsentOrgan, 
			Sum(RegConsentBone) AS RegConsentBone,
			Sum(RegConsentTissue) AS RegConsentTissue,
			Sum(RegConsentSkin) AS RegConsentSkin,
			Sum(RegConsentValves) AS RegConsentValves,
			Sum(RegConsentEyes) AS RegConsentEyes,

			Sum(RegConsentOrganDMVReg) AS RegConsentOrganDMVReg, 
			Sum(RegConsentBoneDMVReg) AS RegConsentBoneDMVReg,
			Sum(RegConsentTissueDMVReg) AS RegConsentTissueDMVReg,
			Sum(RegConsentSkinDMVReg) AS RegConsentSkinDMVReg,
			Sum(RegConsentValvesDMVReg) AS RegConsentValvesDMVReg,
			Sum(RegConsentEyesDMVReg) AS RegConsentEyesDMVReg,

			Sum(RegConsentOrganDRReg) AS RegConsentOrganDRReg, 
			Sum(RegConsentBoneDRReg) AS RegConsentBoneDRReg,
			Sum(RegConsentTissueDRReg) AS RegConsentTissueDRReg,
			Sum(RegConsentSkinDRReg) AS RegConsentSkinDRReg,
			Sum(RegConsentValvesDRReg) AS RegConsentValvesDRReg,
			Sum(RegConsentEyesDRReg) AS RegConsentEyesDRReg,

			Sum(RegConsentOrganNotConsented) AS RegConsentOrganNotConsented, 
			Sum(RegConsentBoneNotConsented) AS RegConsentBoneNotConsented,
			Sum(RegConsentTissueNotConsented) AS RegConsentTissueNotConsented,
			Sum(RegConsentSkinNotConsented) AS RegConsentSkinNotConsented,
			Sum(RegConsentValvesNotConsented) AS RegConsentValvesNotConsented,
			Sum(RegConsentEyesNotConsented) AS RegConsentEyesNotConsented,

			Sum(RegConsentOrganEthnic) AS RegConsentOrganEthnic, 
			Sum(RegConsentBoneEthnic) AS RegConsentBoneEthnic,
			Sum(RegConsentTissueEthnic) AS RegConsentTissueEthnic,
			Sum(RegConsentSkinEthnic) AS RegConsentSkinEthnic,
			Sum(RegConsentValvesEthnic) AS RegConsentValvesEthnic,
			Sum(RegConsentEyesEthnic) AS RegConsentEyesEthnic,

			Sum(RegConsentOrganReligious) AS RegConsentOrganReligious, 
			Sum(RegConsentBoneReligious) AS RegConsentBoneReligious,
			Sum(RegConsentTissueReligious) AS RegConsentTissueReligious,
			Sum(RegConsentSkinReligious) AS RegConsentSkinReligious,
			Sum(RegConsentValvesReligious) AS RegConsentValvesReligious,
			Sum(RegConsentEyesReligious) AS RegConsentEyesReligious,

			Sum(RegConsentOrganEmotional) AS RegConsentOrganEmotional, 
			Sum(RegConsentBoneEmotional) AS RegConsentBoneEmotional,
			Sum(RegConsentTissueEmotional) AS RegConsentTissueEmotional,
			Sum(RegConsentSkinEmotional) AS RegConsentSkinEmotional,
			Sum(RegConsentValvesEmotional) AS RegConsentValvesEmotional,
			Sum(RegConsentEyesEmotional) AS RegConsentEyesEmotional,

			Sum(RegConsentOrganUnknown) AS RegConsentOrganUnknown, 
			Sum(RegConsentBoneUnknown) AS RegConsentBoneUnknown,
			Sum(RegConsentTissueUnknown) AS RegConsentTissueUnknown,
			Sum(RegConsentSkinUnknown) AS RegConsentSkinUnknown,
			Sum(RegConsentValvesUnknown) AS RegConsentValvesUnknown,
			Sum(RegConsentEyesUnknown) AS RegConsentEyesUnknown,

			Sum(RegConsentOrganPrevDiscussion) AS RegConsentOrganPrevDiscussion, 
			Sum(RegConsentBonePrevDiscussion) AS RegConsentBonePrevDiscussion,
			Sum(RegConsentTissuePrevDiscussion) AS RegConsentTissuePrevDiscussion,
			Sum(RegConsentSkinPrevDiscussion) AS RegConsentSkinPrevDiscussion,
			Sum(RegConsentValvesPrevDiscussion) AS RegConsentValvesPrevDiscussion,
			Sum(RegConsentEyesPrevDiscussion) AS RegConsentEyesPrevDiscussion,

			--ccarroll 11/20/2006 added StatTrac 8.2 options
			Sum(ConsentOrganNotPronounced) AS ConsentOrganNotPronounced, 
			Sum(ConsentBoneNotPronounced) AS ConsentBoneNotPronounced,
			Sum(ConsentTissueNotPronounced) AS ConsentTissueNotPronounced,
			Sum(ConsentSkinNotPronounced) AS ConsentSkinNotPronounced,
			Sum(ConsentValvesNotPronounced) AS ConsentValvesNotPronounced,
			Sum(ConsentEyesNotPronounced) AS ConsentEyesNotPronounced,

			Sum(ConsentOrganNoJurisdiction) AS ConsentOrganNoJurisdiction, 
			Sum(ConsentBoneNoJurisdiction) AS ConsentBoneNoJurisdiction,
			Sum(ConsentTissueNoJurisdiction) AS ConsentTissueNoJurisdiction,
			Sum(ConsentSkinNoJurisdiction) AS ConsentSkinNoJurisdiction,
			Sum(ConsentValvesNoJurisdiction) AS ConsentValvesNoJurisdiction,
			Sum(ConsentEyesNoJurisdiction) AS ConsentEyesNoJurisdiction,

			Sum(ConsentOrganDidNotDie) AS ConsentOrganDidNotDie, 
			Sum(ConsentBoneDidNotDie) AS ConsentBoneDidNotDie,
			Sum(ConsentTissueDidNotDie) AS ConsentTissueDidNotDie,
			Sum(ConsentSkinDidNotDie) AS ConsentSkinDidNotDie,
			Sum(ConsentValvesDidNotDie) AS ConsentValvesDidNotDie,
			Sum(ConsentEyesDidNotDie) AS ConsentEyesDidNotDie,

			Sum(RegConsentOrganNotPronounced) AS RegConsentOrganNotPronounced, 
			Sum(RegConsentBoneNotPronounced) AS RegConsentBoneNotPronounced,
			Sum(RegConsentTissueNotPronounced) AS RegConsentTissueNotPronounced,
			Sum(RegConsentSkinNotPronounced) AS RegConsentSkinNotPronounced,
			Sum(RegConsentValvesNotPronounced) AS RegConsentValvesNotPronounced,
			Sum(RegConsentEyesNotPronounced) AS RegConsentEyesNotPronounced,

			Sum(RegConsentOrganNoJurisdiction) AS RegConsentOrganNoJurisdiction, 
			Sum(RegConsentBoneNoJurisdiction) AS RegConsentBoneNoJurisdiction,
			Sum(RegConsentTissueNoJurisdiction) AS RegConsentTissueNoJurisdiction,
			Sum(RegConsentSkinNoJurisdiction) AS RegConsentSkinNoJurisdiction,
			Sum(RegConsentValvesNoJurisdiction) AS RegConsentValvesNoJurisdiction,
			Sum(RegConsentEyesNoJurisdiction) AS RegConsentEyesNoJurisdiction,

			Sum(RegConsentOrganDidNotDie) AS RegConsentOrganDidNotDie, 
			Sum(RegConsentBoneDidNotDie) AS RegConsentBoneDidNotDie,
			Sum(RegConsentTissueDidNotDie) AS RegConsentTissueDidNotDie,
			Sum(RegConsentSkinDidNotDie) AS RegConsentSkinDidNotDie,
			Sum(RegConsentValvesDidNotDie) AS RegConsentValvesDidNotDie,
			Sum(RegConsentEyesDidNotDie) AS RegConsentEyesDidNotDie


    	FROM 		Referral_ConsentReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	
	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate


IF	@vOrgID > 0

    	SELECT 	--YearID, 
			--Referral_ConsentReasonCount.MonthID AS MonthID, 
			--CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName) AS MonthYear,
			--OrganizationName, 
			Sum(ConsentOrgan) AS ConsentOrgan, 
			Sum(ConsentBone) AS ConsentBone,
			Sum(ConsentTissue) AS ConsentTissue,
			Sum(ConsentSkin) AS ConsentSkin,
			Sum(ConsentValves) AS ConsentValves,
			Sum(ConsentEyes) AS ConsentEyes,

			Sum(ConsentOrganNotConsented) AS ConsentOrganNotConsented, 
			Sum(ConsentBoneNotConsented) AS ConsentBoneNotConsented,
			Sum(ConsentTissueNotConsented) AS ConsentTissueNotConsented,
			Sum(ConsentSkinNotConsented) AS ConsentSkinNotConsented,
			Sum(ConsentValvesNotConsented) AS ConsentValvesNotConsented,
			Sum(ConsentEyesNotConsented) AS ConsentEyesNotConsented,

			Sum(ConsentOrganEthnic) AS ConsentOrganEthnic, 
			Sum(ConsentBoneEthnic) AS ConsentBoneEthnic,
			Sum(ConsentTissueEthnic) AS ConsentTissueEthnic,
			Sum(ConsentSkinEthnic) AS ConsentSkinEthnic,
			Sum(ConsentValvesEthnic) AS ConsentValvesEthnic,
			Sum(ConsentEyesEthnic) AS ConsentEyesEthnic,

			Sum(ConsentOrganReligious) AS ConsentOrganReligious, 
			Sum(ConsentBoneReligious) AS ConsentBoneReligious,
			Sum(ConsentTissueReligious) AS ConsentTissueReligious,
			Sum(ConsentSkinReligious) AS ConsentSkinReligious,
			Sum(ConsentValvesReligious) AS ConsentValvesReligious,
			Sum(ConsentEyesReligious) AS ConsentEyesReligious,

			Sum(ConsentOrganEmotional) AS ConsentOrganEmotional, 
			Sum(ConsentBoneEmotional) AS ConsentBoneEmotional,
			Sum(ConsentTissueEmotional) AS ConsentTissueEmotional,
			Sum(ConsentSkinEmotional) AS ConsentSkinEmotional,
			Sum(ConsentValvesEmotional) AS ConsentValvesEmotional,
			Sum(ConsentEyesEmotional) AS ConsentEyesEmotional,

			Sum(ConsentOrganUnknown) AS ConsentOrganUnknown, 
			Sum(ConsentBoneUnknown) AS ConsentBoneUnknown,
			Sum(ConsentTissueUnknown) AS ConsentTissueUnknown,
			Sum(ConsentSkinUnknown) AS ConsentSkinUnknown,
			Sum(ConsentValvesUnknown) AS ConsentValvesUnknown,
			Sum(ConsentEyesUnknown) AS ConsentEyesUnknown,

			Sum(ConsentOrganPrevDiscussion) AS ConsentOrganPrevDiscussion, 
			Sum(ConsentBonePrevDiscussion) AS ConsentBonePrevDiscussion,
			Sum(ConsentTissuePrevDiscussion) AS ConsentTissuePrevDiscussion,
			Sum(ConsentSkinPrevDiscussion) AS ConsentSkinPrevDiscussion,
			Sum(ConsentValvesPrevDiscussion) AS ConsentValvesPrevDiscussion,
			Sum(ConsentEyesPrevDiscussion) AS ConsentEyesPrevDiscussion,

			--drh 10/31/01
			Sum(RegConsentOrgan) AS RegConsentOrgan, 
			Sum(RegConsentBone) AS RegConsentBone,
			Sum(RegConsentTissue) AS RegConsentTissue,
			Sum(RegConsentSkin) AS RegConsentSkin,
			Sum(RegConsentValves) AS RegConsentValves,
			Sum(RegConsentEyes) AS RegConsentEyes,

			Sum(RegConsentOrganDMVReg) AS RegConsentOrganDMVReg, 
			Sum(RegConsentBoneDMVReg) AS RegConsentBoneDMVReg,
			Sum(RegConsentTissueDMVReg) AS RegConsentTissueDMVReg,
			Sum(RegConsentSkinDMVReg) AS RegConsentSkinDMVReg,
			Sum(RegConsentValvesDMVReg) AS RegConsentValvesDMVReg,
			Sum(RegConsentEyesDMVReg) AS RegConsentEyesDMVReg,

			Sum(RegConsentOrganDRReg) AS RegConsentOrganDRReg, 
			Sum(RegConsentBoneDRReg) AS RegConsentBoneDRReg,
			Sum(RegConsentTissueDRReg) AS RegConsentTissueDRReg,
			Sum(RegConsentSkinDRReg) AS RegConsentSkinDRReg,
			Sum(RegConsentValvesDRReg) AS RegConsentValvesDRReg,
			Sum(RegConsentEyesDRReg) AS RegConsentEyesDRReg,

			Sum(RegConsentOrganNotConsented) AS RegConsentOrganNotConsented, 
			Sum(RegConsentBoneNotConsented) AS RegConsentBoneNotConsented,
			Sum(RegConsentTissueNotConsented) AS RegConsentTissueNotConsented,
			Sum(RegConsentSkinNotConsented) AS RegConsentSkinNotConsented,
			Sum(RegConsentValvesNotConsented) AS RegConsentValvesNotConsented,
			Sum(RegConsentEyesNotConsented) AS RegConsentEyesNotConsented,

			Sum(RegConsentOrganEthnic) AS RegConsentOrganEthnic, 
			Sum(RegConsentBoneEthnic) AS RegConsentBoneEthnic,
			Sum(RegConsentTissueEthnic) AS RegConsentTissueEthnic,
			Sum(RegConsentSkinEthnic) AS RegConsentSkinEthnic,
			Sum(RegConsentValvesEthnic) AS RegConsentValvesEthnic,
			Sum(RegConsentEyesEthnic) AS RegConsentEyesEthnic,

			Sum(RegConsentOrganReligious) AS RegConsentOrganReligious, 
			Sum(RegConsentBoneReligious) AS RegConsentBoneReligious,
			Sum(RegConsentTissueReligious) AS RegConsentTissueReligious,
			Sum(RegConsentSkinReligious) AS RegConsentSkinReligious,
			Sum(RegConsentValvesReligious) AS RegConsentValvesReligious,
			Sum(RegConsentEyesReligious) AS RegConsentEyesReligious,

			Sum(RegConsentOrganEmotional) AS RegConsentOrganEmotional, 
			Sum(RegConsentBoneEmotional) AS RegConsentBoneEmotional,
			Sum(RegConsentTissueEmotional) AS RegConsentTissueEmotional,
			Sum(RegConsentSkinEmotional) AS RegConsentSkinEmotional,
			Sum(RegConsentValvesEmotional) AS RegConsentValvesEmotional,
			Sum(RegConsentEyesEmotional) AS RegConsentEyesEmotional,

			Sum(RegConsentOrganUnknown) AS RegConsentOrganUnknown, 
			Sum(RegConsentBoneUnknown) AS RegConsentBoneUnknown,
			Sum(RegConsentTissueUnknown) AS RegConsentTissueUnknown,
			Sum(RegConsentSkinUnknown) AS RegConsentSkinUnknown,
			Sum(RegConsentValvesUnknown) AS RegConsentValvesUnknown,
			Sum(RegConsentEyesUnknown) AS RegConsentEyesUnknown,

			Sum(RegConsentOrganPrevDiscussion) AS RegConsentOrganPrevDiscussion, 
			Sum(RegConsentBonePrevDiscussion) AS RegConsentBonePrevDiscussion,
			Sum(RegConsentTissuePrevDiscussion) AS RegConsentTissuePrevDiscussion,
			Sum(RegConsentSkinPrevDiscussion) AS RegConsentSkinPrevDiscussion,
			Sum(RegConsentValvesPrevDiscussion) AS RegConsentValvesPrevDiscussion,
			Sum(RegConsentEyesPrevDiscussion) AS RegConsentEyesPrevDiscussion,

			--ccarroll 11/20/2006 added StatTrac 8.2 options
			Sum(ConsentOrganNotPronounced) AS ConsentOrganNotPronounced, 
			Sum(ConsentBoneNotPronounced) AS ConsentBoneNotPronounced,
			Sum(ConsentTissueNotPronounced) AS ConsentTissueNotPronounced,
			Sum(ConsentSkinNotPronounced) AS ConsentSkinNotPronounced,
			Sum(ConsentValvesNotPronounced) AS ConsentValvesNotPronounced,
			Sum(ConsentEyesNotPronounced) AS ConsentEyesNotPronounced,

			Sum(ConsentOrganNoJurisdiction) AS ConsentOrganNoJurisdiction, 
			Sum(ConsentBoneNoJurisdiction) AS ConsentBoneNoJurisdiction,
			Sum(ConsentTissueNoJurisdiction) AS ConsentTissueNoJurisdiction,
			Sum(ConsentSkinNoJurisdiction) AS ConsentSkinNoJurisdiction,
			Sum(ConsentValvesNoJurisdiction) AS ConsentValvesNoJurisdiction,
			Sum(ConsentEyesNoJurisdiction) AS ConsentEyesNoJurisdiction,

			Sum(ConsentOrganDidNotDie) AS ConsentOrganDidNotDie, 
			Sum(ConsentBoneDidNotDie) AS ConsentBoneDidNotDie,
			Sum(ConsentTissueDidNotDie) AS ConsentTissueDidNotDie,
			Sum(ConsentSkinDidNotDie) AS ConsentSkinDidNotDie,
			Sum(ConsentValvesDidNotDie) AS ConsentValvesDidNotDie,
			Sum(ConsentEyesDidNotDie) AS ConsentEyesDidNotDie,

			Sum(RegConsentOrganNotPronounced) AS RegConsentOrganNotPronounced, 
			Sum(RegConsentBoneNotPronounced) AS RegConsentBoneNotPronounced,
			Sum(RegConsentTissueNotPronounced) AS RegConsentTissueNotPronounced,
			Sum(RegConsentSkinNotPronounced) AS RegConsentSkinNotPronounced,
			Sum(RegConsentValvesNotPronounced) AS RegConsentValvesNotPronounced,
			Sum(RegConsentEyesNotPronounced) AS RegConsentEyesNotPronounced,

			Sum(RegConsentOrganNoJurisdiction) AS RegConsentOrganNoJurisdiction, 
			Sum(RegConsentBoneNoJurisdiction) AS RegConsentBoneNoJurisdiction,
			Sum(RegConsentTissueNoJurisdiction) AS RegConsentTissueNoJurisdiction,
			Sum(RegConsentSkinNoJurisdiction) AS RegConsentSkinNoJurisdiction,
			Sum(RegConsentValvesNoJurisdiction) AS RegConsentValvesNoJurisdiction,
			Sum(RegConsentEyesNoJurisdiction) AS RegConsentEyesNoJurisdiction,

			Sum(RegConsentOrganDidNotDie) AS RegConsentOrganDidNotDie, 
			Sum(RegConsentBoneDidNotDie) AS RegConsentBoneDidNotDie,
			Sum(RegConsentTissueDidNotDie) AS RegConsentTissueDidNotDie,
			Sum(RegConsentSkinDidNotDie) AS RegConsentSkinDidNotDie,
			Sum(RegConsentValvesDidNotDie) AS RegConsentValvesDidNotDie,
			Sum(RegConsentEyesDidNotDie) AS RegConsentEyesDidNotDie


    	FROM 		Referral_ConsentReasonCount
	JOIN 		_ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.SourceCode.SourceCodeID = Referral_ConsentReasonCount.SourceCodeID
	JOIN		_ReferralProdReport.dbo.WebReportGroupSourceCode ON _ReferralProdReport.dbo.WebReportGroupSourceCode.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID
    	JOIN 		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Organization.OrganizationID = Referral_ConsentReasonCount.OrganizationID
	JOIN		_ReferralProdReport.dbo.WebReportGroupOrg ON _ReferralProdReport.dbo.WebReportGroupOrg.OrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID
	JOIN		Month ON Month.MonthID = Referral_ConsentReasonCount.MonthID

	WHERE 		_ReferralProdReport.dbo.WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
	AND		_ReferralProdReport.dbo.WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  >= @vStartDate
	AND		CAST(  CAST(Month.MonthID AS varchar(2)) + '/1/' + CAST(YearID AS varchar(4))  AS smalldatetime)  <= @vEndDate
	AND		Referral_ConsentReasonCount.OrganizationID = @vOrgID

/*
	GROUP BY	YearID, Referral_ConsentReasonCount.MonthID, CAST(YearID AS varchar(4)) + ' ' + RTrim(MonthName), 
			Referral_ConsentReasonCount.OrganizationID, OrganizationName 
    	ORDER BY 	YearID, Referral_ConsentReasonCountReferral_ConsentReasonCount.MonthID, OrganizationName
*/






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

