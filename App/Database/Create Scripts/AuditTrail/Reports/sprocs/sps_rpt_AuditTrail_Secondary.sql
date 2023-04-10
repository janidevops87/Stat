IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Secondary')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Secondary';
		DROP  PROCEDURE  sps_rpt_AuditTrail_Secondary;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Secondary';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_Secondary
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Secondary.sql
**		Name: sps_rpt_AuditTrail_Secondary
**		Desc: 
**
**		Return values:
**
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/06/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		08/06/2007		ccarroll
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		09/19/2011		ccarroll				Changed LSA to read from Referral table CCRST151
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #SecondaryInfo;
DROP TABLE IF EXISTS #TempYesNoNaILB;


/* Create Temp lookup table containing ILB 
	for reference to Yes, No, N/A and ILB */
SELECT YesNoNa_RefId, YesNoNa_RefName
INTO #TempYesNoNaILB
FROM vwAuditTrailYesNoNa_Ref
UNION
SELECT -2, 'ILB';


/* Set UserOrgTZ Time Zone */
DECLARE @UserOrgTZ AS varchar(2) =
(
	SELECT vwAuditTrailTimeZone.TimeZoneAbbreviation 
	FROM vwAuditTrailOrganization
		JOIN vwAuditTrailTimeZone ON vwAuditTrailOrganization.TimeZoneId = vwAuditTrailTimeZone.TimeZoneID
	WHERE OrganizationID = @UserOrgID
);


IF @ChangeStartDateTime = @ChangeEndDateTime
	BEGIN
		SELECT
			@ChangeStartDateTime = NULL,
			@ChangeEndDateTime = NULL;
	END
ELSE /* Adjust UserInputDateTime */
	BEGIN
		SELECT
			@ChangeStartDateTime =  DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeStartDateTime) * -1), @ChangeStartDateTime),
			@ChangeEndDateTime = DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeEndDateTime) * -1), @ChangeEndDateTime);
	END


SELECT DISTINCT
/* Secondary * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Secondary].LastModified, @DisplayMT) AS smalldatetime)AS 'ChangeDT',
	SecondaryChangePerson.PersonFirst + ' ' + SecondaryChangePerson.PersonLast AS 'ChangeUser',
	SecondaryChangeType.AuditLogTypeName AS 'ChangeType',
/* Case Info */
	YNNOKAware.YesNoNa_RefName AS 'NOK_Notified',
	[Secondary].SecondaryNOKNotifiedBy,
	CASE WHEN [Secondary].SecondaryNOKNotifiedDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryNOKNotifiedDate, 101) END AS 'SecondaryNOKNotifiedDate',
	[Secondary].SecondaryNOKNotifiedTime,
	YNFamInterest.YesNoNa_RefName AS 'SecondaryFamilyInterested',
	YNFamConsent.YesNoNa_RefName AS 'SecondaryFamilyConsent',
	YNNOKAtHospital.YesNoNa_RefName AS 'SecondaryNOKAtHospital',
	[Secondary].SecondaryEstTimeSinceLeft,
	[Secondary].SecondaryTimeLeftInMT,
	[Secondary].SecondaryNOKNextDest,
	[Secondary].SecondaryNOKETA,
/* Patient Info */
	[Secondary].SecondaryPatientMiddleName AS 'MI',
	[Secondary].SecondaryPatientSuffix,
	[Secondary].SecondaryPatientHeightFeet AS 'Height ft.',
	[Secondary].SecondaryPatientHeightInches AS 'Height in.',
	[Secondary].SecondaryPatientBMICalc AS 'BMI',
	CASE WHEN [Secondary].SecondaryPatientABO = -2 THEN 'ILB' ELSE  ABO.ABORefName END AS 'ABO',
	[Secondary].SecondaryCODOther AS 'CauseOfDeath',
	CASE WHEN [Secondary].SecondaryBrainDeathDate = '01/01/1900' THEN 'ILB' ELSE NULLIF(TRIM(ISNULL(CONVERT(varchar, [Secondary].SecondaryBrainDeathDate, 101), '') + ISNULL(' ' + [Secondary].SecondaryBrainDeathTime,'')), '') END AS 'BrainDeath_dt',
	[Secondary].SecondaryCODSignatory,
	[Secondary].SecondaryPCPName,
	[Secondary].SecondaryPCPPhone,
	[Secondary].SecondaryMDAttending,
	[Secondary].SecondaryMDAttendingPhone,
