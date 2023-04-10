  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetStatFileMessageEventSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetStatFileMessageEventSelect]
	PRINT 'Dropping Procedure: GetStatFileMessageEventSelect'
END
	PRINT 'Creating Procedure: GetStatFileMessageEventSelect'
GO

CREATE PROCEDURE [dbo].[GetStatFileMessageEventSelect]
(
	@ExportFileID int = NULL,
	@OrganizationID int = NULL,
	@sortOrder int = 1
)
/******************************************************************************
**		File: GetStatFileMessageEventSelect.sql
**		Name: GetStatFileMessageEventSelect
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
	, MessageID
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
	, ReferralEventAttnTo = '' -- filler: referral event information not for message
	, null AS ReferralEventCalloutMin -- filler: referral event information not for message
	, null AS ReferralEventCalloutAfter -- filler: referral event information not for message
	, null AS ReferralEventContactConfirm -- filler: referral event information not for message
	, null AS ReferralEventFaxNbr -- filler: referral event information not for message
	, null AS ReferralEventDocName -- filler: referral event information not for message
FROM 
	LogEvent 
JOIN Call ON Call.CallID = LogEvent.CallID 
LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
JOIN Message ON Message.CallID = LogEvent.CallID 
WHERE 
	LogEvent.LogEventID IN ( -- note LogEventID is placed in the CallID field
							SELECT CallID 'LogEventID' FROM ExportFileQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0)
							UNION
							SELECT LogEventID FROM LogEvent WHERE CallID IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 0)
							)
AND 
	LogEvent.LogEventID NOT IN (SELECT LogEventID FROM LogEvent WHERE CallID IN (SELECT CallID FROM CloseCaseQueue WHERE ExportFileID = ISNULL(@ExportFileID, 0) AND Enabled = 1))

AND LogEventDeleted = 0 
ORDER BY CASE WHEN @sortOrder = 1 THEN LogEvent.LogEventDateTime ELSE LogEvent.LastModified END

GO

