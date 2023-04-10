IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Referral')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Referral';
		DROP  PROCEDURE  sps_rpt_AuditTrail_Referral;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Referral';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_Referral
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Referral.sql
**		Name: sps_rpt_AuditTrail_Referral
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 07/19/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		08/06/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality
**		11/04/2008		ccarroll				Added DisplayMT for ChangeDT
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		09/2011 		jth						Added LSA date/time
**      10/03/3011		ccarroll				Corrected issue with LSA
**		02/01/2018		mberenson				Added ReferralDCDPotential
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
**		07/22/2021		James Gerberich			Fixed ReferralDonorNameMI when it is empty.
**													TFS 74581
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #ReferralInfo;


IF @ChangeStartDateTime = @ChangeEndDateTime
	BEGIN
		SELECT
			@ChangeStartDateTime = NULL,
			@ChangeEndDateTime = NULL;
	END


SELECT DISTINCT
/* Referral * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, Referral.LastModified, @DisplayMT) AS smalldatetime)AS 'ChangeDT',
	ReferralChangePerson.PersonFirst + ' ' + ReferralChangePerson.PersonLast AS 'ChangeUser',
	ReferralChangeType.AuditLogTypeName AS 'ChangeType',
/* Contact Information */
	'(' + ReferralCallerPhone.PhoneAreaCode + ') ' + ReferralCallerPhone.PhonePrefix + '-' + ReferralCallerPhone.PhoneNumber AS 'ReferralCallerPhone',
	ReferralCallerOrganization.OrganizationName AS 'ReferralFacility',
	Referral.ReferralCallerExtension AS 'ReferralCallerExtension',
	ReferralCallerSubLocation.SubLocationName AS 'HospitalUnit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	ReferralCallerPerson.PersonFirst + ' ' + ReferralCallerPerson.PersonLast AS 'ReferralPerson',
	ReferralCallerPersonType.PersonTypeName AS 'ReferralPersonTitle',
/* Patient Status */
	CASE Referral.ReferralDonorHeartBeat
		WHEN 0 THEN 'No'
		WHEN 1 THEN 'Yes'
	END AS 'ReferralDonorHeartBeat',
	Referral.ReferralDonorOnVentilator AS 'Vent',
	Referral.ReferralExtubated AS 'Extubationd d/t',
	NULLIF(CASE WHEN Referral.ReferralDonorDeathDate = '01/01/1900' THEN 'ILB' ELSE TRIM(ISNULL(CONVERT(varchar, Referral.ReferralDonorDeathDate, 101), '') + ISNULL(' ' + Referral.ReferralDonorDeathTime, '')) END, '') AS 'DonorCardiacDeathDT',
	NULLIF(CASE WHEN Referral.ReferralDonorBrainDeathDate = '01/01/1900' THEN 'ILB' ELSE TRIM(ISNULL(CONVERT(varchar, Referral.ReferralDonorBrainDeathDate, 101), '') + ISNULL( ' ' + Referral.ReferralDonorBrainDeathTime, '')) END, '') AS 'DonorBrainDeathDT',
	NULLIF(CASE WHEN Referral.ReferralDonorAdmitDate = '01/01/1900' THEN 'ILB' ELSE TRIM(ISNULL(CONVERT(varchar, Referral.ReferralDonorAdmitDate,101), '') + ISNULL(' ' + Referral.ReferralDonorAdmitTime, '')) END, '') AS 'DonorAdmitDT',
	CASE
		WHEN Referral.ReferralDOA = 0 THEN 'No'
		WHEN Referral.ReferralDOA = -1 THEN 'Yes'
	END AS 'DonorDOA',
	NULLIF(CASE WHEN Referral.ReferralDonorLSADate = '01/01/1900' THEN 'ILB' ELSE TRIM(ISNULL(CONVERT(varchar, Referral.ReferralDonorLSADate,101), '') + ISNULL(' ' + Referral.ReferralDonorLSATime, '')) END, '') AS 'DonorLSADeathDT',
