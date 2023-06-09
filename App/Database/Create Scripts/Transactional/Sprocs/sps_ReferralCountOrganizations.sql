SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCountOrganizations]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCountOrganizations]
GO






/****** Object:  Stored Procedure dbo.sps_ReferralCountOrganizations    Script Date: 2/24/99 1:12:46 AM ******/
CREATE PROCEDURE sps_ReferralCountOrganizations

	@vReportGroupID	int		= null,
	@vOrgID		int		= null,
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null


AS

/********************************************************************************/
/*										*/
/********************************************************************************/


IF @vOrgID = null OR @vOrgID = 0

	SELECT 	Referral.ReferralCallerOrganizationID, OrganizationName, Count(Referral.CallID) AS  ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	
	JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
	JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID

	WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND	WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND 	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	GROUP BY Referral.ReferralCallerOrganizationID, OrganizationName
	ORDER BY OrganizationName
	
ELSE

	SELECT 	Referral.ReferralCallerOrganizationID, OrganizationName, Count(Referral.CallID) AS  ReferralCount
	FROM 	Referral
	JOIN	Call ON Call.CallID = Referral.CallID 
	
	JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN	WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
	JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID

	WHERE 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND	WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID	
	AND 	CallDateTime >= @vStartDate 
	AND 	CallDateTime <= @vEndDate
	AND	Referral.ReferralCallerOrganizationID = @vOrgID
	GROUP BY Referral.ReferralCallerOrganizationID, OrganizationName




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

