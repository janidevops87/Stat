IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateReferral_Reports')
	BEGIN
		PRINT 'Dropping Procedure UpdateReferral_Reports'
		DROP  Procedure  UpdateReferral_Reports
	END

GO

PRINT 'Creating Procedure UpdateReferral_Reports'
GO 
 
CREATE Procedure UpdateReferral_Reports
    @ReferralID int = NULL , 
    @CallID int = NULL , 

    @ReferralApproachTypeID int = NULL , 
    @ReferralApproachedByPersonID int = NULL , 
    @ReferralGeneralConsent smallint = NULL , 

    @ReferralOrganApproachID int = NULL , 
    @ReferralOrganConsentID int = NULL , 
    @ReferralOrganConversionID int = NULL , 
    
    @ReferralBoneApproachID int = NULL , 
    @ReferralBoneConsentID int = NULL , 
    @ReferralBoneConversionID int = NULL , 
    
    @ReferralTissueApproachID int = NULL , 
    @ReferralTissueConsentID int = NULL , 
    @ReferralTissueConversionID int = NULL , 
    
    @ReferralSkinApproachID int = NULL , 
    @ReferralSkinConsentID int = NULL , 
    @ReferralSkinConversionID int = NULL , 
    
   
    @ReferralValvesApproachID int = NULL , 
    @ReferralValvesConsentID int = NULL , 
    @ReferralValvesConversionID int = NULL , 
    
    @ReferralEyesTransApproachID int = NULL , 
    @ReferralEyesTransConsentID int = NULL , 
    @ReferralEyesTransConversionID int = NULL,
    
    @ReferralEyesRschApproachID int = NULL , 
    @ReferralEyesRschConsentID int = NULL , 
    @ReferralEyesRschConversionID int = NULL,
    
    @LastStatEmployeeID int,
    @AuditLogTypeID int = null
AS

/******************************************************************************
**		File: UpdateReferral_Reports.sql 
**		Name: UpdateReferral_Reports
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
**		Auth: jth
**		Date: 7/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 


UPDATE
	Referral
SET
	
	ReferralApproachTypeID = ISNULL(@ReferralApproachTypeID, ReferralApproachTypeID), 
	ReferralApproachedByPersonID = ISNULL(@ReferralApproachedByPersonID, ReferralApproachedByPersonID), 
	
	ReferralOrganApproachID = ISNULL(@ReferralOrganApproachID, ReferralOrganApproachID), 
	ReferralOrganConsentID = ISNULL(@ReferralOrganConsentID, ReferralOrganConsentID), 
	ReferralOrganConversionID = ISNULL(@ReferralOrganConversionID, ReferralOrganConversionID), 
	
	ReferralBoneApproachID = ISNULL(@ReferralBoneApproachID, ReferralBoneApproachID), 
	ReferralBoneConsentID = ISNULL(@ReferralBoneConsentID, ReferralBoneConsentID), 
	ReferralBoneConversionID = ISNULL(@ReferralBoneConversionID, ReferralBoneConversionID), 
	
	ReferralTissueApproachID = ISNULL(@ReferralTissueApproachID, ReferralTissueApproachID), 
	ReferralTissueConsentID = ISNULL(@ReferralTissueConsentID, ReferralTissueConsentID), 
	ReferralTissueConversionID = ISNULL(@ReferralTissueConversionID, ReferralTissueConversionID), 
	
	ReferralSkinApproachID = ISNULL(@ReferralSkinApproachID, ReferralSkinApproachID), 
	ReferralSkinConsentID = ISNULL(@ReferralSkinConsentID, ReferralSkinConsentID), 
	ReferralSkinConversionID = ISNULL(@ReferralSkinConversionID, ReferralSkinConversionID), 
	
	ReferralEyesTransApproachID = ISNULL(@ReferralEyesTransApproachID, ReferralEyesTransApproachID), 
	ReferralEyesTransConsentID = ISNULL(@ReferralEyesTransConsentID, ReferralEyesTransConsentID), 
	ReferralEyesTransConversionID = ISNULL(@ReferralEyesTransConversionID, ReferralEyesTransConversionID), 
	
	ReferralValvesApproachID = ISNULL(@ReferralValvesApproachID, ReferralValvesApproachID), 
	ReferralValvesConsentID = ISNULL(@ReferralValvesConsentID, ReferralValvesConsentID), 
	ReferralValvesConversionID = ISNULL(@ReferralValvesConversionID, ReferralValvesConversionID),
	
	ReferralEyesRschApproachID= ISNULL(@ReferralEyesRschApproachID, ReferralEyesRschApproachID), 
	ReferralEyesRschConsentID= ISNULL(@ReferralEyesRschConsentID, ReferralEyesRschConsentID),  
	ReferralEyesRschConversionID = ISNULL(@ReferralEyesRschConversionID, ReferralEyesRschConversionID), 
	 
	/*
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
	*/
	ReferralGeneralConsent = ISNULL(@ReferralGeneralConsent, ReferralGeneralConsent),
	LastModified = getDate()
	--AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
WHERE	
	CallID = @CallID
GO
 