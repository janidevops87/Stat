﻿using System.Collections.ObjectModel;

#nullable disable

namespace Statline.StatTrac.Domain.Referrals;

public sealed class ReferralSecondary
{
    internal ReferralSecondary() { }
    public DateTime? FSCaseApproachDateTime { get; private set; }
    public int? FSCaseApproachUserId { get; private set; }
    public short? FSCaseBillApproachCount { get; private set; }
    public DateTime? FSCaseBillApproachDateTime { get; private set; }
    public int? FSCaseBillApproachUserID { get; private set; }
    public short? FSCaseBillCryoFormCount { get; private set; }
    public DateTime? FSCaseBillCryoFormDateTime { get; private set; }
    public int? FSCaseBillCryoFormUserId { get; private set; }
    public DateTime? FSCaseBillDateTime { get; private set; }
    public DateTime? FSCaseBillFamUnavailDateTime { get; private set; }
    public int? FSCaseBillFamUnavailUserId { get; private set; }
    public short? FSCaseBillMedSocCount { get; private set; }
    public DateTime? FSCaseBillMedSocDateTime { get; private set; }
    public int? FSCaseBillMedSocUserID { get; private set; }
    public int? FSCaseBillSecondaryUserID { get; private set; }
    public DateTime? FSCaseCreateDateTime { get; private set; }
    public int? FSCaseCreateUserId { get; private set; }
    public DateTime? FSCaseFinalDateTime { get; private set; }
    public int? FSCaseFinalUserId { get; private set; }
    public DateTime? FSCaseOpenDateTime { get; private set; }
    public int? FSCaseOpenUserId { get; private set; }
    public DateTime? FSCaseSecCompDateTime { get; private set; }
    public int? FSCaseSecCompUserId { get; private set; }
    public int? FSCaseSeconds { get; private set; }
    public DateTime? FSCaseSysEventsDateTime { get; private set; }
    public int? FSCaseSysEventsUserId { get; private set; }
    public string FSCaseTotalTime { get; private set; }
    public DateTime? FSCaseUpdate { get; private set; }
    public int? FSCaseUserId { get; private set; }
    public short? SecondaryActiveInfection { get; private set; }
    public string SecondaryAdditionalComments { get; private set; }
    public string SecondaryAdditionalMedications { get; private set; }
    public string SecondaryAdmissionDiagnosis { get; private set; }
    public short? SecondaryAntibiotic { get; private set; }
    public short? SecondaryApproached { get; private set; }
    public int? SecondaryApproachedBy { get; private set; }
    public short? SecondaryApproachOutcome { get; private set; }
    public short? SecondaryApproachReason { get; private set; }
    public short? SecondaryApproachType { get; private set; }
    public short? SecondaryAutopsy { get; private set; }
    public short? SecondaryAutopsyBloodRequested { get; private set; }
    public short? SecondaryAutopsyCopyRequested { get; private set; }
    public DateTime? SecondaryAutopsyDate { get; private set; }
    public int? SecondaryAutopsyLocation { get; private set; }
    public string SecondaryAutopsyLocationOther { get; private set; }
    public short? SecondaryAutopsyReminderYN { get; private set; }
    public string SecondaryAutopsyTime { get; private set; }
    public string SecondaryBirthCBO { get; private set; }
    public short? SecondaryBloodLoss { get; private set; }
    public short? SecondaryBloodProducts { get; private set; }
    public int? SecondaryBloodProductsReceived1Type { get; private set; }
    public string SecondaryBloodProductsReceived1TypeCC { get; private set; }
    public string SecondaryBloodProductsReceived1TypeOther { get; private set; }
    public string SecondaryBloodProductsReceived1TypeUnitGiven { get; private set; }
    public string SecondaryBloodProductsReceived1Units { get; private set; }
    public int? SecondaryBloodProductsReceived2Type { get; private set; }
    public string SecondaryBloodProductsReceived2TypeCC { get; private set; }
    public string SecondaryBloodProductsReceived2TypeOther { get; private set; }
    public string SecondaryBloodProductsReceived2TypeUnitGiven { get; private set; }
    public string SecondaryBloodProductsReceived2Units { get; private set; }
    public int? SecondaryBloodProductsReceived3Type { get; private set; }
    public string SecondaryBloodProductsReceived3TypeCC { get; private set; }
    public string SecondaryBloodProductsReceived3TypeOther { get; private set; }
    public string SecondaryBloodProductsReceived3TypeUnitGiven { get; private set; }
    public string SecondaryBloodProductsReceived3Units { get; private set; }
    public short? SecondaryBodyCareReminderYN { get; private set; }
    public string SecondaryBodyCoolingMethod { get; private set; }
    public string SecondaryBodyFutureContact { get; private set; }
    public short? SecondaryBodyHoldInstructionsGiven { get; private set; }
    public string SecondaryBodyHoldPhone { get; private set; }
    public DateTime? SecondaryBodyHoldPlaced { get; private set; }
    public string SecondaryBodyHoldPlacedTime { get; private set; }
    public string SecondaryBodyHoldPlacedWith { get; private set; }
    public string SecondaryBodyLocation { get; private set; }
    public DateTime? SecondaryBodyRefrigerationDate { get; private set; }
    public string SecondaryBodyRefrigerationTime { get; private set; }
    public DateTime? SecondaryBrainDeathDate { get; private set; }
    public string SecondaryBrainDeathTime { get; private set; }
    public string SecondaryCircumstanceOfDeath { get; private set; }
    public string SecondaryClientNumber { get; private set; }
    public int? SecondaryCOD { get; private set; }
    public string SecondaryCODOther { get; private set; }
    public string SecondaryCODSignatory { get; private set; }
    public short? SecondaryColloidsInfused { get; private set; }
    public string SecondaryColloidsInfused1CC { get; private set; }
    public int? SecondaryColloidsInfused1Type { get; private set; }
    public string SecondaryColloidsInfused1TypeOther { get; private set; }
    public string SecondaryColloidsInfused1UnitGiven { get; private set; }
    public string SecondaryColloidsInfused1Units { get; private set; }
    public string SecondaryColloidsInfused2CC { get; private set; }
    public int? SecondaryColloidsInfused2Type { get; private set; }
    public string SecondaryColloidsInfused2TypeOther { get; private set; }
    public string SecondaryColloidsInfused2UnitGiven { get; private set; }
    public string SecondaryColloidsInfused2Units { get; private set; }
    public string SecondaryColloidsInfused3CC { get; private set; }
    public int? SecondaryColloidsInfused3Type { get; private set; }
    public string SecondaryColloidsInfused3TypeOther { get; private set; }
    public string SecondaryColloidsInfused3UnitGiven { get; private set; }
    public string SecondaryColloidsInfused3Units { get; private set; }
    public int? SecondaryConsentBy { get; private set; }
    public short? SecondaryConsented { get; private set; }
    public short? SecondaryConsentFuneralPlans { get; private set; }
    public string SecondaryConsentFuneralPlansOther { get; private set; }
    public short? SecondaryConsentLongSleeves { get; private set; }
    public int? SecondaryConsentMedSocObtainedBy { get; private set; }
    public short? SecondaryConsentMedSocPaperwork { get; private set; }
    public short? SecondaryConsentResearch { get; private set; }
    public short? SecondaryCoronerCase { get; private set; }
    public string SecondaryCoronerCaseNumber { get; private set; }
    public string SecondaryCoronerCounty { get; private set; }
    public string SecondaryCoronerReleased { get; private set; }
    public string SecondaryCoronerReleasedStipulations { get; private set; }
    public string SecondaryCryolifeNumber { get; private set; }
    public short? SecondaryCrystalloids { get; private set; }
    public string SecondaryCrystalloids1CC { get; private set; }
    public int? SecondaryCrystalloids1Type { get; private set; }
    public string SecondaryCrystalloids1TypeOther { get; private set; }
    public string SecondaryCrystalloids1UnitGiven { get; private set; }
    public string SecondaryCrystalloids1Units { get; private set; }
    public string SecondaryCrystalloids2CC { get; private set; }
    public int? SecondaryCrystalloids2Type { get; private set; }
    public string SecondaryCrystalloids2TypeOther { get; private set; }
    public string SecondaryCrystalloids2UnitGiven { get; private set; }
    public string SecondaryCrystalloids2Units { get; private set; }
    public string SecondaryCrystalloids3CC { get; private set; }
    public int? SecondaryCrystalloids3Type { get; private set; }
    public string SecondaryCrystalloids3TypeOther { get; private set; }
    public string SecondaryCrystalloids3UnitGiven { get; private set; }
    public string SecondaryCrystalloids3Units { get; private set; }
    public DateTime? SecondaryCulture1DrawnDate { get; private set; }
    public string SecondaryCulture1Growth { get; private set; }
    public string SecondaryCulture1Other { get; private set; }
    public int? SecondaryCulture1Type { get; private set; }
    public DateTime? SecondaryCulture2DrawnDate { get; private set; }
    public string SecondaryCulture2Growth { get; private set; }
    public string SecondaryCulture2Other { get; private set; }
    public int? SecondaryCulture2Type { get; private set; }
    public DateTime? SecondaryCulture3DrawnDate { get; private set; }
    public string SecondaryCulture3Growth { get; private set; }
    public string SecondaryCulture3Other { get; private set; }
    public int? SecondaryCulture3Type { get; private set; }
    public DateTime? SecondaryCXR1Date { get; private set; }
    public string SecondaryCXR1Finding { get; private set; }
    public DateTime? SecondaryCXR2Date { get; private set; }
    public string SecondaryCXR2Finding { get; private set; }
    public DateTime? SecondaryCXR3Date { get; private set; }
    public string SecondaryCXR3Finding { get; private set; }
    public int? SecondaryCXRAvailable { get; private set; }
    public short? SecondaryDeathWitnessed { get; private set; }
    public string SecondaryDeathWitnessedBy { get; private set; }
    public DateTime? SecondaryDNRDate { get; private set; }
    public string SecondaryEMSArrivalToHospitalTime { get; private set; }
    public string SecondaryEMSArrivalToPatientTime { get; private set; }
    public string SecondaryEstTimeSinceLeft { get; private set; }
    public string SecondaryExternalBloodLossCC { get; private set; }
    public short? SecondaryFamilyConsent { get; private set; }
    public short? SecondaryFamilyInterested { get; private set; }
    public short? SecondaryFHReminderYN { get; private set; }
    public short? SecondaryFluidsGiven { get; private set; }
    public string SecondaryFreeText { get; private set; }
    public string SecondaryFuneralHomeAddress { get; private set; }
    public string SecondaryFuneralHomeContact { get; private set; }
    public string SecondaryFuneralHomeMorgueCooled { get; private set; }
    public string SecondaryFuneralHomeName { get; private set; }
    public string SecondaryFuneralHomeNotified { get; private set; }
    public string SecondaryFuneralHomePhone { get; private set; }
    public short? SecondaryFuneralHomeSelected { get; private set; }
    public short? SecondaryHistorySubstanceAbuse { get; private set; }
    public short? SecondaryHoldOnBody { get; private set; }
    public string SecondaryHoldOnBodyTag { get; private set; }
    public short? SecondaryHospitalApproach { get; private set; }
    public int? SecondaryHospitalApproachedBy { get; private set; }
    public short? SecondaryHospitalOutcome { get; private set; }
    public string SecondaryInternalBloodLossCC { get; private set; }
    public string SecondaryLabTemp1 { get; private set; }
    public DateTime? SecondaryLabTemp1Date { get; private set; }
    public string SecondaryLabTemp1Time { get; private set; }
    public string SecondaryLabTemp2 { get; private set; }
    public DateTime? SecondaryLabTemp2Date { get; private set; }
    public string SecondaryLabTemp2Time { get; private set; }
    public string SecondaryLabTemp3 { get; private set; }
    public DateTime? SecondaryLabTemp3Date { get; private set; }
    public string SecondaryLabTemp3Time { get; private set; }
    public string SecondaryLifeNetNumber { get; private set; }
    public DateTime? SecondaryLSADate { get; private set; }
    public string SecondaryLSATime { get; private set; }
    public int? SecondaryManualBillPersonId { get; private set; }
    public string SecondaryMDAttending { get; private set; }
    public int? SecondaryMDAttendingId { get; private set; }
    public string SecondaryMDAttendingPhone { get; private set; }
    public string SecondaryMedicalHistory { get; private set; }
    public short? SecondaryMedication { get; private set; }
    public string SecondaryMTFNumber { get; private set; }
    public string SecondaryNOKAltContact { get; private set; }
    public string SecondaryNOKAltContactPhone { get; private set; }
    public string SecondaryNOKAltPhone { get; private set; }
    public short? SecondaryNOKatHospital { get; private set; }
    public short? SecondaryNOKaware { get; private set; }
    public string SecondaryNOKETA { get; private set; }
    public string SecondaryNOKGender { get; private set; }
    public short? SecondaryNOKLegal { get; private set; }
    public string SecondaryNOKNextDest { get; private set; }
    public string SecondaryNOKNotifiedBy { get; private set; }
    public DateTime? SecondaryNOKNotifiedDate { get; private set; }
    public string SecondaryNOKNotifiedTime { get; private set; }
    public short? SecondaryNOKPostMortemAuthorization { get; private set; }
    public string SecondaryNOKPostMortemAuthorizationReminder { get; private set; }
    public int? SecondaryPatientABO { get; private set; }
    public string SecondaryPatientBMICalc { get; private set; }
    public string SecondaryPatientHeightFeet { get; private set; }
    public string SecondaryPatientHeightInches { get; private set; }
    public string SecondaryPatientHospitalPhone { get; private set; }
    public string SecondaryPatientMiddleName { get; private set; }
    public string SecondaryPatientSuffix { get; private set; }
    public short? SecondaryPatientVent { get; private set; }
    public string SecondaryPCPName { get; private set; }
    public string SecondaryPCPPhone { get; private set; }
    public string SecondaryPhysicalAppearance { get; private set; }
    public DateTime? SecondaryPostMordemSampleCollectionDate { get; private set; }
    public string SecondaryPostMordemSampleCollectionTime { get; private set; }
    public string SecondaryPostMordemSampleContact { get; private set; }
    public string SecondaryPostMordemSampleLocation { get; private set; }
    public short? SecondaryPostMordemSampleTestSuitable { get; private set; }
    public short? SecondaryPreTransfusionSampleAvailable { get; private set; }
    public DateTime? SecondaryPreTransfusionSampleDrawnDate { get; private set; }
    public string SecondaryPreTransfusionSampleDrawnTime { get; private set; }
    public string SecondaryPreTransfusionSampleHeldAt { get; private set; }
    public DateTime? SecondaryPreTransfusionSampleHeldDate { get; private set; }
    public string SecondaryPreTransfusionSampleHeldTechnician { get; private set; }
    public string SecondaryPreTransfusionSampleHeldTime { get; private set; }
    public string SecondaryPreTransfusionSampleQuantity { get; private set; }
    public short? SecondaryPreTransfusionSampleRequired { get; private set; }
    public int? SecondaryRhythm { get; private set; }
    public short? SecondarySignOfInfection { get; private set; }
    public string SecondarySputumCharacteristics { get; private set; }
    public short? SecondarySteroid { get; private set; }
    public string SecondarySubstanceAbuseDetail { get; private set; }
    public string SecondaryTimeLeftInMT { get; private set; }
    public string SecondaryUNOSNumber { get; private set; }
    public short? SecondaryUpdatedFlag { get; private set; }
    public string SecondaryWBC1 { get; private set; }
    public string SecondaryWBC1Bands { get; private set; }
    public DateTime? SecondaryWBC1Date { get; private set; }
    public string SecondaryWBC2 { get; private set; }
    public string SecondaryWBC2Bands { get; private set; }
    public DateTime? SecondaryWBC2Date { get; private set; }
    public string SecondaryWBC3 { get; private set; }
    public string SecondaryWBC3Bands { get; private set; }
    public DateTime? SecondaryWBC3Date { get; private set; }
    public short? SecondaryWrapUpReminderYN { get; private set; }
    public string TBIComment { get; private set; }
    public int TBINotNeeded { get; private set; }
    public string TBINumber { get; private set; }
    public Collection<ReferralMedicationOther> Antibiotics { get; } = new Collection<ReferralMedicationOther>();
    public Collection<ReferralMedicationOther> Steroids { get; } = new Collection<ReferralMedicationOther>();
    public Collection<string> Medications { get; } = new Collection<string>();
}
