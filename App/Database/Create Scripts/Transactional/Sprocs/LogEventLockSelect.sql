 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'LogEventLockSelect')
	BEGIN
		PRINT 'Dropping Procedure LogEventLockSelect'
		DROP Procedure LogEventLockSelect
	END
GO

PRINT 'Creating Procedure LogEventLockSelect'
GO
CREATE Procedure LogEventLockSelect
(
		@LogEventOrg varchar(80) = null
)
AS
/******************************************************************************
**	File: LogEventLockSelect.sql
**	Name: LogEventLockSelect
**	Desc: Selects multiple rows of LogEventLock Based on Id  fields 
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
		LogEventLock.LogEventOrg = ISNULL(@LogEventOrg, LogEventLock.LogEventOrg)				
	ORDER BY 1
GO

GRANT EXEC ON LogEventLockSelect TO PUBLIC
GO
