IF OBJECT_ID('Api.GetReferralDetailSecondaryById') IS NOT NULL 
DROP FUNCTION Api.GetReferralDetailSecondaryById;
GO

CREATE FUNCTION Api.GetReferralDetailSecondaryById
(
	@webReportGroupId int,
	@referralId int
)
RETURNS TABLE
AS

-- Below I tried to fit the query into an inline
-- function to avoid defining a table type with all 
-- numerous columns.

RETURN(
SELECT DISTINCT 
	FSCaseCreateUserId,
	FSCaseCreateDateTime,
	FSCaseOpenUserId,
	FSCaseOpenDateTime,
	FSCaseSysEventsUserId,
	FSCaseSysEventsDateTime,
	FSCaseSecCompUserId,
	FSCaseSecCompDateTime,
	FSCaseApproachUserId,
	FSCaseApproachDateTime,
	FSCaseFinalUserId,
	FSCaseFinalDateTime,
	FSCaseUpdate,
	FSCaseUserId,
	FSCaseBillSecondaryUserID,
	FSCaseBillDateTime,
	FSCaseBillApproachUserID,
	FSCaseBillApproachDateTime,
	FSCaseBillMedSocUserID,
	FSCaseBillMedSocDateTime,
	SecondaryManualBillPersonId,
	SecondaryUpdatedFlag,
	FSCaseTotalTime,
	FSCaseSeconds,
	FSCaseBillFamUnavailUserId,
	FSCaseBillFamUnavailDateTime,
	FSCaseBillCryoFormUserId,
	FSCaseBillCryoFormDateTime,
	FSCaseBillApproachCount,
	FSCaseBillMedSocCount,
	FSCaseBillCryoFormCount,
	SecondaryNOKaware,
	SecondaryFamilyConsent,
	SecondaryFamilyInterested,
	SecondaryNOKatHospital,
	SecondaryEstTimeSinceLeft,
	SecondaryTimeLeftInMT,
	SecondaryNOKNextDest,
	SecondaryNOKETA,
	SecondaryPatientMiddleName,
	SecondaryPatientHeightFeet,
	SecondaryPatientHeightInches,
	SecondaryPatientBMICalc,
	REPLACE(REPLACE(SecondaryCircumstanceOfDeath, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryCircumstanceOfDeath,
	REPLACE(REPLACE(SecondaryMedicalHistory, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryMedicalHistory,
	SecondaryAdmissionDiagnosis,
	SecondaryCOD,
	SecondaryCODSignatory,
	SecondaryPatientVent,
	SecondaryBrainDeathDate,
	SecondaryBrainDeathTime,
	SecondaryDNRDate,
	SecondaryEMSArrivalToPatientTime,
	SecondaryEMSArrivalToHospitalTime,
	SecondaryDeathWitnessed,
	SecondaryDeathWitnessedBy,
	SecondaryLSADate,
	SecondaryLSATime,
	SecondaryBirthCBO,
	SecondaryActiveInfection,
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
	SecondaryAutopsy,
	SecondaryAutopsyDate,
	SecondaryAutopsyTime,
	SecondaryAutopsyLocation,
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
	SecondaryBodyCoolingMethod,
	SecondaryUNOSNumber,
	SecondaryClientNumber,
	SecondaryCryolifeNumber,
	SecondaryMTFNumber,
	SecondaryLifeNetNumber,
	REPLACE(REPLACE(SecondaryFreeText, CHAR(10), CHAR(32)), CHAR(13), '') AS SecondaryFreeText,
	SecondaryHistorySubstanceAbuse,
	SecondarySubstanceAbuseDetail,
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
	'(' + PhoneAreaCode + ') ' + PhonePrefix + '-' + PhoneNumber AS SecondaryPatientHospitalPhone,
	SecondaryCoronerCase,
	SecondaryPatientABO,
	SecondaryPatientSuffix,
	SecondaryMDAttendingId,
	REPLACE(REPLACE(SecondaryAdditionalComments,  CHAR(10),  CHAR(32)),  CHAR(13),  '') AS SecondaryAdditionalComments,
	SecondaryRhythm,
	REPLACE(REPLACE(SecondaryAdditionalMedications,  CHAR(10),  CHAR(32)),  CHAR(13),  '') AS SecondaryAdditionalMedications,
	SecondaryBodyHoldPlaced,
	SecondaryBodyHoldPlacedWith,
	SecondaryBodyFutureContact,
	SecondaryBodyHoldPhone,
	SecondaryBodyHoldInstructionsGiven,
	SecondarySteroid,
	SecondaryBodyHoldPlacedTime,
	--SecondaryAntibiotic1Name,
	--SecondaryAntibiotic1Dose,
	--SecondaryAntibiotic1StartDate,
	--SecondaryAntibiotic1EndDate,
	--SecondaryAntibiotic2Name,
	--SecondaryAntibiotic2Dose,
	--SecondaryAntibiotic2StartDate,
	--SecondaryAntibiotic2EndDate,
	--SecondaryAntibiotic3Name,
	--SecondaryAntibiotic3Dose,
	--SecondaryAntibiotic3StartDate,
	--SecondaryAntibiotic3EndDate,
	--SecondaryAntibiotic4Name,
	--SecondaryAntibiotic4Dose,
	--SecondaryAntibiotic4StartDate,
	--SecondaryAntibiotic4EndDate,
	--SecondaryAntibiotic5Name,
	--SecondaryAntibiotic5Dose,
	--SecondaryAntibiotic5StartDate,
	--SecondaryAntibiotic5EndDate,
	SecondaryBloodProductsReceived1Type,
	SecondaryBloodProductsReceived1Units,
	SecondaryBloodProductsReceived1TypeCC,
	SecondaryBloodProductsReceived1TypeUnitGiven,
	SecondaryBloodProductsReceived2Type,
	SecondaryBloodProductsReceived2Units,
	SecondaryBloodProductsReceived2TypeCC,
	SecondaryBloodProductsReceived2TypeUnitGiven,
	SecondaryBloodProductsReceived3Type,
	SecondaryBloodProductsReceived3Units,
	SecondaryBloodProductsReceived3TypeCC,
	SecondaryBloodProductsReceived3TypeUnitGiven,
	SecondaryColloidsInfused1Type,
	SecondaryColloidsInfused1Units,
	SecondaryColloidsInfused1CC,
	SecondaryColloidsInfused1UnitGiven,
	SecondaryColloidsInfused2Type,
	SecondaryColloidsInfused2Units,
	SecondaryColloidsInfused2CC,
	SecondaryColloidsInfused2UnitGiven,
	SecondaryColloidsInfused3Type,
	SecondaryColloidsInfused3Units,
	SecondaryColloidsInfused3CC,
	SecondaryColloidsInfused3UnitGiven,
	SecondaryCrystalloids1Type,
	SecondaryCrystalloids1Units,
	SecondaryCrystalloids1CC,
	SecondaryCrystalloids1UnitGiven,
	SecondaryCrystalloids2Type,
	SecondaryCrystalloids2Units,
	SecondaryCrystalloids2CC,
	SecondaryCrystalloids2UnitGiven,
	SecondaryCrystalloids3Type,
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
	SecondaryCulture1Type,
	SecondaryCulture1Other,
	SecondaryCulture1DrawnDate,
	SecondaryCulture1Growth,
	SecondaryCulture2Type,
	SecondaryCulture2Other,
	SecondaryCulture2DrawnDate,
	SecondaryCulture2Growth,
	SecondaryCulture3Type,
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
	SecondaryApproached,
	SecondaryApproachedBy,
	SecondaryApproachType,
	SecondaryApproachOutcome,
	SecondaryApproachReason,
	SecondaryConsented,
	SecondaryConsentBy,
	SecondaryConsentResearch,
	SecondaryHospitalApproach,
	SecondaryHospitalApproachedBy,
	SecondaryHospitalOutcome,
	SecondaryConsentMedSocPaperwork,
	SecondaryConsentMedSocObtainedBy,
	SecondaryConsentFuneralPlans,
	SecondaryConsentFuneralPlansOther,
	SecondaryConsentLongSleeves ,
	STBI.SecondaryTBINumber TBINumber,
	CASE STBI.SecondaryTBIAssignmentNotNeeded WHEN 0 THEN -1 WHEN -1 THEN 0 ELSE -1 END AS TBINotNeeded,
	STBI.SecondaryTBIComment TBIComment

	FROM 
		Referral 
	LEFT JOIN 
		Call ON Call.CallID = Referral.CallID 
	JOIN 
		FSCase on FSCase.CallID = Referral.CallID 
    LEFT JOIN 
		CallCriteria ON Referral.CallID = CallCriteria.CallID 
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
		Secondary on Secondary.CallID = Referral.CallID 
	LEFT JOIN 
		Secondary2 on Secondary2.CallID = Referral.CallID 
	LEFT JOIN 
		SecondaryApproach on SecondaryApproach.CallID = Referral.CallID 
	LEFT JOIN
		SecondaryTBI STBI ON STBI.CallID = Referral.CallID
    WHERE 
        Referral.ReferralID = @referralId 
        AND
        [dbo].[Referral].ReferralCallerOrganizationID IN 
            (SELECT * FROM Api.GetWebReportGroupOrganizationIds(@webReportGroupId))
        AND 
		(
		[dbo].[call].SourceCodeID IS NULL OR -- For recycled referrals
        [dbo].[call].SourceCodeID IN 
            (SELECT * FROM Api.GetWebReportGroupSourceCodes(@webReportGroupId))
		)
);
	
GO