 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'DeleteLogEvent')
	BEGIN
		PRINT 'Dropping Procedure DeleteLogEvent'
		DROP  Procedure  DeleteLogEvent
	END

GO

PRINT 'Creating Procedure DeleteLogEvent'
GO
CREATE Procedure DeleteLogEvent	 
	@LogEventID int = null,
	@CallID int ,
	@LastStatEmployeeID int 
AS

/******************************************************************************
**		File: 
**		Name:DeleteLogEvent
**		Desc: DeleteLogEvent a record into the LogEvent table
**
**              
**		
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List. 
**
**		Auth: Thien Ta
**		Date: 04/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**		04/13/07	Thien Ta				initial
**		05/30/07	Bret Knoll				8.4.3.8 audit LogEvent
**												Set LastModified Date
**												add LastStatEmployeeID
**												add AuditLogTypeID	
**												8.4.3.9 Number LogEvents	
**												add LogEventOrderNumber
**												add LogEventDeleted
*******************************************************************************/


UPDATE
	LogEvent
SET
	LogEventDesc = 'Event Type: '  
					+ LogEventTypeName
					+ ' ' + ISNULL(LogEventDesc, ''),	
	LogEventTypeID = 
					(
						SELECT
							LogEventTypeID
						FROM
							LogEventType
						WHERE
							LogEventTypeName = 'DELETED EVENT'	
					),	
	LastModified = GetDate(),
	LogEventCallbackPending = 0, -- not pending
	LogEventDeleted = 1, -- 1 = Yes = Deleted
	LastStatEmployeeID = @LastStatEmployeeID,
	AuditLogTypeID = 4 	-- 4 = Deleted	
FROM
	LogEvent 
JOIN
	LogEventType lt ON lt.LogEventTypeID = LogEvent.LogEventTypeID
WHERE
	LogEventID = ISNULL(@LogEventID, LogEventID)
AND 
	CallID = @CallID
	
	

/*
	Never Delete LogEvent Records. LogEvent Records are Flagged as Deleted.	
*/	
GO