/* Medical/Treatment Info - History/Admit */
	[Secondary].SecondaryPatientVent AS SecondaryPatientVent,  
	[Secondary].SecondaryCircumstanceOfDeath,
	YNSignsOfInfection.YesNoNa_RefName AS 'SecondarySignOfInfection',
	[Secondary].SecondaryMedicalHistory,
	[Secondary].SecondaryPhysicalAppearance, 
	YNSubstanceAbuse.YesNoNa_RefName AS 'SubstanceAbuse',
	[Secondary].SecondarySubstanceAbuseDetail,
	[Secondary].SecondaryAdditionalComments,
	[Secondary].SecondaryAdmissionDiagnosis,
	CAST(NULL AS varchar(41)) AS 'AdmitDT', --Admit DT (Referral)
	CASE WHEN [Secondary].SecondaryDNRDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryDNRDate, 101) END AS 'SecondaryDNRDate',
	YNDeathWitnessed.YesNoNa_RefName AS 'DeathWitnessed',
	[Secondary].SecondaryDeathWitnessedBy,
	Rhythm.RhythmName AS 'RhythmWhenFound',
	CAST(NULL AS varchar(82)) AS 'SecondaryLSADT',
	[Secondary].SecondaryEMSArrivalToPatientTime AS 'SecondaryEMSArrivalToPatientTime',
	[Secondary].SecondaryEMSArrivalToHospitalTime AS 'SecondaryEMSArrivalToHospitalTime',
/* Medication Summary */
	YNMedication.YesNoNa_RefName AS 'Medications',
	YNAntibiotic.YesNoNa_RefName AS 'Antibiotics',
	YNSteroid.YesNoNa_RefName AS 'Steroids',
	[Secondary].SecondaryAdditionalMedications AS 'AdditionalMedications',
/* Medications Antibiotics and Steroids (SecondaryMedication, SecondaryMedicationOther) */
/* Fluids - Blood Loss */
	[Secondary].SecondaryInternalBloodLossCC,	
	[Secondary].SecondaryExternalBloodLossCC,
/* Fluids - Blood Products (Secondary2) */
	YNBloodProducts.YesNoNa_RefName AS 'BloodProducts',
	YNColloidsInfused.YesNoNa_RefName AS 'ColloidsInfused',
	YNCrystalloids.YesNoNa_RefName AS 'Crystalloids',
/* Pre-Transfusion Blood Sample */
	YNPreTransRequired.YesNoNa_RefName AS 'PreTransRequired',
	YNPreTransAvailable.YesNoNa_RefName AS 'PreTransAvailable',
	CASE WHEN [Secondary].SecondaryPreTransfusionSampleDrawnDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryPreTransfusionSampleDrawnDate, 101) END AS 'SecondaryPreTransfusionSampleDrawnDate',
	[Secondary].SecondaryPreTransfusionSampleDrawnTime,
	[Secondary].SecondaryPreTransfusionSampleQuantity,
	[Secondary].SecondaryPreTransfusionSampleHeldAt,
	CASE WHEN [Secondary].SecondaryPreTransfusionSampleHeldDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryPreTransfusionSampleHeldDate, 101) END AS 'SecondaryPreTransfusionSampleHeldDate',
	[Secondary].SecondaryPreTransfusionSampleHeldTime,
	[Secondary].SecondaryPreTransfusionSampleHeldTechnician,
/* Post Mortem Blood Sample */
	YNPostMordemTestSuitable.YesNoNa_RefName AS 'PostMordemTestSuitable',
	[Secondary].SecondaryPostMordemSampleLocation,
	[Secondary].SecondaryPostMordemSampleContact,
	CASE WHEN [Secondary].SecondaryPostMordemSampleCollectionDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryPostMordemSampleCollectionDate,101) END AS 'PostMordemCollectionDate',
	[Secondary].SecondaryPostMordemSampleCollectionTime AS 'PostMordemCollectionTime',
/* Labs  Culture */
	SecondarySputumCharacteristics,
/* Next of Kin */
	[Secondary].SecondaryNOKAltPhone,
	[Secondary].SecondaryNOKGender,
	YNNOKLegal.YesNoNa_RefName AS 'SecondaryNOKLegal',
	[Secondary].SecondaryNOKAltContact,
	[Secondary].SecondaryNOKAltContactPhone,
	YNNOKExamAuthorized.YesNoNa_RefName AS 'SecondaryNOKExamAuthorized',
	[Secondary].SecondaryNOKPostMortemAuthorizationReminder,
/* Coroner */
	CASE [Secondary].SecondaryCoronerCase WHEN 0 THEN 'No' WHEN 1 THEN 'Yes' ELSE NULL END AS 'SecondaryCoronerCase',
	[Secondary].SecondaryCoronerCaseNumber,
	[Secondary].SecondaryCoronerCounty,
	NULL AS 'InvestigatorName', -- Not used, See Referral.ReferralCoronerName
	NULL AS 'InvestigatorPhone', -- Not used See Referral.ReferralCoronerPhone
	[Secondary].SecondaryCoronerReleased,
	[Secondary].SecondaryCoronerReleasedStipulations,
