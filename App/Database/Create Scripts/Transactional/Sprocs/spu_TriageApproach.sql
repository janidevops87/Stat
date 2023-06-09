SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_TriageApproach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'drop procedure spu_TriageApproach';
	drop procedure [dbo].[spu_TriageApproach];
END	
	PRINT 'create procedure spu_TriageApproach';
GO



CREATE PROCEDURE spu_TriageApproach
	@CallId INT,
	@LastStatEmployeeID INT
AS
/******************************************************************************
**		File: spu_TriageApproach.sql
**		Name: spu_TriageApproach
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   StatTrac.ModStatSave.SaveSecondaryApproach
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**     see list above
**
**		Auth: Unknown
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      07/03/07	Bret Knoll			8.4.3.8 AuditTrail
**		09/08/11	ccarroll			Added LSA Date Time - CCRST151
**		10/22/14	Mike Berenson		Added ReferralDOB to update statement to avoid removing it
**		02/17/2020	Mike Berenson		Added EReferral parameter and replaced call to UpdateReferral with ReferralUpdate
**		05/19/2021	Pam Scheichenost	Added all fields for referral so REferralUpdate doesn't null out values.
*******************************************************************************/
DECLARE @SecondaryApproached int,
		@SecondaryApproachedBy int,
		@SecondaryApproachOutcome int,
		@SecondaryConsent int,
		@ReferralApproachTypeId int,
		@ReferralApproachedByPersonID int,
		@ReferralGeneralConsent int,
		@TempAppOutcome int,
		@SecondaryHospitalApproach int,
		@SecondaryHospitalApproachedBy int,
		@SecondaryHospitalOutcome int,
		@UpdateBlankValues int;


--GET SECONDARY APPROACH/CONSENT VALUES
SELECT @SecondaryApproached =  sa.SecondaryApproached,
	@SecondaryApproachedBy  =  sa.SecondaryApproachedBy,
	@SecondaryApproachOutcome =  sa.SecondaryApproachOutcome,
	@SecondaryConsent =  sa.SecondaryConsented,
	@SecondaryHospitalApproach =  sa.SecondaryHospitalApproach,
	@SecondaryHospitalApproachedBy =  sa.SecondaryHospitalApproachedBy,
	@SecondaryHospitalOutcome =  sa.SecondaryHospitalOutcome,
	@ReferralApproachTypeId = r.ReferralApproachTypeId,				--7/18/03 drh - Initialize Triage values with existing value
	@ReferralApproachedByPersonID = r.ReferralApproachedByPersonID,		--7/18/03 drh - Initialize Triage values with existing value
	@ReferralGeneralConsent = r.ReferralGeneralConsent				--7/18/03 drh - Initialize Triage values with existing value
FROM SecondaryApproach sa
JOIN Referral r ON sa.CallId = r.CallId
WHERE sa.CallId = @CallId;

--IF INFORMED APPROACH DONE IS "YES" AND INFORMED APPROACH OUTCOME IS NOT BLANK, USE INFORMED APPROACH; OTHERWISE, USE HOSPITAL APPROACH
IF ISNULL(@SecondaryApproached, -1) = 1 AND (ISNULL(@SecondaryApproachOutcome, -1) <> -1)
BEGIN
	--TRIAGE APPROACH TYPE IS "POST REF, DECOUPLED"
	SELECT @ReferralApproachTypeId = 5;
	SELECT @ReferralApproachedByPersonID = CASE WHEN ISNULL(@SecondaryApproachedBy, -1) = -1 THEN 0 ELSE @SecondaryApproachedBy END;	--Note: SecondaryApproachedBy uses -1 for blank values, but ReferralApproachedByPersonId uses 0 for blank values
	
	SELECT @ReferralGeneralConsent = CASE ISNULL(@SecondaryApproachOutcome, -1)
						WHEN -1 THEN -1	--When SecondaryApproachOutcome is blank, then ReferralGeneralConsent is blank
						WHEN 1 THEN 2	--When SecondaryApproachOutcome = "Yes - Verbal", then ReferralGeneralConsent = "Yes - Verbal"
						WHEN 2 THEN 1	--When SecondaryApproachOutcome = "Yes - Written", then ReferralGeneralConsent = "Yes - Written"
						WHEN 3 THEN 3	--When SecondaryApproachOutcome = "No", then ReferralGeneralConsent = "No"
						WHEN 4 THEN 3	--When SecondaryApproachOutcome = "Undecided", then ReferralGeneralConsent = "No"
					       END;
