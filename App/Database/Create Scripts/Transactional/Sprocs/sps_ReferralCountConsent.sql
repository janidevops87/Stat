SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCountConsent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCountConsent]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralCountConsent    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralCountConsent

	@vReportGroupID	int		= null,
	@vOrgID		int		= null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null

AS


	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.WebReportGroupID = @vReportGroupID	
	AND	ReferralOrganAppropriateID = 1
	AND	ReferralOrganApproachID = 1
	AND	ReferralOrganConsentID = 1

UNION ALL

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.WebReportGroupID = @vReportGroupID	
	AND	ReferralBoneAppropriateID = 1
	AND	ReferralBoneApproachID = 1
	AND	ReferralBoneConsentID = 1

UNION ALL

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.WebReportGroupID = @vReportGroupID	
	AND	ReferralTissueAppropriateID = 1
	AND	ReferralTissueApproachID = 1
	AND	ReferralTissueConsentID = 1

UNION ALL

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.WebReportGroupID = @vReportGroupID	
	AND	ReferralSkinAppropriateID = 1
	AND	ReferralSkinApproachID = 1
	AND	ReferralSkinConsentID = 1

UNION ALL

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.WebReportGroupID = @vReportGroupID	
	AND	ReferralValvesAppropriateID = 1
	AND	ReferralValvesApproachID = 1
	AND	ReferralValvesConsentID = 1

UNION ALL

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.WebReportGroupID = @vReportGroupID	
	AND	ReferralEyesTransAppropriateID = 1
	AND	ReferralEyesTransApproachID = 1
	AND	ReferralEyesTransConsentID = 1




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

