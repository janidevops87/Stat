 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileReferralSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileReferralSelect]
	PRINT 'Dropping Procedure: GetStatFileReferralSelect'
END
	PRINT 'Creating Procedure: GetStatFileReferralSelect'
GO

CREATE PROCEDURE [dbo].[GetStatFileReferralSelect]
(
	@ExportFileID int = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetStatFileReferralSelect.sql
**		Name: GetStatFileReferralSelect
**		Desc:  Used on StatFile
**
**		Called by:  
**              
**
**		Auth: Bret Knoll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/01/2009	Bret Knoll	initial
**      09/2011     jth			added lsa d/t fields
**		10/11/2011	ccarroll	moved LSA to end.
**		10/12/2011	ccarroll	Changed TBINotNeeded value to match file specs
**		12/15/2016	mberenson	Added logic for DLA Registry
**		12/7/2018	bret		striped carriage return from SecondarySubstanceAbuseDetail, ReferralDonorFirstName, ReferralDonorLastName
**		9/6/2019	bret		Null out HeightFeet and HeightInches
**		5/18/2020	mberenson	Added IsNull check to SecondaryPatientHeightFeet
*******************************************************************************/
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT DISTINCT
	Referral.ReferralID, 
	Convert(varchar(25),dbo.fn_StatFile_ConvertDateTime(@OrganizationID, Call.LastModified), 120) as LastModified, 
	CallNumber,
	Convert(varchar(25), dbo.fn_StatFile_ConvertDateTime(@OrganizationID, CallDateTime), 120) as CallDateTime, 
 	StatEmployeeFirstName + ' ' + StatEmployeeLastName as 'StatEmployee', 
 	Referral.ReferralTypeID, 
	ReferralTypeName, 
	1 AS 'ReferralStatusID', 
	'Complete' AS 'ReferralStatus', 
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS 'CallerPhone', 
	ReferralCallerExtension, 
	CallerPerson.PersonFirst + ' ' + CallerPerson.PersonLast AS 'Caller', 
	PersonTypeName, 
	Organization.ProviderNumber 'OrganizationUserCode', 
	Organization.OrganizationName, 
		Case 
			When SubLocationName is null Then '' 
			Else SubLocationName End + ' ' + 
		Case 
			When ReferralCallerSubLocationLevel is null Then '' 
			Else ReferralCallerSubLocationLevel End 
		AS 'CallerOrganizationUnit', 
	REPLACE(REPLACE(ReferralDonorFirstName , CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorFirstName, 
	REPLACE(REPLACE(ReferralDonorLastName  , CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorLastName, 
	ReferralDonorRecNumber, 
	ReferralDonorAge, 
	ReferralDonorAgeUnit, 
	ReferralDonorRaceID, 
	RaceName, 
	ReferralDonorGender, 
	ReferralDonorWeight, 
	ReferralDonorCauseOfDeathID, 
	CauseOfDeathName, 
	REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS 'ReferralNotesCase', 
	ReferralDonorAdmitDate, 
	ReferralDonorAdmitTime,
	ReferralDonorOnVentilator, 
	ReferralDonorDeathDate, 
	ReferralDonorDeathTime, 
	ReferralApproachTypeID, 
	ApproachTypeName, 
	ApproachPerson.PersonFirst + ' ' + ApproachPerson.PersonLast AS 'ApproachBy', 
	Case 
		When ReferralNOKID is not null THEN LEFT(REPLACE(REPLACE(NOK.NOKFirstName + ' ' + NOK.NOKLastName, CHAR(10), CHAR(32)), CHAR(13), ''), 50)
		ELSE ReferralApproachNOK END 
		AS ReferralApproachNOK,
 	Case 
 		When ReferralNOKID is not null THEN nok.nokApproachRelation 
 		else referralapproachrelation END 
 		AS ReferralApproachRelation, 
 	---- Appropriate
 	ReferralOrganAppropriateID, 
 	ReferralBoneAppropriateID, 
 	ReferralTissueAppropriateID, 
 	ReferralSkinAppropriateID, 
 	ReferralValvesAppropriateID, 
	ReferralEyesTransAppropriateID, 
	---- Approach
	case when RegistryStatus.RegistryStatus = 6 then 23 when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganApproachID end as ReferralOrganApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneApproachID end as ReferralBoneApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueApproachID end as ReferralTissueApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinApproachID end as ReferralSkinApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesApproachID end as ReferralValvesApproachID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransApproachID end as ReferralEyesTransApproachID,
	---- Consent
	case when RegistryStatus.RegistryStatus = 6 then 12 when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganConsentID end as ReferralOrganConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneConsentID end as ReferralBoneConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueConsentID end as ReferralTissueConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinConsentID end as ReferralSkinConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesConsentID end as ReferralValvesConsentID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransConsentID end as ReferralEyesTransConsentID,
	---- Conversion or Recovery
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralOrganConversionID end as ReferralOrganConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralBoneConversionID end as ReferralBoneConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralTissueConversionID end as ReferralTissueConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralSkinConversionID end as ReferralSkinConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralValvesConversionID end as ReferralValvesConversionID,
	case when ServiceLevel.ServiceLevelApproachLevel = 1 then  -1  else ReferralEyesTransConversionID end as ReferralEyesTransConversionID,
	ReferralOrganDispositionID, 
	ReferralAllTissueDispositionID, 
	ReferralEyesDispositionID, 
	ReferralBoneDispositionID, 
	ReferralTissueDispositionID, 
	ReferralSkinDispositionID, 
	ReferralValvesDispositionID, 
	ReferralGeneralConsent, 
	ReferralExtubated, 
	cast(convert(char(10),ReferralDOB,101) as varchar(10)) as 'ReferralDOB', 
	ReferralDonorSSN, 
	CASE ReferralCoronersCase WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS 'ReferralCoronersCase', 
	CTY.CountyName, 
	ReferralEyesRschAppropriateID, 
	ReferralEyesRschApproachID,
 	ReferralEyesRschConsentID, 
 	ReferralEyesRschConversionID, 
 	ReferralRschDispositionID, 
 	CallCustomField.CallCustomField1 as customField_1, 
 	CallCustomField.CallCustomField2 as customField_2, 
	CallCustomField.CallCustomField3 as customField_3, 
	CallCustomField.CallCustomField4 as customField_4, 
	CallCustomField.CallCustomField5 as customField_5, 
	CallCustomField.CallCustomField6 as customField_6, 
	REPLACE(REPLACE(CallCustomField.CallCustomField7, CHAR(10), CHAR(32)), CHAR(13), '') as customField_7, 
	CallCustomField.CallCustomField8 as customField_8, 
	CallCustomField.CallCustomField9 as customField_9, 
	CallCustomField.CallCustomField10 as customField_10, 
	CallCustomField.CallCustomField11 as customField_11, 
	CallCustomField.CallCustomField12 as customField_12, 
	CallCustomField.CallCustomField13 as customField_13, 
	CallCustomField.CallCustomField14 as customField_14, 
	CallCustomField.CallCustomField15 as customField_15, 
	CallCustomField.CallCustomField16 as customField_16, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel1 AS ServiceLevelCustomFieldLabel_1, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel2 AS ServiceLevelCustomFieldLabel_2,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel3 AS ServiceLevelCustomFieldLabel_3, 
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel4 AS ServiceLevelCustomFieldLabel_4, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel5 AS ServiceLevelCustomFieldLabel_5, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel6 AS ServiceLevelCustomFieldLabel_6, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel7 AS ServiceLevelCustomFieldLabel_7, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel8 AS ServiceLevelCustomFieldLabel_8, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel9 AS ServiceLevelCustomFieldLabel_9, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel10 AS ServiceLevelCustomFieldLabel_10,
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel11 AS ServiceLevelCustomFieldLabel_11, 
 	ServiceLevelCustomField.ServiceLevelCustomFieldLabel12 AS ServiceLevelCustomFieldLabel_12, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel13 AS ServiceLevelCustomFieldLabel_13, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel14 AS ServiceLevelCustomFieldLabel_14, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel15 AS ServiceLevelCustomFieldLabel_15, 
	ServiceLevelCustomField.ServiceLevelCustomFieldLabel16 AS ServiceLevelCustomFieldLabel_16,
 	CASE 
 		WHEN Len(Referral.ReferralCoronerOrganization) > 0 THEN CoronerST.StateAbbrv 
 		ELSE NULL END 
 		as CoronerState,  
 	Referral.ReferralCoronerOrganization AS CoronerOrganization, 
	Referral.ReferralCoronerName AS CoronerName, 
	Referral.ReferralCoronerPhone AS CoronerPhone, 
	REPLACE(REPLACE(Referral.ReferralCoronerNote, CHAR(10), CHAR(32)), CHAR(13), '') AS CoronerNote, 
	Case 
		When ReferralNOKID is not null then nok.nokphone 
		else Referral.ReferralNOKPhone end 
		AS NOKPhone,
	Case 
		When ReferralNOKID is not null THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress+ ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), '') + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, 255)
		ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END 
		AS ReferralNOKAddress, 	
	RegistryStatus.RegistryStatus RegistryStatusID, 
	RegistryStatusType.RegistryType RegistryStatusType,
	case 
		when isnull(Referral.ReferralDonorHeartBeat, 0)  = 0 then 'N' 
		when isnull(Referral.ReferralDonorHeartBeat, 0)  = -1 then 'N' 
		Else 'Y' End 
		AS PatientHasHeartbeat, 
	Case 
		When Referral.ReferralDOA = 1 then 'Y' 
		Else 'N' End 
		AS DOA, 
	AttendingMD.PersonFirst + ' ' + AttendingMD.PersonLast AS AttendingPhysician,
 	PronouncingMD.PersonFirst + ' ' + PronouncingMD.PersonLast AS PronouncingPhysician  ,
 	FSCaseId,
	FSCaseCreateUserId,
	Convert(varchar(25), FSCaseCreateDateTime, 120) as FSCaseCreateDateTime, 
	FSCaseOpenUserId,
	Convert(varchar(25), FSCaseOpenDateTime, 120) as FSCaseOpenDateTime, 
	FSCaseSysEventsUserId,
	Convert(varchar(25), FSCaseSysEventsDateTime, 120) as FSCaseSysEventsDateTime, 
	FSCaseSecCompUserId,
	Convert(varchar(25), FSCaseSecCompDateTime, 120) as FSCaseSecCompDateTime, 
	FSCaseApproachUserId,
	Convert(varchar(25), FSCaseApproachDateTime, 120) as FSCaseApproachDateTime, 
	FSCaseFinalUserId,
	Convert(varchar(25), FSCaseFinalDateTime, 120) as FSCaseFinalDateTime,
	Convert(varchar(25), FSCaseUpdate, 120) as FSCaseUpdate,
	FSCaseUserId,
	FSCaseBillSecondaryUserID,
	Convert(varchar(25), FSCaseBillDateTime, 120) as FSCaseBillDateTime,
	FSCaseBillApproachUserID,
	Convert(varchar(25), FSCaseBillApproachDateTime, 120) as FSCaseBillApproachDateTime, 
	FSCaseBillMedSocUserID,
	Convert(varchar(25), FSCaseBillMedSocDateTime, 120) as FSCaseBillMedSocDateTime, 
	SecondaryManualBillPersonId,
	SecondaryUpdatedFlag,
	FSCaseTotalTime,
	FSCaseSeconds,
	FSCaseBillFamUnavailUserId,
	Convert(varchar(25), FSCaseBillFamUnavailDateTime, 120) as FSCaseBillFamUnavailDateTime, 
	FSCaseBillCryoFormUserId,
	Convert(varchar(25), FSCaseBillCryoFormDateTime, 120) as FSCaseBillCryoFormDateTime, 
	FSCaseBillApproachCount,
	FSCaseBillMedSocCount,
	FSCaseBillCryoFormCount,
	SecondaryWhoAreWe,
	SecondaryNOKaware,
	SecondaryFamilyConsent,
	SecondaryFamilyInterested,
	case when  SecondaryNOKatHospital <> 1 then 2 else SecondaryNOKatHospital end as SecondaryNOKatHospital,
	SecondaryEstTimeSinceLeft,
	SecondaryTimeLeftInMT,
	SecondaryNOKNextDest,
	SecondaryNOKETA,
	SecondaryPatientMiddleName,
	ISNULL(SecondaryPatientHeightFeet, 0) AS SecondaryPatientHeightFeet,
	SecondaryPatientHeightInches,
	SecondaryPatientBMICalc,
	SecondaryPatientTOD1,
	SecondaryPatientTOD2,
	SecondaryPatientDeathType1,
	SecondaryPatientDeathType2,
	SecondaryTriageHX,
	REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath,
	REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory,
	SecondaryAdmissionDiagnosis,
	case when SecondaryCOD = -1 then null else SecondaryCOD end AS SecondaryCOD,
	SecondaryCODSignatory,
	SecondaryCODTime,
	SecondaryCODSignedBy,
	SecondaryPatientVent,
	SecondaryIntubationDate,
	SecondaryIntubationTime,
	SecondaryBrainDeathDate,
	SecondaryBrainDeathTime,
	SecondaryDNRDate,
	SecondaryERORDeath,
	SecondaryEMSArrivalToPatientDate,
	SecondaryEMSArrivalToPatientTime,
	SecondaryEMSArrivalToHospitalDate,
	SecondaryEMSArrivalToHospitalTime,
	SecondaryPatientTerminal,
	SecondaryDeathWitnessed,
	SecondaryDeathWitnessedBy,
	SecondaryLSADate,
	SecondaryLSATime,
	SecondaryLSABy,
	SecondaryACLSProvided,
	SecondaryACLSProvidedTime,
	SecondaryGestationalAge,
	SecondaryParentName1,
	SecondaryParentName2,
	SecondaryBirthCBO,
	SecondaryActiveInfection,
	SecondaryActiveInfectionType,
	SecondaryFluidsGiven,
	SecondaryBloodLoss,
	SecondarySignOfInfection,
	SecondaryMedication,
	SecondaryAntibiotic,
	SecondaryPCPName,
	SecondaryPCPPhone,
	SecondaryMDAttending,
	SecondaryMDAttendingPhone,
	REPLACE(REPLACE(SecondaryPhysicalAppearance,  CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryPhysicalAppearance,
	SecondaryInternalBloodLossCC,
	SecondaryExternalBloodLossCC,
	SecondaryBloodProducts,
	SecondaryColloidsInfused,
	SecondaryCrystalloids,
	SecondaryPreTransfusionSampleRequired,
	SecondaryPreTransfusionSampleAvailable,
	SecondaryPreTransfusionSampleDrawnDate,
	SecondaryPreTransfusionSampleDrawnTime,
	SecondaryPreTransfusionSampleQuantity,
	SecondaryPreTransfusionSampleHeldAt,
	SecondaryPreTransfusionSampleHeldDate,
	SecondaryPreTransfusionSampleHeldTime,
	SecondaryPreTransfusionSampleHeldTechnician,
	SecondaryPostMordemSampleTestSuitable,
	SecondaryPostMordemSampleLocation,
	SecondaryPostMordemSampleContact,
	SecondaryPostMordemSampleCollectionDate,
	SecondaryPostMordemSampleCollectionTime,
	REPLACE(REPLACE(SecondarySputumCharacteristics, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySputumCharacteristics,
	SecondaryNOKAltPhone,
	SecondaryNOKLegal,
	SecondaryNOKAltContact,
	SecondaryNOKAltContactPhone,
	SecondaryNOKPostMortemAuthorization,
	SecondaryNOKPostMortemAuthorizationReminder,
	SecondaryCoronerCaseNumber,
	SecondaryCoronerCounty,
	SecondaryCoronerReleased,
	REPLACE(REPLACE(SecondaryCoronerReleasedStipulations, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCoronerReleasedStipulations,
	case when SecondaryAutopsy = -1 then null else SecondaryAutopsy end AS SecondaryAutopsy,
	SecondaryAutopsyDate,
	SecondaryAutopsyTime,
	case when SecondaryAutopsyLocation = -1 then null else SecondaryAutopsyLocation end AS SecondaryAutopsyLocation,
	SecondaryAutopsyBloodRequested,
	SecondaryAutopsyCopyRequested,
	SecondaryFuneralHomeSelected,
	SecondaryFuneralHomeName,
	SecondaryFuneralHomePhone,
	SecondaryFuneralHomeAddress,
	SecondaryFuneralHomeContact,
	SecondaryFuneralHomeNotified,
	SecondaryFuneralHomeMorgueCooled,
	SecondaryHoldOnBody,
	SecondaryHoldOnBodyTag,
	SecondaryBodyRefrigerationDate,
	SecondaryBodyRefrigerationTime,
	SecondaryBodyLocation,
	SecondaryBodyMedicalChartLocation,
	SecondaryBodyIDTagLocation,
	SecondaryBodyCoolingMethod,
	SecondaryUNOSNumber,
	SecondaryClientNumber,
	SecondaryCryolifeNumber,
	SecondaryMTFNumber,
	SecondaryLifeNetNumber,
	REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText,
	SecondaryHistorySubstanceAbuse,
	REPLACE(REPLACE(SecondarySubstanceAbuseDetail, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondarySubstanceAbuseDetail,
	SecondaryExtubationDate,
	SecondaryExtubationTime,
	SecondaryAutopsyReminderYN,
	SecondaryFHReminderYN,
	SecondaryBodyCareReminderYN,
	SecondaryWrapUpReminderYN,
	SecondaryNOKNotifiedBy,
	SecondaryNOKNotifiedDate,
	SecondaryNOKNotifiedTime,
	SecondaryNOKGender,
	SecondaryCODOther,
	SecondaryAutopsyLocationOther,
	SecondaryPatientHospitalPhone,
	SecondaryCoronerCase,
	case when SecondaryPatientABO = -1 then null else SecondaryPatientABO end AS SecondaryPatientABO,
	SecondaryPatientSuffix,
	case when SecondaryMDAttendingId = -1 then null else SecondaryMDAttendingId end AS SecondaryMDAttendingId,
	REPLACE(REPLACE(SecondaryAdditionalComments,  CHAR(10),  CHAR(32)),  CHAR(13),  '') AS SecondaryAdditionalComments,
	case when SecondaryRhythm = -1 then null else SecondaryRhythm end AS SecondaryRhythm,
	REPLACE(REPLACE(SecondaryAdditionalMedications,  CHAR(10),  CHAR(32)),  CHAR(13),  '') AS SecondaryAdditionalMedications,
	SecondaryBodyHoldPlaced,
	SecondaryBodyHoldPlacedWith,
	SecondaryBodyFutureContact,
	SecondaryBodyHoldPhone,
	case when SecondaryBodyHoldInstructionsGiven = -1 then null else SecondaryBodyHoldInstructionsGiven end AS SecondaryBodyHoldInstructionsGiven,
	SecondarySteroid,
	SecondaryBodyHoldPlacedTime,
	SecondaryAntibiotic1Name,
	SecondaryAntibiotic1Dose,
	SecondaryAntibiotic1StartDate,
	SecondaryAntibiotic1EndDate,
	SecondaryAntibiotic2Name,
	SecondaryAntibiotic2Dose,
	SecondaryAntibiotic2StartDate,
	SecondaryAntibiotic2EndDate,
	SecondaryAntibiotic3Name,
	SecondaryAntibiotic3Dose,
	SecondaryAntibiotic3StartDate,
	SecondaryAntibiotic3EndDate,
	SecondaryAntibiotic4Name,
	SecondaryAntibiotic4Dose,
	SecondaryAntibiotic4StartDate,
	SecondaryAntibiotic4EndDate,
	SecondaryAntibiotic5Name,
	SecondaryAntibiotic5Dose,
	SecondaryAntibiotic5StartDate,
	SecondaryAntibiotic5EndDate,
	case when SecondaryBloodProductsReceived1Type = -1 then null else SecondaryBloodProductsReceived1Type end AS SecondaryBloodProductsReceived1Type,
	SecondaryBloodProductsReceived1Units,
	SecondaryBloodProductsReceived1TypeCC,
	SecondaryBloodProductsReceived1TypeUnitGiven,
	case when SecondaryBloodProductsReceived2Type = -1 then null else SecondaryBloodProductsReceived2Type end AS SecondaryBloodProductsReceived2Type,
	SecondaryBloodProductsReceived2Units,
	SecondaryBloodProductsReceived2TypeCC,
	SecondaryBloodProductsReceived2TypeUnitGiven,
	case when SecondaryBloodProductsReceived3Type = -1 then null else SecondaryBloodProductsReceived3Type end AS SecondaryBloodProductsReceived3Type,
	SecondaryBloodProductsReceived3Units,
	SecondaryBloodProductsReceived3TypeCC,
	SecondaryBloodProductsReceived3TypeUnitGiven,
	case when SecondaryColloidsInfused1Type = -1 then null else SecondaryColloidsInfused1Type end AS SecondaryColloidsInfused1Type,
	SecondaryColloidsInfused1Units,
	SecondaryColloidsInfused1CC,
	SecondaryColloidsInfused1UnitGiven,
	case when SecondaryColloidsInfused2Type = -1 then null else SecondaryColloidsInfused2Type end AS SecondaryColloidsInfused2Type,
	SecondaryColloidsInfused2Units,
	SecondaryColloidsInfused2CC,
	SecondaryColloidsInfused2UnitGiven,
	case when SecondaryColloidsInfused3Type = -1 then null else SecondaryColloidsInfused3Type end AS SecondaryColloidsInfused3Type,
	SecondaryColloidsInfused3Units,
	SecondaryColloidsInfused3CC,
	SecondaryColloidsInfused3UnitGiven,
	case when SecondaryCrystalloids1Type = -1 then null else SecondaryCrystalloids1Type end AS SecondaryCrystalloids1Type,
	SecondaryCrystalloids1Units,
	SecondaryCrystalloids1CC,
	SecondaryCrystalloids1UnitGiven,
	case when SecondaryCrystalloids2Type = -1 then null else SecondaryCrystalloids2Type end AS SecondaryCrystalloids2Type,
	SecondaryCrystalloids2Units,
	SecondaryCrystalloids2CC,
	SecondaryCrystalloids2UnitGiven,
	case when SecondaryCrystalloids3Type = -1 then null else SecondaryCrystalloids3Type end AS SecondaryCrystalloids3Type,
	SecondaryCrystalloids3Units,
	SecondaryCrystalloids3CC,
	SecondaryCrystalloids3UnitGiven,
	SecondaryWBC1Date,
	SecondaryWBC1,
	SecondaryWBC1Bands,
	SecondaryWBC2Date,
	SecondaryWBC2,
	SecondaryWBC2Bands,
	SecondaryWBC3Date,
	SecondaryWBC3,
	SecondaryWBC3Bands,
	SecondaryLabTemp1,
	SecondaryLabTemp1Date,
	SecondaryLabTemp1Time,
	SecondaryLabTemp2,
	SecondaryLabTemp2Date,
	SecondaryLabTemp2Time,
	SecondaryLabTemp3,
	SecondaryLabTemp3Date,
	SecondaryLabTemp3Time,
	case when SecondaryCulture1Type = -1 then null else SecondaryCulture1Type end AS SecondaryCulture1Type,
	SecondaryCulture1Other,
	SecondaryCulture1DrawnDate,
	SecondaryCulture1Growth,
	case when SecondaryCulture2Type = -1 then null else SecondaryCulture2Type end AS SecondaryCulture2Type,
	SecondaryCulture2Other,
	SecondaryCulture2DrawnDate,
	SecondaryCulture2Growth,
	case when SecondaryCulture3Type = -1 then null else SecondaryCulture3Type end AS SecondaryCulture3Type,
	SecondaryCulture3Other,
	SecondaryCulture3DrawnDate,
	SecondaryCulture3Growth,
	SecondaryCXRAvailable,
	SecondaryCXR1Date,
	REPLACE(REPLACE(SecondaryCXR1Finding, CHAR(10),  CHAR(32)), CHAR(13), '') AS SecondaryCXR1Finding,  
	SecondaryCXR2Date,
	REPLACE(REPLACE(SecondaryCXR2Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR2Finding,
	SecondaryCXR3Date,
	REPLACE(REPLACE(SecondaryCXR3Finding, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCXR3Finding,
	SecondaryAntibiotic1NameOther,
	SecondaryAntibiotic2NameOther,
	SecondaryAntibiotic3NameOther,
	SecondaryAntibiotic4NameOther,
	SecondaryAntibiotic5NameOther,
	SecondaryBloodProductsReceived1TypeOther,
	SecondaryBloodProductsReceived2TypeOther,
	SecondaryBloodProductsReceived3TypeOther,
	SecondaryColloidsInfused1TypeOther,
	SecondaryColloidsInfused2TypeOther,
	SecondaryColloidsInfused3TypeOther,
	SecondaryCrystalloids1TypeOther,
	SecondaryCrystalloids2TypeOther,
	SecondaryCrystalloids3TypeOther,
	case when SecondaryApproached = -1 then null else SecondaryApproached end AS SecondaryApproached,
	case when SecondaryApproachedBy = -1 then null else SecondaryApproachedBy end AS SecondaryApproachedBy,
	case when SecondaryApproachType = -1 then null else SecondaryApproachType end AS SecondaryApproachType,
	case when SecondaryApproachOutcome = -1 then null else SecondaryApproachOutcome end AS SecondaryApproachOutcome,
	case when SecondaryApproachReason = -1 then null else SecondaryApproachReason end AS SecondaryApproachReason,
	case when SecondaryConsented = -1 then null else SecondaryConsented end AS SecondaryConsented,
	case when SecondaryConsentBy = -1 then null else SecondaryConsentBy end AS SecondaryConsentBy,
	SecondaryConsentOutcome,
	SecondaryConsentResearch,
	SecondaryRecoveryLocation,
	SecondaryHospitalApproach,
	case when SecondaryHospitalApproachedBy = -1 then null else SecondaryHospitalApproachedBy end AS SecondaryHospitalApproachedBy,
	case when SecondaryHospitalOutcome = -1 then null else SecondaryHospitalOutcome end AS SecondaryHospitalOutcome,
	case when SecondaryConsentMedSocPaperwork = -1 then null else SecondaryConsentMedSocPaperwork end AS SecondaryConsentMedSocPaperwork,
	case when SecondaryConsentMedSocObtainedBy = -1 then null else SecondaryConsentMedSocObtainedBy end AS SecondaryConsentMedSocObtainedBy,
	SecondaryConsentFuneralPlans,
	SecondaryConsentFuneralPlansOther,
	SecondaryConsentLongSleeves ,
	Referral.LastModified ,
 	CASE Referral.ReferralDOB_ILB WHEN -1 Then  1 ELSE 0 END AS ReferralDonor_ILB,
	REPLACE(REPLACE(ReferralDonorSpecificCOD, CHAR(10), CHAR(32)), CHAR(13), '') AS ReferralDonorSpecificCOD,
	ReferralDonorBrainDeathDate,
	ReferralDonorBrainDeathTime,
	ReferralAttendingMDPhone,
	ReferralPronouncingMDPhone,
	CurrentReferralTypeID,
	REPLACE(REPLACE(ReferralNotesCase, CHAR(10), CHAR(32)), CHAR(13), '') AS MedicalHistory, 
	NOK.NOKFirstName, 
	NOK.NOKLastName, 
	NOK.NOKCity, 
	ST.StateAbbrv AS NOKState, 
	NOK.NOKZip, 
	Referral.ReferralDonorNameMI , 
	'' AS CoronorsCase,
	Case When ReferralNOKID is not null THEN LEFT( REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '')  , 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS ReferralNOKAddress, 
	CAST(ReferralDonorWeight as varchar(6)) AS PatientWeight_Decimal,
	STBI.SecondaryTBINumber TBINumber,
	CASE STBI.SecondaryTBIAssignmentNotNeeded WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS TBINotNeeded,
	STBI.SecondaryTBIComment TBIComment,
	ReferralDonorLSADate,
	ReferralDonorLSATime,
	CASE WHEN (LEN(ReferralExtubated) - LEN(REPLACE(ReferralExtubated, '/', ''))) = 2								-- Check to make sure there are 2 '/' chars
		THEN
			TRY_CONVERT(DATE, ReferralExtubated)																	-- Convert string to date (catches invalid dates)
		ELSE
			NULL
		END
		AS ReferralExtubatedDate,
	CASE WHEN CHARINDEX(':', ReferralExtubated) > 0																	-- Make sure there's a ':' char
		THEN
			(TRY_CONVERT(VARCHAR(5), TRY_CONVERT(DATETIME, ReferralExtubated), 108) + ' ' + TimeZoneAbbreviation)	-- Convert string to datetime, then to hh:mm varchar format to get time component and to catch invalid times
		ELSE
			NULL
		END
		AS ReferralExtubatedTime

	
	FROM 
		Referral 
	JOIN 
		Call ON Call.CallID = Referral.CallID 
	LEFT JOIN 
		CallCriteria ON Call.CallID = CallCriteria.CallID 
	LEFT JOIN
		ServiceLevel On CallCriteria.ServiceLevelID = ServiceLevel.ServiceLevelID 		
	LEFT JOIN 
		ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID 
	LEFT JOIN 
		StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
	LEFT JOIN 
		Person AS CallerPerson ON CallerPerson.PersonID = Referral.ReferralCallerPersonID 
	LEFT JOIN 
		PersonType ON PersonType.PersonTypeID = CallerPerson.PersonTypeID 
	LEFT JOIN 
		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN
		TimeZone ON TimeZone.TimeZoneID = Organization.TimeZoneID
	LEFT JOIN 
		Phone ON Phone.PhoneID = Referral.ReferralCallerPhoneID 
	LEFT JOIN 
		SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID 
	LEFT JOIN 
		SubLocationLevel ON ReferralCallerLevelID = SubLocationLevelID 
	LEFT JOIN 
		Race ON Race.RaceID = ReferralDonorRaceID 
	LEFT JOIN 
		CauseOfDeath ON CauseOfDeathID = ReferralDonorCauseOfDeathID 
	LEFT JOIN 
		ApproachType ON ApproachTypeID=ReferralApproachTypeID 
	LEFT JOIN 
		Person AS ApproachPerson ON ReferralApproachedByPersonID = ApproachPerson.PersonID 
	LEFT JOIN 
		Organization ME ON ME.OrganizationName = Referral.ReferralCoronerOrganization 
	LEFT JOIN 
		COUNTY CTY ON CTY.CountyID = ME.CountyID 
	LEFT JOIN 
		CallCustomField on CallCustomField.CallID = Referral.CallID 
	LEFT JOIN 
		ServiceLevel30Organization ON ServiceLevel30Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN 
		ServiceLevelSourceCode ON ServiceLevelSourceCode.ServiceLevelID = ServiceLevel.ServiceLevelID 
		AND ServiceLevelSourceCode.SourceCodeID = Call.SourceCodeID 
	LEFT JOIN 
		ServiceLevelCustomField ON ServiceLevelCustomField.ServiceLevelID = ServiceLevelSourceCode.ServiceLevelID 
	LEFT JOIN 
		RegistryStatus ON RegistryStatus.CallID = Referral.CallID 
	LEFT JOIN
		RegistryStatusType ON RegistryStatusType.ID = RegistryStatus.RegistryStatus 
	LEFT JOIN 
		Person AS AttendingMD ON AttendingMD.PersonID = Referral.ReferralAttendingMD 
	LEFT JOIN 
		Person AS PronouncingMD ON PronouncingMD.PersonID = Referral.ReferralPronouncingMD
 	LEFT JOIN 
 		Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCallerOrganizationID 
	LEFT JOIN 
		State AS CoronerST ON CoronerST.StateID = CoronerOrg.StateID 
	LEFT JOIN 
		NOK on Referral.ReferralNOKID = NOK.NOKID 
	LEFT JOIN 
		State AS ST on NOK.NOKStateID = ST.StateID	
	LEFT JOIN 
		Secondary on Secondary.CallID = Call.CallID 
	LEFT JOIN 
		Secondary2 on Secondary2.CallID = Call.CallID 
	LEFT JOIN 
		SecondaryApproach on SecondaryApproach.CallID = Call.CallID 
	LEFT JOIN 
		FSCase on FSCase.CallID = Call.CallID 
		
	LEFT JOIN
		SecondaryTBI STBI ON STBI.CallID = Call.CallID			
	WHERE 
		Call.CallID IN (
						SELECT CallID FROM ExportFileQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0)
						UNION
						SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 0				
						)		
	AND 
		Call.CallID NOT IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 1)				
	ORDER BY ReferralID		

GO
