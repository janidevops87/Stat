SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFile_GetData_ReferralEvents2004]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFile_GetData_ReferralEvents2004]
GO


CREATE PROCEDURE sps_StatFile_GetData_ReferralEvents2004
(
	@vOrgID as int,
	@vWebReportGroupID as int,
	@vStartDateTime as datetime,
	@vEndDateTime as datetime,
	@vintIncludeNew bit,
	@vintIncludeModified bit,
	@vLastRecord as int = 0
)

AS

DECLARE @vnumRec as int


SELECT top 1 @vnumRec = recordsreturned FROM StatFileOrgFrequency WHERE OrgID = @vOrgID
SET rowcount @vnumRec

IF (@vintIncludeNew = 1) AND (@vintIncludeModified = 1)
	SELECT DISTINCT LogEventID,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified),120) as LastModified, LogEventID, ReferralID, CallNumber, LogEvent.LogEventTypeID, LogEventTypeName, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEventDateTime),120) as LogEventDateTime, LogEvent.PersonID, LogEventName, LogEventPhone, LogEvent.OrganizationID, LogEventOrg, REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN FaxQueueTo WHEN 19 THEN FaxQueueTo ELSE NULL END, DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, LogEventContactConfirmed AS ReferralEventContactConfirm, ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFaxNo WHEN 19 THEN FaxQueueFaxNo ELSE NULL END, ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFormName WHEN 19 THEN FaxQueueFormName ELSE NULL END FROM LogEvent JOIN Call ON Call.CallID = LogEvent.CallID LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Referral ON Referral.CallID = LogEvent.CallID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN FaxQueue ON FaxQueue.FaxQueueCallId = LogEvent.CallId AND FaxQueue.FaxQueueById = LogEvent.StatEmployeeID 
	WHERE LogEvent.LogEventDateTime BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID =@vWebReportGroupID  AND LogEventID > @vLastRecord 
	
	UNION
	
	SELECT DISTINCT LogEventID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified) ,120)as LastModified, LogEventID, ReferralID, CallNumber, LogEvent.LogEventTypeID, LogEventTypeName, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEventDateTime),120) as LogEventDateTime, LogEvent.PersonID, LogEventName, LogEventPhone, LogEvent.OrganizationID, LogEventOrg, REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN FaxQueueTo WHEN 19 THEN FaxQueueTo ELSE NULL END, DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, LogEventContactConfirmed AS ReferralEventContactConfirm, ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFaxNo WHEN 19 THEN FaxQueueFaxNo ELSE NULL END, ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFormName WHEN 19 THEN FaxQueueFormName ELSE NULL END FROM LogEvent JOIN Call ON Call.CallID = LogEvent.CallID LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Referral ON Referral.CallID = LogEvent.CallID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN FaxQueue ON FaxQueue.FaxQueueCallId = LogEvent.CallId AND FaxQueue.FaxQueueById = LogEvent.StatEmployeeID 
	WHERE LogEvent.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND LogEvent.LogEventDateTime NOT BETWEEN @vStartDateTime  AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  AND LogEventID > @vLastRecord 
	ORDER BY LogEventID
ELSE IF (@vintIncludeNew = 1)
	SELECT DISTINCT LogEventID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified),120) as LastModified, LogEventID, ReferralID, CallNumber, LogEvent.LogEventTypeID, LogEventTypeName, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEventDateTime),120) as LogEventDateTime, LogEvent.PersonID, LogEventName, LogEventPhone, LogEvent.OrganizationID, LogEventOrg, REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN FaxQueueTo WHEN 19 THEN FaxQueueTo ELSE NULL END, DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, LogEventContactConfirmed AS ReferralEventContactConfirm, ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFaxNo WHEN 19 THEN FaxQueueFaxNo ELSE NULL END, ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFormName WHEN 19 THEN FaxQueueFormName ELSE NULL END FROM LogEvent JOIN Call ON Call.CallID = LogEvent.CallID LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Referral ON Referral.CallID = LogEvent.CallID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN FaxQueue ON FaxQueue.FaxQueueCallId = LogEvent.CallId AND FaxQueue.FaxQueueById = LogEvent.StatEmployeeID 
	WHERE LogEvent.LogEventDateTime BETWEEN @vStartDateTime AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID =@vWebReportGroupID  AND LogEventID > @vLastRecord 
	ORDER BY LogEventID
ELSE IF (@vintIncludeModified = 1)
	SELECT DISTINCT LogEventID, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified),120) as LastModified, LogEventID, ReferralID, CallNumber, LogEvent.LogEventTypeID, LogEventTypeName, Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEventDateTime),120) as LogEventDateTime, LogEvent.PersonID, LogEventName, LogEventPhone, LogEvent.OrganizationID, LogEventOrg, REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN FaxQueueTo WHEN 19 THEN FaxQueueTo ELSE NULL END, DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, LogEventContactConfirmed AS ReferralEventContactConfirm, ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFaxNo WHEN 19 THEN FaxQueueFaxNo ELSE NULL END, ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxQueueFormName WHEN 19 THEN FaxQueueFormName ELSE NULL END FROM LogEvent JOIN Call ON Call.CallID = LogEvent.CallID LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID JOIN Referral ON Referral.CallID = LogEvent.CallID JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID LEFT JOIN FaxQueue ON FaxQueue.FaxQueueCallId = LogEvent.CallId AND FaxQueue.FaxQueueById = LogEvent.StatEmployeeID 
	WHERE LogEvent.LastModified BETWEEN @vStartDateTime AND @vEndDateTime AND LogEvent.LogEventDateTime NOT BETWEEN @vStartDateTime  AND @vEndDateTime AND WebReportGroupOrg.WebReportGroupID = @vwebReportGroupID  AND LogEventID > @vLastRecord 
	ORDER BY LogEventID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

