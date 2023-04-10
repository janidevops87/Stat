IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ReferralUpdate')
BEGIN
	PRINT 'Dropping Procedure ReferralUpdate';
	DROP Procedure ReferralUpdate;
END
GO

PRINT 'Creating Procedure ReferralUpdate';
GO
CREATE Procedure [dbo].[ReferralUpdate]
(
		@ReferralID int = null output,
		@CallID int = null,
		@ReferralCallerPhoneID int = null,
		@ReferralCallerExtension varchar(10) = null,
		@ReferralCallerOrganizationID int = null,
		@ReferralCallerSubLocationID int = null,
		@ReferralCallerSubLocationLevel varchar(4) = null,
		@ReferralCallerPersonID int = null,
		@ReferralDonorName varchar(80) = null,
		@ReferralDonorRecNumber varchar(30) = null,
		@ReferralDonorRecNumberSearchable varchar(30) = NULL, 
		@ReferralDonorAge varchar(4) = null,
		@ReferralDonorAgeUnit varchar(10) = null,
		@ReferralDonorRaceID int = null,
		@ReferralDonorGender char(1) = null,
		@ReferralDonorWeight varchar(7) = null,
		@ReferralDonorAdmitDate smalldatetime = null,
		@ReferralDonorAdmitTime varchar(10) = null,
		@ReferralDonorDeathDate smalldatetime = null,
		@ReferralDonorDeathTime varchar(10) = null,
		@ReferralDonorLSADate smalldatetime = null,
		@ReferralDonorLSATime varchar(10) = null,
		@ReferralDonorCauseOfDeathID int = null,
		@ReferralDonorOnVentilator varchar(20) = null,
		@ReferralDonorDead varchar(4) = null,
		@ReferralTypeID int = null,
		@ReferralApproachTypeID int = null,
		@ReferralApproachedByPersonID int = null,
		@ReferralApproachNOK varchar(50) = null,
		@ReferralApproachRelation varchar(50) = null,
		@ReferralOrganAppropriateID int = null,
		@ReferralOrganApproachID int = null,
		@ReferralOrganConsentID int = null,
		@ReferralOrganConversionID int = null,
		@ReferralBoneAppropriateID int = null,
		@ReferralBoneApproachID int = null,
		@ReferralBoneConsentID int = null,
		@ReferralBoneConversionID int = null,
		@ReferralTissueAppropriateID int = null,
		@ReferralTissueApproachID int = null,
		@ReferralTissueConsentID int = null,
		@ReferralTissueConversionID int = null,
		@ReferralSkinAppropriateID int = null,
		@ReferralSkinApproachID int = null,
		@ReferralSkinConsentID int = null,
		@ReferralSkinConversionID int = null,
		@ReferralEyesTransAppropriateID int = null,
		@ReferralEyesTransApproachID int = null,
		@ReferralEyesTransConsentID int = null,
		@ReferralEyesTransConversionID int = null,
		@ReferralEyesRschAppropriateID int = null,
		@ReferralEyesRschApproachID int = null,
		@ReferralEyesRschConsentID int = null,
		@ReferralEyesRschConversionID int = null,
		@ReferralValvesAppropriateID int = null,
		@ReferralValvesApproachID int = null,
		@ReferralValvesConsentID int = null,
		@ReferralValvesConversionID int = null,
		@ReferralNotesCase varchar(400) = null,
		@ReferralNotesPrevious varchar(255) = null,
		@ReferralVerifiedOptions smallint = null,
		@ReferralCoronersCase smallint = null,
		@Inactive smallint = null,
		@ReferralCallerLevelID int = null,
		@LastModified datetime = null,
		@UnusedField1 smallint = null,
		@ReferralDonorFirstName varchar(40) = null,
		@ReferralDonorLastName varchar(40) = null,
		@ReferralOrganDispositionID int = null,
		@ReferralBoneDispositionID int = null,
		@ReferralTissueDispositionID int = null,
		@ReferralSkinDispositionID int = null,
		@ReferralValvesDispositionID int = null,
		@ReferralEyesDispositionID int = null,
		@ReferralRschDispositionID int = null,
		@ReferralAllTissueDispositionID int = null,
		@ReferralPronouncingMD int = null,
		@UnusedField3 int = null,
		@ReferralNOKPhone varchar(14) = null,
		@ReferralAttendingMD int = null,
		@ReferralGeneralConsent smallint = null,
		@ReferralNOKAddress varchar(255) = null,
		@ReferralCoronerName varchar(80) = null,
		@ReferralCoronerPhone varchar(14) = null,
		@ReferralCoronerOrganization varchar(80) = null,
		@ReferralCoronerNote varchar(255) = null,
		@ReferralApproachTime numeric(7,0) = null,
		@ReferralConsentTime numeric(7,0) = null,
		@Unused smalldatetime = null,
		@ReferralDOA smallint = null,
		@ReferralDOB datetime = null,
		@ReferralDonorSSN varchar(11) = null,
		@UpdatedFlag smallint = null,
		@ReferralExtubated varchar(15) = null,
		@DonorRegistryType smallint = null,
		@DonorRegId int = null,
		@DonorDMVId int = null,
		@DonorDMVTable varchar(255) = null,
		@DonorIntentDone smallint = null,
		@DonorFaxSent smallint = null,
		@DonorDSNID smallint = null,
		@ReferralDonorHeartBeat int = null,
		@ReferralCoronerOrgID int = null,
		@CurrentReferralTypeId int = null,
		@ReferralDonorBrainDeathDate smalldatetime = null,
		@ReferralDonorBrainDeathTime varchar(10) = null,
		@ReferralPronouncingMDPhone varchar(14) = null,
		@ReferralAttendingMDPhone varchar(14) = null,
		@ReferralDOB_ILB smallint = null,
		@ReferralDonorSpecificCOD varchar(250) = null,
		@ReferralDonorNameMI varchar(2) = null,
		@ReferralNOKID int = null,
		@ReferralQAReviewComplete smallint = null,
		@ReferralDCDPotential smallint = NULL,
		@ReferralPendingCase smallint = 0,
		@ReferralPendingCaseCoordinator smallint = NULL,
		@ReferralPendingCaseComment varchar(50) = NULL,
		@Hiv int = NULL,
		@Aids int = NULL,
		@HepB int = NULL,
		@HepC int = NULL,
		@Ivda int = NULL,
		@IdentityUnknown int = NULL,
		@AgeEstimated int = NULL,
		@WeightEstimated int = NULL,
		@PastMedicalHistory varchar(950) = NULL,
		@AdmittingDiagnosis varchar(950) = NULL,
		@LastStatEmployeeID int = null,
		@AuditLogTypeID int = null,
		@IsERferralCase bit = 0					
)
AS
/******************************************************************************
**	File: ReferralUpdate.sql
**	Name: ReferralUpdate
**	Desc: Updates Referral Based on Id field 
**	Auth: Bret Knoll
**	Date: 1/7/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	1/7/2011		Bret Knoll			Initial Sproc Creation
**	05/28/2020		Mike Berenson		Added fields for e-referral
**	10/23/2020		Bret Knoll			Added missing IsERferralCase
**	02/17/2021		Mike Berenson		Comment w/no change since previous version didn't get deployed
**	04/09/2021		Mike Berenson		Added ReferralID logic and fields from UpdateReferral.sql
**	04/27/2021		Mike Berenson		Added IsNull logic when updating IsERferralCase
*******************************************************************************/

