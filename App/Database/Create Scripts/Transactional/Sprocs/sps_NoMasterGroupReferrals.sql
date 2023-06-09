SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_NoMasterGroupReferrals]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_NoMasterGroupReferrals]
GO






/****** Object:  Stored Procedure dbo.sps_NoMasterGroupReferrals    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_NoMasterGroupReferrals
	
	@vStartDate	datetime	= null,
	@vEndDate	datetime	= null

AS

	SELECT	Call.CallID, CallNumber, CallDateTime, SourceCodeName, OrganizationName

	FROM	Call
	JOIN	Referral ON Referral.CallID = Call.CallID
	JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN	WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID
	JOIN	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
	JOIN	Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID

	WHERE	CallDateTime >= @vStartDate
	AND 	CallDateTime <= @vEndDate
	AND 	Call.CallID NOT IN


		(
		SELECT		Call.CallID

		FROM		Call
		JOIN		Referral ON Referral.CallID = Call.CallID
		JOIN 		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN		WebReportGroup ON WebReportGroup.WebReportGroupID = WebReportGroupOrg.WebReportGroupID

		WHERE		CallDateTime >= @vStartDate
		AND 		CallDateTime <= @vEndDate	
		AND 		WebReportGroup.WebReportGroupMaster = 1

		GROUP BY	Call.CallID
		)


	GROUP BY Call.CallID, CallNumber, CallDateTime, SourceCodeName, OrganizationName
	ORDER BY SourceCodeName, OrganizationName, CallNumber




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