/* Patient Iformation */
	Referral.ReferralDonorLastName,
	Referral.ReferralDonorFirstName,
	REPLACE(Referral.ReferralDonorNameMI, '-2', 'ILB') AS 'ReferralDonorNameMI',
	CASE WHEN Referral.ReferralDOB_ILB = -1 THEN 'Unknown' ELSE Referral.ReferralDOB END AS 'ReferralDonorDOB',
	NULLIF(ISNULL(Referral.ReferralDonorAge, '') + ISNULL(UPPER(SUBSTRING(Referral.ReferralDonorAgeUnit, 1, 1)),''), '') AS 'ReferralDonorAge',
	CASE WHEN Referral.ReferralDonorRaceID = -2 THEN 'ILB' ELSE ReferralDonorRace.RaceName END AS 'ReferralDonorRace',
	Referral.ReferralDonorGender AS 'ReferralDonorGender',
	Referral.ReferralDonorWeight AS 'ReferralDonorWeight',
	Referral.ReferralDonorRecNumber AS 'MedicalRecordNumber',
	Referral.ReferralDonorSSN AS 'ReferralDonorSSN',
/* Medical History and Cause of Death */
	Referral.ReferralNotesCase AS 'ReferralMedicalHistory',
	Referral.ReferralDonorSpecificCOD,
	CASE WHEN Referral.ReferralDonorCauseOfDeathID = -2 THEN 'ILB' ELSE ReferralCauseOfDeath.CauseOfDeathName END AS 'ReferralCauseOfDeath',
/* Approach Information */
	CASE WHEN Referral.ReferralApproachTypeID = -2 THEN 'ILB' ELSE ReferralApproachType.ApproachTypeName END AS 'ReferralMethodOfApproach',
	ReferralApproachPerson.PersonFirst + ' ' + ReferralApproachPerson.PersonLast AS 'ReferralApproachPerson',
	CASE Referral.ReferralGeneralConsent
		WHEN 1 THEN 'Yes-Written'
		WHEN 2 THEN 'Yes-Verbal'
		WHEN 3 THEN 'No'
		WHEN -2 THEN 'ILB'
	END AS 'ReferralGeneralConsent',
	CASE WHEN Referral.DonorRegistryType = -2 THEN 'ILB' ELSE ReferralRegistryStatusType.RegistryType END AS RegistryStatus,
/* Physician Information */
	CASE WHEN Referral.ReferralAttendingMD = -2 THEN 'ILB' ELSE ReferralAttending.PersonFirst + ' ' + ReferralAttending.PersonLast END AS 'Attending',
	Referral.ReferralAttendingMDPhone,
	CASE WHEN Referral.ReferralPronouncingMD = -2 THEN 'ILB' ELSE ReferralPronouncing.PersonFirst + ' ' + ReferralPronouncing.PersonLast END AS 'Pronouncing',
	Referral.ReferralPronouncingMDPhone,
/* NOK - use sps_rpt_AuditTrail_NOK */
	Referral.ReferralNOKAddress,
/* Coroner Information */
	CASE Referral.ReferralCoronersCase WHEN -1 THEN 'Yes' WHEN 0 THEN 'No' END AS 'CoronersCase',
	CASE WHEN CoronerOrgState.StateID = -2 THEN 'ILB' ELSE CoronerOrgState.StateAbbrv END AS 'CoronersState',		
	Referral.ReferralCoronerOrganization,
	Referral.ReferralCoronerName,
	Referral.ReferralCoronerPhone,
	Referral.ReferralCoronerNote,
/* Appropriate */
	CASE WHEN Referral.ReferralOrganAppropriateID = -2 THEN 'ILB' ELSE AppropOrgan.AppropriateName END AS 'AppropriateOrgan',
	CASE WHEN Referral.ReferralBoneAppropriateID = -2 THEN 'ILB' ELSE AppropBone.AppropriateName END AS 'AppropriateBone',
	CASE WHEN Referral.ReferralTissueAppropriateID = -2 THEN 'ILB' ELSE AppropTissue.AppropriateName END AS 'AppropriateTissue',
	CASE WHEN Referral.ReferralSkinAppropriateID = -2 THEN 'ILB' ELSE AppropSkin.AppropriateName END AS 'AppropriateSkin',
	CASE WHEN Referral.ReferralValvesAppropriateID = -2 THEN 'ILB' ELSE AppropValve.AppropriateName END AS 'AppropriateValve',
	CASE WHEN Referral.ReferralEyesTransAppropriateID = -2 THEN 'ILB' ELSE AppropEyes.AppropriateName END AS 'AppropriateEyes',
	CASE WHEN Referral.ReferralEyesRschAppropriateID = -2 THEN 'ILB' ELSE AppropRsch.AppropriateName END AS 'AppropriateRsch',