END
ELSE
BEGIN
	--IF HOSPITAL APPROACH IS BLANK, DO NOT UPDATE TRIAGE APPROACH INFORMATION (IE. USE EXISTING VALUES); OTHERWISE, USE HOSPITAL APPROACH
	IF ISNULL(@SecondaryHospitalApproach, -1) <> -1
	BEGIN
		SELECT @ReferralApproachTypeId = ISNULL(@SecondaryHospitalApproach, -1);
		SELECT @ReferralApproachedByPersonID = CASE WHEN ISNULL(@SecondaryHospitalApproachedBy, -1) = -1 THEN 0 ELSE @SecondaryHospitalApproachedBy END;	--Note: SecondaryHospitalApproachedBy uses -1 for blank values, but ReferralApproachedByPersonId uses 0 for blank values
		SELECT @ReferralGeneralConsent = ISNULL(@SecondaryHospitalOutcome, -1);
	END
END

--UPDATE THE REFERRAL WITH THE NEW TRIAGE APPROACH VALUES
SELECT 
	@ReferralApproachTypeId = ISNULL(@ReferralApproachTypeId, -1),
	@ReferralApproachedByPersonID = ISNULL(@ReferralApproachedByPersonID, 0),
	@ReferralGeneralConsent = ISNULL(@ReferralGeneralConsent, -1);

