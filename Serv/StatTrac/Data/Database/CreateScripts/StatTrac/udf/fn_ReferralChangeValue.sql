SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ReferralChangeValue]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[fn_ReferralChangeValue]
GO


CREATE FUNCTION [dbo].[fn_ReferralChangeValue] (@callId Integer)  
RETURNS Varchar(50)
AS

BEGIN 
	-- Takes the most recent LogEventID, combines it with a total of fields in the referral table to create a string enabling 
	-- its use in creating links to quickly determine if any changes were made.  9/7/04 - SAP
	DECLARE @changeString Varchar(50)
	DECLARE @changeInt Integer

	SET @changeString = (SELECT Cast(Max(LogEventId) AS Varchar) FROM LogEvent LE WHERE LE.CallId = @callId) 
	SET @changeString = @changeString + 'X'

	SET @changeInt = (SELECT
		ReferralCallerPhoneID +
		IsNull(ReferralCallerOrganizationID, 0) +
		IsNull(ReferralCallerSubLocationID, 0) +
		IsNull(ReferralCallerExtension, 0) +
		IsNull(DonorIntentDone, 0) +
		IsNull(DonorFaxSent, 0) +
		IsNull(DonorDSNID, 0) +
		IsNull(ReferralDonorHeartBeat, 0) +
		IsNull(ReferralCallerPersonID, 0) +
		round(IsNull(ReferralDonorAge, 0),0) +
		IsNull(ReferralDonorRaceID, 0) +
		IsNull(ReferralDonorWeight, 0) +
		IsNull(ReferralDonorCauseOfDeathID, 0) +
		IsNull(ReferralTypeID, 0) +
		IsNull(ReferralApproachTypeID, 0) +
		IsNull(ReferralApproachedByPersonID, 0) +
		IsNull(ReferralOrganAppropriateID, 0) +
		IsNull(ReferralOrganApproachID, 0) +
		IsNull(ReferralOrganConsentID, 0) +
		IsNull(ReferralOrganConversionID, 0) +
		IsNull(ReferralBoneAppropriateID, 0) +
		IsNull(ReferralBoneApproachID, 0) +
		IsNull(ReferralBoneConsentID, 0) +
		IsNull(ReferralBoneConversionID, 0) +
		IsNull(ReferralTissueAppropriateID, 0) +
		IsNull(ReferralTissueApproachID, 0) +
		IsNull(ReferralTissueConsentID, 0) +
		IsNull(ReferralTissueConversionID, 0) +
		IsNull(ReferralSkinAppropriateID, 0) +
		IsNull(ReferralSkinApproachID, 0) +
		IsNull(ReferralSkinConsentID, 0) +
		IsNull(ReferralSkinConversionID, 0) +
		IsNull(ReferralEyesTransAppropriateID, 0) +
		IsNull(ReferralEyesTransApproachID, 0) +
		IsNull(ReferralEyesTransConsentID, 0) +
		IsNull(ReferralEyesTransConversionID, 0) +
		IsNull(ReferralEyesRschAppropriateID, 0) +
		IsNull(ReferralEyesRschApproachID, 0) +
		IsNull(ReferralEyesRschConsentID, 0) +
		IsNull(ReferralEyesRschConversionID, 0) +
		IsNull(ReferralValvesAppropriateID, 0) +
		IsNull(ReferralValvesApproachID, 0) +
		IsNull(ReferralValvesConsentID, 0) +
		IsNull(ReferralValvesConversionID, 0) +
		IsNull(ReferralVerifiedOptions, 0) +
		IsNull(ReferralCoronersCase, 0) +
		IsNull(Inactive, 0) +
		IsNull(ReferralCallerLevelID, 0) +
		IsNull(ReferralOrganDispositionID, 0) +
		IsNull(ReferralBoneDispositionID, 0) +
		IsNull(ReferralTissueDispositionID, 0) +
		IsNull(ReferralSkinDispositionID, 0) +
		IsNull(ReferralValvesDispositionID, 0) +
		IsNull(ReferralEyesDispositionID, 0) +
		IsNull(ReferralRschDispositionID, 0) +
		IsNull(ReferralAllTissueDispositionID, 0) +
		IsNull(ReferralPronouncingMD, 0) +
		IsNull(ReferralAttendingMD, 0) +
		IsNull(ReferralGeneralConsent, 0) +
		IsNull(ReferralApproachTime, 0) +
		IsNull(ReferralConsentTime, 0) +
		IsNull(ReferralDOA, 0) +
		IsNull(DonorRegistryType, 0) +
		IsNull(DonorRegId, 0) +
		IsNull(DonorDMVId, 0) +
		-- Varchar values
		Len(IsNull(ReferralCallerSubLocationLevel,'')) + 
		Len(IsNull(ReferralDonorName,'')) + 
		Len(IsNull(ReferralDonorRecNumber,'')) + 
		Len(IsNull(ReferralDonorGender,'')) + 
		Len(IsNull(ReferralDonorOnVentilator,'')) + 
		Len(IsNull(ReferralDonorDead,'')) + 
		Len(IsNull(ReferralApproachNOK,'')) + 
		Len(IsNull(ReferralApproachRelation,'')) + 
		Len(IsNull(ReferralNotesCase,'')) + 
		Len(IsNull(ReferralNotesPrevious,'')) + 
		Len(IsNull(ReferralDonorFirstName,'')) + 
		Len(IsNull(ReferralDonorLastName,'')) + 
		Len(IsNull(ReferralNOKPhone,'')) + 
		Len(IsNull(ReferralNOKAddress,'')) + 
		Len(IsNull(ReferralCoronerName,'')) + 
		Len(IsNull(ReferralCoronerPhone,'')) + 
		Len(IsNull(ReferralCoronerOrganization,'')) + 
		Len(IsNull(ReferralCoronerNote,'')) + 
		Len(IsNull(ReferralDonorSSN,'')) + 
		Len(IsNull(ReferralExtubated,'')) + 
		Len(IsNull(ReferralDonorAdmitTime,'')) + 
		Len(IsNull(ReferralDonorDeathTime,'')) + 
		Len(IsNull(ReferralDonorAgeUnit,'')) +
		Len(IsNull(DonorDMVTable,'')) +
		-- DateTime values
		Cast(IsNull(ReferralDonorAdmitDate, 0) AS Int) +
		Cast(IsNull(ReferralDonorDeathDate, 0) AS Int) +
		-- Don't use this value - it always changes. Cast(IsNull(LastModified, 0) AS Int) +
		Cast(IsNull(ReferralDOB , 0) AS Int) AS datetotal 
		FROM Referral RF 
		WHERE RF.CallId = @callId);

	SET @changeString = @changeString + Cast(@changeInt AS Varchar)

	Return @changeString
END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