/* Approach */
	CASE WHEN Referral.ReferralOrganApproachID = -2 THEN 'ILB ' ELSE ApproaOrgan.ApproachName END AS 'ApproachOrgan', 
	CASE WHEN Referral.ReferralBoneApproachID = -2 THEN 'ILB ' ELSE ApproaBone.ApproachName END AS 'ApproachBone', 
	CASE WHEN Referral.ReferralTissueApproachID = -2 THEN 'ILB ' ELSE ApproaTissue.ApproachName END AS 'ApproachTissue', 
	CASE WHEN Referral.ReferralSkinApproachID = -2 THEN 'ILB ' ELSE ApproaSkin.ApproachName END AS 'ApproachSkin', 
	CASE WHEN Referral.ReferralValvesApproachID = -2 THEN 'ILB ' ELSE ApproaValve.ApproachName END AS 'ApproachValve', 
	CASE WHEN Referral.ReferralEyesTransApproachID = -2 THEN 'ILB ' ELSE ApproaEyes.ApproachName END AS 'ApproachEyes', 
	CASE WHEN Referral.ReferralEyesRschApproachID = -2 THEN 'ILB ' ELSE ApproaRsch.ApproachName END AS 'ApproachRsch', 
/* Consent */
	CASE WHEN Referral.ReferralOrganConsentID = -2 THEN 'ILB ' ELSE ConsentOrgan.ConsentName END AS 'ConsentOrgan',
	CASE WHEN Referral.ReferralBoneConsentID = -2 THEN 'ILB ' ELSE ConsentBone.ConsentName END AS 'ConsentBone',
	CASE WHEN Referral.ReferralTissueConsentID = -2 THEN 'ILB ' ELSE ConsentTissue.ConsentName END AS 'ConsentTissue',
	CASE WHEN Referral.ReferralSkinConsentID = -2 THEN 'ILB ' ELSE ConsentSkin.ConsentName END AS 'ConsentSkin',
	CASE WHEN Referral.ReferralValvesConsentID = -2 THEN 'ILB ' ELSE ConsentValve.ConsentName END AS 'ConsentValve',
	CASE WHEN Referral.ReferralEyesTransConsentID = -2 THEN 'ILB ' ELSE ConsentEyes.ConsentName END AS 'ConsentEyes',
	CASE WHEN Referral.ReferralEyesRschConsentID = -2 THEN 'ILB ' ELSE ConsentRsch.ConsentName END AS 'ConsentRsch',
/* Recovery */
	CASE WHEN Referral.ReferralOrganConversionID = -2 THEN 'ILB ' ELSE RecoveryOrgan.ConversionName END AS 'RecoveryOrgan',	
	CASE WHEN Referral.ReferralBoneConversionID = -2 THEN 'ILB ' ELSE RecoveryBone.ConversionName END AS 'RecoveryBone',	
	CASE WHEN Referral.ReferralTissueConversionID = -2 THEN 'ILB ' ELSE RecoveryTissue.ConversionName END AS 'RecoveryTissue',	
	CASE WHEN Referral.ReferralSkinConversionID = -2 THEN 'ILB ' ELSE RecoverySkin.ConversionName END AS 'RecoverySkin',	
	CASE WHEN Referral.ReferralValvesConversionID = -2 THEN 'ILB ' ELSE RecoveryValve.ConversionName END AS 'RecoveryValve',
	CASE WHEN Referral.ReferralEyesTransConversionID = -2 THEN 'ILB ' ELSE RecoveryEyes.ConversionName END AS 'RecoveryEyes',
	CASE WHEN Referral.ReferralEyesRschConversionID = -2 THEN 'ILB ' ELSE RecoveryRsch.ConversionName END AS 'RecoveryRsch',	
	CASE Referral.ReferralDCDPotential WHEN -1 THEN 'Yes' WHEN 0 THEN 'No' END AS 'ReferralDCDPotential'
