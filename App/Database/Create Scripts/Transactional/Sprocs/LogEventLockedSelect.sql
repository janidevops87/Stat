 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'LogEventLockedSelect')
	BEGIN
		PRINT 'Dropping Procedure LogEventLockedSelect'
		DROP Procedure LogEventLockedSelect
	END
GO

PRINT 'Creating Procedure LogEventLockedSelect'
GO
CREATE Procedure LogEventLockedSelect
(
		@LogEventID int = null				
)
AS
/******************************************************************************
**	File: LogEventLockedSelect.sql
**	Name: LogEventLockedSelect
**	Desc: Check to see if logevent is locked in a pop up
**	Auth: jim h
**	Date: 4/2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	4/2011			jim h					Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT
		LogEventLock.CallID,
		LogEventLock.OrganizationID,
		LogEventLock.LogEventOrg,
		LogEventLock.LogEventID,
		LogEventLock.StatEmployeeID,
		LogEventLock.LastModified
	FROM 
		dbo.LogEventLock 
	
	WHERE 
		LogEventLock.LogEventID = ISNULL(@LogEventID, LogEventLock.LogEventID)	
GO

GRANT EXEC ON LogEventLockedSelect TO PUBLIC
GO
 