/* Autopsy */
	YNAutopsy.YesNoNa_RefName AS 'Autopsy',
	CASE WHEN [Secondary].SecondaryAutopsyDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryAutopsyDate,101) END AS 'SecondaryAutopsyDate',
	[Secondary].SecondaryAutopsyTime AS 'SecondaryAutopsyTime',
	[Secondary].SecondaryAutopsyLocationOther AS 'SecondaryAutopsyLocation',
	YNAutopsyBloodRequested.YesNoNa_RefName AS 'AutopsyBloodRequested',
	YNAutopsyCopyRequested.YesNoNa_RefName AS 'AutopsyReportRequsted',
	NULL AS 'SecondaryAutopsyReminder', --Field not used:
	YNAutopsyReminder.YesNoNa_RefName AS 'YNAutopsyReminder',
/* Funeral Home */
	YNFHSelected.YesNoNa_RefName AS 'FuneralHomeSelected',
	[Secondary].SecondaryFuneralHomeName,
	[Secondary].SecondaryFuneralHomePhone,
	[Secondary].SecondaryFuneralHomeAddress,
	[Secondary].SecondaryFuneralHomeContact,
	YNFHNotified.YesNoNa_RefName AS 'FuneralHomeNotified',
	YNFHMorgueCooled.YesNoNa_RefName AS 'YNFuneralHomeMorgueCooled',
	YNFHHoldOnBody.YesNoNa_RefName AS 'YNFuneralHomeHoldOnBody',
	[Secondary].SecondaryHoldOnBodyTag AS 'FuneralHomeDateTimePersonStamp',		
	NULL AS 'SecondaryFuneralHomeReminder', --Field not used
	YNFHReminder.YesNoNa_RefName AS 'YNFuneralHomeReminder',
/* Body Care */
	CASE WHEN [Secondary].SecondaryBodyHoldPlaced = '01/01/1900' THEN 'ILB' ELSE NULLIF(TRIM(ISNULL(CONVERT(varchar, [Secondary].SecondaryBodyHoldPlaced,101), '') + ISNULL(' ' + [Secondary].SecondaryBodyHoldPlacedTime, '')), '') END AS 'BodyHoldPlacedDT',
	[Secondary].SecondaryBodyHoldPlacedWith,
	[Secondary].SecondaryBodyFutureContact,
	[Secondary].SecondaryBodyHoldPhone,
	CASE WHEN [Secondary].SecondaryBodyRefrigerationDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, [Secondary].SecondaryBodyRefrigerationDate,101) END AS 'BodyRefrigerationDate',
	[Secondary].SecondaryBodyRefrigerationTime AS 'BodyRefrigerationTime',
	[Secondary].SecondaryBodyLocation,
	[Secondary].SecondaryBodyCoolingMethod,
	YNBodyHoldInstructionsGiven.YesNoNa_RefName AS 'YNBodyHoldInstructionsGiven',
/* Case Numbers */
	[Secondary].SecondaryUNOSNumber,
	[Secondary].SecondaryClientNumber,
	[Secondary].SecondaryCryolifeNumber,
	[Secondary].SecondaryMTFNumber,
	[Secondary].SecondaryLifeNetNumber,
	[Secondary].SecondaryFreeText,
/* Wrap-Up Items */
	NULL AS 'SecondaryWrapUpReminder', --Field not used: Cannot locate in database
	YNWrapUpReminder.YesNoNa_RefName AS 'YNSecondaryWrapUpReminder'
INTO #SecondaryInfo
FROM
	[Secondary]
	JOIN vwAuditTrailReferral refReferral ON refReferral.CallID = [Secondary].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = refReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryChangeEmployee ON SecondaryChangeEmployee.StatEmployeeID = [Secondary].LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson SecondaryChangePerson ON SecondaryChangePerson.PersonID = SecondaryChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryChangeType ON SecondaryChangeType.AuditLogTypeID = [Secondary].AuditLogTypeID
	LEFT JOIN vwAuditTrailPerson AS SecondaryMDAttending ON SecondaryMDAttending.PersonID = [Secondary].SecondaryMDAttendingId
	LEFT JOIN vwAuditTrailRhythm AS Rhythm ON Rhythm.RhythmID = [Secondary].SecondaryRhythm
	LEFT JOIN vwAuditTrailABORef AS ABO ON [Secondary].SecondaryPatientABO = ABO.ABORefid
