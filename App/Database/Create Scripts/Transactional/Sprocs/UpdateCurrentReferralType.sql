 IF EXISTS (SELECT 1 FROM sysobjects WHERE type = 'P' AND name = 'UpdateCurrentReferralType')
	BEGIN
		PRINT 'Dropping Procedure UpdateCurrentReferralType';
		DROP  Procedure  UpdateCurrentReferralType;
	END
GO

PRINT 'Creating Procedure UpdateCurrentReferralType';
GO

CREATE Procedure UpdateCurrentReferralType
	@CallID				INT,
	@ServiceLevelID		INT,
	@LastStatEmployeeID	INT
AS
/******************************************************************************
**		File: 
**		Name: UpdateCurrentReferralType
**		Desc: Update the referral record with the appropriate CurrentReferralType
**				duplicating functionality in StatValidate.ReferralTypeDefault 
**				(called by FrmReferral)
**              
**		Return values: returns the update call table row
** 
**		Called by:  StatSave.UpdateCurrentReferralType
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		@CallID 			[INT]
**		@ServiceLevelID		[INT]
**		@LastStatEmployeeID	[INT]
**
**		Auth: Mike Berenson
**		Date: 11/28/2018
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/05/2018	Mike Berenson		Changed default referral type to ruleout
**		5/22/2019	Mike Berenson		Added concatenation logic (to match logic in StatValidate.ReferralTypeDefault)
*******************************************************************************/

DECLARE	
	@ReferralOrganAppropriateID			INT,
	@ReferralOrganApproachID			INT,
	@ReferralOrganConsentID				INT,
	@ReferralOrganRecoveryID			INT,
	@ReferralBoneAppropriateID			INT,
	@ReferralBoneApproachID				INT,
	@ReferralBoneConsentID				INT,
	@ReferralBoneRecoveryID				INT,
	@ReferralTissueAppropriateID		INT,
	@ReferralTissueApproachID			INT,
	@ReferralTissueConsentID			INT,
	@ReferralTissueRecoveryID			INT,
	@ReferralSkinAppropriateID			INT,
	@ReferralSkinApproachID				INT,
	@ReferralSkinConsentID				INT,
	@ReferralSkinRecoveryID				INT,
	@ReferralValvesAppropriateID		INT,
	@ReferralValvesApproachID			INT,
	@ReferralValvesConsentID			INT,
	@ReferralValvesRecoveryID			INT,	
	@ReferralResearchAppropriateID		INT,
	@ReferralResearchApproachID			INT,
	@ReferralResearchConsentID			INT,
	@ReferralResearchRecoveryID			INT,
	@ReferralEyesAppropriateID			INT,
	@ReferralEyesApproachID				INT,
	@ReferralEyesConsentID				INT,
	@ReferralEyesRecoveryID				INT,	
	@ServiceLevelAppropriateOrganID		INT,
	@ServiceLevelAppropriateBoneID		INT,
	@ServiceLevelAppropriateTissueID	INT,
	@ServiceLevelAppropriateSkinID		INT,
	@ServiceLevelAppropriateValvesID	INT,
	@ServiceLevelAppropriateEyesID		INT,
	@CurrentReferralTypeIdOriginal		INT,
	@CurrentReferralTypeIdNew			INT = 4, --Ruleout
	@CurrentReferralTypeIdNewList		VARCHAR(10) = '4',
	@ReferralTypeEyeOnly				INT = 3,
	@ReferralTypeOrgan					INT = 7,
	@ReferralTypeTissue					INT = 8;

--Look up referral data
SELECT TOP (1)
	@ReferralOrganAppropriateID = ReferralOrganAppropriateID,
	@ReferralOrganApproachID = ReferralOrganApproachID,
	@ReferralOrganConsentID = ReferralOrganConsentID,
	@ReferralOrganRecoveryID = ReferralOrganConversionID,
	@ReferralBoneAppropriateID = ReferralBoneAppropriateID,
	@ReferralBoneApproachID = ReferralBoneApproachID,
	@ReferralBoneConsentID = ReferralBoneConsentID,
	@ReferralBoneRecoveryID = ReferralBoneConversionID,
	@ReferralTissueAppropriateID = ReferralTissueAppropriateID,
	@ReferralTissueApproachID = ReferralTissueApproachID,
	@ReferralTissueConsentID = ReferralTissueConsentID,
	@ReferralTissueRecoveryID = ReferralTissueConversionID,
	@ReferralSkinAppropriateID = ReferralSkinAppropriateID,
	@ReferralSkinApproachID = ReferralSkinApproachID,
	@ReferralSkinConsentID = ReferralSkinConsentID,
	@ReferralSkinRecoveryID = ReferralSkinConversionID,
	@ReferralValvesAppropriateID = ReferralValvesAppropriateID,
	@ReferralValvesApproachID = ReferralValvesApproachID,
	@ReferralValvesConsentID = ReferralValvesConsentID,
	@ReferralValvesRecoveryID = ReferralValvesConversionID,
	@ReferralEyesAppropriateID = ReferralEyesTransAppropriateID,
	@ReferralEyesApproachID = ReferralEyesTransApproachID,
	@ReferralEyesConsentID = ReferralEyesTransConsentID,
	@ReferralEyesRecoveryID = ReferralEyesTransConversionID,
	@ReferralResearchAppropriateID = ReferralEyesRschAppropriateID,
	@ReferralResearchApproachID = ReferralEyesRschApproachID,
	@ReferralResearchConsentID = ReferralEyesRschConsentID,
	@ReferralResearchRecoveryID = ReferralEyesRschConversionID,
	@CurrentReferralTypeIdOriginal = CurrentReferralTypeId