INTO #ReferralInfo
FROM
	Referral 
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = Referral.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Referral Lookups */
	LEFT JOIN vwAuditTrailStatEmployee ReferralChangeEmployee ON ReferralChangeEmployee.StatEmployeeID = Referral.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson ReferralChangePerson ON ReferralChangePerson.PersonID = ReferralChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType ReferralChangeType ON ReferralChangeType.AuditLogTypeID = Referral.AuditLogTypeID
	LEFT JOIN vwAuditTrailPhone ReferralCallerPhone ON ReferralCallerPhone.PhoneID = Referral.ReferralCallerPhoneID
	LEFT JOIN vwAuditTrailOrganization ReferralCallerOrganization ON ReferralCallerOrganization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN vwAuditTrailSubLocation ReferralCallerSubLocation ON ReferralCallerSubLocation.SubLocationID = Referral.ReferralCallerSubLocationID 
	LEFT JOIN vwAuditTrailPerson ReferralCallerPerson ON ReferralCallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN vwAuditTrailPersonType ReferralCallerPersonType ON ReferralCallerPersonType.PersonTypeID = ReferralCallerPerson.PersonTypeID 
	LEFT JOIN vwAuditTrailApproachType ReferralApproachType ON ReferralApproachType.ApproachTypeID = Referral.ReferralApproachTypeID
	LEFT JOIN vwAuditTrailRace ReferralDonorRace ON ReferralDonorRace.RaceID = Referral.ReferralDonorRaceID 
	LEFT JOIN vwAuditTrailCauseOfDeath ReferralCauseOfDeath ON ReferralCauseOfDeath.CauseOfDeathID = Referral.ReferralDonorCauseOfDeathID
	LEFT JOIN vwAuditTrailPerson ReferralApproachPerson ON ReferralApproachPerson.PersonID = Referral.ReferralApproachedByPersonID 
--LEFT JOIN vwAuditTrailRegistryStatus ReferralRegistryStatus ON ReferralRegistryStatus.CallId = Referral.CallId 
	LEFT JOIN vwAuditTrailRegistryStatusType ReferralRegistryStatusType ON Referral.DonorRegistryType = ReferralRegistryStatusType.ID 
	LEFT JOIN vwAuditTrailPerson ReferralAttending ON ReferralAttending.PersonID = Referral.ReferralAttendingMD 
	LEFT JOIN vwAuditTrailPerson ReferralPronouncing ON ReferralPronouncing.PersonID = Referral.ReferralPronouncingMD
/* Coroners Case */
	LEFT JOIN vwAuditTrailOrganization CoronerOrg	ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID
	LEFT JOIN vwAuditTrailState CoronerOrgState ON CoronerOrgState.StateID = CoronerOrg.StateID
/* Appropriate */
	LEFT JOIN vwAuditTrailAppropriate AppropOrgan ON AppropOrgan.AppropriateID = Referral.ReferralOrganAppropriateID 
	LEFT JOIN vwAuditTrailAppropriate AppropBone ON AppropBone.AppropriateID = Referral.ReferralBoneAppropriateID 
	LEFT JOIN vwAuditTrailAppropriate AppropTissue ON AppropTissue.AppropriateID = Referral.ReferralTissueAppropriateID 
	LEFT JOIN vwAuditTrailAppropriate AppropSkin ON AppropSkin.AppropriateID = Referral.ReferralSkinAppropriateID 
	LEFT JOIN vwAuditTrailAppropriate AppropValve ON AppropValve.AppropriateID = Referral.ReferralValvesAppropriateID 
	LEFT JOIN vwAuditTrailAppropriate AppropEyes ON AppropEyes.AppropriateID = Referral.ReferralEyesTransAppropriateID 
	LEFT JOIN vwAuditTrailAppropriate AppropRsch ON AppropRsch.AppropriateID = Referral.ReferralEyesRschAppropriateID 
/* Approach */
	LEFT JOIN vwAuditTrailApproach ApproaOrgan ON ApproaOrgan.ApproachID = Referral.ReferralOrganApproachID 
	LEFT JOIN vwAuditTrailApproach ApproaBone ON ApproaBone.ApproachID = Referral.ReferralBoneApproachID 
	LEFT JOIN vwAuditTrailApproach ApproaTissue ON ApproaTissue.ApproachID = Referral.ReferralTissueApproachID 
	LEFT JOIN vwAuditTrailApproach ApproaSkin ON ApproaSkin.ApproachID = Referral.ReferralSkinApproachID 
	LEFT JOIN vwAuditTrailApproach ApproaValve ON ApproaValve.ApproachID = Referral.ReferralValvesApproachID 
	LEFT JOIN vwAuditTrailApproach ApproaEyes ON ApproaEyes.ApproachID = Referral.ReferralEyesTransApproachID 
	LEFT JOIN vwAuditTrailApproach ApproaRsch ON ApproaRsch.ApproachID = Referral.ReferralEyesRschApproachID 