/* Yes No NA lookups */
	LEFT JOIN #TempYesNoNaILB AS YNNOKAware ON  YNNOKAware.YesNoNa_RefId = [Secondary].SecondaryNOKaware
	LEFT JOIN #TempYesNoNaILB AS YNFamInterest ON  YNFAmInterest.YesNoNa_RefId = [Secondary].SecondaryFamilyInterested
	LEFT JOIN #TempYesNoNaILB AS YNFamConsent ON  YNFAmConsent.YesNoNa_RefId = [Secondary].SecondaryFamilyConsent
	LEFT JOIN #TempYesNoNaILB AS YNNOKAtHospital ON YNNOKAtHospital.YesNoNa_RefID = [Secondary].SecondaryNOKAtHospital
	LEFT JOIN #TempYesNoNaILB AS YNSubstanceAbuse ON YNSubstanceAbuse.YesNoNa_RefID = [Secondary].SecondaryHistorySubstanceAbuse
	LEFT JOIN #TempYesNoNaILB AS YNDeathWitnessed ON YNDeathWitnessed.YesNoNa_RefID = [Secondary].SecondaryDeathWitnessed
	LEFT JOIN #TempYesNoNaILB AS YNBloodProducts ON YNBloodproducts.YesNoNa_RefID = [Secondary].SecondaryBloodProducts
	LEFT JOIN #TempYesNoNaILB AS YNColloidsInfused ON YNColloidsInfused.YesNoNa_RefID = [Secondary].SecondaryColloidsInfused
	LEFT JOIN #TempYesNoNaILB AS YNCrystalloids ON YNCrystalloids.YesNoNa_RefID = [Secondary].SecondaryCrystalloids
	LEFT JOIN #TempYesNoNaILB AS YNPreTransRequired ON YNPreTransRequired.YesNoNa_RefID = [Secondary].SecondaryPreTransfusionSampleRequired
	LEFT JOIN #TempYesNoNaILB AS YNPreTransAvailable ON YNPreTransAvailable.YesNoNa_RefID = [Secondary].SecondaryPreTransfusionSampleAvailable
	LEFT JOIN #TempYesNoNaILB AS YNPostMordemTestSuitable ON YNPostMordemTestSuitable.YesNoNa_RefID = [Secondary].SecondaryPostMordemSampleTestSuitable
	LEFT JOIN #TempYesNoNaILB AS YNNOKLegal ON YNNOKLegal.YesNoNa_RefID = [Secondary].SecondaryNOKLegal
	LEFT JOIN #TempYesNoNaILB AS YNNOKExamAuthorized ON YNNOKExamAuthorized.YesNoNa_RefID = [Secondary].SecondaryNOKPostMortemAuthorization
	LEFT JOIN #TempYesNoNaILB AS YNAutopsy ON YNAutopsy.YesNoNa_RefID = [Secondary].SecondaryAutopsy
	LEFT JOIN #TempYesNoNaILB AS YNAutopsyBloodRequested ON YNAutopsyBloodRequested.YesNoNa_RefID = [Secondary].SecondaryAutopsyBloodRequested
	LEFT JOIN #TempYesNoNaILB AS YNAutopsyCopyRequested ON YNAutopsyCopyRequested.YesNoNa_RefID = [Secondary].SecondaryAutopsyCopyRequested
	LEFT JOIN #TempYesNoNaILB AS YNAutopsyReminder ON YNAutopsyReminder.YesNoNa_RefID = [Secondary].SecondaryAutopsyReminderYN
	LEFT JOIN #TempYesNoNaILB AS YNFHSelected ON YNFHSelected.YesNoNa_RefID = [Secondary].SecondaryFuneralHomeSelected
	LEFT JOIN #TempYesNoNaILB AS YNFHNotified ON YNFHNotified.YesNoNa_RefID = [Secondary].SecondaryFuneralHomeNotified
	LEFT JOIN #TempYesNoNaILB AS YNFHHoldOnBody ON YNFHHoldOnBody.YesNoNa_RefID = [Secondary].SecondaryHoldOnBody
	LEFT JOIN #TempYesNoNaILB AS YNFHMorgueCooled ON YNFHMorgueCooled.YesNoNa_RefID = [Secondary].SecondaryFuneralHomeMorgueCooled
	LEFT JOIN #TempYesNoNaILB AS YNFHReminder ON YNFHReminder.YesNoNa_RefID = [Secondary].SecondaryFHReminderYN
	LEFT JOIN #TempYesNoNaILB AS YNBodyHoldInstructionsGiven ON YNBodyHoldInstructionsGiven.YesNoNa_RefID = [Secondary].SecondaryBodyHoldInstructionsGiven
	LEFT JOIN #TempYesNoNaILB AS YNWrapUpReminder ON YNWrapUpReminder.YesNoNa_RefID = [Secondary].SecondaryWrapUpReminderYN
	LEFT JOIN #TempYesNoNaILB AS YNSignsOfInfection ON YNSignsOfInfection.YesNoNa_RefID = [Secondary].SecondarySignOfInfection
	LEFT JOIN #TempYesNoNaILB AS YNMedication ON YNMedication.YesNoNa_RefID = [Secondary].SecondaryMedication
	LEFT JOIN #TempYesNoNaILB AS YNAntibiotic ON YNAntibiotic.YesNoNa_RefID = [Secondary].SecondaryAntibiotic
	LEFT JOIN #TempYesNoNaILB AS YNSteroid ON YNSteroid.YesNoNa_RefID = [Secondary].SecondarySteroid
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	[Secondary].CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND [Secondary].LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Secondary].LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	SecondaryChangePerson.PersonFirst + ' ' + SecondaryChangePerson.PersonLast AS 'ChangeUser',
	SecondaryChangeType.AuditLogTypeName AS 'ChangeType',
