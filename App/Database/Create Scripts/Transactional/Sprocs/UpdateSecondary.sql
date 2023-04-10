IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSecondary')
	BEGIN
		PRINT 'Dropping Procedure UpdateSecondary'
		DROP  Procedure  UpdateSecondary
	END

GO

PRINT 'Creating Procedure UpdateSecondary'
GO
CREATE Procedure UpdateSecondary
	@CallID int, 
	@SecondaryWhoAreWe varchar(25) = NULL, 
	@SecondaryNOKaware smallint = NULL, 
	@SecondaryFamilyConsent smallint = NULL, 
	@SecondaryFamilyInterested smallint = NULL, 
	@SecondaryNOKatHospital smallint = NULL, 
	@SecondaryEstTimeSinceLeft varchar(10) = NULL, 
	@SecondaryTimeLeftInMT varchar(10) = NULL, 
	@SecondaryNOKNextDest varchar(25) = NULL, 
	@SecondaryNOKETA varchar(10) = NULL, 
	@SecondaryPatientMiddleName varchar(25) = NULL, 
	@SecondaryPatientHeightFeet varchar(2) = NULL, 
	@SecondaryPatientHeightInches varchar(2) = NULL, 
	@SecondaryPatientBMICalc varchar(10) = NULL, 
	@SecondaryPatientTOD1 varchar(10) = NULL, 
	@SecondaryPatientTOD2 varchar(10) = NULL, 
	@SecondaryPatientDeathType1 smalldatetime = NULL, 
	@SecondaryPatientDeathType2 smalldatetime = NULL, 
	@SecondaryTriageHX varchar(255) = NULL, 
	@SecondaryCircumstanceOfDeath varchar(1000) = NULL, 
	@SecondaryMedicalHistory varchar(1000) = NULL, 
	@SecondaryAdmissionDiagnosis varchar(100) = NULL, 
	@SecondaryCOD int = NULL, 
	@SecondaryCODSignatory varchar(50) = NULL, 
	@SecondaryCODTime varchar(10) = NULL, 
	@SecondaryCODSignedBy varchar(25) = NULL, 
	@SecondaryPatientVent smallint = NULL, 
	@SecondaryIntubationDate smalldatetime = NULL, 
	@SecondaryIntubationTime varchar(10) = NULL, 
	@SecondaryBrainDeathDate smalldatetime = NULL, 
	@SecondaryBrainDeathTime varchar(10) = NULL, 
	@SecondaryDNRDate smalldatetime = NULL, 
	@SecondaryERORDeath smallint = NULL, 
	@SecondaryEMSArrivalToPatientDate smalldatetime = NULL, 
	@SecondaryEMSArrivalToPatientTime varchar(10) = NULL, 
	@SecondaryEMSArrivalToHospitalDate smalldatetime = NULL, 
	@SecondaryEMSArrivalToHospitalTime varchar(10) = NULL, 
	@SecondaryPatientTerminal smallint = NULL, 
	@SecondaryDeathWitnessed smallint = NULL, 
	@SecondaryDeathWitnessedBy varchar(50) = NULL, 
	@SecondaryLSADate smalldatetime = NULL, 
	@SecondaryLSATime varchar(10) = NULL, 
	@SecondaryLSABy varchar(25) = NULL, 
	@SecondaryACLSProvided smallint = NULL, 
	@SecondaryACLSProvidedTime varchar(10) = NULL, 
	@SecondaryGestationalAge varchar(10) = NULL, 
	@SecondaryParentName1 varchar(25) = NULL, 
	@SecondaryParentName2 varchar(25) = NULL, 
	@SecondaryBirthCBO varchar(10) = NULL, 
	@SecondaryActiveInfection smallint = NULL, 
	@SecondaryActiveInfectionType varchar(25) = NULL, 
	@SecondaryFluidsGiven smallint = NULL, 
	@SecondaryBloodLoss smallint = NULL, 
	@SecondarySignOfInfection smallint = NULL, 
	@SecondaryMedication smallint = NULL, 
	@SecondaryAntibiotic smallint = NULL, 
	@SecondaryPCPName varchar(50) = NULL, 
	@SecondaryPCPPhone varchar(14) = NULL, 
	@SecondaryMDAttending varchar(50) = NULL, 
	@SecondaryMDAttendingPhone varchar(14) = NULL, 
	@SecondaryPhysicalAppearance varchar(1000) = NULL, 
	@SecondaryInternalBloodLossCC varchar(10) = NULL, 
	@SecondaryExternalBloodLossCC varchar(10) = NULL, 
	@SecondaryBloodProducts smallint = NULL, 
	@SecondaryColloidsInfused smallint = NULL, 
	@SecondaryCrystalloids smallint = NULL, 
	@SecondaryPreTransfusionSampleRequired smallint = NULL, 
	@SecondaryPreTransfusionSampleAvailable smallint = NULL, 
	@SecondaryPreTransfusionSampleDrawnDate smalldatetime = NULL, 
	@SecondaryPreTransfusionSampleDrawnTime varchar(10) = NULL, 
	@SecondaryPreTransfusionSampleQuantity varchar(10) = NULL, 
	@SecondaryPreTransfusionSampleHeldAt varchar(25) = NULL, 
	@SecondaryPreTransfusionSampleHeldDate smalldatetime = NULL, 
	@SecondaryPreTransfusionSampleHeldTime varchar(10) = NULL, 
	@SecondaryPreTransfusionSampleHeldTechnician varchar(25) = NULL, 
	@SecondaryPostMordemSampleTestSuitable smallint = NULL, 
	@SecondaryPostMordemSampleLocation varchar(25) = NULL, 
	@SecondaryPostMordemSampleContact varchar(25) = NULL, 
	@SecondaryPostMordemSampleCollectionDate smalldatetime = NULL, 
	@SecondaryPostMordemSampleCollectionTime varchar(10) = NULL, 
	@SecondarySputumCharacteristics varchar(255) = NULL, 
	@SecondaryNOKAltPhone varchar(14) = NULL, 
	@SecondaryNOKLegal smallint = NULL, 
	@SecondaryNOKAltContact varchar(25) = NULL, 
	@SecondaryNOKAltContactPhone varchar(14) = NULL, 
	@SecondaryNOKPostMortemAuthorization smallint = NULL, 
	@SecondaryNOKPostMortemAuthorizationReminder varchar(25) = NULL, 
	@SecondaryCoronerCaseNumber varchar(25) = NULL, 
	@SecondaryCoronerCounty varchar(25) = NULL, 
	@SecondaryCoronerReleased varchar(25) = NULL, 
	@SecondaryCoronerReleasedStipulations varchar(255) = NULL, 
	@SecondaryAutopsy smallint = NULL, 
	@SecondaryAutopsyDate smalldatetime = NULL, 
	@SecondaryAutopsyTime varchar(10) = NULL, 
	@SecondaryAutopsyLocation int = NULL, 
	@SecondaryAutopsyBloodRequested smallint = NULL, 
	@SecondaryAutopsyCopyRequested smallint = NULL, 
	@SecondaryFuneralHomeSelected smallint = NULL, 
	@SecondaryFuneralHomeName varchar(100) = NULL, 
	@SecondaryFuneralHomePhone varchar(14) = NULL, 
	@SecondaryFuneralHomeAddress varchar(100) = NULL, 
	@SecondaryFuneralHomeContact varchar(25) = NULL, 
	@SecondaryFuneralHomeNotified varchar(2) = NULL, 
	@SecondaryFuneralHomeMorgueCooled varchar(2) = NULL, 
	@SecondaryHoldOnBody smallint = NULL, 
	@SecondaryHoldOnBodyTag varchar(25) = NULL, 
	@SecondaryBodyRefrigerationDate smalldatetime = NULL, 
	@SecondaryBodyRefrigerationTime varchar(10) = NULL, 
	@SecondaryBodyLocation varchar(25) = NULL, 
	@SecondaryBodyMedicalChartLocation varchar(25) = NULL, 
	@SecondaryBodyIDTagLocation varchar(25) = NULL, 
	@SecondaryBodyCoolingMethod varchar(50) = NULL, 
	@SecondaryUNOSNumber varchar(25) = NULL, 
	@SecondaryClientNumber varchar(25) = NULL, 
	@SecondaryCryolifeNumber varchar(25) = NULL, 
	@SecondaryMTFNumber varchar(25) = NULL, 
	@SecondaryLifeNetNumber varchar(25) = NULL, 
	@SecondaryFreeText varchar(255) = NULL, 
	@SecondaryHistorySubstanceAbuse smallint = NULL, 
	@SecondarySubstanceAbuseDetail varchar(255) = NULL, 
	@SecondaryExtubationDate smalldatetime = NULL, 
	@SecondaryExtubationTime varchar(10) = NULL, 
	@SecondaryAutopsyReminderYN smallint = NULL, 
	@SecondaryFHReminderYN smallint = NULL, 
	@SecondaryBodyCareReminderYN smallint = NULL, 
	@SecondaryWrapUpReminderYN smallint = NULL, 
	@SecondaryNOKNotifiedBy varchar(50) = NULL, 
	@SecondaryNOKNotifiedDate smalldatetime = NULL, 
	@SecondaryNOKNotifiedTime varchar(10) = NULL, 
	@SecondaryNOKGender varchar(50) = NULL, 
	@SecondaryCODOther varchar(200) = NULL, 
	@SecondaryAutopsyLocationOther varchar(100) = NULL, 
	@SecondaryPatientHospitalPhone varchar(14) = NULL, 
	@SecondaryCoronerCase smallint = NULL, 
	@SecondaryPatientABO int = NULL, 
	@SecondaryPatientSuffix varchar(10) = NULL, 
	@SecondaryMDAttendingId int = NULL, 
	@SecondaryAdditionalComments varchar(255) = NULL, 
	@SecondaryRhythm int = NULL, 
	@SecondaryAdditionalMedications varchar(150) = NULL, 
	@SecondaryBodyHoldPlaced smalldatetime = NULL, 
	@SecondaryBodyHoldPlacedWith varchar(25) = NULL, 
	@SecondaryBodyFutureContact varchar(25) = NULL, 
	@SecondaryBodyHoldPhone varchar(14) = NULL, 
	@SecondaryBodyHoldInstructionsGiven smallint = NULL, 
	@SecondarySteroid smallint = NULL, 
	@SecondaryBodyHoldPlacedTime varchar(10) = NULL, 
	@LastStatEmployeeID int, 
	@AuditLogTypeID int = NULL