DECLARE
	@ReferralCallerPhoneID int,
	@ReferralCallerExtension varchar(10),
	@ReferralCallerOrganizationID int,
	@ReferralCallerSubLocationID int,
	@ReferralCallerSubLocationLevel varchar(4), 
	@ReferralCallerPersonID int,
	@ReferralDonorName varchar(80), 
	@ReferralDonorRecNumber varchar(30), 
	@ReferralDonorRecNumberSearchable varchar(30),
	@ReferralDonorAge varchar(4), 
	@ReferralDonorAgeUnit varchar(10), 
	@ReferralDonorRaceID int,
	@ReferralDonorGender char(1),
	@ReferralDonorWeight varchar(7), 
	@ReferralDonorAdmitDate smalldatetime,
	@ReferralDonorAdmitTime varchar(10), 
	@ReferralDonorDeathDate smalldatetime,
	@ReferralDonorDeathTime varchar(10), 
	@ReferralDonorLSADate smalldatetime, 
	@ReferralDonorLSATime varchar(10), 
	@ReferralDonorCauseOfDeathID int,
	@ReferralDonorOnVentilator varchar(20), 
	@ReferralDonorDead varchar(4),
	@ReferralTypeID int,
	@ReferralApproachNOK varchar(50),
	@ReferralApproachRelation varchar(50),
	@ReferralOrganAppropriateID int,
	@ReferralOrganApproachID int,
	@ReferralOrganConsentID int,
	@ReferralOrganConversionID int,
	@ReferralBoneAppropriateID int,
	@ReferralBoneApproachID int,
	@ReferralBoneConsentID int,
	@ReferralBoneConversionID int,
	@ReferralTissueAppropriateID int,
	@ReferralTissueApproachID int,
	@ReferralTissueConsentID int,
	@ReferralTissueConversionID int,
	@ReferralSkinAppropriateID int,
	@ReferralSkinApproachID int,
	@ReferralSkinConsentID int,
	@ReferralSkinConversionID int,
	@ReferralEyesTransAppropriateID int,
	@ReferralEyesTransApproachID int,
	@ReferralEyesTransConsentID int,
	@ReferralEyesTransConversionID int,
	@ReferralEyesRschAppropriateID int,
	@ReferralEyesRschApproachID int,
	@ReferralEyesRschConsentID int,
	@ReferralEyesRschConversionID int,
	@ReferralValvesAppropriateID int,
	@ReferralValvesApproachID int,
	@ReferralValvesConsentID int,
	@ReferralValvesConversionID int,
	@ReferralNotesCase varchar(400), 
	@ReferralNotesPrevious varchar(255),
	@ReferralVerifiedOptions smallint,
	@ReferralCoronersCase smallint,
	@Inactive smallint,
	@ReferralCallerLevelID int,
	@UnusedField1 smallint,
	@ReferralDonorFirstName varchar(40), 
	@ReferralDonorLastName varchar(40),
	@ReferralOrganDispositionID int,
	@ReferralBoneDispositionID int,
	@ReferralTissueDispositionID int,
	@ReferralSkinDispositionID int,
	@ReferralValvesDispositionID int,
	@ReferralEyesDispositionID int,
	@ReferralRschDispositionID int,
	@ReferralAllTissueDispositionID int,
	@ReferralPronouncingMD int,
	@UnusedField3 int,
	@ReferralNOKPhone varchar(14),
	@ReferralAttendingMD int,
	@ReferralNOKAddress varchar(255), 
	@ReferralCoronerName varchar(80), 
	@ReferralCoronerPhone varchar(14), 
	@ReferralCoronerOrganization varchar(80),
	@ReferralCoronerNote varchar(255), 
	@ReferralApproachTime numeric(7,0),
	@ReferralConsentTime numeric(7,0),
	@Unused smalldatetime,
	@ReferralDOA smallint,
	@ReferralDonorDOB datetime, 
	@ReferralDonorSSN varchar(11), 
	@UpdatedFlag smallint,
	@ReferralExtubated varchar(15), 
	@DonorRegistryType smallint,
	@DonorRegId int,
	@DonorDMVId int,
	@DonorDMVTable varchar(255), 
	@DonorIntentDone smallint,
	@DonorFaxSent smallint,
	@DonorDSNID smallint,
	@ReferralDonorHeartBeat int,
	@ReferralCoronerOrgID int,
	@CurrentReferralTypeId int,
	@ReferralDonorBrainDeathDate smalldatetime,
	@ReferralDonorBrainDeathTime varchar(10), 
	@ReferralPronouncingMDPhone varchar(14), 
	@ReferralAttendingMDPhone varchar(14), 
	@ReferralDOB_ILB smallint,
	@ReferralDonorSpecificCOD varchar(250),
	@ReferralDonorNameMI varchar(2),
	@ReferralNOKID int,
	@ReferralQAReviewComplete smallint,
	@Hiv int,
	@Aids int,
	@HepB int,
	@HepC int,
	@Ivda int,
	@IdentityUnknown int,
	@AgeEstimated int,
	@WeightEstimated int,
	@PastMedicalHistory varchar(950),
	@AdmittingDiagnosis varchar(950),
	@AuditLogTypeID int = 3,  --modified
	@IsERferralCase bit;



		
		
