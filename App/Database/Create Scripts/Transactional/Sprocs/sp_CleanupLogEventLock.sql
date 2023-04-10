IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'sp_CleanupLogEventLock')
	BEGIN
		PRINT 'Dropping Procedure sp_CleanupLogEventLock';
		DROP Procedure sp_CleanupLogEventLock;
	END
GO

PRINT 'Creating Procedure sp_CleanupLogEventLock';
GO
CREATE Procedure sp_CleanupLogEventLock
AS
/******************************************************************************
**	File: sp_CleanupLogEventLock.sql
**	Name: sp_CleanupLogEventLock
**	Desc: Removes old LogEventLock records, to prevent future issues. 
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

	delete logeventLock 
	from logeventLock 
	join CallRecycle on logeventlock.callid = CallRecycle.callid;
	
	delete
	-- select *
	from logeventLock 
	where LastModified < dateadd(hour, -1,  getdate());


GO
GRANT EXEC ON sp_CleanupLogEventLock TO PUBLIC;
GO