-- Lookup ReferralID if needed
IF @ReferralID IS NULL AND @CallID IS NOT NULL
BEGIN
	SELECT
		@ReferralID = ReferralID
	FROM
		Referral
	WHERE
		CallID = @CallID;
END

/**********************************
NOTE:  If adding any additional columns to referral table,
please pdate spu_TriageApproach that calls this stored procedure.
**********************************/
UPDATE
	dbo.Referral 	
SET 
	CallID = @CallID,
	ReferralCallerPhoneID = @ReferralCallerPhoneID,
	ReferralCallerExtension = @ReferralCallerExtension,
	ReferralCallerOrganizationID = @ReferralCallerOrganizationID,
	ReferralCallerSubLocationID = @ReferralCallerSubLocationID,
	ReferralCallerSubLocationLevel = @ReferralCallerSubLocationLevel,
	ReferralCallerPersonID = @ReferralCallerPersonID,
	ReferralDonorName = @ReferralDonorName,
	ReferralDonorRecNumber = @ReferralDonorRecNumber,
	ReferralDonorRecNumberSearchable = ISNULL(@ReferralDonorRecNumberSearchable, ReferralDonorRecNumberSearchable),
	ReferralDonorAge = @ReferralDonorAge,
	ReferralDonorAgeUnit = @ReferralDonorAgeUnit,
	ReferralDonorRaceID = @ReferralDonorRaceID,
	ReferralDonorGender = @ReferralDonorGender,
	ReferralDonorWeight = @ReferralDonorWeight,
	ReferralDonorAdmitDate = @ReferralDonorAdmitDate,
	ReferralDonorAdmitTime = @ReferralDonorAdmitTime,
	ReferralDonorDeathDate = @ReferralDonorDeathDate,
	ReferralDonorDeathTime = @ReferralDonorDeathTime,
	ReferralDonorLSADate = @ReferralDonorLSADate,
	ReferralDonorLSATime = @ReferralDonorLSATime,
	ReferralDonorCauseOfDeathID = @ReferralDonorCauseOfDeathID,
	ReferralDonorOnVentilator = @ReferralDonorOnVentilator,
	ReferralDonorDead = @ReferralDonorDead,
	ReferralTypeID = @ReferralTypeID,
	ReferralApproachTypeID = @ReferralApproachTypeID,
	ReferralApproachedByPersonID = @ReferralApproachedByPersonID,
	ReferralApproachNOK = @ReferralApproachNOK,
	ReferralApproachRelation = @ReferralApproachRelation,
	ReferralOrganAppropriateID = @ReferralOrganAppropriateID,
	ReferralOrganApproachID = @ReferralOrganApproachID,
	ReferralOrganConsentID = @ReferralOrganConsentID,
	ReferralOrganConversionID = @ReferralOrganConversionID,
	ReferralBoneAppropriateID = @ReferralBoneAppropriateID,
	ReferralBoneApproachID = @ReferralBoneApproachID,
	ReferralBoneConsentID = @ReferralBoneConsentID,
	ReferralBoneConversionID = @ReferralBoneConversionID,
	ReferralTissueAppropriateID = @ReferralTissueAppropriateID,
	ReferralTissueApproachID = @ReferralTissueApproachID,
	ReferralTissueConsentID = @ReferralTissueConsentID,
	ReferralTissueConversionID = @ReferralTissueConversionID,
	ReferralSkinAppropriateID = @ReferralSkinAppropriateID,
	ReferralSkinApproachID = @ReferralSkinApproachID,
	ReferralSkinConsentID = @ReferralSkinConsentID,
	ReferralSkinConversionID = @ReferralSkinConversionID,
	ReferralEyesTransAppropriateID = @ReferralEyesTransAppropriateID,
	ReferralEyesTransApproachID = @ReferralEyesTransApproachID,
	ReferralEyesTransConsentID = @ReferralEyesTransConsentID,
	ReferralEyesTransConversionID = @ReferralEyesTransConversionID,
	ReferralEyesRschAppropriateID = @ReferralEyesRschAppropriateID,
	ReferralEyesRschApproachID = @ReferralEyesRschApproachID,
	ReferralEyesRschConsentID = @ReferralEyesRschConsentID,
	ReferralEyesRschConversionID = @ReferralEyesRschConversionID,
	ReferralValvesAppropriateID = @ReferralValvesAppropriateID,
	ReferralValvesApproachID = @ReferralValvesApproachID,
	ReferralValvesConsentID = @ReferralValvesConsentID,
	ReferralValvesConversionID = @ReferralValvesConversionID,
	ReferralNotesCase = @ReferralNotesCase,
	ReferralNotesPrevious = @ReferralNotesPrevious,
	ReferralVerifiedOptions = @ReferralVerifiedOptions,
	ReferralCoronersCase = @ReferralCoronersCase,
	Inactive = @Inactive,
	ReferralCallerLevelID = @ReferralCallerLevelID,
	LastModified = GetDate(),
	UnusedField1 = @UnusedField1,
	ReferralDonorFirstName = @ReferralDonorFirstName,
	ReferralDonorLastName = @ReferralDonorLastName,
	ReferralOrganDispositionID = @ReferralOrganDispositionID,
	ReferralBoneDispositionID = @ReferralBoneDispositionID,
	ReferralTissueDispositionID = @ReferralTissueDispositionID,
	ReferralSkinDispositionID = @ReferralSkinDispositionID,
	ReferralValvesDispositionID = @ReferralValvesDispositionID,
	ReferralEyesDispositionID = @ReferralEyesDispositionID,
	ReferralRschDispositionID = @ReferralRschDispositionID,
	ReferralAllTissueDispositionID = @ReferralAllTissueDispositionID,
	ReferralPronouncingMD = @ReferralPronouncingMD,
	UnusedField3 = @UnusedField3,
	ReferralNOKPhone = @ReferralNOKPhone,
	ReferralAttendingMD = @ReferralAttendingMD,
	ReferralGeneralConsent = @ReferralGeneralConsent,
	ReferralNOKAddress = @ReferralNOKAddress,
	ReferralCoronerName = @ReferralCoronerName,
	ReferralCoronerPhone = @ReferralCoronerPhone,
	ReferralCoronerOrganization = @ReferralCoronerOrganization,
	ReferralCoronerNote = @ReferralCoronerNote,
	ReferralApproachTime = @ReferralApproachTime,
	ReferralConsentTime = @ReferralConsentTime,
	Unused = @Unused,
	ReferralDOA = @ReferralDOA,
	ReferralDOB = @ReferralDOB,
	ReferralDonorSSN = @ReferralDonorSSN,
	UpdatedFlag = @UpdatedFlag,
	ReferralExtubated = @ReferralExtubated,
	DonorRegistryType = @DonorRegistryType,
	DonorRegId = @DonorRegId,
	DonorDMVId = @DonorDMVId,
	DonorDMVTable = @DonorDMVTable,
	DonorIntentDone = @DonorIntentDone,
	DonorFaxSent = @DonorFaxSent,
	DonorDSNID = @DonorDSNID,
	ReferralDonorHeartBeat = @ReferralDonorHeartBeat,
	ReferralCoronerOrgID = @ReferralCoronerOrgID,
	CurrentReferralTypeId = @CurrentReferralTypeId,
	ReferralDonorBrainDeathDate = @ReferralDonorBrainDeathDate,
	ReferralDonorBrainDeathTime = @ReferralDonorBrainDeathTime,
	ReferralPronouncingMDPhone = @ReferralPronouncingMDPhone,
	ReferralAttendingMDPhone = @ReferralAttendingMDPhone,
	ReferralDOB_ILB = @ReferralDOB_ILB,
	ReferralDonorSpecificCOD = @ReferralDonorSpecificCOD,
	ReferralDonorNameMI = @ReferralDonorNameMI,
	ReferralNOKID = @ReferralNOKID,
	ReferralQAReviewComplete = @ReferralQAReviewComplete,
	ReferralDCDPotential = ISNULL(@ReferralDCDPotential, ReferralDCDPotential),
	ReferralPendingCase = ISNULL(@ReferralPendingCase, ReferralPendingCase),
	ReferralPendingCaseCoordinator = ISNULL(@ReferralPendingCaseCoordinator, ReferralPendingCaseCoordinator),
	ReferralPendingCaseComment = @ReferralPendingCaseComment,
	ReferralPendingCaseLastModified =
		CASE
			WHEN (ISNULL(@ReferralPendingCase, 0) <> ISNULL(ReferralPendingCase, 0))
				OR (@ReferralPendingCaseCoordinator <> ReferralPendingCaseCoordinator)
				OR (@ReferralPendingCaseComment <> ReferralPendingCaseComment)
			THEN GETDATE()
			ELSE ReferralPendingCaseLastModified
		END,	
	Hiv = @Hiv,
	Aids = @Aids,
	HepB = @HepB,
	HepC = @HepC,
	Ivda = @Ivda,
	IdentityUnknown = @IdentityUnknown,
	AgeEstimated = @AgeEstimated,
	WeightEstimated = @WeightEstimated,
	PastMedicalHistory = @PastMedicalHistory,
	AdmittingDiagnosis = @AdmittingDiagnosis,
	IsERferralCase = ISNULL(@IsERferralCase, IsERferralCase),
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */
WHERE 
	ReferralID = @ReferralID;	 		
GO

GRANT EXEC ON ReferralUpdate TO PUBLIC;
GO
