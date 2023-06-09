SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileReferralEvents2004LastMod]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileReferralEvents2004LastMod]
GO




CREATE PROCEDURE sps_StatFileReferralEvents2004LastMod

			@vUserName as varchar(20),
			@vPassword as varchar(20),
			@vwebReportGroupID as int,
			@vStartDateTime as datetime,
			@vEndDateTime as datetime,
			@vLastRecord as int = 0


 AS
/**	12/08/2009	ccarroll	Removed table alias in ORDER BY for SQL Server 2008 update **/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	declare
		@vOrgID as int,
		@vOrgTZ as varchar(20),
		@vOrgTZdiff as int,
		@vnumRec as int

--Get OrganizationID
SELECT 	@vOrgID = OrganizationID  
	
    		FROM 	WebPerson
    		JOIN 	Person ON Person.PersonID = WebPerson.PersonID

	    	WHERE 	WebPersonUserName = @vUserName
    		AND 	WebPersonPassword = @vPassword

--Get OrganizationTimeZone
SELECT @vOrgTZ = TimeZone.TimeZoneAbbreviation 
		from Organization 
		join TimeZone ON Organization.TimeZoneID = TimeZone.TimeZoneID
		where OrganizationID = @vOrgID
 --select @vOrgTZdiff = exec spf_TimeZone @vOrgTZ

SELECT @vOrgTZdiff = 
                    CASE @vOrgTZ
                    When 'AT' Then 3                    
                    When 'AS' Then 3                    
                    When 'ET' Then 2
                    When 'ES' Then 2
                    When 'CT' Then 1
                    When 'CS' Then 1
                    When 'MT' Then 0
                    When 'MS' Then 0
                    When 'PT' Then -1
                    When 'PS' Then -1
                    When 'KT' Then -2
                    When 'KS' Then -2
                    When 'HT' Then -3
                    When 'HS' Then -3
                    When 'ST' Then -4                                                              
                    When 'SS' Then -4                                                              
                    END

select @vnumRec = recordsreturned from StatFileOrgFrequency where OrgID = @vOrgID
set rowcount @vnumRec

/* FileReferralEvents2004 */ SELECT DISTINCT LogEventID, DATEADD(hour, @vOrgTZdiff, LogEvent.LastModified) as LastModified, LogEventID, ReferralID, CallNumber, LogEvent.LogEventTypeID, LogEventTypeName, DATEADD(hour, @vOrgTZdiff, LogEventDateTime) as LogEventDateTime, LogEvent.PersonID, LogEventName, LogEventPhone, LogEvent.OrganizationID, LogEventOrg, REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN FaxQueueTo WHEN 19 THEN FaxQueueTo ELSE NULL END, DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, LogEventContactConfirmed AS ReferralEventContactConfirm, ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFaxNo WHEN 19 THEN FaxQueueFaxNo ELSE NULL END, ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFormName WHEN 19 THEN FaxQueueFormName ELSE NULL END FROM LogEvent JOIN Call ON Call.CallID = LogEvent.CallID LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Referral ON Referral.CallID = LogEvent.CallID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN FaxQueue ON FaxQueue.FaxQueueCallId = LogEvent.CallId AND FaxQueue.FaxQueueById = LogEvent.StatEmployeeID 
WHERE LogEvent.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND LogEvent.LogEventDateTime NOT BETWEEN @vStartDateTime  AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID 
ORDER BY LastModified



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