AS

/******************************************************************************
**		File: UpdateSecondary.sql
**		Name: UpdateSecondary
**		Desc: 
**
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**     see list above
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail
*******************************************************************************/
UPDATE 
	Secondary 
SET 
	SecondaryWhoAreWe = @SecondaryWhoAreWe, 
	SecondaryNOKaware = ISNULL(@SecondaryNOKaware, SecondaryNOKaware), 
	SecondaryFamilyConsent = ISNULL(@SecondaryFamilyConsent, SecondaryFamilyConsent), 
	SecondaryFamilyInterested = ISNULL(@SecondaryFamilyInterested, SecondaryFamilyInterested), 
	SecondaryNOKatHospital = ISNULL(@SecondaryNOKatHospital, SecondaryNOKatHospital), 
	SecondaryEstTimeSinceLeft = @SecondaryEstTimeSinceLeft, 
	SecondaryTimeLeftInMT = @SecondaryTimeLeftInMT, 
	SecondaryNOKNextDest = @SecondaryNOKNextDest, 
	SecondaryNOKETA = @SecondaryNOKETA, 
	SecondaryPatientMiddleName = @SecondaryPatientMiddleName, 
	SecondaryPatientHeightFeet = @SecondaryPatientHeightFeet, 
	SecondaryPatientHeightInches = @SecondaryPatientHeightInches, 
	SecondaryPatientBMICalc = @SecondaryPatientBMICalc, 
	SecondaryPatientTOD1 = @SecondaryPatientTOD1, 
	SecondaryPatientTOD2 = @SecondaryPatientTOD2, 
	SecondaryPatientDeathType1 = ISNULL(@SecondaryPatientDeathType1, SecondaryPatientDeathType1), 
	SecondaryPatientDeathType2 = ISNULL(@SecondaryPatientDeathType2, SecondaryPatientDeathType2), 
	SecondaryTriageHX = @SecondaryTriageHX, 
	SecondaryCircumstanceOfDeath = @SecondaryCircumstanceOfDeath, 
	SecondaryMedicalHistory = @SecondaryMedicalHistory, 
	SecondaryAdmissionDiagnosis = @SecondaryAdmissionDiagnosis, 
	SecondaryCOD = ISNULL(@SecondaryCOD, SecondaryCOD), 
	SecondaryCODSignatory = @SecondaryCODSignatory, 
	SecondaryCODTime = @SecondaryCODTime, 
	SecondaryCODSignedBy = @SecondaryCODSignedBy, 
	SecondaryPatientVent = ISNULL(@SecondaryPatientVent, SecondaryPatientVent), 
	SecondaryIntubationDate = @SecondaryIntubationDate, 
	SecondaryIntubationTime = @SecondaryIntubationTime, 
	SecondaryBrainDeathDate = @SecondaryBrainDeathDate, 
	SecondaryBrainDeathTime = @SecondaryBrainDeathTime, 
	SecondaryDNRDate = @SecondaryDNRDate, 
	SecondaryERORDeath = ISNULL(@SecondaryERORDeath, SecondaryERORDeath), 
	SecondaryEMSArrivalToPatientDate = @SecondaryEMSArrivalToPatientDate, 
	SecondaryEMSArrivalToPatientTime = @SecondaryEMSArrivalToPatientTime, 
	SecondaryEMSArrivalToHospitalDate = @SecondaryEMSArrivalToHospitalDate, 
	SecondaryEMSArrivalToHospitalTime = @SecondaryEMSArrivalToHospitalTime, 
	SecondaryPatientTerminal = ISNULL(@SecondaryPatientTerminal, SecondaryPatientTerminal), 
	SecondaryDeathWitnessed = ISNULL(@SecondaryDeathWitnessed, SecondaryDeathWitnessed), 
	SecondaryDeathWitnessedBy = @SecondaryDeathWitnessedBy, 
	SecondaryLSADate = @SecondaryLSADate, 
	SecondaryLSATime = @SecondaryLSATime, 
	SecondaryLSABy = @SecondaryLSABy, 
	SecondaryACLSProvided = ISNULL(@SecondaryACLSProvided, SecondaryACLSProvided), 
	SecondaryACLSProvidedTime = @SecondaryACLSProvidedTime, 
	SecondaryGestationalAge = @SecondaryGestationalAge, 
	SecondaryParentName1 = @SecondaryParentName1, 
	SecondaryParentName2 = @SecondaryParentName2, 
	SecondaryBirthCBO = @SecondaryBirthCBO, 
	SecondaryActiveInfection = ISNULL(@SecondaryActiveInfection, SecondaryActiveInfection), 
	SecondaryActiveInfectionType = @SecondaryActiveInfectionType, 
	SecondaryFluidsGiven = ISNULL(@SecondaryFluidsGiven, SecondaryFluidsGiven), 
	SecondaryBloodLoss = ISNULL(@SecondaryBloodLoss, SecondaryBloodLoss), 
	SecondarySignOfInfection = ISNULL(@SecondarySignOfInfection, SecondarySignOfInfection), 
	SecondaryMedication = ISNULL(@SecondaryMedication, SecondaryMedication), 
	SecondaryAntibiotic = ISNULL(@SecondaryAntibiotic, SecondaryAntibiotic), 
	SecondaryPCPName = @SecondaryPCPName, 
	SecondaryPCPPhone = @SecondaryPCPPhone, 
	SecondaryMDAttending = @SecondaryMDAttending, 
	SecondaryMDAttendingPhone = @SecondaryMDAttendingPhone, 
	SecondaryPhysicalAppearance = @SecondaryPhysicalAppearance, 
	SecondaryInternalBloodLossCC = @SecondaryInternalBloodLossCC, 
	SecondaryExternalBloodLossCC = @SecondaryExternalBloodLossCC, 
	SecondaryBloodProducts = ISNULL(@SecondaryBloodProducts, SecondaryBloodProducts), 
	SecondaryColloidsInfused = ISNULL(@SecondaryColloidsInfused, SecondaryColloidsInfused), 
	SecondaryCrystalloids = ISNULL(@SecondaryCrystalloids, SecondaryCrystalloids), 
	SecondaryPreTransfusionSampleRequired = ISNULL(@SecondaryPreTransfusionSampleRequired, SecondaryPreTransfusionSampleRequired), 
	SecondaryPreTransfusionSampleAvailable = ISNULL(@SecondaryPreTransfusionSampleAvailable, SecondaryPreTransfusionSampleAvailable), 
	SecondaryPreTransfusionSampleDrawnDate = @SecondaryPreTransfusionSampleDrawnDate, 
	SecondaryPreTransfusionSampleDrawnTime = @SecondaryPreTransfusionSampleDrawnTime, 
	SecondaryPreTransfusionSampleQuantity = @SecondaryPreTransfusionSampleQuantity, 
	SecondaryPreTransfusionSampleHeldAt = @SecondaryPreTransfusionSampleHeldAt, 
	SecondaryPreTransfusionSampleHeldDate = @SecondaryPreTransfusionSampleHeldDate, 
	SecondaryPreTransfusionSampleHeldTime = @SecondaryPreTransfusionSampleHeldTime, 
	SecondaryPreTransfusionSampleHeldTechnician = @SecondaryPreTransfusionSampleHeldTechnician, 
	SecondaryPostMordemSampleTestSuitable = ISNULL(@SecondaryPostMordemSampleTestSuitable, SecondaryPostMordemSampleTestSuitable), 
	SecondaryPostMordemSampleLocation = @SecondaryPostMordemSampleLocation, 
	SecondaryPostMordemSampleContact = @SecondaryPostMordemSampleContact, 
	SecondaryPostMordemSampleCollectionDate = @SecondaryPostMordemSampleCollectionDate, 
	SecondaryPostMordemSampleCollectionTime = @SecondaryPostMordemSampleCollectionTime, 
	SecondarySputumCharacteristics = @SecondarySputumCharacteristics, 
	SecondaryNOKAltPhone = @SecondaryNOKAltPhone, 
	SecondaryNOKLegal = ISNULL(@SecondaryNOKLegal, SecondaryNOKLegal), 
	SecondaryNOKAltContact = @SecondaryNOKAltContact, 
	SecondaryNOKAltContactPhone = @SecondaryNOKAltContactPhone, 
	SecondaryNOKPostMortemAuthorization = ISNULL(@SecondaryNOKPostMortemAuthorization, SecondaryNOKPostMortemAuthorization), 
	SecondaryNOKPostMortemAuthorizationReminder = @SecondaryNOKPostMortemAuthorizationReminder, 
	SecondaryCoronerCaseNumber = @SecondaryCoronerCaseNumber, 
	SecondaryCoronerCounty = @SecondaryCoronerCounty, 
	SecondaryCoronerReleased = @SecondaryCoronerReleased, 
	SecondaryCoronerReleasedStipulations = @SecondaryCoronerReleasedStipulations, 
	SecondaryAutopsy = ISNULL(@SecondaryAutopsy, SecondaryAutopsy), 
	SecondaryAutopsyDate = @SecondaryAutopsyDate, 
	SecondaryAutopsyTime = @SecondaryAutopsyTime, 
	SecondaryAutopsyLocation = ISNULL(@SecondaryAutopsyLocation, SecondaryAutopsyLocation), 
	SecondaryAutopsyBloodRequested = ISNULL(@SecondaryAutopsyBloodRequested, SecondaryAutopsyBloodRequested), 
	SecondaryAutopsyCopyRequested = ISNULL(@SecondaryAutopsyCopyRequested, SecondaryAutopsyCopyRequested), 
	SecondaryFuneralHomeSelected = ISNULL(@SecondaryFuneralHomeSelected, SecondaryFuneralHomeSelected), 
	SecondaryFuneralHomeName = @SecondaryFuneralHomeName, 
	SecondaryFuneralHomePhone = @SecondaryFuneralHomePhone, 
	SecondaryFuneralHomeAddress = @SecondaryFuneralHomeAddress, 
	SecondaryFuneralHomeContact = @SecondaryFuneralHomeContact, 
	SecondaryFuneralHomeNotified = @SecondaryFuneralHomeNotified, 
	SecondaryFuneralHomeMorgueCooled = @SecondaryFuneralHomeMorgueCooled, 
	SecondaryHoldOnBody = ISNULL(@SecondaryHoldOnBody, SecondaryHoldOnBody), 
	SecondaryHoldOnBodyTag = @SecondaryHoldOnBodyTag, 
	SecondaryBodyRefrigerationDate = @SecondaryBodyRefrigerationDate, 
	SecondaryBodyRefrigerationTime = @SecondaryBodyRefrigerationTime, 
	SecondaryBodyLocation = @SecondaryBodyLocation, 
	SecondaryBodyMedicalChartLocation = @SecondaryBodyMedicalChartLocation, 
	SecondaryBodyIDTagLocation = @SecondaryBodyIDTagLocation, 
	SecondaryBodyCoolingMethod = @SecondaryBodyCoolingMethod, 
	SecondaryUNOSNumber = @SecondaryUNOSNumber, 
	SecondaryClientNumber = @SecondaryClientNumber, 
	SecondaryCryolifeNumber = @SecondaryCryolifeNumber, 
	SecondaryMTFNumber = @SecondaryMTFNumber, 
	SecondaryLifeNetNumber = @SecondaryLifeNetNumber, 
	SecondaryFreeText = @SecondaryFreeText, 
	SecondaryHistorySubstanceAbuse = ISNULL(@SecondaryHistorySubstanceAbuse, SecondaryHistorySubstanceAbuse), 
	SecondarySubstanceAbuseDetail = @SecondarySubstanceAbuseDetail, 
	SecondaryExtubationDate = @SecondaryExtubationDate, 
	SecondaryExtubationTime = @SecondaryExtubationTime, 
	SecondaryAutopsyReminderYN = ISNULL(@SecondaryAutopsyReminderYN, SecondaryAutopsyReminderYN), 
	SecondaryFHReminderYN = ISNULL(@SecondaryFHReminderYN, SecondaryFHReminderYN), 
	SecondaryBodyCareReminderYN = ISNULL(@SecondaryBodyCareReminderYN, SecondaryBodyCareReminderYN), 
	SecondaryWrapUpReminderYN = ISNULL(@SecondaryWrapUpReminderYN, SecondaryWrapUpReminderYN), 
	SecondaryNOKNotifiedBy = @SecondaryNOKNotifiedBy, 
	SecondaryNOKNotifiedDate = @SecondaryNOKNotifiedDate, 
	SecondaryNOKNotifiedTime = @SecondaryNOKNotifiedTime, 
	SecondaryNOKGender = @SecondaryNOKGender, 
	SecondaryCODOther = @SecondaryCODOther, 
	SecondaryAutopsyLocationOther = @SecondaryAutopsyLocationOther, 
	SecondaryPatientHospitalPhone = @SecondaryPatientHospitalPhone, 
	SecondaryCoronerCase = ISNULL(@SecondaryCoronerCase, SecondaryCoronerCase), 
	SecondaryPatientABO = ISNULL(@SecondaryPatientABO, SecondaryPatientABO), 
	SecondaryPatientSuffix = @SecondaryPatientSuffix, 
	SecondaryMDAttendingId = ISNULL(@SecondaryMDAttendingId, SecondaryMDAttendingId), 
	SecondaryAdditionalComments = @SecondaryAdditionalComments, 
	SecondaryRhythm = ISNULL(@SecondaryRhythm, SecondaryRhythm), 
	SecondaryAdditionalMedications = @SecondaryAdditionalMedications, 
	SecondaryBodyHoldPlaced = ISNULL(@SecondaryBodyHoldPlaced, SecondaryBodyHoldPlaced), 
	SecondaryBodyHoldPlacedWith = @SecondaryBodyHoldPlacedWith, 
	SecondaryBodyFutureContact = @SecondaryBodyFutureContact, 
	SecondaryBodyHoldPhone = @SecondaryBodyHoldPhone, 
	SecondaryBodyHoldInstructionsGiven = ISNULL(@SecondaryBodyHoldInstructionsGiven, SecondaryBodyHoldInstructionsGiven), 
	SecondarySteroid = ISNULL(@SecondarySteroid, SecondarySteroid), 
	SecondaryBodyHoldPlacedTime = @SecondaryBodyHoldPlacedTime, 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify
	LastModified = GetDate()

WHERE 
	CallID = @CallID 



GO

GRANT EXEC ON UpdateSecondary TO PUBLIC

GO
