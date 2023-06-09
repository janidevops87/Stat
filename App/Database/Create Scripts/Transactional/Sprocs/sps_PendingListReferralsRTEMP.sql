SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingListReferralsRTEMP]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingListReferralsRTEMP]
GO




/****** Object:  Stored Procedure dbo.sps_PendingListReferralsRTEMP    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_PendingListReferralsRTEMP


AS

	SELECT 	Call.CallID, Call.CallNumber, CallDateTime

        FROM 	LogEvent
        JOIN 	Referral ON LogEvent.CallID = Referral.CallID
        JOIN 	Call ON Referral.CallID = Call.CallID

        WHERE 	LogEvent.LogEventCallbackPending = -1
        AND 	LogEventTypeID = 5

	AND	(ReferralOrganAppropriateID = 1 AND ReferralOrganConversionID > 0
	OR 	(ReferralBoneAppropriateID = 1 AND ReferralBoneConversionID > 0)
	OR 	(ReferralTissueAppropriateID = 1 AND ReferralTissueConversionID > 0)
	OR 	(ReferralSkinAppropriateID = 1 AND ReferralSkinConversionID > 0)
	OR 	(ReferralValvesAppropriateID = 1 AND ReferralValvesConversionID > 0)
	OR 	(ReferralEyesTransAppropriateID = 1 AND ReferralEyesTransConversionID > 0))	

	AND Call.CallID NOT IN (

	SELECT 	Call.CallID

        FROM 	LogEvent
        JOIN 	Referral ON LogEvent.CallID = Referral.CallID
        JOIN 	Call ON Referral.CallID = Call.CallID

        WHERE 	LogEvent.LogEventCallbackPending = -1
        AND 	LogEventTypeID = 5

	AND	(ReferralOrganAppropriateID = 1 AND ReferralOrganConversionID = -1
	OR 	(ReferralBoneAppropriateID = 1 AND ReferralBoneConversionID = -1)
	OR 	(ReferralTissueAppropriateID = 1 AND ReferralTissueConversionID = -1)
	OR 	(ReferralSkinAppropriateID = 1 AND ReferralSkinConversionID = -1)
	OR 	(ReferralValvesAppropriateID = 1 AND ReferralValvesConversionID = -1)
	OR 	(ReferralEyesTransAppropriateID = 1 AND ReferralEyesTransConversionID = -1))	
	
	)
	
        ORDER BY 	Call.CallDateTime ASC


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