SELECT 
	@ReferralCallerPhoneID = ReferralCallerPhoneID,
	@ReferralCallerOrganizationID = ReferralCallerOrganizationID,
	@ReferralCallerExtension = ReferralCallerExtension,
	@ReferralCallerSubLocationID = ReferralCallerSubLocationID,
	@ReferralCallerSubLocationLevel = ReferralCallerSubLocationLevel, 
	@ReferralCallerPersonID = ReferralCallerPersonID, 
	@ReferralDonorName = ReferralDonorName, 
	@ReferralDonorRecNumber = ReferralDonorRecNumber, 
	@ReferralDonorRecNumberSearchable = ReferralDonorRecNumberSearchable,
	@ReferralDonorAge = ReferralDonorAge, 
	@ReferralDonorAgeUnit = ReferralDonorAgeUnit,
	@ReferralDonorRaceID = ReferralDonorRaceID,
	@ReferralDonorGender = ReferralDonorGender,
	@ReferralDonorWeight = ReferralDonorWeight, 
	@ReferralDonorAdmitTime = ReferralDonorAdmitTime, 
	@ReferralDonorAdmitDate = ReferralDonorAdmitDate, 
	@ReferralDonorDeathTime = ReferralDonorDeathTime, 
	@ReferralDonorDeathDate = ReferralDonorDeathDate,
	@ReferralDonorDOB = ReferralDOB,
	@ReferralDonorLSATime = ReferralDonorLSATime, 
	@ReferralDonorLSADate = ReferralDonorLSADate,
	@ReferralDonorCauseOfDeathID = ReferralDonorCauseOfDeathID,
	@ReferralDonorOnVentilator = ReferralDonorOnVentilator, 
	@ReferralDonorDead = ReferralDonorDead, 
	@ReferralTypeID = ReferralTypeID,
	@ReferralApproachNOK = ReferralApproachNOK, 
	@ReferralApproachRelation = ReferralApproachRelation, 
	@ReferralNotesCase = ReferralNotesCase, 
	@ReferralNotesPrevious = ReferralNotesPrevious, 
	@ReferralDonorFirstName = ReferralDonorFirstName, 
	@ReferralDonorLastName = ReferralDonorLastName, 
	@ReferralNOKPhone = ReferralNOKPhone, 
	@ReferralNOKAddress = ReferralNOKAddress, 
	@ReferralCoronerName = ReferralCoronerName, 
	@ReferralCoronerPhone = ReferralCoronerPhone, 
	@ReferralCoronerOrganization = ReferralCoronerOrganization, 
	@ReferralCoronerNote = ReferralCoronerNote, 
	@ReferralDonorSSN = ReferralDonorSSN, 
	@ReferralExtubated = ReferralExtubated, 
	@DonorDMVTable = DonorDMVTable, 
	@ReferralDonorBrainDeathTime = ReferralDonorBrainDeathTime, 
	@ReferralDonorBrainDeathDate = ReferralDonorBrainDeathDate, 
	@ReferralPronouncingMDPhone = ReferralPronouncingMDPhone, 
	@ReferralAttendingMDPhone = ReferralAttendingMDPhone, 
	@ReferralDonorSpecificCOD = ReferralDonorSpecificCOD, 
	@ReferralDonorNameMI = ReferralDonorNameMI,
	@ReferralOrganAppropriateID = ReferralOrganAppropriateID,
	@ReferralOrganApproachID = ReferralOrganApproachID,
	@ReferralOrganConsentID = ReferralOrganConsentID,
	@ReferralOrganConversionID = ReferralOrganConversionID,
	@ReferralBoneAppropriateID = ReferralBoneAppropriateID,
	@ReferralBoneApproachID = ReferralBoneApproachID,
	@ReferralBoneConsentID = ReferralBoneConsentID,
	@ReferralBoneConversionID = ReferralBoneConversionID,
	@ReferralTissueAppropriateID = ReferralTissueAppropriateID,
	@ReferralTissueApproachID = ReferralTissueApproachID,
	@ReferralTissueConsentID = ReferralTissueConsentID,
	@ReferralTissueConversionID = ReferralTissueConversionID,
	@ReferralSkinAppropriateID = ReferralSkinAppropriateID,
	@ReferralSkinApproachID = ReferralSkinApproachID,
	@ReferralSkinConsentID = ReferralSkinConsentID,
	@ReferralSkinConversionID = ReferralSkinConversionID,
	@ReferralEyesTransAppropriateID = ReferralEyesTransAppropriateID,
	@ReferralEyesTransApproachID = ReferralEyesTransApproachID,
	@ReferralEyesTransConsentID = ReferralEyesTransConsentID,
	@ReferralEyesTransConversionID = ReferralEyesTransConversionID,
	@ReferralEyesRschAppropriateID = ReferralEyesRschAppropriateID,
	@ReferralEyesRschApproachID = ReferralEyesRschApproachID,
	@ReferralEyesRschConsentID = ReferralEyesRschConsentID,
	@ReferralEyesRschConversionID = ReferralEyesRschConversionID,
	@ReferralValvesAppropriateID = ReferralValvesAppropriateID,
	@ReferralValvesApproachID = ReferralValvesApproachID,
	@ReferralValvesConsentID = ReferralValvesConsentID,
	@ReferralValvesConversionID = ReferralValvesConversionID,
	@ReferralVerifiedOptions = ReferralVerifiedOptions,
	@ReferralCoronersCase = ReferralCoronersCase,
	@Inactive = Inactive,
	@ReferralCallerLevelID = ReferralCallerLevelID,
	@UnusedField1 = UnusedField1,
	@ReferralOrganDispositionID = ReferralOrganDispositionID,
	@ReferralBoneDispositionID = ReferralBoneDispositionID,
	@ReferralTissueDispositionID = ReferralTissueDispositionID,
	@ReferralSkinDispositionID = ReferralSkinDispositionID,
	@ReferralValvesDispositionID = ReferralValvesDispositionID,
	@ReferralEyesDispositionID = ReferralEyesDispositionID,
	@ReferralRschDispositionID = ReferralRschDispositionID,
	@ReferralAllTissueDispositionID = ReferralAllTissueDispositionID,
	@ReferralPronouncingMD = ReferralPronouncingMD,
	@UnusedField3 = UnusedField3,
	@ReferralAttendingMD = ReferralAttendingMD,
	@ReferralApproachTime = ReferralApproachTime,
	@ReferralConsentTime = ReferralConsentTime,
	@Unused = Unused,
	@ReferralDOA = ReferralDOA,
	@UpdatedFlag = UpdatedFlag ,
	@DonorRegistryType = DonorRegistryType ,
	@DonorRegId = DonorRegId ,
	@DonorDMVId = DonorDMVId,
	@DonorIntentDone = DonorIntentDone,
	@DonorFaxSent = DonorFaxSent,
	@DonorDSNID = DonorDSNID,
	@ReferralDonorHeartBeat = ReferralDonorHeartBeat,
	@ReferralCoronerOrgID = ReferralCoronerOrgID,
	@CurrentReferralTypeId = CurrentReferralTypeId,
	@ReferralDOB_ILB = ReferralDOB_ILB,
	@ReferralNOKID = ReferralNOKID,
	@ReferralQAReviewComplete = ReferralQAReviewComplete,
	@Hiv = Hiv,
	@Aids = Aids,
	@HepB = HepB,
	@HepC = HepC,
	@Ivda = Ivda,
	@IdentityUnknown = IdentityUnknown,
	@AgeEstimated = AgeEstimated,
	@WeightEstimated = WeightEstimated,
	@PastMedicalHistory = PastMedicalHistory,
	@AdmittingDiagnosis = AdmittingDiagnosis,
	@IsERferralCase = IsERferralCase	