/* Case Info */
	NULL AS 'NOK_Notified',
	NULL AS 'SecondaryNOKNotifiedBy',
	NULL AS 'SecondaryNOKNotifiedDate',
	NULL AS 'SecondaryNOKNotifiedTime',
	NULL AS 'SecondaryFamilyInterested',
	NULL AS 'SecondaryFamilyConsent',
	NULL AS 'SecondaryNOKAtHospital',
	NULL AS 'SecondaryEstTimeSinceLeft',
	NULL AS 'SecondaryTimeLeftInMT',
	NULL AS 'SecondaryNOKNextDest',
	NULL AS 'SecondaryNOKETA',
/* Patient Info */
	NULL AS 'MI',
	NULL AS 'SecondaryPatientSuffix',
	NULL AS 'Height ft.',
	NULL AS 'Height in.',
	NULL AS 'BMI',
	NULL AS 'ABO',
	NULL AS 'CauseOfDeath',
	NULL AS 'BrainDeath_dt',
	NULL AS 'SecondaryCODSignatory',
	NULL AS 'SecondaryPCPName',
	NULL AS 'SecondaryPCPPhone',
	NULL AS 'SecondaryMDAttending',
	NULL AS 'SecondaryMDAttendingPhone',
/* Medical/Treatment Info - History/Admit */
	NULL AS 'SecondaryPatientVent',  
	NULL AS 'SecondaryCircumstanceOfDeath',
	NULL AS 'SecondarySignOfInfection',
	NULL AS 'SecondaryMedicalHistory',
	NULL AS 'SecondaryPhysicalAppearance', 
	NULL AS 'SubstanceAbuse',
	NULL AS 'SecondarySubstanceAbuseDetail',
	NULL AS 'SecondaryAdditionalComments',
	NULL AS 'SecondaryAdmissionDiagnosis',
	NULL AS 'AdmitDT', --Admit DT (Referral)
	NULL AS 'SecondaryDNRDate',
	NULL AS 'DeathWitnessed',
	NULL AS 'SecondaryDeathWitnessedBy',
	NULL AS 'RhythmWhenFound',
	NULL AS 'SecondaryLSADT',
	NULL AS 'SecondaryEMSArrivalToPatientTime',
	NULL AS 'SecondaryEMSArrivalToHospitalTime',
/* Medication Summary */	
	NULL AS 'Medications',
	NULL AS 'Antibiotics',
	NULL AS 'Steroids',
	NULL AS 'AdditionalMedications',
/* Medications Antibiotics and Steroids (SecondaryMedication, SecondaryMedicationOther) */
/* Fluids - Blood Loss */
	NULL AS 'SecondaryInternalBloodLossCC',	
	NULL AS 'SecondaryExternalBloodLossCC',
/* Fluids - Blood Products (Secondary2) */
	NULL AS 'BloodProducts',
	NULL AS 'ColloidsInfused',
	NULL AS 'Crystalloids',
/* Pre-Transfusion Blood Sample */
	NULL AS 'PreTransRequired',
	NULL AS 'PreTransAvailable',
	NULL AS 'SecondaryPreTransfusionSampleDrawnDate',
	NULL AS 'SecondaryPreTransfusionSampleDrawnTime',
	NULL AS 'SecondaryPreTransfusionSampleQuantity',
	NULL AS 'SecondaryPreTransfusionSampleHeldAt',
	NULL AS 'SecondaryPreTransfusionSampleHeldDate',
	NULL AS 'SecondaryPreTransfusionSampleHeldTime',
	NULL AS 'SecondaryPreTransfusionSampleHeldTechnician',
