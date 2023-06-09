SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ApprchTotalBone]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ApprchTotalBone]
GO






/****** Object:  Stored Procedure dbo.sps_ApprchTotalBone    Script Date: 2/24/99 1:12:44 AM ******/
CREATE PROCEDURE sps_ApprchTotalBone

	@vUserOrgID	int		= null,
	@vOrgID		int		= null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null,
	@vReferralTypeID int		= null

AS

IF	@vReferralTypeID = 0 OR @vReferralTypeID = null 

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.OrgHierarchyParentID = @vUserOrgID
	AND	WebReportGroup.WebReportGroupMaster = 1
	AND	ReferralBoneAppropriateID = 1
	AND	ReferralBoneApproachID = 1

ELSE

	SELECT 	Count(Referral.CallID) AS ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID
	JOIN 	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupSourceCode.WebReportGroupID
	WHERE	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	AND 	WebReportGroup.OrgHierarchyParentID = @vUserOrgID
	AND	WebReportGroup.WebReportGroupMaster = 1
	AND	ReferralBoneAppropriateID = 1
	AND	ReferralBoneApproachID = 1
	AND 	ReferralTypeID = @vReferralTypeID




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

