SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCountType2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCountType2]
GO




CREATE PROCEDURE sps_ReferralCountType2
	
	@vStartDate			datetime	= null,
	@vEndDate			datetime	= null,
	@vReferralTypeID 		int		= 0,
	@vReportGroupID		int		= 0,
	@vOrgID			int		= 0

AS

/********************************************************************************/
/*	Totals									*/
/********************************************************************************/

IF	@vOrgID = 0

	IF	@vReferralTypeID = 0

		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 		Referral
		JOIN		Call ON Call.CallID = Referral.CallID
		JOIN 		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND		WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND 		CallDateTime >= @vStartDate 
		AND 		CallDateTime <= @vEndDate

	ELSE

		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 	Referral
		JOIN	Call ON Call.CallID = Referral.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND	WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate
		AND	Referral.ReferralTypeID = @vReferralTypeID

ELSE
	IF	@vReferralTypeID = 0

		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 	Referral
		JOIN	Call ON Call.CallID = Referral.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND	WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate
		AND	Referral.ReferralCallerOrganizationID = @vOrgID

	ELSE

		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 	Referral
		JOIN	Call ON Call.CallID = Referral.CallID
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
		WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND	WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND 	CallDateTime >= @vStartDate 
		AND 	CallDateTime <= @vEndDate
		AND	Referral.ReferralTypeID = @vReferralTypeID
		AND	Referral.ReferralCallerOrganizationID = @vOrgID







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

