IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertLogEventWeb')
	BEGIN
		PRINT 'Dropping Procedure InsertLogEventWeb'
		DROP  Procedure  InsertLogEventWeb
	END

GO

PRINT 'Creating Procedure InsertLogEventWeb'
GO 
CREATE Procedure InsertLogEventWeb
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
    @LogEventDeleted bit = 0,
    @TimeZone varchar(2)	  

AS

/******************************************************************************
**		File: InsertLogEventWeb.sql
**		Name: InsertLogEventWeb
**		Desc: inserts a record into the LogEvent table...special version for web to insert log date based on tz
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
**		Auth: jth
**		Date: 8/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    		8/08		jth
**          02/20/09    jth             fixed to not do the adjusting for the timezone
******************************************************************************/
-- adjust the time for the time zone
--SET @LogEventDateTime = DATEADD(hh,-dbo.fn_TimeZoneDifference(@TimeZone,@LogEventDateTime),@LogEventDateTime)	

SELECT
	@LogEventNumber = ISNULL(MAX(LogEventNumber) + 1, 1)  
FROM 
	Logevent 
WHERE 
	Callid = @CallID
	-- when LogEventID is null or 0 the insert shold be from production stattrac
	-- when LogEventID is < 0 it is a negative number and being used by datasets

IF (ISNULL(@LogEventID, 0) < 1) 
	
BEGIN
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
END
ELSE -- LogEventID is > 0 and should be in the archive database
BEGIN
	INSERT INTO 
		LogEvent (
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
		@LogEventID,
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
END

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


GO

 