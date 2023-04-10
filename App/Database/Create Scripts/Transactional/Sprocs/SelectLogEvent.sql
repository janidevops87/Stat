

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectLogEvent')
	BEGIN
		PRINT 'Dropping Procedure SelectLogEvent'
		PRINT GetDate()
		DROP Procedure SelectLogEvent;
	END
GO

PRINT 'Creating Procedure SelectLogEvent'
GO
CREATE Procedure SelectLogEvent
(
		@LogEventID int = null output,
		@CallID int = null,
		@LogEventTypeID int = null,
		@ScheduleGroupID int = null,
		@LogEventContactConfirmed int = null,
		@LogEventCallbackPending int = null,
		@OrganizationID int = null
)
AS
/******************************************************************************
**	File: SelectLogEvent.sql
**	Name: SelectLogEvent
**	Desc: Selects multiple rows of LogEvent Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
**	09/18/2019		Mike Berenson		Optimized where clause for performance
**	10/2/2019		Mike Berenson		Added OrganizationID to the list of parameters
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 

	SELECT
		LogEvent.LogEventID,
		LogEvent.CallID,
		LogEvent.LogEventTypeID,
		LogEvent.LogEventDateTime,
		LogEvent.LogEventNumber,
		LogEvent.LogEventName,
		LogEvent.LogEventPhone,
		LogEvent.LogEventOrg,
		LogEvent.LogEventDesc,
		LogEvent.StatEmployeeID,
		LogEvent.LogEventCallbackPending,
		LogEvent.LastModified,
		LogEvent.ScheduleGroupID,
		LogEvent.PersonID,
		LogEvent.OrganizationID,
		LogEvent.PhoneID,
		LogEvent.LogEventContactConfirmed,
		LogEvent.UpdatedFlag,
		LogEvent.LogEventCalloutDateTime,
		LogEvent.LastStatEmployeeID,
		LogEvent.AuditLogTypeID,
		LogEvent.LogEventDeleted
	FROM 
		dbo.LogEvent 
	WHERE
		(
			LogEvent.CallID = @CallID
		)
	AND
		(
			@ScheduleGroupID IS NULL
			OR
			LogEvent.ScheduleGroupID = @ScheduleGroupID
		)

	AND
		(
			@LogEventTypeID IS NULL
			OR
			LogEvent.LogEventTypeID = @LogEventTypeID
		)
			
	AND
		(
			@LogEventID IS NULL
			OR
			LogEvent.LogEventID = @LogEventID
		)

	AND
		(
			@LogEventContactConfirmed IS NULL
			OR					 
			ABS(LogEvent.LogEventContactConfirmed) = @LogEventContactConfirmed
		)
	AND
		(
			@LogEventCallbackPending IS NULL
			OR
			ABS(logEvent.LogEventCallbackPending)= @LogEventCallbackPending
		)
	AND
		(
			@OrganizationID IS NULL
			OR
			LogEvent.OrganizationID = @OrganizationID
		);

GO

GRANT EXEC ON SelectLogEvent TO PUBLIC;
GO
