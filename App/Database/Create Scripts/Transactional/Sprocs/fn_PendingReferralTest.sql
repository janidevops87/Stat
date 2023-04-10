 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'FN' AND name = 'fn_PendingReferralTest')
	BEGIN
		PRINT 'Dropping Function fn_PendingReferralTest'
		DROP  function  fn_PendingReferralTest
	END

GO

PRINT 'Creating Procedure GetScheduleSingle'
GO
 
 CREATE FUNCTION fn_PendingReferralTest(
		@CallID int
		
)

RETURNS int  AS  
/******************************************************************************
**		File: 
**		Name: fn_PendingReferralTest
**		Desc: This provides the logic to return whether a callid is a pending referral
**			  
**
**              
**		Return values: 
**			Returns 1 if true otherwise 0...i.e. the count
**			
**		Called by:   
**              
**		Parameters:
**		Input							Output
**	     ----------							-----------
**
**		Auth: jth
**		Date: 11/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**     		 11/08		jth				initial 
*******************************************************************************/
BEGIN 


declare	@ReferralType int	
DECLARE @Organ Int
DECLARE @Bone Int
DECLARE @Tissue Int
DECLARE @Skin Int
DECLARE @EyesTrans Int
DECLARE @EyesRsch Int
DECLARE @Valves Int
DECLARE @returnVal int

IF IsNull(@ReferralType, 0) = 0 /* Select all */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 0
					SET @Bone = 0 
					SET @Tissue = 0
					SET @Skin = 0
					SET @EyesTrans = 0
					SET @EyesRsch = 0
					SET @Valves = 0 
			END 

		IF IsNull(@ReferralType, 0) = 1 /* Organ/Tissue/Eye - Select all */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 0
					SET @Bone = 0 
					SET @Tissue = 0
					SET @Skin = 0
					SET @EyesTrans = 0
					SET @EyesRsch = 1
					SET @Valves = 1 
			END 

		IF IsNull(@ReferralType, 0) = 2 /* Tissue/Eye */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 1
					SET @Bone = 0 
					SET @Tissue = 0
					SET @Skin = 0
					SET @EyesTrans = 0
					SET @EyesRsch = 1
					SET @Valves = 1 
			END	

		IF IsNull(@ReferralType, 0) = 3 /* Eyes Only */
			BEGIN
					/*	0 = Display (Select)
						1 = Hide (Exclude from selection) */ 
					SET @Organ = 1
					SET @Bone = 1 
					SET @Tissue = 1
					SET @Skin = 1
					SET @EyesTrans = 0
					SET @EyesRsch = 1
					SET @Valves = 1 
			END	

SELECT  @returnVal=count(*)
FROM referral



