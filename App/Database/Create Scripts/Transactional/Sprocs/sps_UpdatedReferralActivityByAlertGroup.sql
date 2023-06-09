SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_UpdatedReferralActivityByAlertGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_UpdatedReferralActivityByAlertGroup]
GO




-- sp_helptext sps_ReferralActivityByAlertGroup
-- sps_ReferralActivityByAlertGroup '4/6/00 06:00', '4/7/00', 37

-- sps_UpdatedReferralActivityByAlertGroup '4/6/00 06:00', '4/7/00', 37


CREATE PROCEDURE sps_UpdatedReferralActivityByAlertGroup

	@vStartDate		datetime	= null,
	@vEndDate		datetime	= null,
	@vReportGroupID	int		= null
AS

             SELECT DISTINCT 
                        Alert.AlertID, AlertGroupName, 

			CASE
			WHEN Referral.ReferralTypeID = 1 THEN "O/T/E"
			WHEN Referral.ReferralTypeID = 2 THEN "T/E"
			WHEN Referral.ReferralTypeID = 3 THEN "E Only"
			WHEN Referral.ReferralTypeID = 4 THEN "RO"
			END AS ReferralTypeName,
                        ReferralTypeID, 
			Call.CallID,  CallNumber, 
			--DATEADD(hour, 0, CallDateTime) AS CallDateTime,
			CallDateTime,
			Organization.OrganizationName, Referral.ReferralDonorName,
			ReferralDonorGender AS ReferralSex, ReferralDonorAge + ' ' + ReferralDonorAgeUnit AS ReferralAge,
			(Select Count(LogEventID) from LogEvent where LogEvent.CallID = Call.CallID) AS LogCount
	FROM		Call
	JOIN		Referral ON Referral.CallID = Call.CallID
	JOIN		AlertOrganization ON AlertOrganization.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		Alert ON Alert.AlertID = AlertOrganization.AlertID 
	JOIN		AlertSourceCode ON AlertSourceCode.AlertID = Alert.AlertID
	JOIN		WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = Referral.ReferralCallerOrganizationID
	JOIN		Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID
	--JOIN	        ReferralType ON ReferralType.ReferralTypeID = Referral.ReferralTypeID
	LEFT JOIN       LogEvent ON LogEvent.CAllID = Call.CallID 
	WHERE 	        
                        LogEvent.StatEmployeeID <> '77'
        AND		LogEvent.LogEventDateTime between @vStartDate  AND  @vEndDate
        AND	        (
                        --LogEvent.LogEventTypeID = 2                        AND 
                        (Select Count(LogEventID) from LogEvent where LogEvent.CallID = Call.CallID AND LogEvent.LogEventTypeID = 2) > 1 --Incoming Call
	OR		LogEvent.LogEventTypeID = 7 -- Consent OutCome
	OR		LogEvent.LogEventTypeID = 8 -- Recovery OutCome
                        )
	
	AND		WebReportGroupID = @vReportGroupID
	AND		Call.SourceCodeID = AlertSourceCode.SourceCodeID

			
	ORDER BY 	AlertGroupName, Referral.ReferralTypeID, CallDateTime


-- select * from LogEvent WHERE CallID = 1131878 LogEventName like '%line%' order by LogEventID desc 
-- select * from LogEventType
-- select * from StatEmployee where StatEmployeeID = 77























GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