FROM Referral
WHERE CallID = @CallID;

--Look up service level data
SELECT TOP (1)
	@ServiceLevelAppropriateOrganID = ServiceLevelAppropriateOrgan,
	@ServiceLevelAppropriateBoneID = ServiceLevelAppropriateBone,
	@ServiceLevelAppropriateTissueID = ServiceLevelAppropriateTissue,
	@ServiceLevelAppropriateSkinID = ServiceLevelAppropriateSkin,
	@ServiceLevelAppropriateValvesID = ServiceLevelAppropriateValves,
	@ServiceLevelAppropriateEyesID = ServiceLevelAppropriateEyes
FROM ServiceLevel
WHERE ServiceLevelID = @ServiceLevelID;

--Make sure we have an appropriate service level value
IF (@ServiceLevelAppropriateOrganID = -1 OR @ServiceLevelAppropriateBoneID = -1 OR @ServiceLevelAppropriateTissueID = -1 OR @ServiceLevelAppropriateSkinID = -1 OR @ServiceLevelAppropriateValvesID = -1 OR @ServiceLevelAppropriateEyesID = -1)
BEGIN
	DECLARE @returnValue BIT;

	--Check Organ
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralOrganRecoveryID, @ConsentID = @ReferralOrganConsentID, @AppropriateId = @ReferralOrganAppropriateID, @ApproachId = @ReferralOrganApproachID;
	IF @returnValue = 1
	BEGIN
		SELECT @CurrentReferralTypeIdNew = @ReferralTypeOrgan, @CurrentReferralTypeIdNewList = @ReferralTypeOrgan;
	END

	--Check Tissue
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralTissueRecoveryID, @ConsentID = @ReferralTissueConsentID, @AppropriateId = @ReferralTissueAppropriateID, @ApproachId = @ReferralTissueApproachID;
	IF @returnValue = 1
	BEGIN
		SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
	END

	--Check Bone
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralBoneRecoveryID, @ConsentID = @ReferralBoneConsentID, @AppropriateId = @ReferralBoneAppropriateID, @ApproachId = @ReferralBoneApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
		END
	END

	--Check Skin
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralSkinRecoveryID, @ConsentID = @ReferralSkinConsentID, @AppropriateId = @ReferralSkinAppropriateID, @ApproachId = @ReferralSkinApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
		END
	END	
	
	--Check Valves
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralValvesRecoveryID, @ConsentID = @ReferralValvesConsentID, @AppropriateId = @ReferralValvesAppropriateID, @ApproachId = @ReferralValvesApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
		END
	END
	
	--Check Research
	IF @CurrentReferralTypeIdNew <> @ReferralTypeTissue
	BEGIN
		EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralResearchRecoveryID, @ConsentID = @ReferralResearchConsentID, @AppropriateId = @ReferralResearchAppropriateID, @ApproachId = @ReferralResearchApproachID;
		IF @returnValue = 1
		BEGIN
			SELECT @CurrentReferralTypeIdNew = @ReferralTypeTissue, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeTissue AS VARCHAR);
		END
	END
	
	--Check Eyes
	EXEC @returnValue = dbo.fn_CreateReferralType @RecoveryId = @ReferralEyesRecoveryID, @ConsentID = @ReferralEyesConsentID, @AppropriateId = @ReferralEyesAppropriateID, @ApproachId = @ReferralEyesApproachID;
	IF @returnValue = 1
	BEGIN
		SELECT @CurrentReferralTypeIdNew = @ReferralTypeEyeOnly, @CurrentReferralTypeIdNewList = @CurrentReferralTypeIdNewList + CAST(@ReferralTypeEyeOnly AS VARCHAR);
	END	

END

--now the fun part...translate the end product...what was concatenated, make one of 8 referral types
SELECT @CurrentReferralTypeIdNew = 
	CASE @CurrentReferralTypeIdNewList
		WHEN '783' THEN 1 -- Organ/Tissue/Eye
		WHEN '78' THEN 5 -- Organ/Tissue
		WHEN '73' THEN 6 -- Organ/Eye
		WHEN '7' THEN 7 -- Organ
		WHEN '48' THEN 8 -- Tissue
		WHEN '483' THEN 2 -- Tissue/Eye
		WHEN '43' THEN 3 -- Eyes Only
		ELSE @CurrentReferralTypeIdNew
	END;

--Save New CurrentReferralTypeID If There Was A Change
IF @CurrentReferralTypeIdNew <> @CurrentReferralTypeIdOriginal
BEGIN

	UPDATE Referral 
	SET CurrentReferralTypeID = @CurrentReferralTypeIdNew,
		LastModified = GETDATE(),
		LastStatEmployeeID = @LastStatEmployeeID		
	WHERE CallID = @callID;

	RETURN @@ERROR;
END
ELSE
BEGIN
	RETURN 1;
END

GO

GRANT EXEC ON UpdateCurrentReferralType TO PUBLIC;
GO