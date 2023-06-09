SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_PageResponse1]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_PageResponse1]
GO




/****** Object:  Stored Procedure dbo.sps_PageResponse1    Script Date: 2/24/99 1:12:45 AM ******/
CREATE PROCEDURE sps_PageResponse1
	@vProcOrgID	int		= null, -- Procurement OrganizationID
	@vStartDate	smalldatetime	= null,
	@vEndDate	smalldatetime	= null,
	@vResponseType	int		= null,	
	@vRefOrgID  	int		= 0,	-- Referring OrganizationID
	@vReportGroupID	int 		= null
AS
DECLARE
	@vHour	smallint,
	@vTZ		varchar(2)

	SELECT	@vTZ = TimeZone.TimeZoneAbbreviation
	FROM Organization 
	LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
	JOIN WebReportGroup ON WebReportGroup.OrgHierarchyParentID = Organization.OrganizationID
	WHERE 	WebReportGroupID = @vReportGroupID 

	EXEC spf_TZDif @vTZ, @vHour OUTPUT, @vStartDate
	
    	
    	If @vRefOrgID = 0
    	BEGIN
		SELECT 	LogEvent.CallID, 
		LogEventTypeID AS TypeID, 
		CONVERT(char(8), DATEADD(hour, @vHour, LogEventDateTime), 1) + " " +
		CONVERT(char(5), DATEADD(hour, @vHour, LogEventDateTime), 8) AS DateTime,
		PersonFirst + ' ' + PersonLast AS Person

		FROM 	LogEvent
		JOIN	Person ON Person.PersonID = LogEvent.PersonID
		JOIN	Call ON Call.CallID = LogEvent.CallID
		LEFT
		JOIN	Referral ON Referral.CallID = Call.CallID
		LEFT 
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID

		WHERE 	LogEvent.OrganizationID = @vProcOrgID
		AND 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID
		AND	(LogEventTypeID = 6
		OR	LogEventTypeID = 9
		OR	LogEventTypeID = 12)
		AND	LogEventDateTime >= @vStartDate AND LogEventDateTime <= @vEndDate
		AND	CallTypeID = @vResponseType	
		ORDER BY PersonFirst + ' ' + PersonLast, LogEvent.CallID, LogEventDateTime
	END
	
	ELSE
	BEGIN
	
	    	SELECT 	LogEvent.CallID, 
		LogEventTypeID AS TypeID, 
		CONVERT(char(8), DATEADD(hour, @vHour, LogEventDateTime), 1) + " " +
		CONVERT(char(5), DATEADD(hour, @vHour, LogEventDateTime), 8) AS DateTime,
		PersonFirst + ' ' + PersonLast AS Person
		
		FROM 	LogEvent
		JOIN	Person ON Person.PersonID = LogEvent.PersonID
		JOIN	Call ON Call.CallID = LogEvent.CallID
		LEFT
		JOIN	Referral ON Referral.CallID = Call.CallID
		LEFT 
		JOIN 	WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID

		WHERE 	LogEvent.OrganizationID = @vProcOrgID
		AND 	WebReportGroupOrg.WebReportGroupID = @vReportGroupID			
		AND	(LogEventTypeID = 6
		OR	LogEventTypeID = 9
		OR	LogEventTypeID = 12)
		AND	LogEventDateTime >= @vStartDate AND LogEventDateTime <= @vEndDate
		AND	CallTypeID = @vResponseType	
		AND  	Referral.ReferralCallerOrganizationID = @vRefOrgID

		ORDER BY PersonFirst + ' ' + PersonLast, LogEvent.CallID, LogEventDateTime
	END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