FROM
	REFERRAL
WHERE 
	CallID = @CallID;

EXEC ReferralUpdate
	@ReferralCallerPhoneID = @ReferralCallerPhoneID,
	@ReferralCallerOrganizationID = @ReferralCallerOrganizationID,
	@ReferralApproachTypeId = @ReferralApproachTypeId,
	@ReferralApproachedByPersonID = @ReferralApproachedByPersonID,
	@ReferralGeneralConsent = @ReferralGeneralConsent,
	@LastStatEmployeeID = @LastStatEmployeeID,
	@CallId = @CallId,
	@ReferralCallerExtension = @ReferralCallerExtension,
	@ReferralCallerSubLocationID = @ReferralCallerSubLocationID, 
	@ReferralCallerSubLocationLevel = @ReferralCallerSubLocationLevel,
	@ReferralCallerPersonID = @ReferralCallerPersonID,
	@ReferralDOB = @ReferralDonorDOB,
	@ReferralDonorName = @ReferralDonorName, 
	@ReferralDonorRecNumber = @ReferralDonorRecNumber, 
	@ReferralDonorAge = @ReferralDonorAge, 
	@ReferralDonorAgeUnit = @ReferralDonorAgeUnit,
	@ReferralDonorRaceID = @ReferralDonorRaceID,
	@ReferralDonorGender = @ReferralDonorGender,
	@ReferralDonorWeight = @ReferralDonorWeight, 
	@ReferralDonorAdmitTime = @ReferralDonorAdmitTime, 
	@ReferralDonorAdmitDate = @ReferralDonorAdmitDate, 
	@ReferralDonorDeathTime = @ReferralDonorDeathTime, 
	@ReferralDonorDeathDate = @ReferralDonorDeathDate, 
	@ReferralDonorLSATime = @ReferralDonorLSATime, 
	@ReferralDonorLSADate = @ReferralDonorLSADate,
	@ReferralDonorCauseOfDeathID = @ReferralDonorCauseOfDeathID,
	@ReferralDonorOnVentilator = @ReferralDonorOnVentilator, 
	@ReferralDonorDead = @ReferralDonorDead, 
	@ReferralTypeID = @ReferralTypeID,
	@ReferralApproachNOK = @ReferralApproachNOK, 
	@ReferralApproachRelation = @ReferralApproachRelation, 
	@ReferralNotesCase = @ReferralNotesCase, 
	@ReferralNotesPrevious = @ReferralNotesPrevious, 
	@ReferralDonorFirstName = @ReferralDonorFirstName, 
	@ReferralDonorLastName = @ReferralDonorLastName, 
	@ReferralNOKPhone = @ReferralNOKPhone, 
	@ReferralNOKAddress = @ReferralNOKAddress, 
	@ReferralCoronerName = @ReferralCoronerName, 
	@ReferralCoronerPhone = @ReferralCoronerPhone, 
	@ReferralCoronerOrganization = @ReferralCoronerOrganization, 
	@ReferralCoronerNote = @ReferralCoronerNote, 
	@ReferralDonorSSN = @ReferralDonorSSN, 
	@ReferralExtubated = @ReferralExtubated, 
	@DonorDMVTable = @DonorDMVTable, 
	@ReferralDonorBrainDeathTime = @ReferralDonorBrainDeathTime, 
	@ReferralDonorBrainDeathDate = @ReferralDonorBrainDeathDate, 
	@ReferralPronouncingMDPhone = @ReferralPronouncingMDPhone, 
	@ReferralAttendingMDPhone = @ReferralAttendingMDPhone, 
	@ReferralDonorSpecificCOD = @ReferralDonorSpecificCOD, 
	@ReferralDonorNameMI = @ReferralDonorNameMI,
	@ReferralOrganAppropriateID = @ReferralOrganAppropriateID,
	@ReferralOrganApproachID = @ReferralOrganApproachID,
	@ReferralOrganConsentID = @ReferralOrganConsentID,
	@ReferralOrganConversionID = @ReferralOrganConversionID,
	@ReferralBoneAppropriateID = @ReferralBoneAppropriateID,
	@ReferralBoneApproachID = @ReferralBoneApproachID,
	@ReferralBoneConsentID = @ReferralBoneConsentID,
	@ReferralBoneConversionID = @ReferralBoneConversionID,
	@ReferralTissueAppropriateID = @ReferralTissueAppropriateID,
	@ReferralTissueApproachID = @ReferralTissueApproachID,
	@ReferralTissueConsentID = @ReferralTissueConsentID,
	@ReferralTissueConversionID = @ReferralTissueConversionID,
	@ReferralSkinAppropriateID = @ReferralSkinAppropriateID,
	@ReferralSkinApproachID = @ReferralSkinApproachID,
	@ReferralSkinConsentID = @ReferralSkinConsentID,
	@ReferralSkinConversionID = @ReferralSkinConversionID,
	@ReferralEyesTransAppropriateID = @ReferralEyesTransAppropriateID,
	@ReferralEyesTransApproachID = @ReferralEyesTransApproachID,
	@ReferralEyesTransConsentID = @ReferralEyesTransConsentID,
	@ReferralEyesTransConversionID = @ReferralEyesTransConversionID,
	@ReferralEyesRschAppropriateID = @ReferralEyesRschAppropriateID,
	@ReferralEyesRschApproachID = @ReferralEyesRschApproachID,
	@ReferralEyesRschConsentID = @ReferralEyesRschConsentID,
	@ReferralEyesRschConversionID = @ReferralEyesRschConversionID,
	@ReferralValvesAppropriateID = @ReferralValvesAppropriateID,
	@ReferralValvesApproachID = @ReferralValvesApproachID,
	@ReferralValvesConsentID = @ReferralValvesConsentID,
	@ReferralValvesConversionID = @ReferralValvesConversionID,
	@ReferralVerifiedOptions = @ReferralVerifiedOptions,
	@ReferralCoronersCase = @ReferralCoronersCase,
	@Inactive = @Inactive,
	@ReferralCallerLevelID = @ReferralCallerLevelID,
	@UnusedField1 = @UnusedField1,
	@ReferralOrganDispositionID = @ReferralOrganDispositionID,
	@ReferralBoneDispositionID = @ReferralBoneDispositionID,
	@ReferralTissueDispositionID = @ReferralTissueDispositionID,
	@ReferralSkinDispositionID = @ReferralSkinDispositionID,
	@ReferralValvesDispositionID = @ReferralValvesDispositionID,
	@ReferralEyesDispositionID = @ReferralEyesDispositionID,
	@ReferralRschDispositionID = @ReferralRschDispositionID,
	@ReferralAllTissueDispositionID = @ReferralAllTissueDispositionID,
	@ReferralPronouncingMD = @ReferralPronouncingMD,
	@UnusedField3 = @UnusedField3,
	@ReferralAttendingMD = @ReferralAttendingMD,
	@ReferralApproachTime = @ReferralApproachTime,
	@ReferralConsentTime = @ReferralConsentTime,
	@Unused = @Unused,
	@ReferralDOA = @ReferralDOA,
	@UpdatedFlag = @UpdatedFlag ,
	@DonorRegistryType = @DonorRegistryType ,
	@DonorRegId = @DonorRegId ,
	@DonorDMVId = @DonorDMVId,
	@DonorIntentDone = @DonorIntentDone,
	@DonorFaxSent = @DonorFaxSent,
	@DonorDSNID = @DonorDSNID,
	@ReferralDonorHeartBeat = @ReferralDonorHeartBeat,
	@ReferralCoronerOrgID = @ReferralCoronerOrgID,
	@CurrentReferralTypeId = @CurrentReferralTypeId,
	@ReferralDOB_ILB = @ReferralDOB_ILB,
	@ReferralNOKID = @ReferralNOKID,
	@ReferralQAReviewComplete = @ReferralQAReviewComplete,
	@Hiv = @Hiv,
	@Aids = @Aids,
	@HepB = @HepB,
	@HepC = @HepC,
	@Ivda = @Ivda,
	@IdentityUnknown = @IdentityUnknown,
	@AgeEstimated = @AgeEstimated,
	@WeightEstimated = @WeightEstimated,
	@PastMedicalHistory = @PastMedicalHistory,
	@AdmittingDiagnosis = @AdmittingDiagnosis,
	@IsERferralCase = @IsERferralCase;

GO
SET QUOTED_IDENTIFIER OFF; 
GO
SET ANSI_NULLS ON; 
GO

