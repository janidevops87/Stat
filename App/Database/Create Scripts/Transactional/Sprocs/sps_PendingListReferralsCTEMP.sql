SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingListReferralsCTEMP]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingListReferralsCTEMP]
GO




/****** Object:  Stored Procedure dbo.sps_PendingListReferralsCTEMP    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_PendingListReferralsCTEMP


AS


	SELECT 	Call.CallID, Call.CallNumber, CallDateTime

        FROM 	LogEvent
        JOIN 	Referral ON LogEvent.CallID = Referral.CallID
        JOIN 	Call ON Referral.CallID = Call.CallID

        WHERE 	LogEvent.LogEventCallbackPending = -1
        AND 	LogEventTypeID = 4

	AND	(ReferralOrganAppropriateID = 1 AND (ReferralOrganApproachID > 1)
	OR 	(ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID > 1))
	OR 	(ReferralTissueAppropriateID = 1 AND (ReferralTissueApproachID > 1))
	OR 	(ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID > 1))
	OR 	(ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID > 1))
	OR 	(ReferralEyesTransAppropriateID = 1 AND (ReferralEyesTransApproachID > 1)))	


	AND Call.CallID NOT IN (

	SELECT 	Call.CallID

        FROM 	LogEvent
        JOIN 	Referral ON LogEvent.CallID = Referral.CallID
        JOIN 	Call ON Referral.CallID = Call.CallID

        WHERE 	LogEvent.LogEventCallbackPending = -1
        AND 	LogEventTypeID = 4

	AND	(ReferralOrganAppropriateID = 1 AND (ReferralOrganApproachID = -1)
	OR 	(ReferralBoneAppropriateID = 1 AND (ReferralBoneApproachID = -1))
	OR 	(ReferralTissueAppropriateID = 1 AND (ReferralTissueApproachID = -1))
	OR 	(ReferralSkinAppropriateID = 1 AND (ReferralSkinApproachID = -1))
	OR 	(ReferralValvesAppropriateID = 1 AND (ReferralValvesApproachID = -1))
	OR 	(ReferralEyesTransAppropriateID = 1 AND (ReferralEyesTransApproachID = -1)))	
	
	)


UNION


	SELECT 	Call.CallID, Call.CallNumber, CallDateTime

        FROM 	LogEvent
        JOIN 	Referral ON LogEvent.CallID = Referral.CallID
        JOIN 	Call ON Referral.CallID = Call.CallID

        WHERE 	LogEvent.LogEventCallbackPending = -1
        AND 	LogEventTypeID = 4

	AND	(ReferralOrganAppropriateID = 1 AND ReferralOrganApproachID = 1 AND ReferralOrganConsentID > 0
	OR 	(ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = 1 AND ReferralBoneConsentID > 0)
	OR 	(ReferralTissueAppropriateID = 1 AND ReferralTissueApproachID = 1 AND ReferralTissueConsentID > 0)
	OR 	(ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = 1 AND ReferralSkinConsentID > 0)
	OR 	(ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = 1 AND ReferralValvesConsentID > 0)
	OR 	(ReferralEyesTransAppropriateID = 1 AND ReferralEyesTransApproachID = 1 AND ReferralEyesTransConsentID > 0))


	AND Call.CallID NOT IN (

	SELECT 	Call.CallID

        FROM 	LogEvent
        JOIN 	Referral ON LogEvent.CallID = Referral.CallID
        JOIN 	Call ON Referral.CallID = Call.CallID

        WHERE 	LogEvent.LogEventCallbackPending = -1
        AND 	LogEventTypeID = 4

	AND	(ReferralOrganAppropriateID = 1 AND ReferralOrganApproachID = -1 AND ReferralOrganConsentID = -1
	OR 	(ReferralBoneAppropriateID = 1 AND ReferralBoneApproachID = -1 AND ReferralBoneConsentID = -1)
	OR 	(ReferralTissueAppropriateID = 1 AND ReferralTissueApproachID = -1 AND ReferralTissueConsentID = -1)
	OR 	(ReferralSkinAppropriateID = 1 AND ReferralSkinApproachID = -1 AND ReferralSkinConsentID = -1)
	OR 	(ReferralValvesAppropriateID = 1 AND ReferralValvesApproachID = -1 AND ReferralValvesConsentID = -1)
	OR 	(ReferralEyesTransAppropriateID = 1 AND ReferralEyesTransApproachID = -1 AND ReferralEyesTransConsentID = -1))	

	
	)
	
        ORDER BY 	Call.CallDateTime ASC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

