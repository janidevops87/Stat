IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReferralPending')
	BEGIN
		PRINT 'Dropping Procedure UpdateReferralPending'
		DROP  Procedure  UpdateReferralPending
	END

GO

PRINT 'Creating Procedure UpdateReferralPending'
GO
CREATE Procedure UpdateReferralPending
    @ReferralID int = NULL , 
    @CallID int = NULL , 
    @ReferralApproachTypeID int = NULL , 
    @ReferralApproachedByPersonID int = NULL ,     
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
    @ReferralGeneralConsent smallint = NULL , 
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL 
AS

/******************************************************************************
**		File: UpdateReferralPending.sql 
**		Name: UpdateReferralPending
**		Desc: Updates Referral data from the PendingReferrals Form
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
**		Date: 9/6/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      9/06/2007	Bret Knoll			8.4.3.8 AuditTrail
*******************************************************************************/

UPDATE
	Referral
SET	
	ReferralApproachTypeID = ISNULL(@ReferralApproachTypeID, ReferralApproachTypeID), 
	ReferralApproachedByPersonID = ISNULL(@ReferralApproachedByPersonID, ReferralApproachedByPersonID), 
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
	ReferralEyesTransAppropriateID = ISNULL(@ReferralEyesTransAppropriateID, ReferralEyesTransAppropriateID), 		ReferralEyesTransApproachID = ISNULL(@ReferralEyesTransApproachID, ReferralEyesTransApproachID), 
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
	ReferralOrganDispositionID = dbo.fn_CalculateOverallDisposition
									(
									1, -- 1 = Organ
									ISNULL(@ReferralOrganAppropriateID, ReferralOrganAppropriateID), 
									ISNULL(@ReferralOrganApproachID, ReferralOrganApproachID), 
									ISNULL(@ReferralOrganConsentID, ReferralOrganConsentID), 
									ISNULL(@ReferralOrganConversionID, ReferralOrganConversionID)
									), 	
	ReferralBoneDispositionID = dbo.fn_CalculateOverallDisposition
									(
									2, -- 2 = Bone
									ISNULL(@ReferralBoneAppropriateID, ReferralBoneAppropriateID), 
									ISNULL(@ReferralBoneApproachID, ReferralBoneApproachID), 
									ISNULL(@ReferralBoneConsentID, ReferralBoneConsentID), 
									ISNULL(@ReferralBoneConversionID, ReferralBoneConversionID)
									), 
	ReferralTissueDispositionID = dbo.fn_CalculateOverallDisposition
									(
									3, -- 3 = Tissue
									ISNULL(@ReferralTissueAppropriateID, ReferralTissueAppropriateID), 
									ISNULL(@ReferralTissueApproachID, ReferralTissueApproachID), 
									ISNULL(@ReferralTissueConsentID, ReferralTissueConsentID), 
									ISNULL(@ReferralTissueConversionID, ReferralTissueConversionID)
									), 
	ReferralSkinDispositionID = dbo.fn_CalculateOverallDisposition
									(
									4, -- 4 = Skin
									ISNULL(@ReferralSkinAppropriateID, ReferralSkinAppropriateID), 
									ISNULL(@ReferralSkinApproachID, ReferralSkinApproachID), 
									ISNULL(@ReferralSkinConsentID, ReferralSkinConsentID), 
									ISNULL(@ReferralSkinConversionID, ReferralSkinConversionID)
									), 
	ReferralValvesDispositionID = dbo.fn_CalculateOverallDisposition
									(
									5, -- 5 = Valves
									ISNULL(@ReferralValvesAppropriateID, ReferralValvesAppropriateID), 
									ISNULL(@ReferralValvesApproachID, ReferralValvesApproachID), 
									ISNULL(@ReferralValvesConsentID, ReferralValvesConsentID), 
									ISNULL(@ReferralValvesConversionID, ReferralValvesConversionID) 
									), 										
	ReferralEyesDispositionID = dbo.fn_CalculateOverallDisposition
									(6, -- 6 = Eyes
									ISNULL(@ReferralEyesTransAppropriateID, ReferralEyesTransAppropriateID), 
									ISNULL(@ReferralEyesTransApproachID, ReferralEyesTransApproachID), 
									ISNULL(@ReferralEyesTransConsentID, ReferralEyesTransConsentID), 
									ISNULL(@ReferralEyesTransConversionID, ReferralEyesTransConversionID)
									), 
	ReferralRschDispositionID = dbo.fn_CalculateOverallDisposition
									(7, -- 7 = Other
									ISNULL(@ReferralEyesRschAppropriateID, ReferralEyesRschAppropriateID), 
									ISNULL(@ReferralEyesRschApproachID, ReferralEyesRschApproachID), 
									ISNULL(@ReferralEyesRschConsentID, ReferralEyesRschConsentID), 
									ISNULL(@ReferralEyesRschConversionID, ReferralEyesRschConversionID)
									),	 		
	ReferralGeneralConsent = ISNULL(@ReferralGeneralConsent, ReferralGeneralConsent), 	
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE	
	CallID = @CallID

	


GO

GRANT EXEC ON UpdateReferralPending TO PUBLIC

GO
