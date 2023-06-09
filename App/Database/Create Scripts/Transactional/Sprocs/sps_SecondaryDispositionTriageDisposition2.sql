SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_SecondaryDispositionTriageDisposition2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_SecondaryDispositionTriageDisposition2]
GO


CREATE PROCEDURE sps_SecondaryDispositionTriageDisposition2 @Callid INT AS

SELECT ReferralOrganAppropriateID, 
       ReferralBoneAppropriateID, 
       ReferralTissueAppropriateID, 
       ReferralSkinAppropriateID, 
       ReferralEyesTransAppropriateID, 
       ReferralEyesRschAppropriateID, 
       ReferralValvesAppropriateID, 

       ReferralOrganApproachID, 
       ReferralBoneApproachID, 
       ReferralTissueApproachID, 
       ReferralSkinApproachID, 
       ReferralEyesTransApproachID, 
       ReferralEyesRschApproachID, 
       ReferralValvesApproachID, 

       ReferralOrganConsentID, 
       ReferralBoneConsentID, 
       ReferralTissueConsentID, 
       ReferralSkinConsentID, 
       ReferralEyesTransConsentID, 
       ReferralEyesRschConsentID, 
       ReferralValvesConsentID, 

       ReferralOrganConversionID, 
       ReferralBoneConversionID, 
       ReferralTissueConversionID, 
       ReferralSkinConversionID, 
       ReferralEyesTransConversionID, 
       ReferralEyesRschConversionID, 
       ReferralValvesConversionID
FROM Referral
WHERE CallID = @Callid


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