/* Post Mortem Blood Sample */
	NULL AS 'PostMordemTestSuitable',
	NULL AS 'SecondaryPostMordemSampleLocation',
	NULL AS 'SecondaryPostMordemSampleContact',
	NULL AS 'PostMordemCollectionDate',
	NULL AS 'PostMordemCollectionTime',
/* Labs  Culture */
	NULL AS 'SecondarySputumCharacteristics',
/* Next of Kin */
	NULL AS 'SecondaryNOKAltPhone',
	NULL AS 'SecondaryNOKGender',
	NULL AS 'SecondaryNOKLegal',
	NULL AS 'SecondaryNOKAltContact',
	NULL AS 'SecondaryNOKAltContactPhone',
	NULL AS 'SecondaryNOKExamAuthorized',
	NULL AS 'SecondaryNOKPostMortemAuthorizationReminder',
/* Coroner */
	NULL AS 'SecondaryCoronerCase',
	NULL AS 'SecondaryCoronerCaseNumber',
	NULL AS 'SecondaryCoronerCounty',
	NULL AS 'InvestigatorName', -- Not used, See Referral.ReferralCoronerName
	NULL AS 'InvestigatorPhone', -- Not used See Referral.ReferralCoronerPhone
	NULL AS 'SecondaryCoronerReleased',
	NULL AS 'SecondaryCoronerReleasedStipulations',
/* Autopsy */
	NULL AS 'Autopsy',
	NULL AS 'SecondaryAutopsyDate',
	NULL AS 'SecondaryAutopsyTime',
	NULL AS 'SecondaryAutopsyLocation',
	NULL AS 'AutopsyBloodRequested',
	NULL AS 'AutopsyReportRequsted',
	NULL AS 'SecondaryAutopsyReminder', --Field not used:
	NULL AS 'YNAutopsyReminder',
/* Funeral Home */
	NULL AS 'FuneralHomeSelected',
	NULL AS 'SecondaryFuneralHomeName',
	NULL AS 'SecondaryFuneralHomePhone',
	NULL AS 'SecondaryFuneralHomeAddress',
	NULL AS 'SecondaryFuneralHomeContact',
	NULL AS 'FuneralHomeNotified',
	NULL AS 'YNFuneralHomeMorgueCooled',
	NULL AS 'YNFuneralHomeHoldOnBody',
	NULL AS 'FuneralHomeDateTimePersonStamp',		
	NULL AS 'SecondaryFuneralHomeReminder', --Field not used
	NULL AS 'YNFuneralHomeReminder',
/* Body Care */
	NULL AS 'BodyHoldPlacedDT',
	NULL AS 'SecondaryBodyHoldPlacedWith',
	NULL AS 'SecondaryBodyFutureContact',
	NULL AS 'SecondaryBodyHoldPhone',
	NULL AS 'BodyRefrigerationDate',
	NULL AS 'BodyRefrigerationTime',
	NULL AS 'SecondaryBodyLocation',
	NULL AS 'SecondaryBodyCoolingMethod',
	NULL AS 'YNBodyHoldInstructionsGiven',
/* Case Numbers */
	NULL AS 'SecondaryUNOSNumber',
	NULL AS 'SecondaryClientNumber',
	NULL AS 'SecondaryCryolifeNumber',
	NULL AS 'SecondaryMTFNumber',
	NULL AS 'SecondaryLifeNetNumber',
	NULL AS 'SecondaryFreeText',
/* Wrap-Up Items */
	NULL AS 'SecondaryWrapUpReminder', --Field not used: Cannot locate in database
	NULL AS 'YNSecondaryWrapUpReminder'
FROM
	[Call]
	JOIN [Secondary] ON [Secondary].CallID = [Call].CallID
	JOIN vwAuditTrailReferral refReferral ON refReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = refReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryChangeEmployee ON SecondaryChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson SecondaryChangePerson ON SecondaryChangePerson.PersonID = SecondaryChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryChangeType ON SecondaryChangeType.AuditLogTypeID = [Call].AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND [Call].AuditLogTypeID = 4 -- Deleted
AND	[Call].CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;

