SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_IncompleteReferralDetail]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_IncompleteReferralDetail]
GO






/****** Object:  Stored Procedure dbo.sps_IncompleteReferralDetail    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_IncompleteReferralDetail

	@vTZ		varchar(2)	= null,
	@vCallID	int		= null

AS

DECLARE

	@vHour		smallint,
	@vCallDateTime	smalldatetime
	
	IF RIGHT(@vTZ, 1) = 'S' -- if time zone is standard get calldatetime else just get time zone differencre
	BEGIN
		SELECT @vCallDateTime = CallDateTime from Call Where CallID = @vCallID
	END
	
	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vCallDateTime


	SELECT 	Call.CallID, Call.CallNumber, 
			CONVERT(char(8), DATEADD(hour, @vHour, CallDateTime), 1) AS CallDate,
			CONVERT(char(5), DATEADD(hour, @vHour, CallDateTime), 8) AS CallTime,
			Organization.OrganizationID, Organization.OrganizationName, 
			Referral.ReferralDonorName + ',   ' + ReferralDonorGender + ',   ' + ReferralDonorAge + '  ' + ReferralDonorAgeUnit AS ReferralDonorName,
			ReferralApproachTypeID, ReferralApproachedByPersonID, ReferralGeneralConsent,
			ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID,
			ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID,
			ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID,
			ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID,
			ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID,
			ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID,
			ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID
        FROM 		Call
        JOIN 		Referral ON Referral.CallID = Call.CallID
        JOIN 		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
        WHERE 		Call.CallID = @vCallID







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

