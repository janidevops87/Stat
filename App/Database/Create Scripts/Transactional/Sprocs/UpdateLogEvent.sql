if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[UpdateLogEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print 'drop procedure [dbo].[UpdateLogEvent]'
	drop procedure [dbo].[UpdateLogEvent]
end	
GO
	print 'create procedure [dbo].[UpdateLogEvent]'
go
 
CREATE Procedure UpdateLogEvent
    @LogEventID int, 
    @CallID int = NULL , 
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
**		Name: UpdateLogEvent
**		Desc: Update a record into the LogEvent table
**
**              
**		Return values: returns the update LogEvent record
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**
**		Auth: Thien Ta
**		Date: 4/13/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**    4/13/07			Thien Ta				initial
**	  05/30/07			Bret Knoll				8.4.3.8 audit LogEvent
**												Set LastModified Date
**												add LastStatEmployeeID
**												add AuditLogTypeID	
**												8.4.3.9 Number LogEvents	
**												add LogEventDeleted
**	10/22/2008			ccarroll				audit trail: added @ to parameter LastStatEmployeeID
**												ref: @LastStatEmployeeID
*******************************************************************************/
Update 
	LogEvent  
SET	
	LogEventTypeID = ISNULL(@LogEventTypeID, LogEventTypeID), 
	LogEventDateTime = ISNULL(@LogEventDateTime, LogEventDateTime), 
	LogEventName = @LogEventName, 
	LogEventPhone = @LogEventPhone, 
	LogEventOrg = @LogEventOrg,
	LogEventDesc = @LogEventDesc, 
	StatEmployeeID = ISNULL(@StatEmployeeID, StatEmployeeID), 
	LogEventCallbackPending = ISNULL(@LogEventCallbackPending, LogEventCallbackPending), 
	LastModified = GetDate(), 
	ScheduleGroupID = ISNULL(@ScheduleGroupID, ScheduleGroupID), 
	PersonID = ISNULL(@PersonID, PersonID), 
	OrganizationID = ISNULL(@OrganizationID, OrganizationID), 
	PhoneID = ISNULL(@PhoneID, PhoneID), 
	LogEventContactConfirmed = ISNULL(@LogEventContactConfirmed, LogEventContactConfirmed), 
	LogEventCalloutDateTime = ISNULL(@LogEventCalloutDateTime, LogEventCalloutDateTime), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify	
	LogEventDeleted = ISNULL(@LogEventDeleted, LogEventDeleted) 
		
WHERE
	LogEventID = @LogEventID
	
	

GO
