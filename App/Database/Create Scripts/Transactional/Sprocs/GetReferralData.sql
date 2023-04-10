IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferralData')
	BEGIN
		PRINT 'Dropping Procedure GetReferralData'
		DROP  Procedure  GetReferralData
	END

GO

PRINT 'Creating Procedure GetReferralData'
GO
CREATE Procedure GetReferralData
	@CallID INT

AS

/******************************************************************************
**		File: GetReferralList.sql
**		Name: GetReferralList
**		Desc: Gets Referrals data
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll	
**		Date: 11/01/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/01/2008	ccarroll
**      09/2011     jth					added lsa d/t fields			
*******************************************************************************/

SELECT 
ReferralID,
CallID,
ReferralCallerPhoneID,
ReferralCallerExtension,
ReferralCallerOrganizationID,
ReferralCallerSubLocationID,
ReferralCallerSubLocationLevel,
ReferralCallerPersonID,
ReferralDonorName,
ReferralDonorRecNumber,
ReferralDonorAge,
ReferralDonorAgeUnit,
ReferralDonorRaceID,
ReferralDonorGender,
ReferralDonorWeight,
ReferralDonorAdmitDate,
ReferralDonorAdmitTime,
ReferralDonorDeathDate,
ReferralDonorDeathTime,
ReferralDonorLSADate,
ReferralDonorLSATime, 
ReferralDonorCauseOfDeathID,
ReferralDonorOnVentilator,
ReferralDonorDead,
ReferralTypeID,
ReferralApproachTypeID,
ReferralApproachedByPersonID,
ReferralApproachNOK,
ReferralApproachRelation,
ReferralOrganAppropriateID,
ReferralOrganApproachID,
ReferralOrganConsentID,
ReferralOrganConversionID,
ReferralBoneAppropriateID,
ReferralBoneApproachID,
ReferralBoneConsentID,
ReferralBoneConversionID,
ReferralTissueAppropriateID,
ReferralTissueApproachID,
ReferralTissueConsentID,
ReferralTissueConversionID,
ReferralSkinAppropriateID,
ReferralSkinApproachID,
ReferralSkinConsentID,
ReferralSkinConversionID,
ReferralEyesTransAppropriateID,
ReferralEyesTransApproachID,
ReferralEyesTransConsentID,
ReferralEyesTransConversionID,
ReferralEyesRschAppropriateID,
ReferralEyesRschApproachID,
ReferralEyesRschConsentID,
ReferralEyesRschConversionID,
ReferralValvesAppropriateID,
ReferralValvesApproachID,
ReferralValvesConsentID,
ReferralValvesConversionID,
ReferralNotesCase,
ReferralNotesPrevious,
ReferralVerifiedOptions,
ReferralCoronersCase,
Inactive,
ReferralCallerLevelID,
LastModified,
UnusedField1,
ReferralDonorFirstName,
ReferralDonorLastName,
ReferralOrganDispositionID,
ReferralBoneDispositionID,
ReferralTissueDispositionID,
ReferralSkinDispositionID,
ReferralValvesDispositionID,
ReferralEyesDispositionID,
ReferralRschDispositionID,
ReferralAllTissueDispositionID,
ReferralPronouncingMD,
UnusedField3,
ReferralNOKPhone,
ReferralAttendingMD,
ReferralGeneralConsent,
ReferralNOKAddress,
ReferralCoronerName,
ReferralCoronerPhone,
ReferralCoronerOrganization,
ReferralCoronerNote,
ReferralApproachTime,
ReferralConsentTime,
Unused,
ReferralDOA,
ReferralDOB,
ReferralDonorSSN,
UpdatedFlag,
ReferralExtubated,
DonorRegistryType,
DonorRegId,
DonorDMVId,
DonorDMVTable,
DonorIntentDone,
DonorFaxSent,
DonorDSNID,
ReferralDonorHeartBeat,
ReferralCoronerOrgID,
CurrentReferralTypeId,
ReferralDonorBrainDeathDate,
ReferralDonorBrainDeathTime,
ReferralPronouncingMDPhone,
ReferralAttendingMDPhone,
ReferralDOB_ILB,
ReferralDonorSpecificCOD,
ReferralDonorNameMI,
ReferralNOKID,
ReferralQAReviewComplete,
LastStatEmployeeID,
AuditLogTypeID

FROM 
	Referral 
WHERE 
	Referral.CallID = @CallID 

GO

