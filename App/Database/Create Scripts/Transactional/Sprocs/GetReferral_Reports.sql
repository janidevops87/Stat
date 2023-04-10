IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetReferral_Reports')
	BEGIN
		PRINT 'Dropping Procedure GetReferral_Reports'
		DROP  Procedure  GetReferral_Reports
	END

GO

PRINT 'Creating Procedure GetReferral_Reports'
GO 

CREATE Procedure GetReferral_Reports
  
    @CallID int = NULL 

AS

/******************************************************************************
**		File: GetReferral_Reports.sql 
**		Name: GetReferral_Reports
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
**     07/06/2009   ccarroll			Added data to rs get prior to update
**										HS-19591	
**	   11/20/2014	mberenson			Added ReferralDOB to the selected fields
*******************************************************************************/

select
	--HS-19591
	ReferralDonorAdmitDate,
	ReferralDonorAdmitTime,
	ReferralDonorDeathDate,
	ReferralDonorDeathTime,
	--HS-19591

	ReferralApproachTypeID , 
	ReferralApproachedByPersonID , 
	
	ReferralOrganApproachID , 
	ReferralOrganConsentID , 
	ReferralOrganConversionID , 
	
	ReferralBoneApproachID , 
	ReferralBoneConsentID , 
	ReferralBoneConversionID , 
	
	ReferralTissueApproachID , 
	ReferralTissueConsentID , 
	ReferralTissueConversionID , 
	
	ReferralSkinApproachID , 
	ReferralSkinConsentID , 
	ReferralSkinConversionID , 
	
	ReferralEyesTransApproachID , 
	ReferralEyesTransConsentID , 
	ReferralEyesTransConversionID , 
	
	ReferralValvesApproachID , 
	ReferralValvesConsentID , 
	ReferralValvesConversionID , 
	
	ReferralEyesRschApproachID , 
	ReferralEyesRschConsentID , 
	ReferralEyesRschConversionID , 

	--HS-19591
	ReferralDonorBrainDeathDate,
	ReferralDonorBrainDeathTime,
	--HS-19591

	LastStatEmployeeID,
	AuditLogTypeID,


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
	ReferralGeneralConsent,
	ReferralDOB
	
	--AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify		
from referral
WHERE	
	CallID = @CallID
GO
 