/* Add AdmitDT from Referral */
INSERT #SecondaryInfo (ChangeDT, ChangeUser, ChangeType, AdmitDT, SecondaryLSADT)
SELECT DISTINCT
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, Referral.LastModified, @DisplayMT) AS smalldatetime)AS 'ChangeDT',
	ReferralChangePerson.PersonFirst + ' ' + ReferralChangePerson.PersonLast AS 'ChangeUser',
	ReferralChangeType.AuditLogTypeName AS 'ChangeType',
	CASE WHEN Referral.ReferralDonorAdmitDate ='01/01/1900' THEN 'ILB' ELSE NULLIF(TRIM(ISNULL(CONVERT(varchar, Referral.ReferralDonorAdmitDate, 101), '') + ISNULL(' ' + Referral.ReferralDonorAdmitTime, '')), '') END AS 'AdmitDT', --Admit DT (Referral)
	CASE WHEN Referral.ReferralDonorLSADate = '01/01/1900' THEN 'ILB' ELSE NULLIF(TRIM(ISNULL(CONVERT(varchar, Referral.ReferralDonorLSADate,101), '') + ISNULL(' ' + Referral.ReferralDonorLSATime, '')), '') END AS 'SecondaryLSADT'
FROM
	Referral
	JOIN vwAuditTrailReferral RefReferral ON Referral.CallID = RefReferral.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Referral Lookups */
	LEFT JOIN vwAuditTrailStatEmployee ReferralChangeEmployee ON ReferralChangeEmployee.StatEmployeeID = Referral.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson ReferralChangePerson ON ReferralChangePerson.PersonID = ReferralChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType ReferralChangeType ON ReferralChangeType.AuditLogTypeID = Referral.AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	Referral.CallID = @CallID
AND Referral.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN Referral.LastStatEmployeeID
			ELSE @CoordinatorID
		END
AND	(
		Referral.ReferralDonorAdmitDate IS NOT NULL
	OR	Referral.ReferralDonorAdmitTime IS NOT NULL
	OR	Referral.ReferralDonorLSADate IS NOT NULL
	OR	Referral.ReferralDonorLSATime IS NOT NULL
	);


