SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ConsentTotalEyes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ConsentTotalEyes]
GO






/****** Object:  Stored Procedure dbo.sps_ConsentTotalEyes    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_ConsentTotalEyes

	@vUserOrgID	int		= null,
	@vOrgID		int		= null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vReferralTypeID int		= null

AS

IF	@vReferralTypeID = 0 OR @vReferralTypeID = null

	SELECT 	Count(Call.CallID) AS ReferralCount
	FROM 	Call
	JOIN	Referral ON Referral.CallID = Call.CallID
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate AND CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.OrgHierarchyParentID = @vUserOrgID
	AND	WebReportGroup.WebReportGroupMaster = 1
	AND	ReferralEyesTransAppropriateID = 1
	AND	ReferralEyesTransApproachID = 1
	AND	ReferralEyesTransConsentID = 1

ELSE

	SELECT 	Count(Call.CallID) AS ReferralCount
	FROM 	Call
	JOIN	Referral ON Referral.CallID = Call.CallID
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate AND CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.OrgHierarchyParentID = @vUserOrgID
	AND	WebReportGroup.WebReportGroupMaster = 1
	AND	ReferralEyesTransAppropriateID = 1
	AND	ReferralEyesTransApproachID = 1
	AND	ReferralEyesTransConsentID = 1
	AND	ReferralTypeID = @vReferralTypeID




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

