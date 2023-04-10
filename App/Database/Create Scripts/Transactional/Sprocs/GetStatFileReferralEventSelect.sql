  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileReferralEventSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileReferralEventSelect];
	PRINT 'Dropping Procedure: GetStatFileReferralEventSelect';
END
	PRINT 'Creating Procedure: GetStatFileReferralEventSelect'
GO

CREATE PROCEDURE [dbo].[GetStatFileReferralEventSelect]
(
	@ExportFileID int = NULL,
	@OrganizationID int = NULL,
	@sortOrder int = 1
)
/******************************************************************************
**		File: GetStatFileReferralEventSelect.sql
**		Name: GetStatFileReferralEventSelect
**		Desc:  Used on StatFile
**
**		Called by:  
**              
**
**		Auth: Bret Knoll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/01/2009	Bret Knoll	initial
*******************************************************************************/
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT  
	Convert(varchar(25), dbo.fn_StatFile_ConvertDateTime(@OrganizationID, LogEvent.LastModified), 120) as LastModified
	, LogEventID
	, ReferralID
	, CallNumber
	, LogEvent.LogEventTypeID
	, LogEventTypeName
	, Convert(varchar(25), dbo.fn_StatFile_ConvertDateTime(@OrganizationID, LogEventDateTime), 120) as LogEventDateTime
	, LogEvent.PersonID
	, LogEventName
	, LogEventPhone
	, LogEvent.OrganizationID
	, LogEventOrg
	, REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc'
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
JOIN Call ON Call.CallID = LogEvent.CallID 
LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
LEFT JOIN (
			SELECT DISTINCT CallId, DocumentSentById, FaxNumber, FormName, DocumentTo 
			FROM DocumentRequestQueue 
		) FaxQ ON FaxQ.CallId = LogEvent.CallId AND FaxQ.DocumentSentById = LogEvent.StatEmployeeID AND  LogEvent.LogEventTypeID in (18, 19)
JOIN Referral ON Referral.CallID = LogEvent.CallID 
WHERE 
	LogEvent.LogEventID IN ( -- note LogEventID is placed in the CallID field
							SELECT CallID 'LogEventID' FROM ExportFileQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0)
							UNION
							SELECT LogEventID FROM LogEvent WHERE CallID IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 0)
							)
AND 
	 NOT EXISTS (SELECT le.LogEventID FROM LogEvent le WHERE le.CallID IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 1) AND LogEvent.LogEventID = le.LogEventId)
	
AND LogEventDeleted = 0 
ORDER BY CASE WHEN @sortOrder = 1 THEN LogEvent.LogEventDateTime ELSE LogEvent.LastModified END;

GO

