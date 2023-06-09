SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SecondaryDispositionTriageDisposition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure spu_SecondaryDispositionTriageDisposition'
		DROP procedure [dbo].[spu_SecondaryDispositionTriageDisposition]

	END
GO

		PRINT 'Creating Procedure spu_SecondaryDispositionTriageDisposition'
GO


CREATE PROCEDURE spu_SecondaryDispositionTriageDisposition @ReferralID                        INT,
                                                           @ReferralOrganAppropriateID        INT,
                                                           @ReferralBoneAppropriateID         INT,
                                                           @ReferralTissueAppropriateID       INT,
                                                           @ReferralSkinAppropriateID         INT,
                                                           @ReferralValvesAppropriateID       INT,
                                                           @ReferralEyesTransAppropriateID    INT,
														   @ReferralEyesRschAppropriateID     INT,

                                                           @ReferralOrganApproachID           INT,
                                                           @ReferralBoneApproachID            INT,
                                                           @ReferralTissueApproachID          INT,
                                                           @ReferralSkinApproachID            INT,
                                                           @ReferralValvesApproachID          INT,
                                                           @ReferralEyesTransApproachID       INT,
														   @ReferralEyesRschApproachID        INT,

                                                           @ReferralOrganConsentID            INT,
                                                           @ReferralBoneConsentID             INT,
                                                           @ReferralTissueConsentID           INT,
                                                           @ReferralSkinConsentID             INT,
                                                           @ReferralValvesConsentID           INT,
                                                           @ReferralEyesTransConsentID        INT,
                                                           @ReferralEyesRschConsentID         INT,

                                                           @ReferralOrganConversionID         INT,
                                                           @ReferralBoneConversionID          INT,
                                                           @ReferralTissueConversionID        INT,
                                                           @ReferralSkinConversionID          INT,
                                                           @ReferralValvesConversionID        INT,
                                                           @ReferralEyesTransConversionID     INT,
                                                           @ReferralEyesRschConversionID      INT AS

/* ccarroll 09/06/2007 - Check to see if the approach value was a ruleout in FS. If it was, reset the 
						 values for Consent and Conversion on the Triage side. (-2) is used as a flag
						 to indicate when to reset values to (-1.) See Consent and Conversion case statements
						 which follow. */

IF @ReferralOrganApproachID > 1 BEGIN SET @ReferralOrganConsentID = -2 SET @ReferralOrganConversionID = -2 END
IF @ReferralBoneApproachID > 1 BEGIN SET @ReferralBoneConsentID = -2 SET @ReferralBoneConversionID = -2 END
IF @ReferralTissueApproachID > 1 BEGIN SET @ReferralTissueConsentID = -2 SET @ReferralTissueConversionID = -2 END
IF @ReferralSkinApproachID > 1 BEGIN SET @ReferralSkinConsentID = -2 SET @ReferralSkinConversionID = -2 END
IF @ReferralValvesApproachID > 1 BEGIN SET @ReferralValvesConsentID = -2 SET @ReferralValvesConversionID = -2 END
IF @ReferralEyesTransApproachID > 1 BEGIN SET @ReferralEyesTransConsentID = -2 SET @ReferralEyesTransConversionID = -2 END




