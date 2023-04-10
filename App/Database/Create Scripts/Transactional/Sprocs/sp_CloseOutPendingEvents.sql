IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_CloseOutPendingEvents')
	BEGIN
		PRINT 'Dropping Procedure sp_CloseOutPendingEvents';
		DROP Procedure sp_CloseOutPendingEvents;
	END
GO

PRINT 'Creating Procedure sp_CloseOutPendingEvents';
GO
CREATE Procedure sp_CloseOutPendingEvents
AS
/******************************************************************************
**	File: sp_CloseOutPendingEvents.sql
**	Name: sp_CloseOutPendingEvents
**	Desc: Close out pending events older than a month.
**	Auth: Bret Knoll
**	Date: 9/18/2019
**	Called By: SQL Job 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:			Description:
**	--------		--------		----------------------------------
**	9/18/2019		Bret Knoll		Initial Sproc Creation (9376)
*******************************************************************************/


---- Close out pending events older than a month.
update LogEvent
set 
	LogEventCallbackPending = 0, 
	LastModified = getdate(), 
	LastStatEmployeeID = 375
--select *
from LogEvent
where 
	LogEventCallbackPending = -1
and 
	LogEventDateTime < DATEADD(month, -1, GETDATE())

