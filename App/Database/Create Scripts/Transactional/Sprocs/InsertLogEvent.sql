IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertLogEvent')
	BEGIN
		PRINT 'Dropping Procedure InsertLogEvent'
		DROP  Procedure  InsertLogEvent
	END

GO

PRINT 'Creating Procedure InsertLogEvent'
GO
CREATE Procedure InsertLogEvent
    @LogEventID int = NULL , 
    @CallID int, 
    @LogEventTypeID int = NULL , 
    @LogEventDateTime smalldatetime = NULL , 
    @LogEventNumber int = NULL , 
    @LogEventName varchar(50) = NULL , 
    @LogEventPhone varchar(100) = NULL , 
    @LogEventOrg varchar(80) = NULL , 
    @LogEventDesc varchar(1000) = NULL , 
    @StatEmployeeID int = NULL , 
    @LogEventCallbackPending smallint = NULL , 
    @ScheduleGroupID int = NULL , 
    @PersonID int = NULL , 
    @OrganizationID int = NULL , 
    @PhoneID int = NULL , 
    @LogEventContactConfirmed smallint = NULL , 
    @LogEventCalloutDateTime smalldatetime = NULL , 
    @LastStatEmployeeID int , 
    @AuditLogTypeID int = NULL , 
    @LogEventDeleted bit = 0  

AS

/******************************************************************************
**		File: 
**		Name: InsertLogEvent
**		Desc: inserts a record into the LogEvent table
**
**              
**		Return values: returns the update LogEvent record
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List.
**
**		Auth: Bret Knoll
**		Date: 4/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    4/13/07			Bret Knoll				initial
**	  05/30/07			Bret Knoll				8.4.3.8 audit LogEvent
**												Set LastModified Date
**												add LastStatEmployeeID
**												add AuditLogTypeID	
**												8.4.3.9 Number LogEvents	
**												add LogEventOrderNumber
**												add LogEventDeleted
**    4/11			jth							added code to add to locked events that are popped up
**    6/11          jth                         use statemployeeid of person already opened popup event
******************************************************************************/
SELECT
	@LogEventNumber = ISNULL(MAX(LogEventNumber) + 1, 1)  
FROM 
	Logevent 
WHERE 
	Callid = @CallID
	-- when LogEventID is null or 0 the insert shold be from production stattrac
	-- when LogEventID is < 0 it is a negative number and being used by datasets

	INSERT INTO 
		LogEvent (
			CallID, 
			LogEventTypeID,
			LogEventName, 
			LogEventPhone, 
			LogEventOrg, 
			LogEventDesc, 
			StatEmployeeID, 
			LogEventDateTime, 
			LogEventCallbackPending,
			LastModified,
			OrganizationID, 
			ScheduleGroupID, 
			PersonID, 
			PhoneID, 
			LogEventContactConfirmed, 
			LogEventCalloutDateTime, 
			LogEventNumber,
			LastStatEmployeeID,
			AuditLogTypeID,		
			LogEventDeleted
			)
	VALUES 
		(
		@CallID, 
		@LogEventTypeID, 
		@LogEventName, 
		@LogEventPhone, 
		@LogEventOrg, 
		@LogEventDesc, 
		@StatEmployeeID, 
		@LogEventDateTime, 
		@LogEventCallbackPending,
		GetDate(), 
		@OrganizationID, 
		@ScheduleGroupID, 
		@PersonID, 
		@PhoneID, 
		@LogEventContactConfirmed, 
		@LogEventCalloutDateTime, 
		@LogEventNumber,
		@LastStatEmployeeID,
		1, -- @AuditLogTypeID 1 = Create
		@LogEventDeleted
		)
DECLARE    
    @LockedLogEventID int
set @LockedLogEventID = SCOPE_IDENTITY()
SELECT
		LogEventID,
		CallID, 
		LogEventTypeID,
		LogEventName, 
		LogEventPhone, 
		LogEventOrg, 
		LogEventDesc, 
		StatEmployeeID, 
		LogEventDateTime, 
		LogEventCallbackPending,
		OrganizationID, 
		ScheduleGroupID, 
		PersonID, 
		PhoneID, 
		LogEventContactConfirmed, 
		LogEventCalloutDateTime, 
		LogEventNumber,		
		LogEventDeleted
FROM
	LOGEVENT
WHERE
	LogEventID = SCOPE_IDENTITY()			
--GO
--this is the insert for pending events, in case one is added while the popup is open
DECLARE    
    @CountLocked int,
    @PopUpUserID int
select @CountLocked = count(*) from LogEventLock where logeventlock.logeventorg = @LogEventOrg
if (@LogEventTypeID = 6 or @LogEventTypeID =8 or @LogEventTypeID =21 or @LogEventTypeID = 40) and @CountLocked > 0
Begin
select Top 1 @PopUpUserID =  StatEmployeeID from LogEventLock where logeventlock.logeventorg = @LogEventOrg
	Exec LogEventLockInsert
		@CallID = @CallID,
		@OrganizationID = @OrganizationID,
		@LogEventOrg = @LogEventOrg,
		@LogEventID = @LockedLogEventID,
		@StatEmployeeID  = 	@PopUpUserID
end
GO

GRANT EXEC ON InsertLogEvent TO PUBLIC

GO
