IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE   schema_name = 'Api' ) 
BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Api'
END
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetReferralEventsInJson')
	BEGIN
		PRINT 'Dropping Procedure GetReferralEventsInJson'
		DROP Procedure [Api].[GetReferralEventsInJson]
	END
GO

PRINT 'Creating Procedure GetReferralEventsInJson'
GO

CREATE PROCEDURE [Api].[GetReferralEventsInJson](@OrganizationID INT,  @CallID INT, @JSONOUTPUT NVARCHAR(MAX) OUTPUT)
AS
		/******************************************************************************
		**	File: Api.GetReferralEventsInJson.sql 
		**	Name: GetReferralEventsInJson
		**	Desc: Set Referral events in Json
		**	Auth: Ilya Osipov
		**	Date: 9/15/2017
		*******************************************************************************/	
		BEGIN
PRINT 'Referral has been created'

--- get Event log

DECLARE @XML_EventLog VARCHAR(MAX), @EventLog_JSON VARCHAR(MAX)

 SET @XML_EventLog = CAST( (
 SELECT  LastModified
	, LogEventID
	, ReferralID
	, CallNumber
	, LogEventTypeID
	, LogEventTypeName
	, LogEventDateTime
	, PersonID
	, LogEventName
	, LogEventPhone
	, OrganizationID
	, LogEventOrg
	, LogEventDesc
	, LogEventCreatedBy 
	, ReferralEventAttnTo
	, ReferralEventCalloutMin
	, ReferralEventCalloutAfter
	, ReferralEventContactConfirm
	, ReferralEventFaxNbr
	, ReferralEventDocName	 FROM [Api].[fn_GetEvents] (@OrganizationID, @CallID) ORDER BY LastModified

 FOR XML RAW,TYPE,ELEMENTS, ROOT('referralevents')   )AS NVARCHAR(MAX));

EXEC [Api].[SerializeReferralEventToJSON] @XML_EventLog, @JSONOUTPUT = @EventLog_JSON OUTPUT;

SELECT @JSONOUTPUT = @EventLog_JSON;

END;
