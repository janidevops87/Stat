IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReferralFS')
	BEGIN
		PRINT 'Dropping Procedure UpdateReferralFS'
		DROP  Procedure  UpdateReferralFS
	END

GO

PRINT 'Creating Procedure UpdateReferralFS'
GO
CREATE Procedure UpdateReferralFS
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
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateReferralFS.sql 
**		Name: UpdateReferralFS
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
**		09/08/2011	ccarroll			Added LSA Date Time update - CCRST151
*******************************************************************************/

-- SELECT PARAMETERS NOT UPDATED BY FS
SELECT
	@DonorDMVTable = DonorDMVTable, 
	@ReferralAttendingMDPhone = ReferralAttendingMDPhone,  
	@ReferralCoronerNote = ReferralCoronerNote, 
	@ReferralDonorDead = ReferralDonorDead, 
	@ReferralDonorName = @ReferralDonorFirstName + ' ' + @ReferralDonorLastName, 
	@ReferralDonorNameMI = ReferralDonorNameMI, 
	@ReferralDonorOnVentilator = ReferralDonorOnVentilator, 
	@ReferralExtubated = ReferralExtubated, 
	@ReferralNotesCase = ReferralNotesCase, 
	@ReferralNotesPrevious = ReferralNotesPrevious, 
	@ReferralPronouncingMDPhone = ReferralPronouncingMDPhone 
FROM
	REFERRAL
WHERE CallID = @CallID



EXEC 
	UpdateReferral
	@ReferralID = @ReferralID, 
	@CallID = @CallID, 
	@ReferralCallerPhoneID = @ReferralCallerPhoneID, 
	@ReferralCallerExtension = @ReferralCallerExtension, 
	@ReferralCallerOrganizationID = @ReferralCallerOrganizationID, 
	@ReferralCallerSubLocationID = @ReferralCallerSubLocationID, 
	@ReferralCallerSubLocationLevel = @ReferralCallerSubLocationLevel, 
	@ReferralCallerPersonID = @ReferralCallerPersonID, 
	@ReferralDonorName = @ReferralDonorName, 
	@ReferralDonorRecNumber = @ReferralDonorRecNumber, 
	@ReferralDonorAge = @ReferralDonorAge, 
	@ReferralDonorAgeUnit = @ReferralDonorAgeUnit, 
	@ReferralDonorRaceID = @ReferralDonorRaceID, 
	@ReferralDonorGender = @ReferralDonorGender, 
	@ReferralDonorWeight = @ReferralDonorWeight, 
	@ReferralDonorAdmitDate = @ReferralDonorAdmitDate, 
	@ReferralDonorAdmitTime = @ReferralDonorAdmitTime,
	@ReferralDonorDeathDate = @ReferralDonorDeathDate, 
	@ReferralDonorDeathTime = @ReferralDonorDeathTime, 
	@ReferralDonorLSADate = @ReferralDonorLSADate, 
	@ReferralDonorLSATime = @ReferralDonorLSATime, 
	@ReferralDonorCauseOfDeathID = @ReferralDonorCauseOfDeathID, 
	@ReferralDonorOnVentilator = @ReferralDonorOnVentilator, 
	@ReferralDonorDead = @ReferralDonorDead, 
	@ReferralTypeID = @ReferralTypeID, 
	@ReferralApproachTypeID = @ReferralApproachTypeID, 
	@ReferralApproachedByPersonID = @ReferralApproachedByPersonID, 
	@ReferralApproachNOK = @ReferralApproachNOK, 
	@ReferralApproachRelation = @ReferralApproachRelation, 
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
	@ReferralNotesCase = @ReferralNotesCase, 
	@ReferralNotesPrevious = @ReferralNotesPrevious, 
	@ReferralVerifiedOptions = @ReferralVerifiedOptions, 
	@ReferralCoronersCase = @ReferralCoronersCase, 
	@Inactive = @Inactive, 
	@ReferralCallerLevelID = @ReferralCallerLevelID, 
	@UnusedField1 = @UnusedField1, 
	@ReferralDonorFirstName = @ReferralDonorFirstName, 
	@ReferralDonorLastName = @ReferralDonorLastName, 
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
	@ReferralNOKPhone = @ReferralNOKPhone, 
	@ReferralAttendingMD = @ReferralAttendingMD, 
	@ReferralGeneralConsent = @ReferralGeneralConsent, 
	@ReferralNOKAddress = @ReferralNOKAddress, 
	@ReferralCoronerName = @ReferralCoronerName, 
	@ReferralCoronerPhone = @ReferralCoronerPhone, 
	@ReferralCoronerOrganization = @ReferralCoronerOrganization, 
	@ReferralCoronerNote = @ReferralCoronerNote, 
	@ReferralApproachTime = @ReferralApproachTime, 
	@ReferralConsentTime = @ReferralConsentTime, 
	@Unused = @Unused, 
	@ReferralDOA = @ReferralDOA, 
	@ReferralDOB = @ReferralDOB, 
	@ReferralDonorSSN = @ReferralDonorSSN, 
	@ReferralExtubated = @ReferralExtubated, 
	@DonorRegistryType = @DonorRegistryType, 
	@DonorRegId = @DonorRegId, 
	@DonorDMVId = @DonorDMVId, 
	@DonorDMVTable = @DonorDMVTable, 
	@DonorIntentDone = @DonorIntentDone, 
	@DonorFaxSent = @DonorFaxSent, 
	@DonorDSNID = @DonorDSNID, 
	@ReferralDonorHeartBeat = @ReferralDonorHeartBeat, 
	@ReferralCoronerOrgID = @ReferralCoronerOrgID, 
	@CurrentReferralTypeId = @CurrentReferralTypeId, 
	@ReferralDonorBrainDeathDate = @ReferralDonorBrainDeathDate, 
	@ReferralDonorBrainDeathTime = @ReferralDonorBrainDeathTime, 
	@ReferralPronouncingMDPhone = @ReferralPronouncingMDPhone, 
	@ReferralAttendingMDPhone = @ReferralAttendingMDPhone, 
	@ReferralDOB_ILB = @ReferralDOB_ILB, 
	@ReferralDonorSpecificCOD = @ReferralDonorSpecificCOD, 
	@ReferralDonorNameMI = @ReferralDonorNameMI, 
	@ReferralNOKID = @ReferralNOKID, 
	@ReferralQAReviewComplete = @ReferralQAReviewComplete, 
	@LastStatEmployeeID = @LastStatEmployeeID, 
	@AuditLogTypeID = @AuditLogTypeID 

	

	


GO

GRANT EXEC ON UpdateReferralFS TO PUBLIC

GO
