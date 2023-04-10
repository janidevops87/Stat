IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE   schema_name = 'Api' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Api'
END
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'IF' AND name = 'fn_GetEvents')
	BEGIN
		PRINT 'Dropping Function fn_GetEvents'
		DROP Function [Api].[fn_GetEvents]
	END
GO

PRINT 'Creating Function fn_GetEvents' 
GO 

CREATE FUNCTION [Api].[fn_GetEvents]
(
	@OrganizationID INT , @CallID INT
)
RETURNS TABLE
AS

		/******************************************************************************
		**	File: Api.[fn_GetEvents].sql 
		**	Name: [fn_GetEvents]
		**	Desc: Get Events by CallId
		**	Auth: Ilya Osipov
		**	Date: 9/15/2017
		*******************************************************************************/

RETURN(
SELECT  
	LogEvent.LastModified
	, LogEventID
	, ReferralID
	,  CallNumber = CASE
			CallNumber			
			WHEN '' THEN ' '
			ELSE CallNumber		
			END
	, LogEvent.LogEventTypeID
	, LogEventTypeName
	, LogEventDateTime
	, LogEvent.PersonID
	, LogEventName
	, LogEventPhone = CASE
			LogEventPhone			
			WHEN '' THEN ' '
			ELSE LogEventPhone		
			END
	, LogEvent.OrganizationID
	, LogEventOrg
	, LogEventDesc = CASE
			LogEventDesc			
			WHEN '' THEN ' '
			ELSE REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') 		
			END	
	, StatEmployeeFirstName + ' ' + StatEmployeeLastName AS LogEventCreatedBy 
	, ReferralEventAttnTo =
		CASE
			LogEvent.LogEventTypeID
			WHEN 18 THEN DocumentTo
			WHEN 19 THEN DocumentTo
			ELSE NULL
		END
	, DateDiff(n, LogEventDateTime, LogEventCalloutDateTime) AS ReferralEventCalloutMin
	, Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter
	, LogEventContactConfirmed AS ReferralEventContactConfirm
	, ReferralEventFaxNbr = 
		CASE 
			LogEvent.LogEventTypeId
			WHEN 18 THEN FaxNumber
			WHEN 19 THEN FaxNumber
			ELSE NULL
		END
	, ReferralEventDocName =
		CASE 
			LogEvent.LogEventTypeId 
			WHEN 18 THEN FormName
			WHEN 19 THEN FormName
			ELSE NULL
		END		

FROM 
	LogEvent 	
	JOIN
		Call ON Call.CallID = LogEvent.CallID 
LEFT JOIN LogEventType ON LogEvent.LogEventTypeID = LogEventType.LogEventTypeID
LEFT JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
LEFT JOIN (
			SELECT DISTINCT CallId, DocumentSentById, FaxNumber, FormName, DocumentTo 
			FROM DocumentRequestQueue 
		) FaxQ ON FaxQ.CallId = LogEvent.CallId AND FaxQ.DocumentSentById = LogEvent.StatEmployeeID AND  LogEvent.LogEventTypeID in (18, 19)
JOIN Referral ON Referral.CallID = LogEvent.CallID 
WHERE LogEventDeleted = 0 AND LogEvent.CallID = @CallID
);
GO