UPDATE Referral
SET --ReferralOrganAppropriateID     = @ReferralOrganAppropriateID,
    --ReferralBoneAppropriateID      = @ReferralBoneAppropriateID,
    --ReferralTissueAppropriateID    = @ReferralTissueAppropriateID,
    --ReferralSkinAppropriateID      = @ReferralSkinAppropriateID,
    --ReferralEyesTransAppropriateID = @ReferralEyesTransAppropriateID,
    --ReferralEyesRschAppropriateID  = @ReferralEyesRschAppropriateID,
    --ReferralValvesAppropriateID    = @ReferralValvesAppropriateID,
    ReferralOrganApproachID = CASE ISNULL(@ReferralOrganApproachID, -1)		--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralOrganApproachID
					WHEN  0 THEN ReferralOrganApproachID --ccarroll 05/12/2011 - was overwritting triage data HS 26660 :wi9389
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralOrganApproachID
				END,
    ReferralBoneApproachID = CASE ISNULL(@ReferralBoneApproachID, -1)		--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralBoneApproachID
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralBoneApproachID
				END,
    ReferralTissueApproachID = CASE ISNULL(@ReferralTissueApproachID, -1)		--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralTissueApproachID
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralTissueApproachID
				END,
    ReferralSkinApproachID = CASE ISNULL(@ReferralSkinApproachID, -1)			--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralSkinApproachID
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralSkinApproachID
				END,
    ReferralEyesTransApproachID = CASE ISNULL(@ReferralEyesTransApproachID, -1)	--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralEyesTransApproachID
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralEyesTransApproachID
				END,
    ReferralEyesRschApproachID = CASE ISNULL(@ReferralEyesRschApproachID, -1)	--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralEyesRschApproachID
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralEyesRschApproachID
				END,
    ReferralValvesApproachID = CASE ISNULL(@ReferralValvesApproachID, -1)		--10/22/02 drh - To minimize interference with Approach updates on the Web, don't overwrite Approach if empty
					WHEN -1 THEN ReferralValvesApproachID
					WHEN 15 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					WHEN 16 THEN 7				--drh 05/20/03 - Need to map Approach values now that there's a separate FSApproach table
					ELSE @ReferralValvesApproachID
				END,
    ReferralOrganConsentID = CASE ISNULL(@ReferralOrganConsentID, -1)			--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralOrganConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralOrganConsentID
				END,
    ReferralBoneConsentID = CASE ISNULL(@ReferralBoneConsentID, -1)			--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralBoneConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralBoneConsentID
				END,
    ReferralTissueConsentID = CASE ISNULL(@ReferralTissueConsentID, -1)		--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralTissueConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralTissueConsentID
				END,
    ReferralSkinConsentID = CASE ISNULL(@ReferralSkinConsentID, -1)			--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralSkinConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralSkinConsentID
				END,
   ReferralEyesTransConsentID = CASE ISNULL(@ReferralEyesTransConsentID, -1)		--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralEyesTransConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralEyesTransConsentID
				END,
   ReferralEyesRschConsentID = CASE ISNULL(@ReferralEyesRschConsentID, -1)		--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralEyesRschConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralEyesRschConsentID
				END,
    ReferralValvesConsentID = CASE ISNULL(@ReferralValvesConsentID, -1)		--10/22/02 drh - To minimize interference with Consent updates on the Web, don't overwrite Consent if empty
					WHEN -1 THEN ReferralValvesConsentID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralValvesConsentID
				END,
    ReferralOrganConversionID = CASE ISNULL(@ReferralOrganConversionID, -1)		--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralOrganConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralOrganConversionID
				END,
    ReferralBoneConversionID = CASE ISNULL(@ReferralBoneConversionID, -1)		--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralBoneConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralBoneConversionID
				END,
    ReferralTissueConversionID = CASE ISNULL(@ReferralTissueConversionID, -1)		--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralTissueConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralTissueConversionID
				END,
    ReferralSkinConversionID = CASE ISNULL(@ReferralSkinConversionID, -1)		--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralSkinConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralSkinConversionID
				END,
    ReferralEyesTransConversionID = CASE ISNULL(@ReferralEyesTransConversionID, -1)	--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralEyesTransConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralEyesTransConversionID
				END,
    ReferralEyesRschConversionID = CASE ISNULL(@ReferralEyesRschConversionID, -1)	--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralEyesRschConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralEyesRschConversionID
				END,
    ReferralValvesConversionID = CASE ISNULL(@ReferralValvesConversionID, -1)		--10/18/02 drh - To minimize interference with Recovery updates on the Web, don't overwrite Recovery if empty
					WHEN -1 THEN ReferralValvesConversionID
					WHEN -2 THEN -1					--cwc 09/06/2007 reset if Approach is a ruleout
					ELSE @ReferralValvesConversionID
				END
WHERE ReferralID = @ReferralID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

