SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCountTypeNotApprch]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCountTypeNotApprch]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralCountTypeNotApprch    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralCountTypeNotApprch
	
	@vOrgID			int		= null,
	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vSourceCodeID		int		= null,
	@vReportGroupID		int		= null,
	@vOrganizationID	int		= null,
	@vRuleoutTypeID 	int		= null

AS
/********************************************************************************/
/*	NotApproached								*/
/********************************************************************************/
	
IF	@vRuleoutTypeID = null OR @vRuleoutTypeID = 0

	IF @vOrganizationID = null OR @vOrganizationID = 0

		SELECT 	ReferralTypeID, Count(Referral.CallID) AS ReferralCount
		FROM 	Referral
		JOIN	Call ON Call.CallID = Referral.CallID 	
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID

		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate	
		AND	ReferralApproachTypeID = 1
		AND	SourceCodeID = @vSourceCodeID
		GROUP BY ReferralTypeID
		ORDER BY ReferralTypeID	

	ELSE

		SELECT 	ReferralTypeID, Count(Referral.CallID) AS ReferralCount
		FROM 	Referral
		JOIN	Call ON Call.CallID = Referral.CallID 	
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID

		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate	
		AND	ReferralApproachTypeID = 1
		AND	SourceCodeID = @vSourceCodeID
		AND	Referral.ReferralCallerOrganizationID = @vOrganizationID
		GROUP BY ReferralTypeID
		ORDER BY ReferralTypeID	

ELSE IF	@vRuleoutTypeID = 1

/********************************************************************************/
/*	ROAge - Not Approached							*/
/********************************************************************************/

	IF @vOrganizationID = null OR @vOrganizationID = 0

		SELECT 	Count(Call.CallID) AS ReferralCount
		FROM 	Call
		JOIN	Referral ON Referral.CallID = Call.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID

		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate	
		AND	ReferralTypeID = 4
		AND	ReferralApproachTypeID = 1
		AND	ReferralBoneAppropriateID <> 4
		AND	ReferralBoneAppropriateID <> 3
		AND	ReferralTissueAppropriateID <> 4
		AND	ReferralTissueAppropriateID <> 3
		AND	ReferralSkinAppropriateID <> 4
		AND	ReferralSkinAppropriateID <> 3
		AND	ReferralValvesAppropriateID <> 4
		AND	ReferralValvesAppropriateID <> 3
		AND	ReferralEyesTransAppropriateID <> 4
		AND	ReferralEyesTransAppropriateID <> 3
		AND	SourceCodeID = @vSourceCodeID

	ELSE

		SELECT 	Count(Call.CallID) AS ReferralCount
		FROM 	Call
		JOIN	Referral ON Referral.CallID = Call.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID

		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate	
		AND	ReferralTypeID = 4
		AND	ReferralApproachTypeID = 1
		AND	ReferralBoneAppropriateID <> 4
		AND	ReferralBoneAppropriateID <> 3
		AND	ReferralTissueAppropriateID <> 4
		AND	ReferralTissueAppropriateID <> 3
		AND	ReferralSkinAppropriateID <> 4
		AND	ReferralSkinAppropriateID <> 3
		AND	ReferralValvesAppropriateID <> 4
		AND	ReferralValvesAppropriateID <> 3
		AND	ReferralEyesTransAppropriateID <> 4
		AND	ReferralEyesTransAppropriateID <> 3
		AND	SourceCodeID = @vSourceCodeID
		AND	Referral.ReferralCallerOrganizationID = @vOrganizationID

ELSE IF	@vRuleoutTypeID = 2

/********************************************************************************/
/*	ROMed - Not Approached							*/
/********************************************************************************/

	IF @vOrganizationID = null OR @vOrganizationID = 0

		SELECT 	Count(Call.CallID) AS ReferralCount
		FROM 	Call
		JOIN	Referral ON Referral.CallID = Call.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID

		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate	
		AND	ReferralTypeID = 4
		AND	ReferralApproachTypeID = 1
		AND	(ReferralBoneAppropriateID = 4
		OR 	ReferralBoneAppropriateID = 3
		OR	ReferralTissueAppropriateID = 4
		OR	ReferralTissueAppropriateID = 3
		OR	ReferralSkinAppropriateID = 4
		OR	ReferralSkinAppropriateID = 3
		OR	ReferralValvesAppropriateID = 4
		OR	ReferralValvesAppropriateID = 3
		OR	ReferralEyesTransAppropriateID = 4
		OR	ReferralEyesTransAppropriateID = 3)
		AND	SourceCodeID = @vSourceCodeID

	ELSE

		SELECT 	Count(Call.CallID) AS ReferralCount
		FROM 	Call
		JOIN	Referral ON Referral.CallID = Call.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID

		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate	
		AND	ReferralTypeID = 4
		AND	ReferralApproachTypeID = 1
		AND	(ReferralBoneAppropriateID = 4
		OR 	ReferralBoneAppropriateID = 3
		OR	ReferralTissueAppropriateID = 4
		OR	ReferralTissueAppropriateID = 3
		OR	ReferralSkinAppropriateID = 4
		OR	ReferralSkinAppropriateID = 3
		OR	ReferralValvesAppropriateID = 4
		OR	ReferralValvesAppropriateID = 3
		OR	ReferralEyesTransAppropriateID = 4
		OR	ReferralEyesTransAppropriateID = 3)
		AND	SourceCodeID = @vSourceCodeID
		AND	Referral.ReferralCallerOrganizationID = @vOrganizationID





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

