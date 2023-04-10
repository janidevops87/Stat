IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_sub_ReferralDisposition_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_sub_ReferralDisposition_Select'
		DROP  Procedure  sps_rpt_sub_ReferralDisposition_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_sub_ReferralDisposition_Select'
GO
CREATE Procedure sps_rpt_sub_ReferralDisposition_Select
	@CallID						int = Null,
	@UserOrgID					int = Null
AS
/******************************************************************************
**		File: sps_rpt_sub_ReferralDisposition_Select.sql
**		Name: sps_rpt_sub_ReferralDisposition_Select
**
**		Desc: This is sub-report displays disposition from a referral
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@CallID		int
**		@UserOrgID		int
**
**		Auth: christopher carroll
**		Date: 09/06/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      09/06/2007		ccarroll				Initial release
**		09/30/2008		ccarroll				Created select sproc for Archive and Production dbs
*******************************************************************************/


SELECT  DISTINCT

	/* Disposition Notes:
		1. Custom Mapping - USE exec sps_DynamicDonorCategoryByOrg2 to find custom mapping lables for client.

		2. ServiceLevel - If client's service level is turned off, default values are set by the 
		function: dbo.fn_ServiceLevelDefault (Service Level Default). The default text may be modified in the 
		future by changing the return value in the function. All reports using this function will 
		receive the new default value. Passing the function either a blank ('') or NULL value will cause
		the default value to be returned. If the UserOrg = 194 all data will be displaied
	*/

		/* Organ */
		AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		
		/* Bone*/
		AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,

		/* Tissue*/
		AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 

		/* Skin*/
		AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 

		/* Valves*/
		AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 

		/* Eyes*/
		AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 

		/* Other*/
		AppropRsch.AppropriateReportName AS AppropriateOther,
		ApproaRsch.ApproachReportName AS ApproachOther,
		ConsentRsch.ConsentReportName AS ConsentOther,
		RecoveryRsch.ConversionReportName AS RecoveryOther

FROM Referral
	LEFT JOIN ApproachType ON ApproachType.ApproachTypeID = Referral.ReferralApproachTypeID 
	LEFT JOIN Appropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
	LEFT JOIN Appropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
	LEFT JOIN Appropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
	LEFT JOIN Appropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
	LEFT JOIN Appropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
	LEFT JOIN Appropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
	LEFT JOIN Appropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
	LEFT JOIN Approach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
	LEFT JOIN Approach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
	LEFT JOIN Approach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
	LEFT JOIN Approach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
	LEFT JOIN Approach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
	LEFT JOIN Approach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
	LEFT JOIN Approach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
	LEFT JOIN Consent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
	LEFT JOIN Consent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
	LEFT JOIN Consent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
	LEFT JOIN Consent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
	LEFT JOIN Consent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
	LEFT JOIN Consent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
	LEFT JOIN Consent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
	LEFT JOIN Conversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN Conversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN Conversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN Conversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN Conversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN Conversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN Conversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 

	LEFT JOIN CallCriteria CC ON CC.CallID = Referral.CallID 
	LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 

WHERE ISNULL(@CallID, Referral.CallID) = Referral.CallID


GROUP BY

	AppropOrgan.AppropriateReportName,
	AppropTissue.AppropriateReportName,
	AppropBone.AppropriateReportName,
	AppropSkin.AppropriateReportName,
	AppropValve.AppropriateReportName,
	AppropEyes.AppropriateReportName,
	AppropRsch.AppropriateReportName,

	ApproaOrgan.ApproachReportName,
	ApproaBone.ApproachReportName,
	ApproaTissue.ApproachReportName,
	ApproaSkin.ApproachReportName,
	ApproaValve.ApproachReportName,
	ApproaRsch.ApproachReportName,

	ConsentOrgan.ConsentReportName,
	ConsentBone.ConsentReportName,
	ConsentTissue.ConsentReportName,
	ConsentSkin.ConsentReportName,
	ConsentValve.ConsentReportName,
	ConsentRsch.ConsentReportName,

	RecoveryOrgan.ConversionReportName,
	RecoveryBone.ConversionReportName,
	RecoveryTissue.ConversionReportName,
	RecoverySkin.ConversionReportName,
	RecoveryValve.ConversionReportName,
	RecoveryRsch.ConversionReportName,

	ServiceLevel.ServiceLevelApproachOrgan,
	ServiceLevel.ServiceLevelApproachBone,
	ServiceLevel.ServiceLevelApproachTissue,
	ServiceLevel.ServiceLevelApproachSkin,
	ServiceLevel.ServiceLevelApproachValves,
	ServiceLevel.ServiceLevelApproachEyes,

	ServiceLevel.ServiceLevelConsentOrgan,
	ServiceLevel.ServiceLevelConsentBone,
	ServiceLevel.ServiceLevelConsentTissue,
	ServiceLevel.ServiceLevelConsentSkin,
	ServiceLevel.ServiceLevelConsentValves,
	ServiceLevel.ServiceLevelConsentEyes,

	ServiceLevel.ServiceLevelRecoveryOrgan,
	ServiceLevel.ServiceLevelRecoveryBone,
	ServiceLevel.ServiceLevelRecoveryTissue,
	ServiceLevel.ServiceLevelRecoverySkin,
	ServiceLevel.ServiceLevelRecoveryValves,
	ServiceLevel.ServiceLevelRecoveryEyes




GO

