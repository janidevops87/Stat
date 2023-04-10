IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_rpt_ReferralDetail_Secondary_Select]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping Procedure sps_rpt_ReferralDetail_Secondary_Select'
	DROP PROCEDURE [dbo].[sps_rpt_ReferralDetail_Secondary_Select];
END
GO

PRINT 'Creating Procedure sps_rpt_ReferralDetail_Secondary_Select'
GO


CREATE PROCEDURE [dbo].[sps_rpt_ReferralDetail_Secondary_Select]
     @CallID            int          = null,
     @DisplayMT			int			 = null

AS
/******************************************************************************
**		File: sps_rpt_ReferralDetail_Secondary_Select.sql
**		Name: sps_rpt_ReferralDetail_Secondary_Select
**		Desc:	This stored procedure returns Secondary Information to 
**				ReferralDetail_Secondary report where @CallID and @TZ values are 
**				returned from sps_rpt_ReferralDetail_Triage
**              
**		Return values:
** 
**		Called by: ReferralDetail_Secondary_Select.rdl
**		Parent Report: ReferralDetail.rdl
		Parent Sproc: sps_rpt_ReferralDetail_Triage   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**      @CallID         int
**      @TZ				varchar(2)
**
**		Auth: christopher carroll  
**		Date: 03/27/2007
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		6/20/2007		ccarroll				Initial release  
**		11/14/2007		ccarroll				removed @TZ ref
**		10/02/2008		ccarroll				Added select sproc for Archive and Production db
**		02/24/2011		jegerberich				Added COALESCE to CultureTypes
**		03/03/2011		jegerberich				Added -1 as a 'Yes' value for YNBodyHoldInstructionsGiven
**												logic and switched to IN statement.  VS 9396
**		09/09/2019		mberenson				Added IsNull check to logic for ProductType 1, 2, and 3
**		05/14/2019		jegerberich				Account for NULL NOK information. VS 66070
**		10/04/2019		jegerberich				Account for 'other' Colloid and Crystalloid products VS 67259
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/* Secondary Information */

     SELECT
     FSCase.CallID,
	/* Case Management */
	FSCase.FSCaseOpenDateTime,
		ISNULL(CaseOpenPerson.PersonFirst, '') + ' ' + ISNULL(CaseOpenPerson.PersonLast, '') AS 'CaseOpenBy',
	FSCase.FSCaseSysEventsDateTime,
		ISNULL(CaseSystemEventsPerson.PersonFirst, '') + ' ' + ISNULL(CaseSystemEventsPerson.PersonLast, '') AS 'CaseEventsBy',
	FSCase.FSCaseSecCompDateTime,
		ISNULL(CaseCompletePerson.PersonFirst, '') + ' ' + ISNULL(CaseCompletePerson.PersonLast, '') AS 'CaseCompleteBy',
	FSCase.FSCaseApproachDateTime,
		ISNULL(CaseApproachPerson.PersonFirst, '') + ' ' + ISNULL(CaseApproachPerson.PersonLast, '') AS 'CaseApproachBy',
	FSCase.FSCaseFinalDateTime,
		ISNULL(CaseFinalPerson.PersonFirst, '') + ' ' + ISNULL(CaseFinalPerson.PersonLast, '') AS 'CaseFinalBy',
	FSCase.FSCaseBillDateTime,
		ISNULL(CaseBillSecondaryPerson.PersonFirst, '') + ' ' + ISNULL(CaseBillSecondaryPerson.PersonLast, '') AS 'CaseBillSecondaryBy',
	FSCase.FSCaseBillOTEDateTime,
		ISNULL(CaseBillOTEPerson.PersonFirst, '') + ' ' + ISNULL(CaseBillOTEPerson.PersonLast, '') AS 'CaseBillOTEBy',
	FSCase.FSCaseBillFamUnavailDateTime,
		ISNULL(CaseBillFamUnavailPerson.PersonFirst, '') + ' ' + ISNULL(CaseBillFamUnavailPerson.PersonLast, '') AS 'CaseBillFamUnavailBy',
	FSCase.FSCaseBillApproachDateTime,
		ISNULL(CaseBillFamApproachPerson.PersonFirst, '') + ' ' + ISNULL(CaseBillFamApproachPerson.PersonLast, '') AS 'CaseBillFamApproachBy',
		FSCase.FSCaseBillApproachCount,
	FSCase.FSCaseBillMedSocDateTime,
		ISNULL(CaseBillMedSocPerson.PersonFirst, '') + ' ' + ISNULL(CaseBillMedSocPerson.PersonLast, '') AS 'CaseBillMedSocBy',
		FSCase.FSCaseBillMedSocCount,
	FSCase.FSCaseBillCryoFormDateTime,
		ISNULL(CaseBillCryoFormPerson.PersonFirst, '') +' ' + ISNULL(CaseBillCryoFormPerson.PersonLast, '') AS 'CaseBillCryoFormBy',
		FSCase.FSCaseBillCryoFormCount,

	/* Case Information */	
	YNNOKAware.YesNoNa_RefName AS 'NOK_Notified',
	Secondary.SecondaryNOKNotifiedBy,
	Secondary.SecondaryNOKNotifiedDate,
	Secondary.SecondaryNOKNotifiedTime,
	Secondary.SecondaryEstTimeSinceLeft,
	Secondary.SecondaryTimeLeftInMT,
	YNFamInterest.YesNoNa_RefName AS 'SecondaryFamilyInterested',
	YNFamConsent.YesNoNa_RefName AS 'SecondaryFamilyConsent',
	YNNOKAtHospital.YesNoNa_RefName AS 'SecondaryNOKAtHospital',
	Secondary.SecondaryNOKNextDest,
	Secondary.SecondaryNOKETA,

	/* Hospital Information */	
	Organization.OrganizationName AS 'HospitalName',
	SubLocation.SubLocationName AS 'Unit',
	Referral.ReferralCallerSubLocationLevel AS 'Floor',
	Referral.ReferralDonorRecNumber AS 'MedicalRecord',
	ISNULL(CallerPerson.PersonFirst, '') + ' ' + ISNULL(CallerPerson.PersonLast, '') AS 'ContactName',
	CallerPersonType.PersonTypeName AS 'Title',
	'(' + ISNULL(CallerPersonPhone.PhoneAreaCode, '') + ')' + ISNULL(CallerPersonPhone.PhonePrefix, '') + '-' + ISNULL(CallerPersonPhone.PhoneNumber, '') AS 'GivenPhone',

	/* Patient Information */
	Referral.ReferralDonorFirstName,
	Secondary.SecondaryPatientMiddleName,
	Referral.ReferralDonorLastName,
	Secondary.SecondaryPatientSuffix,
	ABORef.ABORefName AS 'ABO',
	Referral.ReferralDonorSSN,
	CONVERT(VARCHAR, ReferralDOB,101) AS 'DateOfBirth',
	Referral.ReferralDonorAge + LOWER(SUBSTRING(Referral.ReferralDonorAgeUnit,1,1)) + ' / ' + Referral.ReferralDonorGender + ' / ' + ISNULL(UPPER(SUBSTRING(race.RaceName,1,2)),'') AS 'A/S/R',
	Referral.ReferralDonorWeight AS 'DonorWeight',
	ISNULL(Secondary.SecondaryPatientHeightFeet, '0') + 'ft' + ' ' + ISNULL(Secondary.SecondaryPatientHeightInches, '0') + 'in' AS 'Height',
	Secondary.SecondaryPatientBMICalc AS 'BMI',

	/* DOD_COD_PCP_Attending */
        ISNULL(CONVERT(VARCHAR,  Referral.ReferralDonorDeathDate, 101), '') + ' ' + ISNULL(Referral.ReferralDonorDeathTime, '') AS 'CardiacDeathDT',
        ISNULL(CONVERT(VARCHAR,  Referral.ReferralDonorBrainDeathDate, 101), '') + ' ' + ISNULL(Referral.ReferralDonorBrainDeathTime, '') AS 'BrainDeathDT',
		Secondary.SecondaryPCPName,
		Secondary.SecondaryPCPPhone,
		FSCOD.FS_CauseOfDeathName,
		Secondary.SecondaryCODSignatory,
		ISNULL(SecondaryMDAttending.PersonLast, '') + CASE WHEN SecondaryMDAttending.PersonLast IS NOT NULL AND SecondaryMDAttending.PersonFirst IS NOT NULL THEN ', ' ELSE '' END + ISNULL(SecondaryMDAttending.PersonFirst, '') AS 'AttendingMD',
        Secondary.SecondaryMDAttendingPhone,

	/* Medical History */	
		Referral.ReferralDonorOnVentilator AS 'PatientVentilated',
		Secondary.SecondaryCircumstanceOfDeath AS 'DeathCircumstances',
		YNSubstanceAbuse.YesNoNa_RefName AS 'SubstanceAbuse',
		Secondary.SecondaryPhysicalAppearance,

		YNSignsOfInfection.YesNoNa_RefName AS 'SignsOfInfection',
		Secondary.SecondaryMedicalHistory,
		Secondary.SecondarySubstanceAbuseDetail,
		Secondary.SecondaryAdditionalComments,

		/* Admit */	
		Secondary.SecondaryAdmissionDiagnosis,
		ISNULL(CONVERT(VARCHAR, Referral.ReferralDonorAdmitDate,101), '') + ' ' + ISNULL(Referral.ReferralDonorAdmitTime, '') AS 'AdmitDT',
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryDNRDate,101), '') AS SecondaryDNRDate,
		YNDeathWitnessed.YesNoNa_RefName AS 'DeathWitnessed',
		Secondary.SecondaryDeathWitnessedBy,
		Rhythm.RhythmName AS 'RhythmWhenFound',
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryLSADate,101), '') + ' ' + ISNULL(Secondary.SecondaryLSATime, '') AS 'SecondaryLSADT',
		ISNULL(Secondary.SecondaryEMSArrivalToPatientTime, '') AS 'SecondaryEMSArrivalToPatientTime',
		ISNULL(Secondary.SecondaryEMSArrivalToHospitalTime, '') AS 'SecondaryEMSArrivalToHospitalTime',

		/* Medications */	
		YNMedication.YesNoNa_RefName AS 'Medications',
		--For medications list, see sps_rpt_medicationsList
		Secondary.SecondaryAdditionalMedications,

		/* Antibiotics */
		YNAntibiotic.YesNoNa_RefName AS 'Antibiotics',
		--For Antibiotics list, see sps_rpt_medicationOtherList

		/* Steroids */
		YNSteroid.YesNoNa_RefName AS 'Steroids',
		--For Steroids list, see sps_rpt_medicationOtherList

		/* Blood Loss */
		Secondary.SecondaryInternalBloodLossCC,	
		Secondary.SecondaryExternalBloodLossCC,

		/* Blood Products */
		YNBloodProducts.YesNoNa_RefName AS 'BloodProducts',
		ISNULL( BloodProduct1.BloodProductName, Secondary2.SecondaryBloodProductsReceived1TypeOther ) AS 'Product1Type',
		Secondary2.SecondaryBloodProductsReceived1Units,
		Secondary2.SecondaryBloodProductsReceived1TypeCC,
		Secondary2.SecondaryBloodProductsReceived1TypeUnitGiven,

		ISNULL(BloodProduct2.BloodProductName, Secondary2.SecondaryBloodProductsReceived2TypeOther )  AS 'Product2Type',
		Secondary2.SecondaryBloodProductsReceived2Units,
		Secondary2.SecondaryBloodProductsReceived2TypeCC,
		Secondary2.SecondaryBloodProductsReceived2TypeUnitGiven,

		ISNULL(BloodProduct3.BloodProductName, Secondary2.SecondaryBloodProductsReceived3TypeOther )  AS 'Product3Type',
		Secondary2.SecondaryBloodProductsReceived3Units,
		Secondary2.SecondaryBloodProductsReceived3TypeCC,
		Secondary2.SecondaryBloodProductsReceived3TypeUnitGiven,

		/* Colloids */
		YNColloidsInfused.YesNoNa_RefName AS 'ColloidsInfused',		
		ISNULL(ColloidsInfused1.BloodProductName, SecondaryColloidsInfused1TypeOther)  AS 'ColloidsInfused1Type',		
		Secondary2.SecondaryColloidsInfused1Units,
		Secondary2.SecondaryColloidsInfused1CC,
		Secondary2.SecondaryColloidsInfused1UnitGiven,

		ISNULL(ColloidsInfused2.BloodProductName, SecondaryColloidsInfused2TypeOther) AS 'ColloidsInfused2Type',		
		Secondary2.SecondaryColloidsInfused2Units,		
		Secondary2.SecondaryColloidsInfused2CC,
		Secondary2.SecondaryColloidsInfused2UnitGiven,	
		
		ISNULL(ColloidsInfused3.BloodProductName, SecondaryColloidsInfused3TypeOther) AS 'ColloidsInfused3Type',
		Secondary2.SecondaryColloidsInfused3Units,
		Secondary2.SecondaryColloidsInfused3CC,
		Secondary2.SecondaryColloidsInfused3UnitGiven,

		/* Crystalloids */
		YNCrystalloids.YesNoNa_RefName AS 'Crystalloids',		
		ISNULL(Crystalloids1.BloodProductName, SecondaryCrystalloids1TypeOther) AS 'Crystalloids1Type',		
		Secondary2.SecondaryCrystalloids1Units,
		Secondary2.SecondaryCrystalloids1CC,
		Secondary2.SecondaryCrystalloids1UnitGiven,

		ISNULL(Crystalloids2.BloodProductName, SecondaryCrystalloids2TypeOther) AS 'Crystalloids2Type',		
		Secondary2.SecondaryCrystalloids2Units,
		Secondary2.SecondaryCrystalloids2CC,
		Secondary2.SecondaryCrystalloids2UnitGiven,

		ISNULL(Crystalloids3.BloodProductName, SecondaryCrystalloids3UnitGiven) AS 'Crystalloids3Type',		
		Secondary2.SecondaryCrystalloids3Units,
		Secondary2.SecondaryCrystalloids3CC,
		Secondary2.SecondaryCrystalloids3UnitGiven,

		/* Pre-Transfusion Blood Sample */
		YNPreTransRequired.YesNoNa_RefName AS 'PreTransRequired',
		Secondary.SecondaryPreTransfusionSampleHeldAt,
		YNPreTransAvailable.YesNoNa_RefName AS 'PreTransAvailable',
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryPreTransfusionSampleDrawnDate,101), '') + ' ' + ISNULL(Secondary.SecondaryPreTransfusionSampleDrawnTime, '') AS SecondaryPreTransfusionSampleDrawnDT,
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryPreTransfusionSampleHeldDate,101), '') + ' ' + ISNULL(Secondary.SecondaryPreTransfusionSampleHeldTime, '') AS SecondaryPreTransfusionSampleHeldDT,
		--Secondary.SecondaryPreTransfusionSampleDrawnDate,
		Secondary.SecondaryPreTransfusionSampleHeldTechnician,
		Secondary.SecondaryPreTransfusionSampleQuantity,

		/* Post Mortem Blood Sample */
		YNPostMordemTestSuitable.YesNoNa_RefName AS 'PostMordemTestSuitable',
		Secondary.SecondaryPostMordemSampleContact,
		Secondary.SecondaryPostMordemSampleLocation,
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryPostMordemSampleCollectionDate,101), '') + ' ' + ISNULL(Secondary.SecondaryPostMordemSampleCollectionTime, '') AS 'PostMordemCollectionDT',

		/* WBC */
		Secondary2.SecondaryWBC1,
		CONVERT(VARCHAR, Secondary2.SecondaryWBC1Date,101) AS 'SecondaryWBC1Date',
		Secondary2.SecondaryWBC1Bands,

		Secondary2.SecondaryWBC2,
		CONVERT(VARCHAR, Secondary2.SecondaryWBC2Date,101) AS 'SecondaryWBC2Date',
		Secondary2.SecondaryWBC2Bands,

		Secondary2.SecondaryWBC3,
		CONVERT(VARCHAR, Secondary2.SecondaryWBC3Date,101) AS 'SecondaryWBC3Date',
		Secondary2.SecondaryWBC3Bands,

		/* Temperature */
		ISNULL(CONVERT(VARCHAR, Secondary2.SecondaryLabTemp1Date,101), '') + ' ' + ISNULL(Secondary2.SecondaryLabTemp1Time, '') AS 'SecondaryLabTemp1DT',
		Secondary2.SecondaryLabTemp1,
		ISNULL(CONVERT(VARCHAR, Secondary2.SecondaryLabTemp2Date,101), '') + ' ' + ISNULL(Secondary2.SecondaryLabTemp2Time, '') AS 'SecondaryLabTemp2DT',
		Secondary2.SecondaryLabTemp2,
		ISNULL(CONVERT(VARCHAR, Secondary2.SecondaryLabTemp3Date,101), '') + ' ' + ISNULL(Secondary2.SecondaryLabTemp3Time, '') AS 'SecondaryLabTemp3DT',
		Secondary2.SecondaryLabTemp3,

		/* Culture */
		COALESCE(Culture1.CultureName, Secondary2.SecondaryCulture1Other) AS 'Culture1Type',
		SecondaryCulture1DrawnDate,
		SecondaryCulture1Growth,

		COALESCE(Culture2.CultureName, Secondary2.SecondaryCulture2Other) AS 'Culture2Type',
		SecondaryCulture2DrawnDate,
		SecondaryCulture2Growth,

		COALESCE(Culture3.CultureName, Secondary2.SecondaryCulture3Other) AS 'Culture3Type',
		SecondaryCulture3DrawnDate,
		SecondaryCulture3Growth,
		Secondary.SecondarySputumCharacteristics,

		/* CXR */
		YNCXRAvailable.YesNoNa_RefName AS 'CXRAvailable',
		CONVERT(VARCHAR, SecondaryCXR1Date,101) AS 'SecondaryCXR1Date',
		SecondaryCXR1Finding,
		CONVERT(VARCHAR, SecondaryCXR2Date,101) AS 'SecondaryCXR2Date',
		SecondaryCXR2Finding,
		CONVERT(VARCHAR, SecondaryCXR3Date,101) AS 'SecondaryCXR3Date',
		SecondaryCXR3Finding,

		/* Next of Kin */
		Case When ReferralNOKID > 0 THEN LEFT(REPLACE(REPLACE(IsNULL(NOK.NOKFirstName,'') + IsNULL(' ' + NOK.NOKLastName,''),CHAR(10), CHAR(32)), CHAR(13), ''),50) ELSE ReferralApproachNOK END AS ReferralApproachNOK, 
		CASE WHEN ReferralNOKID > 0 THEN NOK.NOKApproachRelation ELSE ReferralApproachRelation END AS ReferralApproachRelation, 
		Secondary.SecondaryNOKGender,
		CASE WHEN ReferralNOKID > 0 THEN NOK.NOKPhone ELSE ReferralNOKPhone END AS ReferralNOKPhone,
		SecondaryNOKAltPhone, 
		CASE WHEN ReferralNOKID > 0 THEN Referral.ReferralNOKAddress  END AS 'ReferralNOKAddress', 
		CASE WHEN ReferralNOKID > 0 THEN IsNULL(NOK.NOKCity,'') + IsNULL(', ' + st.StateAbbrv,'') + IsNULL(' ' + NOK.NOKZip,'') end AS ReferralNOKCSZ,
		--Case When ReferralNOKID > 0 THEN LEFT(REPLACE(REPLACE(Referral.ReferralNOKAddress + ' ' + NOK.NOKCity + ' ' + st.StateAbbrv + ' ' + NOK.NOKZip, CHAR(10), CHAR(32)), CHAR(13), ''), 255) ELSE REPLACE(REPLACE(Referral.ReferralNOKAddress, CHAR(10), CHAR(32)), CHAR(13), '') END AS ReferralNOKAddress,
		YNNOKLegal.YesNoNa_RefName AS 'SecondaryNOKLegal',

		/* NOK - Alternate Contact */
		SecondaryNOKAltContact,
		SecondaryNOKAltContactPhone,

		/* NOK Post Mortem */
		YNNOKExamAuthorized.YesNoNa_RefName AS 'SecondaryNOKExamAuthorized',
		SecondaryNOKPostMortemAuthorizationReminder,

		/* Coroner */
		YNCoronerCase.YesNoNa_RefName AS 'SecondaryCoronerCase',
		Secondary.SecondaryCoronerCaseNumber,
		ReferralCoronerOrgID,
		CoronerState.StateAbbrv AS CoronerState,
		Referral.ReferralCoronerName AS 'InvestigatorName',
		Referral.ReferralCoronerOrganization,
		Referral.ReferralCoronerPhone AS 'InvestigaterPhone',
		Secondary.SecondaryCoronerCounty,
		Secondary.SecondaryCoronerReleased,
		Secondary.SecondaryCoronerReleasedStipulations,

		/* Autopsy */
		YNAutopsy.YesNoNa_RefName AS 'Autopsy',
		YNAutopsyBloodRequested.YesNoNa_RefName AS 'AutopsyBloodRequested',
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryAutopsyDate,101), '') + ' ' + ISNULL(Secondary.SecondaryAutopsyTime, '') AS 'SecondaryAutopsyDT',
		YNAutopsyCopyRequested.YesNoNa_RefName AS 'AutopsyReportRequsted',
		Secondary.SecondaryAutopsyLocationOther,
		--Field not used: SecondaryAutopsyReminder,
		YNAutopsyReminder.YesNoNa_RefName AS 'YNAutopsyReminder',

		/* Funeral Home */
		YNFHSelected.YesNoNa_RefName AS 'FuneralHomeSelected',
		YNFHNotified.YesNoNa_RefName AS 'FuneralHomeNotified',
		Secondary.SecondaryFuneralHomeName,
		YNFHMorgueCooled.YesNoNa_RefName AS 'YNFuneralHomeMorgueCooled',
		Secondary.SecondaryFuneralHomePhone,
		YNFHHoldOnBody.YesNoNa_RefName AS 'YNFuneralHomeHoldOnBody',
		Secondary.SecondaryFuneralHomeAddress,
		Secondary.SecondaryHoldOnBodyTag AS 'FuneralHomeDateTimePersonStamp',		
		Secondary.SecondaryFuneralHomeContact,
		--Field not used: SecondaryAutopsyReminder,
		YNFHReminder.YesNoNa_RefName AS 'YNFuneralHomeReminder',

		/* Body Care */
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryBodyHoldPlaced,101), '') + ' ' + ISNULL(Secondary.SecondaryBodyHoldPlacedTime, '') AS 'BodyHoldPlacedDT',
		ISNULL(CONVERT(VARCHAR, Secondary.SecondaryBodyRefrigerationDate,101), '') + ' ' + ISNULL(Secondary.SecondaryBodyRefrigerationTime, '') AS 'BodyRefrigerationDT',
		Secondary.SecondaryBodyHoldPlacedWith,
		Secondary.SecondaryBodyLocation,
		Secondary.SecondaryBodyFutureContact,
		Secondary.SecondaryBodyCoolingMethod,
		Secondary.SecondaryBodyHoldPhone,
		CASE
			WHEN
				ISNULL(Secondary.SecondaryBodyHoldInstructionsGiven, 0) IN (-1, 1)
			THEN
				'Yes'
			ELSE
				'No'
			END AS 'YNBodyHoldInstructionsGiven',
		/* Wrap-Up Items */
		--Field not used: SecondaryWrapUpReminder, -- Cannot locate in database
		YNWrapUpReminder.YesNoNa_RefName AS 'YNSecondaryWrapUpReminder',

		/* Case Numbers */
		SecondaryUNOSNumber,
		SecondaryMTFNumber,
		SecondaryClientNumber,
		SecondaryLifeNetNumber,
		SecondaryCryolifeNumber,
		SecondaryFreeText,
		ISNULL(SecondaryTBI.SecondaryTBINumber, '') AS 'SecondaryTBINumber',
		CASE WHEN ISNULL(SecondaryTBIAssignmentNotNeeded, 0) = -1 THEN 'Yes' ELSE '' END AS 'SecondaryTBINotNeeded', 
		ISNULL(SecondaryTBI.SecondaryTBIComment, '') AS 'SecondaryTBIComment',

		/* Hospital Approach */
		HospitalApproach.ApproachTypeName AS 'HospitalApproachType',
		ISNULL(HospitalApproachPerson.PersonFirst, '') + ' ' + ISNULL(HospitalApproachPerson.PersonLast, '') AS 'HospitalApproachPerson',
		CASE SecondaryApproach.SecondaryHospitalOutcome WHEN 1 THEN 'Yes-Written'
								WHEN 2 THEN 'Yes-Verbal'
								WHEN 3 THEN 'No'
						END  AS 'HospitalApproachOutcome',

		/* Informed Approach */
		YNInformedAppraochDone.YesNoNa_RefName AS 'InformedAppraochDone',
		InformedApproach.FSApproachTypeName AS 'InformedApproachType',
		ISNULL(InformedApproachPerson.PersonFirst, '') + ' ' + ISNULL(InformedApproachPerson.PersonLast, '') AS 'InformedApproachPerson',
		CASE SecondaryApproach.SecondaryApproachOutcome WHEN 1 THEN 'Yes-Verbal'
								WHEN 2 THEN 'Yes-Written'
								WHEN 3 THEN 'No'
								WHEN 4 THEN 'Undecided'
						END  AS 'InformedApproachOutcome',

		ApproachReason.ApproachReportName AS 'ReasonInformed',
		''AS 'ApproachedNotCompleted', -- Not used. Remove

		/* Consent */
		YNConsentPaperwork.YesNoNa_RefName AS 'ConsentPaperwork',
		ISNULL(ConsentPerson.PersonFirst, '') + ' ' + ISNULL(ConsentPerson.PersonLast, '') AS 'ConsentObtainedBy',
		YNConsentForResearch.YesNoNa_RefName AS 'ConsentForResearch',

		YNMedSocPaperwork.YesNoNa_RefName AS 'MedSocPaperwork',
		ISNULL(MedSocPerson.PersonFirst, '') + ' ' + ISNULL(MedSocPerson.PersonLast, '') AS 'MedSocObtainedBy',
		SecondaryApproach.SecondaryConsentFuneralPlansOther,
		YNConsentLongSleeves.YesNoNa_RefName AS 'ConsentLongSleeves'

	/* Disposition */
		--For Disposition, see sps_rpt_SecondaryDisposition


     FROM FSCase
     /* Referral */
     LEFT JOIN Referral ON FSCase.CallID = Referral.CallID
     LEFT JOIN SecondaryTBI ON SecondaryTBI.CallID = FSCase.CallID
     LEFT JOIN Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationId
     LEFT JOIN SubLocation ON Referral.ReferralCallerSubLocationID = SubLocation.SubLocationID
     LEFT JOIN Person AS CallerPerson ON Referral.ReferralCallerPersonID = CallerPerson.PersonID
     LEFT JOIN PersonType AS CallerPersonType ON CallerPerson.PersonTypeID = CallerPersonType.PersonTypeID
     LEFT JOIN Phone AS CallerPersonPhone ON Referral.ReferralCallerPhoneID= CallerPersonPhone.PhoneID
     LEFT JOIN NOK ON NOK.NOKID = Referral.ReferralNOKID 
     LEFT JOIN State st ON st.StateID = NOK.NOKStateID
     LEFT JOIN Organization AS CoronerOrg ON CoronerOrg.OrganizationID = Referral.ReferralCoronerOrgID
     LEFT JOIN State AS CoronerState ON CoronerState.StateID = CoronerOrg.StateID


     /* Case Open */
     LEFT JOIN StatEmployee AS SECaseOpen ON SECaseOpen.StatEmployeeID = FSCase.FSCaseOpenUserID
     LEFT JOIN Person AS CaseOpenPerson ON CaseOpenPerson.PersonID = SECaseOpen.PersonID
     /* Case System Events */
     LEFT JOIN StatEmployee AS SECaseSystemEvents ON SECaseSystemEvents.StatEmployeeID = FSCase.FSCaseSysEventsUserID
     LEFT JOIN Person AS CaseSystemEventsPerson ON CaseSystemEventsPerson.PersonID = SECaseSystemEvents.PersonID
     /* Case Complete */
     LEFT JOIN StatEmployee AS SECaseComplete ON SECaseComplete.StatEmployeeID = FSCase.FSCaseSecCompUserID
     LEFT JOIN Person AS CaseCompletePerson ON CaseCompletePerson.PersonID = SECaseComplete.PersonID
     /* Case Approach */
     LEFT JOIN StatEmployee AS SECaseApproach ON SECaseApproach.StatEmployeeID = FSCase.FSCaseApproachUserID
     LEFT JOIN Person AS CaseApproachPerson ON CaseApproachPerson.PersonID = SECaseApproach.PersonID
     /* Case Final */
     LEFT JOIN StatEmployee AS SECaseFinal ON SECaseFinal.StatEmployeeID = FSCase.FSCaseFinalUserID
     LEFT JOIN Person AS CaseFinalPerson ON CaseFinalPerson.PersonID = SECaseFinal.PersonID
     /* Case Bill Secondary */
     LEFT JOIN StatEmployee AS SECaseBillSecondary ON SECaseBillSecondary.StatEmployeeID = FSCase.FSCaseBillSecondaryUserID
     LEFT JOIN Person AS CaseBillSecondaryPerson ON CaseBillSecondaryPerson.PersonID = SECaseBillSecondary.PersonID
     /* Case Bill OTE */
     LEFT JOIN StatEmployee AS SECaseBillOTE ON SECaseBillOTE.StatEmployeeID = FSCase.FSCaseBillOTEUserID
     LEFT JOIN Person AS CaseBillOTEPerson ON CaseBillOTEPerson.PersonID = SECaseBillOTE.PersonID
     /* Case Bill FamUnavail */
     LEFT JOIN StatEmployee AS SECaseBillFamUnavail ON SECaseBillFamUnavail.StatEmployeeID = FSCase.FSCaseBillFamUnavailUserID
     LEFT JOIN Person AS CaseBillFamUnavailPerson ON CaseBillFamUnavailPerson.PersonID = SECaseBillFamUnavail.PersonID
     /* Case Bill FamApproach */
     LEFT JOIN StatEmployee AS SECaseBillFamApproach ON SECaseBillFamApproach.StatEmployeeID = FSCase.FSCaseBillApproachUserID
     LEFT JOIN Person AS CaseBillFamApproachPerson ON CaseBillFamApproachPerson.PersonID = SECaseBillFamApproach.PersonID
     /* Case Bill MedSoc */
     LEFT JOIN StatEmployee AS SECaseBillMedSoc ON SECaseBillMedSoc.StatEmployeeID = FSCase.FSCaseBillMedSocUserID
     LEFT JOIN Person AS CaseBillMedSocPerson ON CaseBillMedSocPerson.PersonID = SECaseBillMedSoc.PersonID
     /* Case Bill CryoForm */
     LEFT JOIN StatEmployee AS SECaseBillCryoForm ON SECaseBillCryoForm.StatEmployeeID = FSCase.FSCaseBillCryoFormUserID
     LEFT JOIN Person AS CaseBillCryoFormPerson ON CaseBillCryoFormPerson.PersonID = SECaseBillCryoForm.PersonID

     LEFT JOIN Secondary ON Secondary.CallID = FSCase.CallID
     LEFT JOIN Secondary2 ON Secondary2.CallID = FSCase.CallID
     LEFT JOIN SecondaryApproach ON SecondaryApproach.CallID = FSCase.CallID

     /* Hospital Approach */
     LEFT JOIN ApproachType AS HospitalApproach ON HospitalApproach.ApproachTypeID = SecondaryApproach.SecondaryHospitalApproach
     LEFT JOIN Person AS HospitalApproachPerson ON HospitalApproachPerson.PersonID = SecondaryApproach.SecondaryHospitalApproachedBy

     /* Informed Approach */
     LEFT JOIN FSApproachType AS InformedApproach ON InformedApproach.FSApproachTypeID = SecondaryApproach.SecondaryApproachType
     LEFT JOIN Person AS InformedApproachPerson ON InformedApproachPerson.PersonID = SecondaryApproach.SecondaryApproachedBy
	 LEFT JOIN Approach AS ApproachReason ON ApproachReason.ApproachID = SecondaryApproach.SecondaryApproachReason
     /* Consent */
     LEFT JOIN Person AS ConsentPerson ON ConsentPerson.PersonID = SecondaryApproach.SecondaryConsentBy
     LEFT JOIN Person AS MedSocPerson ON MedSocPerson.PersonID = SecondaryApproach.SecondaryConsentMedSocObtainedBy

     /* Yes No NA lookup */
     LEFT JOIN YesNoNa_Ref AS YNNOKAware ON  YNNOKAware.YesNoNa_RefId = Secondary.SecondaryNOKaware
     LEFT JOIN YesNoNa_Ref AS YNFamInterest ON  YNFAmInterest.YesNoNa_RefId = Secondary.SecondaryFamilyInterested
     LEFT JOIN YesNoNa_Ref AS YNFamConsent ON  YNFAmConsent.YesNoNa_RefId = Secondary.SecondaryFamilyConsent
     LEFT JOIN YesNoNa_Ref AS YNNOKAtHospital ON YNNOKAtHospital.YesNoNa_RefID = Secondary.SecondaryNOKAtHospital
     LEFT JOIN YesNoNa_Ref AS YNSubstanceAbuse ON YNSubstanceAbuse.YesNoNa_RefID = Secondary.SecondaryHistorySubstanceAbuse
     LEFT JOIN YesNoNa_Ref AS YNSignsOfInfection ON YNSignsOfInfection.YesNoNa_RefID = Secondary.SecondarySignOfInfection
     LEFT JOIN YesNoNa_Ref AS YNDeathWitnessed ON YNDeathWitnessed.YesNoNa_RefID = Secondary.SecondaryDeathWitnessed
     LEFT JOIN YesNoNa_Ref AS YNMedication ON YNMedication.YesNoNa_RefID = Secondary.SecondaryMedication
     LEFT JOIN YesNoNa_Ref AS YNAntibiotic ON YNAntibiotic.YesNoNa_RefID = Secondary.SecondaryAntibiotic
     LEFT JOIN YesNoNa_Ref AS YNSteroid ON YNSteroid.YesNoNa_RefID = Secondary.SecondarySteroid
     LEFT JOIN YesNoNa_Ref AS YNBloodProducts ON YNBloodproducts.YesNoNa_RefID = Secondary.SecondaryBloodProducts
     LEFT JOIN YesNoNa_Ref AS YNColloidsInfused ON YNColloidsInfused.YesNoNa_RefID = Secondary.SecondaryColloidsInfused
     LEFT JOIN YesNoNa_Ref AS YNCrystalloids ON YNCrystalloids.YesNoNa_RefID = Secondary.SecondaryCrystalloids
     LEFT JOIN YesNoNa_Ref AS YNPreTransRequired ON YNPreTransRequired.YesNoNa_RefID = Secondary.SecondaryPreTransfusionSampleRequired
     LEFT JOIN YesNoNa_Ref AS YNPreTransAvailable ON YNPreTransAvailable.YesNoNa_RefID = Secondary.SecondaryPreTransfusionSampleAvailable
     LEFT JOIN YesNoNa_Ref AS YNPostMordemTestSuitable ON YNPostMordemTestSuitable.YesNoNa_RefID = Secondary.SecondaryPostMordemSampleTestSuitable
     LEFT JOIN YesNoNa_Ref AS YNCXRAvailable ON YNCXRAvailable.YesNoNa_RefID = Secondary2.SecondaryCXRAvailable
     LEFT JOIN YesNoNa_Ref AS YNNOKLegal ON YNNOKLegal.YesNoNa_RefID = Secondary.SecondaryNOKLegal
     LEFT JOIN YesNoNa_Ref AS YNNOKExamAuthorized ON YNNOKExamAuthorized.YesNoNa_RefID = Secondary.SecondaryNOKPostMortemAuthorization
     LEFT JOIN YesNoNa_Ref AS YNCoronerCase ON YNCoronerCase.YesNoNa_RefID = Secondary.SecondaryCoronerCase
     LEFT JOIN YesNoNa_Ref AS YNAutopsy ON YNAutopsy.YesNoNa_RefID = Secondary.SecondaryAutopsy
     LEFT JOIN YesNoNa_Ref AS YNAutopsyBloodRequested ON YNAutopsyBloodRequested.YesNoNa_RefID = Secondary.SecondaryAutopsyBloodRequested
     LEFT JOIN YesNoNa_Ref AS YNAutopsyCopyRequested ON YNAutopsyCopyRequested.YesNoNa_RefID = Secondary.SecondaryAutopsyCopyRequested
     LEFT JOIN YesNoNa_Ref AS YNAutopsyReminder ON YNAutopsyReminder.YesNoNa_RefID = Secondary.SecondaryAutopsyReminderYN
     LEFT JOIN YesNoNa_Ref AS YNFHSelected ON YNFHSelected.YesNoNa_RefID = Secondary.SecondaryFuneralHomeSelected
     LEFT JOIN YesNoNa_Ref AS YNFHNotified ON YNFHNotified.YesNoNa_RefID = Secondary.SecondaryFuneralHomeNotified
     LEFT JOIN YesNoNa_Ref AS YNFHHoldOnBody ON YNFHHoldOnBody.YesNoNa_RefID = Secondary.SecondaryHoldOnBody
     LEFT JOIN YesNoNa_Ref AS YNFHMorgueCooled ON YNFHMorgueCooled.YesNoNa_RefID = Secondary.SecondaryFuneralHomeMorgueCooled
     LEFT JOIN YesNoNa_Ref AS YNFHReminder ON YNFHReminder.YesNoNa_RefID = Secondary.SecondaryFHReminderYN
     LEFT JOIN YesNoNa_Ref AS YNWrapUpReminder ON YNWrapUpReminder.YesNoNa_RefID = Secondary.SecondaryWrapUpReminderYN
     LEFT JOIN YesNoNa_Ref AS YNInformedAppraochDone ON YNInformedAppraochDone.YesNoNa_RefID = SecondaryApproach.SecondaryApproached
     LEFT JOIN YesNoNa_Ref AS YNConsentPaperwork ON YNConsentPaperwork.YesNoNa_RefID = SecondaryApproach.SecondaryConsented
     LEFT JOIN YesNoNa_Ref AS YNConsentForResearch ON YNConsentForResearch.YesNoNa_RefID = SecondaryApproach.SecondaryConsentResearch
     LEFT JOIN YesNoNa_Ref AS YNMedSocPaperwork ON YNMedSocPaperwork.YesNoNa_RefID = SecondaryApproach.SecondaryConsentMedSocPaperwork
     LEFT JOIN YesNoNa_Ref AS YNConsentLongSleeves ON YNConsentLongSleeves.YesNoNa_RefID = SecondaryApproach.SecondaryConsentLongSleeves

     /* Blood Products */
     LEFT JOIN BloodProduct AS BloodProduct1 ON BloodProduct1.BloodProductId = Secondary2.SecondaryBloodProductsReceived1Type
     LEFT JOIN BloodProduct AS BloodProduct2 ON BloodProduct2.BloodProductId = Secondary2.SecondaryBloodProductsReceived2Type
     LEFT JOIN BloodProduct AS BloodProduct3 ON BloodProduct3.BloodProductId = Secondary2.SecondaryBloodProductsReceived3Type

     /* Colloids */
     LEFT JOIN BloodProduct AS ColloidsInfused1 ON ColloidsInfused1.BloodProductId = Secondary2.SecondaryColloidsInfused1Type
     LEFT JOIN BloodProduct AS ColloidsInfused2 ON ColloidsInfused2.BloodProductId = Secondary2.SecondaryColloidsInfused2Type
     LEFT JOIN BloodProduct AS ColloidsInfused3 ON ColloidsInfused3.BloodProductId = Secondary2.SecondaryColloidsInfused3Type

     /* Crystalloids */
     LEFT JOIN BloodProduct AS Crystalloids1 ON Crystalloids1.BloodProductId = Secondary2.SecondaryCrystalloids1Type
     LEFT JOIN BloodProduct AS Crystalloids2 ON Crystalloids2.BloodProductId = Secondary2.SecondaryCrystalloids2Type
     LEFT JOIN BloodProduct AS Crystalloids3 ON Crystalloids3.BloodProductId = Secondary2.SecondaryCrystalloids3Type

     /* Culture */
     LEFT JOIN Culture AS Culture1 ON Culture1.CultureId = Secondary2.SecondaryCulture1Type
     LEFT JOIN Culture AS Culture2 ON Culture2.CultureId = Secondary2.SecondaryCulture2Type
     LEFT JOIN Culture AS Culture3 ON Culture3.CultureId = Secondary2.SecondaryCulture3Type
 

     LEFT JOIN ABORef ON Secondary.SecondaryPatientABO = ABORef.ABORefid
     LEFT JOIN Race ON Race.RaceID = Referral.ReferralDonorRaceID 
     LEFT JOIN Rhythm ON Rhythm.RhythmID = Secondary.SecondaryRhythm
     LEFT JOIN Person AS SecondaryMDAttending ON SecondaryMDAttending.PersonID = Referral.ReferralAttendingMD
     LEFT JOIN FS_CauseOfDeath AS FSCOD ON FSCOD.FS_CauseOfDeathID = Secondary.SecondaryCOD
     WHERE     FSCase.CallID = @CallID;


