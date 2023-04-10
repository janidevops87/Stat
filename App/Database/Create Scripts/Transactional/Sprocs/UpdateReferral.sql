IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReferral')
BEGIN
	PRINT 'Dropping Procedure UpdateReferral';
	DROP  Procedure  UpdateReferral;
END
GO

PRINT 'Creating Procedure UpdateReferral';
GO
CREATE Procedure [dbo].[UpdateReferral]
    @ReferralID int = NULL , 
    @CallID int = NULL , 
    @ReferralCallerPhoneID int = NULL , 
    @ReferralCallerExtension varchar(10) = NULL , 
    @ReferralCallerOrganizationID int = NULL , 
    @ReferralCallerSubLocationID int = NULL , 
    @ReferralCallerSubLocationLevel varchar(4) = NULL , 
    @ReferralCallerPersonID int = NULL , 
    @ReferralDonorName varchar(80) = NULL , 
    @ReferralDonorRecNumber varchar(30) = NULL , 
    @ReferralDonorRecNumberSearchable varchar(30) = NULL , 
    @ReferralDonorAge varchar(4) = NULL , 
    @ReferralDonorAgeUnit varchar(10) = NULL , 
    @ReferralDonorRaceID int = NULL , 
    @ReferralDonorGender char(1) = NULL , 
    @ReferralDonorWeight varchar(7) = NULL , 
    @ReferralDonorAdmitDate smalldatetime = NULL , 
    @ReferralDonorAdmitTime varchar(10) = NULL , 
    @ReferralDonorDeathDate smalldatetime = NULL , 
    @ReferralDonorDeathTime varchar(10) = NULL ,
    @ReferralDonorLSADate smalldatetime = NULL , 
    @ReferralDonorLSATime varchar(10) = NULL ,
    @ReferralDonorCauseOfDeathID int = NULL , 
    @ReferralDonorOnVentilator varchar(20) = NULL , 
    @ReferralDonorDead varchar(4) = NULL , 
    @ReferralTypeID int = NULL , 
    @ReferralApproachTypeID int = NULL , 
    @ReferralApproachedByPersonID int = NULL , 
    @ReferralApproachNOK varchar(50) = NULL , 
    @ReferralApproachRelation varchar(50) = NULL , 
    @ReferralOrganAppropriateID int = NULL , 
    @ReferralOrganApproachID int = NULL , 
    @ReferralOrganConsentID int = NULL , 
    @ReferralOrganConversionID int = NULL , 
    @ReferralBoneAppropriateID int = NULL , 
    @ReferralBoneApproachID int = NULL , 
    @ReferralBoneConsentID int = NULL , 
    @ReferralBoneConversionID int = NULL , 
    @ReferralTissueAppropriateID int = NULL , 
    @ReferralTissueApproachID int = NULL , 
    @ReferralTissueConsentID int = NULL , 
    @ReferralTissueConversionID int = NULL , 
    @ReferralSkinAppropriateID int = NULL , 
    @ReferralSkinApproachID int = NULL , 
    @ReferralSkinConsentID int = NULL , 
    @ReferralSkinConversionID int = NULL , 
    @ReferralEyesTransAppropriateID int = NULL , 
    @ReferralEyesTransApproachID int = NULL , 
    @ReferralEyesTransConsentID int = NULL , 
    @ReferralEyesTransConversionID int = NULL , 
    @ReferralEyesRschAppropriateID int = NULL , 
    @ReferralEyesRschApproachID int = NULL , 
    @ReferralEyesRschConsentID int = NULL , 
    @ReferralEyesRschConversionID int = NULL , 
    @ReferralValvesAppropriateID int = NULL , 
    @ReferralValvesApproachID int = NULL , 
    @ReferralValvesConsentID int = NULL , 
    @ReferralValvesConversionID int = NULL , 
    @ReferralNotesCase varchar(400) = NULL , 
    @ReferralNotesPrevious varchar(255) = NULL , 
    @ReferralVerifiedOptions smallint = NULL , 
    @ReferralCoronersCase smallint = NULL , 
    @Inactive smallint = NULL , 
    @ReferralCallerLevelID int = NULL , 
    @UnusedField1 smallint = NULL , 
    @ReferralDonorFirstName varchar(40) = NULL , 
    @ReferralDonorLastName varchar(40) = NULL , 
    @ReferralOrganDispositionID int = NULL , 
    @ReferralBoneDispositionID int = NULL , 
    @ReferralTissueDispositionID int = NULL , 
    @ReferralSkinDispositionID int = NULL , 
    @ReferralValvesDispositionID int = NULL , 
    @ReferralEyesDispositionID int = NULL , 
    @ReferralRschDispositionID int = NULL , 
    @ReferralAllTissueDispositionID int = NULL , 
    @ReferralPronouncingMD int = NULL , 
    @UnusedField3 int = NULL , 
    @ReferralNOKPhone varchar(14) = NULL , 
    @ReferralAttendingMD int = NULL , 
    @ReferralGeneralConsent smallint = NULL , 
    @ReferralNOKAddress varchar(255) = NULL , 
    @ReferralCoronerName varchar(80) = NULL , 
    @ReferralCoronerPhone varchar(14) = NULL , 
    @ReferralCoronerOrganization varchar(80) = NULL , 
    @ReferralCoronerNote varchar(255) = NULL , 
    @ReferralApproachTime numeric = NULL , 
    @ReferralConsentTime numeric = NULL , 
    @Unused smalldatetime = NULL , 
    @ReferralDOA smallint = NULL , 
    @ReferralDOB datetime = NULL , 
    @ReferralDonorSSN varchar(11) = NULL , 
    @ReferralExtubated varchar(15) = NULL , 
    @DonorRegistryType smallint = NULL , 
    @DonorRegId int = NULL , 
    @DonorDMVId int = NULL , 
    @DonorDMVTable varchar(255) = NULL , 
    @DonorIntentDone smallint = NULL , 
    @DonorFaxSent smallint = NULL , 
    @DonorDSNID smallint = NULL , 
    @ReferralDonorHeartBeat int = NULL , 
    @ReferralCoronerOrgID int = NULL , 
    @CurrentReferralTypeId int = NULL , 
    @ReferralDonorBrainDeathDate smalldatetime = NULL , 
    @ReferralDonorBrainDeathTime varchar(10) = NULL , 
    @ReferralPronouncingMDPhone varchar(14) = NULL , 
    @ReferralAttendingMDPhone varchar(14) = NULL , 
    @ReferralDOB_ILB smallint = NULL , 
    @ReferralDonorSpecificCOD varchar(250) = NULL , 
    @ReferralDonorNameMI varchar(2) = NULL , 
    @ReferralNOKID int = NULL , 
    @ReferralQAReviewComplete smallint = NULL , 
	@ReferralDCDPotential smallint = NULL ,
	@ReferralPendingCase smallint = 0 ,
	@ReferralPendingCaseCoordinator smallint = NULL ,
	@ReferralPendingCaseComment varchar(50) = NULL ,
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
	@IsERferralCase bit = NULL,
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateReferral.sql 
**		Name: UpdateReferral
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
**		11/07/2008	ccarroll			changed default value for ReferralAttendingMD
**										and ReferralPronouncingMD to -1 : AuditTrail consistency
**		12/03/2008	ccarroll			added ISNull statements for use with reporting site updates	
**      3/7/11      jth                 don't set referraltypeid to current referral type id from parm
**		09/06/2011	ccarroll			Added LSA Date Time - CCRST151
**		07/24/2015	Aykut Ucar			Enable clearing of weight field
**		01/22/2018	Mike Berenson		Added ReferralDCDPotential
**		10/02/2018	Serge Hurko			#61346 - Add new fields to StatTrac Referral Event Log
**		6/19/2019	Mike Berenson		Added field: ReferralDonorRecNumberSearchable
**		7/15/2019	Mike Berenson		Set ReferralPendingCaseComment to allow updates to null
**		05/28/2020	Mike Berenson		Added fields for e-referral
*******************************************************************************/
If	@ReferralPronouncingMD = 0
BEGIN
	SELECT @ReferralPronouncingMD = -1;
