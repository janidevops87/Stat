SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralActivityByAlertGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralActivityByAlertGroup]
GO




CREATE PROCEDURE sps_ReferralActivityByAlertGroup

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReportGroupID	int		= null
--with 	Recompile
AS

	SELECT	Alert.AlertID, AlertGroupName, 

			CASE
			WHEN Referral.ReferralTypeID = 1 THEN "O/T/E"
			WHEN Referral.ReferralTypeID = 2 THEN "T/E"
			WHEN Referral.ReferralTypeID = 3 THEN "E Only"
			WHEN Referral.ReferralTypeID = 4 THEN "RO"
			END AS ReferralTypeName,

			Call.CallID,  CallNumber, 
			DATEADD(hour, 0, CallDateTime) AS CallDateTime,
			Organization.OrganizationName, Referral.ReferralDonorName,
			ReferralDonorGender AS ReferralSex, ReferralDonorAge + ' ' + ReferralDonorAgeUnit AS ReferralAge

	FROM		Call
	JOIN		Referral ON Referral.CallID = Call.CallID
	JOIN		AlertOrganization ON AlertOrganization.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		Alert ON Alert.AlertID = AlertOrganization.AlertID 
	JOIN		AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
	JOIN		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID

	WHERE 	CallDateTime >= @vStartDate
	AND 		CallDateTime <= @vEndDate
	AND		WebReportGroupID = @vReportGroupID
	AND		Call.SourceCodeID = AlertSourceCode.SourceCodeID
	AND		Call.StatemployeeID <> 888	

	ORDER BY 	AlertGroupName, ReferralType.ReferralTypeID, CallDateTime
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