/* Consent */
	LEFT JOIN vwAuditTrailConsent ConsentOrgan ON ConsentOrgan.ConsentID = Referral.ReferralOrganConsentID 
	LEFT JOIN vwAuditTrailConsent ConsentBone ON ConsentBone.ConsentID = Referral.ReferralBoneConsentID 
	LEFT JOIN vwAuditTrailConsent ConsentTissue ON ConsentTissue.ConsentID = Referral.ReferralTissueConsentID 
	LEFT JOIN vwAuditTrailConsent ConsentSkin ON ConsentSkin.ConsentID = Referral.ReferralSkinConsentID 
	LEFT JOIN vwAuditTrailConsent ConsentValve ON ConsentValve.ConsentID = Referral.ReferralValvesConsentID 
	LEFT JOIN vwAuditTrailConsent ConsentEyes ON ConsentEyes.ConsentID = Referral.ReferralEyesTransConsentID 
	LEFT JOIN vwAuditTrailConsent ConsentRsch ON ConsentRsch.ConsentID = Referral.ReferralEyesRschConsentID 
/* Conversion */
	LEFT JOIN vwAuditTrailConversion RecoveryOrgan ON RecoveryOrgan.ConversionID = Referral.ReferralOrganConversionID 
	LEFT JOIN vwAuditTrailConversion RecoveryBone ON RecoveryBone.ConversionID = Referral.ReferralBoneConversionID 
	LEFT JOIN vwAuditTrailConversion RecoveryTissue ON RecoveryTissue.ConversionID = Referral.ReferralTissueConversionID 
	LEFT JOIN vwAuditTrailConversion RecoverySkin ON RecoverySkin.ConversionID = Referral.ReferralSkinConversionID 
	LEFT JOIN vwAuditTrailConversion RecoveryValve ON RecoveryValve.ConversionID = Referral.ReferralValvesConversionID 
	LEFT JOIN vwAuditTrailConversion RecoveryEyes ON RecoveryEyes.ConversionID = Referral.ReferralEyesTransConversionID 
	LEFT JOIN vwAuditTrailConversion RecoveryRsch ON RecoveryRsch.ConversionID = Referral.ReferralEyesRschConversionID 
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	Referral.CallID = @CallID
AND Referral.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN Referral.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	ReferralChangePerson.PersonFirst + ' ' +ReferralChangePerson.PersonLast AS 'ChangeUser',
	ReferralChangeType.AuditLogTypeName AS 'ChangeType',
/* Contact Information */
	NULL AS 'ReferralCallerPhone',
	NULL AS 'ReferralFacility',
	NULL AS 'ReferralCallerExtension',
	NULL AS 'HospitalUnit',
	NULL AS 'Floor',
	NULL AS 'ReferralPerson',
	NULL AS 'ReferralPersonTitle',
/* Patient Status */
	NULL AS 'ReferralDonorHeartBeat',
	NULL AS 'Vent',
	NULL AS 'Extubationd d/t',
	NULL AS 'DonorCardiacDeathDT',
	NULL AS 'DonorBrainDeathDT',
	NULL AS 'DonorAdmitDT',
	NULL AS 'DonorDOA',
	NULL AS 'DonorLSADeathDT',
/* Patient Iformation */
	NULL AS 'ReferralDonorLastName',
	NULL AS 'ReferralDonorFirstName',
	NULL AS 'ReferralDonorNameMI',
	NULL AS 'ReferralDonorDOB',
	NULL AS 'ReferralDonorAge',
	NULL AS 'ReferralDonorRace',
	NULL AS 'ReferralDonorGender',
	NULL AS 'ReferralDonorWeight',
	NULL AS 'MedicalRecordNumber',
	NULL AS 'ReferralDonorSSN',
/* Medical History and Cause of Death */
	NULL AS 'ReferralMedicalHistory',
	NULL AS 'ReferralDonorSpecificCOD',
	NULL AS 'ReferralCauseOfDeath',
