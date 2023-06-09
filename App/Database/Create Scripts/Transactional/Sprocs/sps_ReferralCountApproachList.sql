SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCountApproachList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCountApproachList]
GO




CREATE PROCEDURE sps_ReferralCountApproachList

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReportGroupID	int		= null

AS


	SELECT 	Organization.OrganizationID, Organization.OrganizationName, 
			ReferralTypeID, Count(ReferralTypeID) AS ReferralTypeCount
			
      
	FROM 		Call
	JOIN 		Referral ON Referral.CallID = Call.CallID

	JOIN 		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	
	JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID

	WHERE 	CallDateTime >= @vStartDate
	AND 		CallDateTime <= @vEndDate
	AND		WebReportGroupOrg.WebReportGroupID = @vReportGroupID
	AND		WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID

	GROUP BY	Organization.OrganizationID, Organization.OrganizationName, ReferralTypeID

	ORDER BY	OrganizationName





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

