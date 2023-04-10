IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferralDetail_Single')
	BEGIN
		PRINT 'Dropping Procedure GetReferralDetail_Single'
		DROP  Procedure  GetReferralDetail_Single
	END

GO	

PRINT 'Creating Procedure GetReferralDetail_Single'
GO  
CREATE PROCEDURE GetReferralDetail_Single
	@CallID						int = Null,
	@UserOrgID					int = Null,
	@ReportGroupID              int = null,
	@TimeZone AS varchar(2)
	

AS
/******************************************************************************
**		File: GetReferralDetail_Single.sql
**		Name: GetReferralDetail_Single
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: Referral Search.aspx
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: jth
**		Date: 07/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**     10/2008      jth             added timezone and report group parm, added access columns
**     10/2008      jth             criteria for initial consent changed  
**	   11/2008      jth             added servicelevel fields 	 
**     12/2008      jth             don't do inner select for servicelevels 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT  DISTINCT 
	call.CallID, 
	(select accessorgans from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessOrgans,
	(select AccessBone from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessBone,
	(select AccessTissue from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessTissue,
	(select  AccessSkin from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID)  AccessSkin,
	(select AccessValves from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessValves,
	(select AccessEyes from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessEyes,
	(select AccessResearch from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessResearch,
	
	(select accessorgansupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessOrgansupdate,
	(select AccessBoneupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessBoneupdate,
	(select AccessTissueupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessTissueupdate,
	(select  AccessSkinupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID)  AccessSkinupdate,
	(select AccessValvesupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessValvesupdate,
	(select AccessEyesupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessEyesupdate,
	(select AccessResearchupdate from WebReportGroupSourceCode where SourceCodeID =  Call.SourceCodeID   and WebReportGroupID = @ReportGroupID) AccessResearchupdate,
	ServiceLevelApproachOrgan,
	ServiceLevelApproachBone,
	ServiceLevelApproachTissue,
	ServiceLevelApproachSkin,
	ServiceLevelApproachValves,
	ServiceLevelApproachEyes,
	ServiceLevelApproachRsch,
	ServiceLevelConsentOrgan,
	ServiceLevelConsentBone,
	ServiceLevelConsentTissue,
	ServiceLevelConsentSkin,
	ServiceLevelConsentValves,
	ServiceLevelConsentEyes,
	ServiceLevelConsentRsch,
	ServiceLevelRecoveryOrgan,
	ServiceLevelRecoveryBone,
	ServiceLevelRecoveryTissue,
	ServiceLevelRecoverySkin,
	ServiceLevelRecoveryValves,
	ServiceLevelRecoveryEyes,
	ServiceLevelRecoveryRsch,
	call.CallNumber,
	DATEADD(hh, dbo.fn_TimeZoneDifference(	@TimeZone, Call.CallDateTime), Call.CallDateTime) as
	CallDateTime, 
	
	/* Caller Information */
	Organization.OrganizationName AS 'ReferralFacility',
	Organization.OrganizationID,
	
	/* Patient Information */
	CASE WHEN ServiceLevel.ServiceLevelFirstName = -1 THEN IsNull(Referral.ReferralDonorFirstName, '')  ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralDonorFirstName', 
	ISNULL(Referral.ReferralDonorNameMI,'') AS 'ReferralDonorNameMI',
	CASE WHEN ServiceLevel.ServiceLevelLastName = -1 THEN IsNull(Referral.ReferralDonorLastName, '') ELSE dbo.fn_ServiceLevelDefault(NULL) END AS 'ReferralDonorLastName', 
	
	/* Organ @UserOrgId = 194 OR */
		--AppropOrgan.AppropriateReportName AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateOrgan = -1 THEN AppropOrgan.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachOrgan = -1 THEN ApproaOrgan.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentOrgan = -1 THEN ConsentOrgan.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOrgan, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryOrgan = -1 THEN RecoveryOrgan.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOrgan,
		ReferralOrganApproachID,
		ReferralOrganConsentID,
		ReferralOrganConversionID,
		/* Bone*/
		--AppropBone.AppropriateReportName AS AppropriateBone,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateBone = -1 THEN AppropBone.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachBone = -1 THEN ApproaBone.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentBone = -1 THEN ConsentBone.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentBone, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryBone = -1 THEN RecoveryBone.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryBone,
		ReferralBoneApproachID,
		ReferralBoneConsentID,
		ReferralBoneConversionID,
		/* Tissue*/
		--AppropTissue.AppropriateReportName AS AppropriateTissue,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateTissue = -1 THEN AppropTissue.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachTissue = -1 THEN ApproaTissue.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentTissue = -1 THEN ConsentTissue.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentTissue, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryTissue = -1 THEN RecoveryTissue.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryTissue, 
		ReferralTissueApproachID,
		ReferralTissueConsentID,
		ReferralTissueConversionID,
		/* Skin*/
		--AppropSkin.AppropriateReportName AS AppropriateSkin,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateSkin = -1 THEN AppropSkin.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachSkin = -1 THEN ApproaSkin.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentSkin = -1 THEN ConsentSkin.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentSkin, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoverySkin = -1 THEN RecoverySkin.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoverySkin, 
		ReferralValvesApproachID,
		ReferralValvesConsentID,
		ReferralValvesConversionID,
		/* Valves*/
		--AppropValve.AppropriateReportName AS AppropriateValve,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateValves = -1 THEN AppropValve.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachValves = -1 THEN ApproaValve.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentValves = -1 THEN ConsentValve.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentValve, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryValves = -1 THEN RecoveryValve.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryValve, 
		ReferralValvesApproachID,
		ReferralValvesConsentID,
		ReferralValvesConversionID,
		/* Eyes*/
		--AppropEyes.AppropriateReportName AS AppropriateEyes,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateEyes = -1 THEN AppropEyes.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachEyes = -1 THEN ApproaEyes.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentEyes = -1 THEN ConsentEyes.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentEyes, 
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryEyes = -1 THEN RecoveryEyes.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryEyes, 
		ReferralEyesTransApproachID,
		ReferralEyesTransConsentID, 
		ReferralEyesTransConversionID,
		/* Other*/
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelAppropriateRsch = -1 THEN AppropRsch.AppropriateReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS AppropriateOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelApproachRsch = -1 THEN ApproaRsch.ApproachReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ApproachOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelConsentRsch = -1 THEN ConsentRsch.ConsentReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS ConsentOther,
		CASE WHEN @UserOrgId = 194 OR ServiceLevel.ServiceLevelRecoveryRsch = -1 THEN RecoveryRsch.ConversionReportName ELSE dbo.fn_ServiceLevelDefault(NULL) END AS RecoveryOther,
		ReferralEyesRschApproachID,
		ReferralEyesRschConsentID, 
		ReferralEyesRschConversionID,
		
	'Appropriate' as AppropriateText,
	'Approach' as ApproachText,
	'Consent' as ConsentText,
	'Recovery' as RecoveryText,
	/* Approach Imformation */