/* Approach Information */
	NULL AS 'ReferralMethodOfApproach',
	NULL AS 'ReferralApproachPerson',
	NULL AS 'ReferralGeneralConsent',
	NULL AS 'RegistryStatus',
/* Physician Information */
	NULL AS 'Attending',
	NULL AS 'ReferralAttendingMDPhone',
	NULL AS 'Pronouncing',
	NULL AS 'ReferralPronouncingMDPhone',
/* NOK - use sps_rpt_AuditTrail_NOK */
	NULL AS 'ReferralNOKAddress',
/* Coroner Information */
	NULL AS 'CoronersCase',
	NULL AS 'CoronersState',		
	NULL AS 'ReferralCoronerOrganization',
	NULL AS 'ReferralCoronerName',
	NULL AS 'ReferralCoronerPhone',
	NULL AS 'ReferralCoronerNote',
/* Appropriate */
	NULL AS 'AppropriateOrgan',
	NULL AS 'AppropriateBone',
	NULL AS 'AppropriateTissue',
	NULL AS 'AppropriateSkin',
	NULL AS 'AppropriateValve',
	NULL AS 'AppropriateEyes',
	NULL AS 'AppropriateRsch',
/* Approach */
	NULL AS 'ApproachOrgan', 
	NULL AS 'ApproachBone', 
	NULL AS 'ApproachTissue', 
	NULL AS 'ApproachSkin', 
	NULL AS 'ApproachValve', 
	NULL AS 'ApproachEyes', 
	NULL AS 'ApproachRsch', 
/* Consent */
	NULL AS 'ConsentOrgan',
	NULL AS 'ConsentBone',
	NULL AS 'ConsentTissue',
	NULL AS 'ConsentSkin',
	NULL AS 'ConsentValve',
	NULL AS 'ConsentEyes',
	NULL AS 'ConsentRsch',
/* Recovery */
	NULL AS 'RecoveryOrgan',	
	NULL AS 'RecoveryBone',	
	NULL AS 'RecoveryTissue',	
	NULL AS 'RecoverySkin',	
	NULL AS 'RecoveryValve',
	NULL AS 'RecoveryEyes',
	NULL AS 'RecoveryRsch',	
	NULL As 'ReferralDCDPotential'
FROM
	[Call] 
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
	LEFT JOIN vwAuditTrailStatEmployee ReferralChangeEmployee ON ReferralChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson ReferralChangePerson ON ReferralChangePerson.PersonID = ReferralChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType ReferralChangeType ON ReferralChangeType.AuditLogTypeID = [Call].AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND [Call].AuditLogTypeID = 4 -- Deleted
AND	[Call].CallID = @CallID
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;

/* Additional Registry status changes */
INSERT #ReferralInfo (ChangeDT, ChangeUser, ChangeType, RegistryStatus)
SELECT DISTINCT
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, RegistryStatus.LastModified, @DisplayMT) AS smalldatetime)AS 'ChangeDT',
	ReferralChangePerson.PersonFirst + ' ' + ReferralChangePerson.PersonLast AS 'ChangeUser',
	ReferralChangeType.AuditLogTypeName AS 'ChangeType',
	RegistryStatusType.RegistryType AS RegistryStatus
FROM
	RegistryStatus
	JOIN vwAuditTrailReferral RefReferral ON RegistryStatus.CallID = RefReferral.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Referral Lookups */
	LEFT JOIN vwAuditTrailStatEmployee ReferralChangeEmployee ON ReferralChangeEmployee.StatEmployeeID = RegistryStatus.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson ReferralChangePerson ON ReferralChangePerson.PersonID = ReferralChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType ReferralChangeType ON ReferralChangeType.AuditLogTypeID = RegistryStatus.AuditLogTypeID
	LEFT JOIN vwAuditTrailRegistryStatusType RegistryStatusType ON RegistryStatus.RegistryStatus = RegistryStatusType.ID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	RegistryStatus.CallID = @CallID
AND RegistryStatus.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN RegistryStatus.LastStatEmployeeID
			ELSE @CoordinatorID
		END;


/* Final Results */
SELECT *
FROM #ReferralInfo
WHERE
	ChangeDT >= 
		CASE
			WHEN @ChangeStartDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeStartDateTime
		END
AND	ChangeDT <=
		CASE
			WHEN @ChangeEndDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeEndDateTime
		END;

DROP TABLE IF EXISTS #ReferralInfo;