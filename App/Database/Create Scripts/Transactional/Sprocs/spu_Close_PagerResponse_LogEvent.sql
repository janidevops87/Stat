SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_Close_PagerResponse_LogEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_Close_PagerResponse_LogEvent]
GO

CREATE PROCEDURE spu_Close_PagerResponse_LogEvent
				@CallId INT = -1,
				@LogEventTypeId INT = -1,
				@LogEventNumber INT = -1, -- NOTE: this is the LogEventCode and not the LogEventNumber
				@UpdatedRows int = 0 OUTPUT
				

AS
/******************************************************************************
**		File: spu_Close_PagerResponse_LogEvent.sql
**		Name: spu_Close_PagerResponse_LogEvent
**		Description: Updates LogEvent table for records having                          
**                     LogEventTypeId of 6 -  Pager(Auto Response) or                
**                     21 - Email Pending and Inserts a new LogEvent record       
**                     showing that this change was recorded.    **
**              
**		Return values: Count of records updated. 
** 
**		Called by:   
**			AutomatedPageResponse.clsLogEvent.CloseLogEvent
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		see list.
**
**		Auth: Scott Plummer
**		Date: 12/16/04 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/16/04	Scott Plummer		Release 7.7.2 Task 340
**		07/16/07	Bret Knoll			8.4.3.9 Log Event Number
**										Replace insert and updates with calls to
**										InserLogEvent and UpdateLogEvent
*******************************************************************************/

DECLARE 
	@ResponseEventTypeId INT, 
	@@UPDATEROWs INT, 
	@EventDesc VARCHAR(100),
	@LogEventID INT,
    @LogEventName varchar(50), 
    @LogEventPhone varchar(100), 
    @LogEventOrg varchar(80), 
    @ScheduleGroupID int , 
    @PersonID int , 
    @OrganizationID int ,
    @LogEventDateTime DATETIME
	

-- Set appropriate Response Event Types according to original pager event type
IF @LogEventTypeId = 6    -- Pager(Auto Response)
     BEGIN
	SET @ResponseEventTypeId = 9  -- Page Response
	SET @EventDesc = 'AUTOMATED PAGER RESPONSE'
     END

ELSE IF @LogEventTypeId = 21   -- Email Pending
     BEGIN
	SET @ResponseEventTypeId = 22   -- Email Response
	SET @EventDesc = 'EMAIL RESPONSE'
     END

-- Set the LogEventID so that the event can be udpated
SELECT 
	@LogEventID = LogEventID
FROM
	AutoResponseCode
WHERE
	CallID = @CallID
AND
	AutoResponseCode = 	@LogEventNumber	
-- Update LogEvent matching CallId, LogEventTypeId and LogEventNumber with callback pending
-- Changed to maintain original LogEventTypeId (... Pending) instead of (... Response).  12/21/04 - SAP


EXEC UpdateLogEventClose
	@LogEventCallbackPending = 0, -- 0 clear the CallBackPending
	@LogEventID = @LogEventID,
	@LastStatEmployeeID = 375 -- Pager	AutoResponse
SELECT @@UPDATEROWs = @@ROWCOUNT;

-- Insert a new LogEvent showing action taken by PgrRspns.EXE.
-- Only do this if an event was closed in the stmt above, otherwise if an email is responded to
-- multiple times, there will be multiple response events.  12/22/04 - SAP
-- set event values regardless of sucess or failure these values stay the same.
	SELECT 		
		@OrganizationID = LE.OrganizationID, 
		@ScheduleGroupID = LE.ScheduleGroupID, 
		@PersonID = LE.PersonID,
	    @LogEventName = LE.LogEventName, 
	    @LogEventPhone = LE.LogEventPhone , 
		@LogEventOrg = LE.LogEventOrg,
		@LogEventDateTime = GetDate()
		
	FROM LogEvent LE
	WHERE LE.LogEventID = @LogEventID
	AND   LE.CallID = @CallID	

IF @@UPDATEROWs > 0 
   BEGIN

	EXEC 
		InsertLogEvent
		@CallID = @CallID,
		@LogEventTypeID = @ResponseEventTypeId,
		@LogEventName = @LogEventName,
		@LogEventPhone = @LogEventPhone,
		@LogEventOrg = @LogEventOrg,
		@LogEventDesc = @EventDesc,
		@StatEmployeeID = 375, -- Pager	AutoResponse
		@LogEventDateTime = @LogEventDateTime,
		@LogEventCallbackPending = 0,
		@OrganizationID = @OrganizationID,
		@ScheduleGroupID = @ScheduleGroupID,
		@PersonID = @PersonID, 		
		@PhoneID = 0,
		@LogEventContactConfirmed = 1,
		@LogEventCalloutDateTime = NULL,
		@LastStatEmployeeID = 375 -- Pager	AutoResponse
	
   END

-- In the case of emails with a legitimate subject string which were returned, but didn't clear
-- add a new LogEvent of type Unmatched Response (23).  Added 5/3/05 - SAP
ELSE IF @@UPDATEROWs = 0 
   BEGIN
	
	SELECT
		@EventDesc =   'LogEvent: ' + Cast(@LogEventNumber AS Varchar) + '|*|' + Cast(@CallId AS Varchar) + '|' + Cast(@LogEventTypeId AS Varchar) + '|' 
	print @LogEventDateTime
	
		SET @LogEventDateTime = ISNULL(@LogEventDateTime, GetDate()) -- 9/27/07 bret 
	EXEC 	
		InsertLogEvent
		@CallID = @CallID,
		@LogEventTypeID = 23,-- Unmatched Response
		@LogEventName = @LogEventName,
		@LogEventPhone = @LogEventPhone,
		@LogEventOrg = @LogEventOrg,
		@LogEventDesc = @EventDesc,
		@StatEmployeeID = 375, -- Pager	AutoResponse
		@LogEventDateTime = @LogEventDateTime,
		@LogEventCallbackPending = 0,
		@OrganizationID = @OrganizationID,
		@ScheduleGroupID = @ScheduleGroupID,
		@PersonID = @PersonID, 		
		@PhoneID = 0,
		@LogEventContactConfirmed = 1,
		@LogEventCalloutDateTime = NULL,
		@LastStatEmployeeID = 375 -- Pager	AutoResponse   
   
   END

SET @UpdatedRows = @@UPDATEROWs
RETURN @@UPDATEROWs;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

