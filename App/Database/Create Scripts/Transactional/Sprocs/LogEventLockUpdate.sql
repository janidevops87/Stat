 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'LogEventLockUpdate')
	BEGIN
		PRINT 'Dropping Procedure LogEventLockUpdate'
		DROP Procedure LogEventLockUpdate
	END
GO

PRINT 'Creating Procedure LogEventLockUpdate'
GO
CREATE Procedure LogEventLockUpdate
(
		@CallID int = null output,
		@OrganizationID int = null,
		@LogEventOrg varchar(80) = null,
		@LogEventID int = null,
		@StatEmployeeID int = null,
		@LastModified datetime = null					
)
AS
/******************************************************************************
**	File: LogEventLockUpdate.sql
**	Name: LogEventLockUpdate
**	Desc: Updates LogEventLock Based on Id field 
**	Auth: jim h
**	Date: 9/29/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/29/2010		jim h					Initial Sproc Creation
*******************************************************************************/

UPDATE
	dbo.LogEventLock 	
SET 
		CallID = @CallID,
		OrganizationID = @OrganizationID,
		LogEventOrg = @LogEventOrg,
		LogEventID = @LogEventID,
		StatEmployeeID = @StatEmployeeID,
		LastModified = GetDate()
WHERE 
	LogEventLock.LogEventOrg = ISNULL(@LogEventOrg, LogEventLock.LogEventOrg)				

GO

GRANT EXEC ON LogEventLockUpdate TO PUBLIC
GO
