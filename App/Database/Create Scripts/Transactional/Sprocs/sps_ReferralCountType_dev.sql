SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralCountType_dev]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralCountType_dev]
GO




CREATE PROCEDURE sps_ReferralCountType_dev  

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReferralTypeID 	int		= null,
	@vReportGroupID		int		= null,
	@vOrgID			int		= null
WITH RECOMPILE
AS

/********************************************************************************/
/*	Totals									*/
/********************************************************************************/

IF	@vOrgID = null OR @vOrgID = 0

	IF	@vReferralTypeID = null OR @vReferralTypeID = 0

                SELECT	Count(Call.CallID) AS  ReferralCount

                FROM		Call
                JOIN		Referral ON Referral.CallID = Call.CallID
                JOIN		AlertOrganization ON AlertOrganization.OrganizationID = Referral.ReferralCallerOrganizationID
                JOIN		Alert ON Alert.AlertID = AlertOrganization.AlertID 
                JOIN		AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
                JOIN		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
                JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
                JOIN		ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
                JOIN	        WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID

		WHERE 	        CallDateTime BETWEEN @vStartDate 
		AND 		@vEndDate
                AND 		WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND		WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		

	ELSE

		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 		Referral
		JOIN		Call ON Call.CallID = Referral.CallID
		JOIN 		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	

		WHERE 	        CallDateTime BETWEEN @vStartDate 
		AND 		@vEndDate
		AND 		WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND		WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND		Referral.ReferralTypeID = @vReferralTypeID



ELSE
	IF	@vReferralTypeID = null OR @vReferralTypeID = 0

		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 		Referral
		JOIN		Call ON Call.CallID = Referral.CallID
		JOIN 		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	

		WHERE 	        WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND		WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND 		CallDateTime BETWEEN @vStartDate 
		AND 		@vEndDate
		AND		Referral.ReferralCallerOrganizationID = @vOrgID

	ELSE
		SELECT 	Count(Referral.CallID) AS  ReferralCount
		FROM 		Referral
		JOIN		Call ON Call.CallID = Referral.CallID
		JOIN 		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
		JOIN		WebReportGroupSourceCode ON WebReportGroupSourceCode.SourceCodeID = Call.SourceCodeID	

		WHERE 	        WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND		WebReportGroupSourceCode.WebReportGroupID = @vReportGroupID
		AND 		CallDateTime BETWEEN @vStartDate 
		AND 		@vEndDate
		AND		Referral.ReferralTypeID = @vReferralTypeID
		AND		Referral.ReferralCallerOrganizationID = @vOrgID














GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

