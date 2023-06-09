SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_SetDisposition]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_SetDisposition]
GO





CREATE PROCEDURE spu_SetDisposition
	@CallID INT
AS

SET NOCOUNT ON

UPDATE Referral 
SET ReferralOrganDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID=1 AND AppropriateID = Referral.ReferralOrganAppropriateID AND ApproachID = Referral.ReferralOrganApproachID AND ConsentID = Referral.ReferralOrganConsentID   AND RecoveryID = Referral.ReferralOrganConversionID ), 
ReferralBoneDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID= 2 AND AppropriateID = Referral.ReferralBoneAppropriateID AND ApproachID = Referral.ReferralBoneApproachID AND ConsentID = Referral.ReferralBoneConsentID   AND RecoveryID = Referral.ReferralBoneConversionID ), 
ReferralTissueDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID=3 AND AppropriateID = Referral.ReferralTissueAppropriateID AND ApproachID = Referral.ReferralTissueApproachID AND ConsentID = Referral.ReferralTissueConsentID   AND RecoveryID = Referral.ReferralTissueConversionID ), 
ReferralSkinDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID=4 AND AppropriateID = Referral.ReferralSkinAppropriateID AND ApproachID = Referral.ReferralSkinApproachID AND ConsentID = Referral.ReferralSkinConsentID   AND RecoveryID = Referral.ReferralSkinConversionID ), 
ReferralValvesDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID=5 AND AppropriateID = Referral.ReferralValvesAppropriateID AND ApproachID = Referral.ReferralValvesApproachID AND ConsentID = Referral.ReferralValvesConsentID   AND RecoveryID = Referral.ReferralValvesConversionID ), 
ReferralEyesDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID=6 AND AppropriateID = Referral.ReferralEyesTransAppropriateID AND ApproachID = Referral.ReferralEyesTransApproachID AND ConsentID = Referral.ReferralEyesTransConsentID   AND RecoveryID = Referral.ReferralEyesTransConversionID ), 
ReferralRschDispositionID = (SELECT DispositionID FROM SetDisposition WHERE OptionID=7 AND AppropriateID = Referral.ReferralEyesRschAppropriateID AND ApproachID = Referral.ReferralEyesRschApproachID AND ConsentID = Referral.ReferralEyesRschConsentID   AND RecoveryID = Referral.ReferralEyesRschConversionID ) , 
ReferralAllTissueDispositionID = 9

WHERE CallID = @CallID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