--	ApproachType.ApproachTypeName AS 'FinalApproachType',
	/* Final Approach - Display values only if Secondary Servicelevel is turned ON */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		 THEN InformedApproach.FSApproachTypeName
		 ELSE '' 
	END AS 'FinalApproachType',
	
	/* Initial Approach -  */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 
		 THEN isnull(HospitalApproach.ApproachTypeName,ApproachType.ApproachTypeName) -- pull from Secondary
		 ELSE ApproachType.ApproachTypeName     -- pull from Triage
	END AS 'InitialApproachType',approachtype.ApproachTypeID,
	
	--ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'FinalApproacher',
	
	--CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1
		-- THEN ISNULL(InformedApproachPerson.PersonFirst, '') + ' ' + ISNULL(InformedApproachPerson.PersonLast, '')
		-- ELSE ''
	--END AS 'FinalApproacher',
	
	/* Initial Approacher - */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 
		 THEN ISNULL(HospitalApproachPerson.PersonFirst, ApproachPerson.PersonFirst) + ' ' + ISNULL(HospitalApproachPerson.PersonLast, ApproachPerson.PersonLast)
		 ELSE ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast
	END AS 'InitialApproacher',Person.PersonID,

	/* Initial Approach Outcome - */
	CASE WHEN ServicelevelSecondary.ServiceLevelSecondaryON = -1 AND FSCase.CallID IS NOT Null and SecondaryApproach.SecondaryHospitalOutcome > 0
		 THEN (CASE SecondaryApproach.SecondaryHospitalOutcome
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
		 ELSE
			  (CASE Referral.ReferralGeneralConsent
					WHEN 1 THEN 'Yes-Written'
					WHEN 2 THEN 'Yes-Verbal'
					WHEN 3 THEN 'No'
				END)
	END AS 'InitialOutcome'
	

FROM 
Call
JOIN Referral ON Referral.CallID = Call.CallID
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
LEFT JOIN LogEvent ON Call.CallID = LogEvent.CallID
LEFT JOIN NOK ON NOK.NOKID = Referral.ReferralNOKID 
LEFT JOIN State st ON st.StateID = NOK.NOKStateID 
LEFT JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN Person StatPerson ON StatPerson.PersonID = StatEmployee.PersonID 
LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID 
LEFT JOIN Person CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
LEFT JOIN Person ApproachPerson ON ApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
/* Hospital Approach */
LEFT JOIN SecondaryApproach ON Call.CallID = SecondaryApproach.CallID 
LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
LEFT JOIN Person HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy 
/* Informed Approach */
LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy

LEFT JOIN ApproachType HospitalApproachType ON HospitalApproachType.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach 
LEFT JOIN Person Attending ON Attending.PersonID = Referral.ReferralAttendingMD 
LEFT JOIN Person Pronouncing ON Pronouncing.PersonID = Referral.ReferralPronouncingMD 
LEFT JOIN PersonType ON PersonType.PersonTypeID = Person.PersonTypeID 
LEFT JOIN PersonType CallPersonType ON CallPersonType.PersonTypeID = CallerPerson.PersonTypeID 
LEFT JOIN SubLocation ON SubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
LEFT JOIN Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
LEFT JOIN ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
LEFT JOIN ReferralType AS CurrentRefType ON CurrentRefType.ReferralTypeID = Referral.CurrentReferralTypeID 
LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
LEFT JOIN CauseOfDeath ON CauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID 
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


LEFT JOIN RegistryStatus ON RegistryStatus.CallId = Call.CallId 
LEFT JOIN RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID 
LEFT JOIN CallCriteria CC ON CC.CallID = Call.CallID 
LEFT JOIN ServiceLevel ON ServiceLevel.ServiceLevelID = CC.ServiceLevelID 
LEFT JOIN ServiceLevelSecondary ON ServiceLevelSecondary.ServiceLevelID = CC.ServiceLevelID
LEFT JOIN FSCase ON Call.CallID =FSCase.CallID
LEFT JOIN ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
LEFT JOIN ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID

WHERE 
Call.CallID = @CallID
and
IsNull(WebReportGroupOrg.WebReportGroupID, 0) = IsNull(ISNull(@ReportGroupID, WebReportGroupOrg.WebReportGroupID), 0)
GO