WHERE callid = @CallID

	/* Pending Referrals */
		AND (
				(	/* Approach Type: (2)Unknown */
					(ReferralOrganApproachID + @Organ) = 2 OR
					(ReferralBoneApproachID + @Bone) = 2 OR
					(ReferralTissueApproachID + @Tissue) = 2 OR
					(ReferralSkinApproachID + @Skin) = 2 OR
					(ReferralEyesTransApproachID + @EyesTrans) = 2 OR
					(ReferralEyesRschApproachID + @EyesRsch) = 2 OR
					(ReferralValvesApproachID + @Valves) = 2
					) OR
--				(	/* Consent Type: (5)No,Unknown */
--					ReferralOrganConsentID = 5 OR
--					ReferralBoneConsentID = 5 OR
--					ReferralTissueConsentID = 5 OR
--					ReferralSkinConsentID = 5 OR
--					ReferralEyesTransConsentID = 5 OR
--					ReferralEyesRschConsentID = 5 OR
--					ReferralValvesConsentID = 5
--					) OR
				(	/* Conversion Type: (9)Unknown */ 
					(ReferralOrganConversionID + @Organ) = 9 OR
					(ReferralBoneConversionID + @Bone) = 9 OR
					(ReferralTissueConversionID + @Tissue) = 9 OR
					(ReferralSkinConversionID + @Skin) = 9 OR
					(ReferralEyesTransConversionID + @EyesTrans) = 9 OR
					(ReferralEyesRschConversionID + @EyesRsch) = 9 OR
					(ReferralValvesConversionID + @Valves) = 9
					) OR
				(	/* Appropriate = (1)Yes, Approach = (-1)Blank */ 
					(ReferralOrganAppropriateID + @Organ = 1 AND IsNull(ReferralOrganApproachID, -1) + @Organ = -1) OR
					(ReferralBoneAppropriateID + @Bone = 1 AND IsNull(ReferralBoneApproachID, -1) + @Bone = -1) OR
					(ReferralTissueAppropriateID + @Tissue = 1 AND IsNull(ReferralTissueApproachID, -1) + @Tissue = -1) OR
					(ReferralSkinAppropriateID + @Skin =1 AND IsNull(ReferralSkinApproachID, -1) + @Skin = -1) OR
					(ReferralEyesTransAppropriateID + @EyesTrans = 1 AND IsNull(ReferralEyesTransApproachID, -1) + @EyesTrans = -1) OR
					(ReferralEyesRschAppropriateID + @EyesRsch = 1 AND IsNull(ReferralEyesRschApproachID, -1) + @EyesRsch = -1) OR
					(ReferralValvesAppropriateID + @Valves = 1 AND IsNull(ReferralValvesApproachID, -1) + @Valves = -1)
					) OR

				(	/* Approach = (1)Yes, Consent = (-1)Blank */ 
					(ReferralOrganApproachID + @Organ = 1 AND IsNull(ReferralOrganConsentID, -1) + @Organ = -1) OR
					(ReferralBoneApproachID + @Bone = 1 AND IsNull(ReferralBoneConsentID, -1)+ @Bone = -1) OR
					(ReferralTissueApproachID + @Tissue = 1 AND IsNull(ReferralTissueConsentID, -1) + @Tissue = -1) OR
					(ReferralSkinApproachID + @Skin =1 AND IsNull(ReferralSkinConsentID, -1) + @Skin = -1) OR
					(ReferralEyesTransApproachID + @EyesTrans = 1 AND IsNull(ReferralEyesTransConsentID, -1) + @EyesTrans = -1) OR
					(ReferralEyesRschApproachID + @EyesRsch = 1 AND IsNull(ReferralEyesRschConsentID, -1) + @EyesRsch = -1) OR
					(ReferralValvesApproachID + @Valves = 1 AND IsNull(ReferralValvesConsentID, -1) + @Valves = -1)
					) OR

				(	/* Consent = (1)Yes, Recovery = (-1)Blank */ 
					(ReferralOrganConsentID + @Organ = 1 AND IsNull(ReferralOrganConversionID, -1) + @Organ = -1) OR
					(ReferralBoneConsentID + @Bone = 1 AND IsNull(ReferralBoneConversionID, -1)+ @Bone = -1) OR
					(ReferralTissueConsentID + @Tissue = 1 AND IsNull(ReferralTissueConversionID, -1) + @Tissue = -1) OR
					(ReferralSkinConsentID + @Skin =1 AND IsNull(ReferralSkinConversionID, -1) + @Skin = -1) OR
					(ReferralEyesTransConsentID + @EyesTrans = 1 AND IsNull(ReferralEyesTransConversionID, -1) + @EyesTrans = -1) OR
					(ReferralEyesRschConsentID + @EyesRsch = 1 AND IsNull(ReferralEyesRschConversionID, -1) + @EyesRsch = -1) OR
					(ReferralValvesConsentID + @Valves = 1 AND IsNull(ReferralValvesConversionID, -1) + @Valves = -1)
					) 
			)
		 


 


return @returnVal
END
 
GO








