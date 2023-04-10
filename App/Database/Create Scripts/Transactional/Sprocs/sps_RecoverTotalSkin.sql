SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_RecoverTotalSkin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_RecoverTotalSkin]
GO






/****** Object:  Stored Procedure dbo.sps_RecoverTotalSkin    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_RecoverTotalSkin

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
	AND	ReferralSkinAppropriateID = 1
	AND	ReferralSkinApproachID = 1
	AND	ReferralSkinConsentID = 1
	AND	ReferralSkinConversionID = 1

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
	AND	ReferralSkinAppropriateID = 1
	AND	ReferralSkinApproachID = 1
	AND	ReferralSkinConsentID = 1
	AND	ReferralSkinConversionID = 1
	AND	ReferralTypeID = @vReferralTypeID




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

