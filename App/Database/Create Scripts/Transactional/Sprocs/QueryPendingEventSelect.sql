

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'QueryPendingEventSelect')
	BEGIN
		PRINT 'Dropping Procedure QueryPendingEventSelect';
		PRINT GetDate()
		DROP Procedure QueryPendingEventSelect;
	END
GO

PRINT 'Creating Procedure QueryPendingEventSelect';
GO
CREATE Procedure QueryPendingEventSelect
(
		@CallID int 
)
AS
/******************************************************************************
**	File: QueryPendingEventSelect.sql
**	Name: QueryPendingEventSelect
**	Desc: Selects pending events
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:						Description:
**	--------		--------					----------------------------------
**	10/22/2019		Pam Scheichenost			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON ;

	SELECT 
	LogEvent.LogEventID, 
	LogEventType.LogEventTypeName, 
	ISNULL(LogEvent.LogEventOrg,'') + ' - ' + ISNULL(LogEvent.LogEventName,'') 
FROM LogEvent 
JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
WHERE LogEvent.LogEventCallbackPending = -1 
AND LogEvent.CallID = @CallID
ORDER BY LogEvent.LogEventDateTime DESC;

GO

GRANT EXEC ON SelectLogEvent TO PUBLIC;
GO
