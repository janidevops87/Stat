 

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'LogEventLockInsert')
	BEGIN
		PRINT 'Dropping Procedure LogEventLockInsert'
		DROP Procedure LogEventLockInsert
	END
GO

PRINT 'Creating Procedure LogEventLockInsert'
GO
CREATE Procedure LogEventLockInsert
(
		@CallID int = null output,
		@OrganizationID int = null,
		@LogEventID int = null,
		@LogEventOrg varchar(80) = null,
		@StatEmployeeID int = null,
		@LastModified datetime = null					
)
AS
/******************************************************************************
**	File: LogEventLockInsert.sql
**	Name: LogEventLockInsert
**	Desc: Inserts LogEventLock Based on Id field 
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

INSERT	LogEventLock
	(	CallID,
		OrganizationID,
		LogEventOrg,
		LogEventID,
		StatEmployeeID,
		LastModified
	)
VALUES
	(
		@CallID,
		@OrganizationID,
		@LogEventOrg, 
		@LogEventID,
		@StatEmployeeID,
		GETDATE()
	)