END

If	@ReferralAttendingMD = 0
BEGIN
	SELECT @ReferralAttendingMD = -1;
END

UPDATE
	Referral
SET
	ReferralCallerPhoneID = ISNULL(@ReferralCallerPhoneID, ReferralCallerPhoneID), 
	ReferralCallerExtension = ISNULL(@ReferralCallerExtension, ReferralCallerExtension),
	ReferralCallerOrganizationID = ISNULL(@ReferralCallerOrganizationID, ReferralCallerOrganizationID), 
	ReferralCallerSubLocationID = ISNULL(@ReferralCallerSubLocationID, ReferralCallerSubLocationID), 
	ReferralCallerSubLocationLevel = ISNULL(@ReferralCallerSubLocationLevel, ReferralCallerSubLocationLevel),
	ReferralCallerPersonID = ISNULL(@ReferralCallerPersonID, ReferralCallerPersonID), 
	ReferralDonorName = ISNULL(@ReferralDonorName, ReferralDonorName),
	ReferralDonorRecNumber = ISNULL(@ReferralDonorRecNumber, ReferralDonorRecNumber),
	ReferralDonorRecNumberSearchable = ISNULL(@ReferralDonorRecNumberSearchable, ReferralDonorRecNumberSearchable),
	ReferralDonorAge = ISNULL(@ReferralDonorAge, ReferralDonorAge),
	ReferralDonorAgeUnit = ISNULL(@ReferralDonorAgeUnit, ReferralDonorAgeUnit),
	ReferralDonorRaceID = ISNULL(@ReferralDonorRaceID, ReferralDonorRaceID), 
	ReferralDonorGender = ISNULL(@ReferralDonorGender, ReferralDonorGender), 
	ReferralDonorWeight = @ReferralDonorWeight,
	ReferralDonorAdmitDate = @ReferralDonorAdmitDate,
	ReferralDonorAdmitTime = @ReferralDonorAdmitTime,
	ReferralDonorDeathTime = @ReferralDonorDeathTime,
	ReferralDonorDeathDate = @ReferralDonorDeathDate,
	ReferralDonorLSATime = @ReferralDonorLSATime,
	ReferralDonorLSADate = @ReferralDonorLSADate,
	ReferralDonorCauseOfDeathID = ISNULL(@ReferralDonorCauseOfDeathID, ReferralDonorCauseOfDeathID), 
	ReferralDonorOnVentilator = ISNULL(@ReferralDonorOnVentilator, ReferralDonorOnVentilator),
	ReferralDonorDead = ISNULL(@ReferralDonorDead, ReferralDonorDead),
	ReferralTypeID = ISNULL(@ReferralTypeID, ISNULL(ReferralTypeID, 0)),
	--ReferralTypeID = ISNULL(@CurrentReferralTypeId, ISNULL(ReferralTypeID, 0)), 
	ReferralApproachTypeID = ISNULL(@ReferralApproachTypeID, ReferralApproachTypeID), 
	ReferralApproachedByPersonID = ISNULL(@ReferralApproachedByPersonID, ReferralApproachedByPersonID), 
	ReferralApproachNOK = ISNULL(@ReferralApproachNOK, 	ReferralApproachNOK),
	ReferralApproachRelation = ISNULL(@ReferralApproachRelation, ReferralApproachRelation),
	ReferralOrganAppropriateID = ISNULL(@ReferralOrganAppropriateID, ReferralOrganAppropriateID), 
	ReferralOrganApproachID = ISNULL(@ReferralOrganApproachID, ReferralOrganApproachID), 
	ReferralOrganConsentID = ISNULL(@ReferralOrganConsentID, ReferralOrganConsentID), 
	ReferralOrganConversionID = ISNULL(@ReferralOrganConversionID, ReferralOrganConversionID), 
	ReferralBoneAppropriateID = ISNULL(@ReferralBoneAppropriateID, ReferralBoneAppropriateID), 
	ReferralBoneApproachID = ISNULL(@ReferralBoneApproachID, ReferralBoneApproachID), 
	ReferralBoneConsentID = ISNULL(@ReferralBoneConsentID, ReferralBoneConsentID), 
	ReferralBoneConversionID = ISNULL(@ReferralBoneConversionID, ReferralBoneConversionID), 
	ReferralTissueAppropriateID = ISNULL(@ReferralTissueAppropriateID, ReferralTissueAppropriateID), 
	ReferralTissueApproachID = ISNULL(@ReferralTissueApproachID, ReferralTissueApproachID), 
	ReferralTissueConsentID = ISNULL(@ReferralTissueConsentID, ReferralTissueConsentID), 
	ReferralTissueConversionID = ISNULL(@ReferralTissueConversionID, ReferralTissueConversionID), 
	ReferralSkinAppropriateID = ISNULL(@ReferralSkinAppropriateID, ReferralSkinAppropriateID), 
	ReferralSkinApproachID = ISNULL(@ReferralSkinApproachID, ReferralSkinApproachID), 
	ReferralSkinConsentID = ISNULL(@ReferralSkinConsentID, ReferralSkinConsentID), 
	ReferralSkinConversionID = ISNULL(@ReferralSkinConversionID, ReferralSkinConversionID), 
	ReferralEyesTransAppropriateID = ISNULL(@ReferralEyesTransAppropriateID, ReferralEyesTransAppropriateID), 
	ReferralEyesTransApproachID = ISNULL(@ReferralEyesTransApproachID, ReferralEyesTransApproachID), 
	ReferralEyesTransConsentID = ISNULL(@ReferralEyesTransConsentID, ReferralEyesTransConsentID), 
	ReferralEyesTransConversionID = ISNULL(@ReferralEyesTransConversionID, ReferralEyesTransConversionID), 
	ReferralEyesRschAppropriateID = ISNULL(@ReferralEyesRschAppropriateID, ReferralEyesRschAppropriateID), 
	ReferralEyesRschApproachID = ISNULL(@ReferralEyesRschApproachID, ReferralEyesRschApproachID), 
	ReferralEyesRschConsentID = ISNULL(@ReferralEyesRschConsentID, ReferralEyesRschConsentID), 
	ReferralEyesRschConversionID = ISNULL(@ReferralEyesRschConversionID, ReferralEyesRschConversionID), 
	ReferralValvesAppropriateID = ISNULL(@ReferralValvesAppropriateID, ReferralValvesAppropriateID), 
	ReferralValvesApproachID = ISNULL(@ReferralValvesApproachID, ReferralValvesApproachID), 
	ReferralValvesConsentID = ISNULL(@ReferralValvesConsentID, ReferralValvesConsentID), 
	ReferralValvesConversionID = ISNULL(@ReferralValvesConversionID, ReferralValvesConversionID), 
	ReferralNotesCase = ISNULL(@ReferralNotesCase, ReferralNotesCase),
	ReferralNotesPrevious = ISNULL(@ReferralNotesPrevious, ReferralNotesPrevious),
	ReferralVerifiedOptions = ISNULL(@ReferralVerifiedOptions, ReferralVerifiedOptions), 
	ReferralCoronersCase = ISNULL(@ReferralCoronersCase, ReferralCoronersCase), 
	Inactive = ISNULL(@Inactive, Inactive), 
	ReferralCallerLevelID = ISNULL(@ReferralCallerLevelID, ReferralCallerLevelID), 
	LastModified = getDate(), 
	UnusedField1 = ISNULL(@UnusedField1, UnusedField1), 
	ReferralDonorFirstName = ISNULL(@ReferralDonorFirstName, ReferralDonorFirstName),
	ReferralDonorLastName = ISNULL(@ReferralDonorLastName, ReferralDonorLastName),
	ReferralOrganDispositionID = dbo.fn_CalculateOverallDisposition
									(
									1, -- 1 = Organ
									@ReferralOrganAppropriateID,
									@ReferralOrganApproachID, 
									@ReferralOrganConsentID, 
									@ReferralOrganConversionID
									), 	
	ReferralBoneDispositionID = dbo.fn_CalculateOverallDisposition
									(
									2, -- 2 = Bone
									@ReferralBoneAppropriateID, 
									@ReferralBoneApproachID, 
									@ReferralBoneConsentID, 
									@ReferralBoneConversionID
									), 
	ReferralTissueDispositionID = dbo.fn_CalculateOverallDisposition
									(
									3, -- 3 = Tissue
									@ReferralTissueAppropriateID, 
									@ReferralTissueApproachID, 
									@ReferralTissueConsentID, 
									@ReferralTissueConversionID 
									), 
	ReferralSkinDispositionID = dbo.fn_CalculateOverallDisposition
									(
									4, -- 4 = Skin
									@ReferralSkinAppropriateID, 
									@ReferralSkinApproachID, 
									@ReferralSkinConsentID, 
									@ReferralSkinConversionID
									), 
	ReferralValvesDispositionID = dbo.fn_CalculateOverallDisposition
									(
									5, -- 5 = Valves
									@ReferralValvesAppropriateID, 
									@ReferralValvesApproachID, 
									@ReferralValvesConsentID, 
									@ReferralValvesConversionID
									), 										
	ReferralEyesDispositionID = dbo.fn_CalculateOverallDisposition
									(6, -- 6 = Eyes
									@ReferralEyesTransAppropriateID, 
									@ReferralEyesTransApproachID, 
									@ReferralEyesTransConsentID, 
									@ReferralEyesTransConversionID
									), 
	ReferralRschDispositionID = dbo.fn_CalculateOverallDisposition
									(7, -- 7 = Other
									@ReferralEyesRschAppropriateID, 
									@ReferralEyesRschApproachID, 
									@ReferralEyesRschConsentID, 
									@ReferralEyesRschConversionID
									),	 	
	ReferralPronouncingMD = ISNULL(@ReferralPronouncingMD, ReferralPronouncingMD), 
	UnusedField3 = ISNULL(@UnusedField3, UnusedField3), 
	ReferralNOKPhone = ISNULL(@ReferralNOKPhone, ReferralNOKPhone),
	ReferralAttendingMD = ISNULL(@ReferralAttendingMD, ReferralAttendingMD), 
	ReferralGeneralConsent = ISNULL(@ReferralGeneralConsent, ReferralGeneralConsent), 
	ReferralNOKAddress = ISNULL(@ReferralNOKAddress, ReferralNOKAddress),
	ReferralCoronerName = ISNULL(@ReferralCoronerName, ReferralCoronerName),
	ReferralCoronerPhone = ISNULL(@ReferralCoronerPhone, ReferralCoronerPhone),
	ReferralCoronerOrganization = ISNULL(@ReferralCoronerOrganization, ReferralCoronerOrganization),
	ReferralCoronerNote = ISNULL(@ReferralCoronerNote, ReferralCoronerNote),
	ReferralApproachTime = ISNULL(@ReferralApproachTime, ReferralApproachTime), 
	ReferralConsentTime = ISNULL(@ReferralConsentTime, ReferralConsentTime), 
	Unused = ISNULL(@Unused, Unused), 
	ReferralDOA = ISNULL(@ReferralDOA, ReferralDOA), 
	ReferralDOB = @ReferralDOB,
	ReferralDonorSSN = ISNULL(@ReferralDonorSSN, ReferralDonorSSN),
	ReferralExtubated = ISNULL(@ReferralExtubated, ReferralExtubated),
	DonorRegistryType = ISNULL(@DonorRegistryType, DonorRegistryType), 
	DonorRegId = ISNULL(@DonorRegId, DonorRegId), 
	DonorDMVId = ISNULL(@DonorDMVId, DonorDMVId), 
	DonorDMVTable = ISNULL(@DonorDMVTable, DonorDMVTable),
	DonorIntentDone = ISNULL(@DonorIntentDone, DonorIntentDone), 
	DonorFaxSent = ISNULL(@DonorFaxSent, DonorFaxSent), 
	DonorDSNID = ISNULL(@DonorDSNID, DonorDSNID), 
	ReferralDonorHeartBeat = ISNULL(@ReferralDonorHeartBeat, ReferralDonorHeartBeat), 
	ReferralCoronerOrgID = ISNULL(@ReferralCoronerOrgID, ReferralCoronerOrgID), 
	CurrentReferralTypeId = ISNULL(@CurrentReferralTypeId, CurrentReferralTypeId), 
	ReferralDonorBrainDeathDate = @ReferralDonorBrainDeathDate,
	ReferralDonorBrainDeathTime = @ReferralDonorBrainDeathTime,
	ReferralPronouncingMDPhone = ISNULL(@ReferralPronouncingMDPhone, ReferralPronouncingMDPhone),
	ReferralAttendingMDPhone = ISNULL(@ReferralAttendingMDPhone, ReferralAttendingMDPhone),
	ReferralDOB_ILB = ISNULL(@ReferralDOB_ILB, ReferralDOB_ILB), 
	ReferralDonorSpecificCOD = ISNULL(@ReferralDonorSpecificCOD, ReferralDonorSpecificCOD),
	ReferralDonorNameMI = ISNULL(@ReferralDonorNameMI, ReferralDonorNameMI),
	ReferralNOKID = ISNULL(@ReferralNOKID, ReferralNOKID), 
	ReferralQAReviewComplete = ISNULL(@ReferralQAReviewComplete, ReferralQAReviewComplete), 
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
	IsERferralCase = @IsERferralCase,
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE	
	CallID = @CallID;
GO

GRANT EXEC ON UpdateReferral TO PUBLIC;
GO