/* Final Results */
SELECT *
FROM #SecondaryInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[NOK_Notified] IS NOT NULL
	OR	[SecondaryNOKNotifiedBy] IS NOT NULL
	OR	[SecondaryNOKNotifiedDate] IS NOT NULL
	OR	[SecondaryNOKNotifiedTime] IS NOT NULL
	OR	[SecondaryFamilyInterested] IS NOT NULL
	OR	[SecondaryFamilyConsent] IS NOT NULL
	OR	[SecondaryNOKAtHospital] IS NOT NULL
	OR	[SecondaryEstTimeSinceLeft] IS NOT NULL
	OR	[SecondaryTimeLeftInMT] IS NOT NULL
	OR	[SecondaryNOKNextDest] IS NOT NULL
	OR	[SecondaryNOKETA] IS NOT NULL
	OR	[MI] IS NOT NULL
	OR	[SecondaryPatientSuffix] IS NOT NULL
	OR	[Height ft.] IS NOT NULL
	OR	[Height in.] IS NOT NULL
	OR	[BMI] IS NOT NULL
	OR	[ABO] IS NOT NULL
	OR	[CauseOfDeath] IS NOT NULL
	OR	[BrainDeath_dt] IS NOT NULL
	OR	[SecondaryCODSignatory] IS NOT NULL
	OR	[SecondaryPCPName] IS NOT NULL
	OR	[SecondaryPCPPhone] IS NOT NULL
	OR	[SecondaryMDAttending] IS NOT NULL
	OR	[SecondaryMDAttendingPhone] IS NOT NULL
	OR	[SecondaryPatientVent] IS NOT NULL
	OR	[SecondaryCircumstanceOfDeath] IS NOT NULL
	OR	[SecondarySignOfInfection] IS NOT NULL
	OR	[SecondaryMedicalHistory] IS NOT NULL
	OR	[SecondaryPhysicalAppearance] IS NOT NULL
	OR	[SubstanceAbuse] IS NOT NULL
	OR	[SecondarySubstanceAbuseDetail] IS NOT NULL
	OR	[SecondaryAdditionalComments] IS NOT NULL
	OR	[SecondaryAdmissionDiagnosis] IS NOT NULL
	OR	[AdmitDT] IS NOT NULL
	OR	[SecondaryDNRDate] IS NOT NULL
	OR	[DeathWitnessed] IS NOT NULL
	OR	[SecondaryDeathWitnessedBy] IS NOT NULL
	OR	[RhythmWhenFound] IS NOT NULL
	OR	[SecondaryLSADT] IS NOT NULL
	OR	[SecondaryEMSArrivalToPatientTime] IS NOT NULL
	OR	[SecondaryEMSArrivalToHospitalTime] IS NOT NULL
	OR	[Medications] IS NOT NULL
	OR	[Antibiotics] IS NOT NULL
	OR	[Steroids] IS NOT NULL
	OR	[AdditionalMedications] IS NOT NULL
	OR	[SecondaryInternalBloodLossCC] IS NOT NULL
	OR	[SecondaryExternalBloodLossCC] IS NOT NULL
	OR	[BloodProducts] IS NOT NULL
	OR	[ColloidsInfused] IS NOT NULL
	OR	[Crystalloids] IS NOT NULL
	OR	[PreTransRequired] IS NOT NULL
	OR	[PreTransAvailable] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleDrawnDate] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleDrawnTime] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleQuantity] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleHeldAt] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleHeldDate] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleHeldTime] IS NOT NULL
	OR	[SecondaryPreTransfusionSampleHeldTechnician] IS NOT NULL
	OR	[PostMordemTestSuitable] IS NOT NULL
	OR	[SecondaryPostMordemSampleLocation] IS NOT NULL
	OR	[SecondaryPostMordemSampleContact] IS NOT NULL
	OR	[PostMordemCollectionDate] IS NOT NULL
	OR	[PostMordemCollectionTime] IS NOT NULL
	OR	[SecondarySputumCharacteristics] IS NOT NULL
	OR	[SecondaryNOKAltPhone] IS NOT NULL
	OR	[SecondaryNOKGender] IS NOT NULL
	OR	[SecondaryNOKLegal] IS NOT NULL
	OR	[SecondaryNOKAltContact] IS NOT NULL
	OR	[SecondaryNOKAltContactPhone] IS NOT NULL
	OR	[SecondaryNOKExamAuthorized] IS NOT NULL
	OR	[SecondaryNOKPostMortemAuthorizationReminder] IS NOT NULL
	OR	[SecondaryCoronerCase] IS NOT NULL
	OR	[SecondaryCoronerCaseNumber] IS NOT NULL
	OR	[SecondaryCoronerCounty] IS NOT NULL
	OR	[InvestigatorName] IS NOT NULL
	OR	[InvestigatorPhone] IS NOT NULL
	OR	[SecondaryCoronerReleased] IS NOT NULL
	OR	[SecondaryCoronerReleasedStipulations] IS NOT NULL
	OR	[Autopsy] IS NOT NULL
	OR	[SecondaryAutopsyDate] IS NOT NULL
	OR	[SecondaryAutopsyTime] IS NOT NULL
	OR	[SecondaryAutopsyLocation] IS NOT NULL
	OR	[AutopsyBloodRequested] IS NOT NULL
	OR	[AutopsyReportRequsted] IS NOT NULL
	OR	[SecondaryAutopsyReminder] IS NOT NULL
	OR	[YNAutopsyReminder] IS NOT NULL
	OR	[FuneralHomeSelected] IS NOT NULL
	OR	[SecondaryFuneralHomeName] IS NOT NULL
	OR	[SecondaryFuneralHomePhone] IS NOT NULL
	OR	[SecondaryFuneralHomeAddress] IS NOT NULL
	OR	[SecondaryFuneralHomeContact] IS NOT NULL
	OR	[FuneralHomeNotified] IS NOT NULL
	OR	[YNFuneralHomeMorgueCooled] IS NOT NULL
	OR	[YNFuneralHomeHoldOnBody] IS NOT NULL
	OR	[FuneralHomeDateTimePersonStamp] IS NOT NULL
	OR	[SecondaryFuneralHomeReminder] IS NOT NULL
	OR	[YNFuneralHomeReminder] IS NOT NULL
	OR	[BodyHoldPlacedDT] IS NOT NULL
	OR	[SecondaryBodyHoldPlacedWith] IS NOT NULL
	OR	[SecondaryBodyFutureContact] IS NOT NULL
	OR	[SecondaryBodyHoldPhone] IS NOT NULL
	OR	[BodyRefrigerationDate] IS NOT NULL
	OR	[BodyRefrigerationTime] IS NOT NULL
	OR	[SecondaryBodyLocation] IS NOT NULL
	OR	[SecondaryBodyCoolingMethod] IS NOT NULL
	OR	[YNBodyHoldInstructionsGiven] IS NOT NULL
	OR	[SecondaryUNOSNumber] IS NOT NULL
	OR	[SecondaryClientNumber] IS NOT NULL
	OR	[SecondaryCryolifeNumber] IS NOT NULL
	OR	[SecondaryMTFNumber] IS NOT NULL
	OR	[SecondaryLifeNetNumber] IS NOT NULL
	OR	[SecondaryFreeText] IS NOT NULL
	OR	[SecondaryWrapUpReminder] IS NOT NULL
	OR	[YNSecondaryWrapUpReminder] IS NOT NULL
	)
AND	ChangeDT >= 
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


DROP TABLE IF EXISTS #SecondaryInfo;
DROP TABLE IF EXISTS #TempYesNoNaILB;