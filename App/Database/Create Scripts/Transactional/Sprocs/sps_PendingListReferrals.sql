SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PendingListReferrals]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PendingListReferrals]
GO




/****** Object:  Stored Procedure dbo.sps_PendingListReferrals    Script Date: 2/24/99 1:12:45 AM ******/
/*  Remove after online update of incomplete referrals is implemented  */


CREATE PROCEDURE sps_PendingListReferrals

	@vTZ			varchar(2)	= null,
	@vUserOrgID		int		= null,
	@vReportGroupID	int		= null

AS

DECLARE

	@vHour		smallint

	EXEC spf_TZDif @vTZ, @vHour OUTPUT
	
IF @vReportGroupID = null

	SELECT 		LogEvent.LogEventID, LogEventTypeID, Call.CallID, Call.CallNumber, 
			CONVERT(char(8), DATEADD(hour, @vHour, CallDateTime), 1) AS CallDate,
			CONVERT(char(5), DATEADD(hour, @vHour, CallDateTime), 8) AS CallTime,
			Organization.OrganizationName, Referral.ReferralDonorName
        FROM 		LogEvent
        JOIN 		Referral ON LogEvent.CallID = Referral.CallID
        JOIN 		Call ON Referral.CallID = Call.CallID
        JOIN 		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
        WHERE 		LogEvent.LogEventCallbackPending = -1
        AND 		(LogEventTypeID = 4 OR LogEventTypeID = 5)
	AND 		LogEvent.OrganizationID = @vUserOrgID
        ORDER BY 	Call.CallDateTime, LogEventTypeID ASC

ELSE

	SELECT 		LogEvent.LogEventID, LogEventTypeID, Call.CallID, Call.CallNumber, 
			CONVERT(char(8), DATEADD(hour, @vHour, CallDateTime), 1) AS CallDate,
			CONVERT(char(5), DATEADD(hour, @vHour, CallDateTime), 8) AS CallTime,
			Organization.OrganizationName, Referral.ReferralDonorName
        FROM 		LogEvent
        JOIN 		Referral ON LogEvent.CallID = Referral.CallID
        JOIN 		Call ON Referral.CallID = Call.CallID
        JOIN 		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
        WHERE 		LogEvent.LogEventCallbackPending = -1
        AND 		(LogEventTypeID = 4 OR LogEventTypeID = 5)
	AND 		LogEvent.OrganizationID = @vUserOrgID
	AND		WebReportGroupOrg.WebReportGroupID = @vReportGroupID
        ORDER BY 	Call.CallDateTime, LogEventTypeID ASC




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

