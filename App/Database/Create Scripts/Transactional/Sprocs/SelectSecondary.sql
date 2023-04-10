IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectSecondary')
	BEGIN
		PRINT 'Dropping Procedure SelectSecondary'
		PRINT GETDATE()
		DROP Procedure SelectSecondary
	END
GO

PRINT 'Creating Procedure SelectSecondary'
PRINT GETDATE()
GO
CREATE Procedure SelectSecondary
(
		@CallID int = null
)
AS
/******************************************************************************
**	File: SelectSecondary.sql
**	Name: SelectSecondary
**	Desc: Selects Secondary data from call id.
**  Note:  
**	Auth: ccarroll
**	Date: 12/3/2010
**	Called By: modStatQuery.QuerySecondarySecData
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	09/08/2011		ccarroll			Initial Sproc Creation
*******************************************************************************/
	SET NOCOUNT ON

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		SecondaryNOKNotifiedBy,
		SecondaryNOKNextDest,
		SecondaryPatientMiddleName,
		SecondaryPatientHeightFeet,
		SecondaryPatientHeightInches,
		SecondaryPatientBMICalc,
		SecondaryAdmissionDiagnosis,
		SecondaryCODSignatory,
		SecondaryCODTime,
		SecondaryCODSignedBy,
		SecondaryDeathWitnessedBy,
		SecondaryPCPName,
		SecondaryPCPPhone,
		SecondaryMDAttendingPhone,
		SecondaryInternalBloodLossCC,
		SecondaryExternalBloodLossCC,
		SecondaryPreTransfusionSampleQuantity,
		SecondaryPreTransfusionSampleHeldTechnician,
		SecondaryPostMordemSampleLocation,
		SecondaryPostMordemSampleContact,
		SecondarySputumCharacteristics,
		SecondaryNOKAltPhone,
		SecondaryNOKAltContact,
		SecondaryNOKAltContactPhone,
		SecondaryNOKPostMortemAuthorizationReminder,
		SecondaryCoronerCaseNumber,
		SecondaryCoronerCounty,
		SecondaryCoronerReleasedStipulations,
		SecondaryFuneralHomeName,
		SecondaryFuneralHomePhone,
		SecondaryFuneralHomeAddress,
		SecondaryFuneralHomeContact,
		SecondaryHoldOnBodyTag,
		SecondaryBodyLocation,
		SecondaryBodyMedicalChartLocation,
		SecondaryBodyIDTagLocation,
		SecondaryUNOSNumber,
		SecondaryClientNumber,
		SecondaryCryolifeNumber,
		SecondaryMTFNumber,
		SecondaryLifeNetNumber,
		SecondaryFreeText,
		SecondaryPatientSuffix,
		SecondaryBodyHoldPlacedWith,
		SecondaryBodyFutureContact,
		SecondaryBodyHoldPhone,
		SecondaryIntubationDate,
		SecondaryBrainDeathDate,
		SecondaryDNRDate,
		ReferralDonorLSADate AS SecondaryLSADate,
		SecondaryPreTransfusionSampleDrawnDate,
		SecondaryPreTransfusionSampleHeldDate,
		SecondaryPostMordemSampleCollectionDate,
		SecondaryAutopsyDate,
		SecondaryBodyRefrigerationDate,
		SecondaryExtubationDate,
		SecondaryNOKNotifiedDate,
		SecondaryBodyHoldPlaced,
		SecondaryEstTimeSinceLeft,
		SecondaryTimeLeftInMT,
		SecondaryIntubationTime,
		SecondaryBrainDeathTime,
		SecondaryEMSArrivalToPatientTime,
		SecondaryEMSArrivalToHospitalTime,
		ReferralDonorLSATime AS SecondaryLSATime,
		SecondaryPreTransfusionSampleDrawnTime,
		SecondaryPreTransfusionSampleHeldTime,
		SecondaryPostMordemSampleCollectionTime,
		SecondaryAutopsyTime,
		SecondaryBodyRefrigerationTime,
		SecondaryExtubationTime,
		SecondaryNOKNotifiedTime,
		SecondaryNOKETA,
		SecondaryBodyHoldPlacedTime,
		SecondaryPreTransfusionSampleRequired,
		SecondaryPreTransfusionSampleAvailable,
		SecondaryNOKaware,SecondaryFamilyConsent,
		SecondaryFamilyInterested,
		SecondaryNOKatHospital,
		SecondaryPatientVent,
		SecondaryDeathWitnessed,
		SecondaryFluidsGiven,
		SecondaryBloodLoss,
		SecondarySignOfInfection,
		SecondaryMedication,
		SecondaryAntibiotic,
		SecondaryBloodProducts,
		SecondaryColloidsInfused,
		SecondaryCrystalloids,
		SecondaryPostMordemSampleTestSuitable,
		SecondaryNOKLegal,
		SecondaryNOKPostMortemAuthorization,
		SecondaryAutopsy,
		SecondaryAutopsyBloodRequested,
		SecondaryAutopsyCopyRequested,
		SecondaryFuneralHomeSelected,
		SecondaryHoldOnBody,
		SecondaryHistorySubstanceAbuse,
		SecondaryAutopsyReminderYN,
		SecondaryFHReminderYN,
		SecondaryBodyCareReminderYN,
		SecondaryWrapUpReminderYN,
		SecondaryFuneralHomeNotified,
		SecondaryFuneralHomeMorgueCooled,
		SecondaryPatientABO,SecondaryRhythm,
		SecondarySteroid,SecondaryCoronerCase,
		SecondaryCOD,
		SecondaryAutopsyLocation,
		SecondaryNOKGender,
		SecondaryCoronerReleased,
		SecondaryPreTransfusionSampleHeldAt,
		SecondaryBodyCoolingMethod,
		SecondaryCircumstanceOfDeath,
		SecondaryMedicalHistory,
		SecondaryPhysicalAppearance,
		SecondarySubstanceAbuseDetail,
		SecondaryAdditionalComments,
		SecondaryAdditionalMedications,
		SecondaryBodyHoldInstructionsGiven,
		SecondaryCODOther,
		SecondaryAutopsyLocationOther
	FROM Secondary
	JOIN Referral ON Referral.CallID = Secondary.CallID
	WHERE Secondary.CallID = @CallId

GO

GRANT EXEC ON SelectSecondary TO PUBLIC
GO
