

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashboardRecycledOasisUpdate')
	BEGIN
		PRINT 'Dropping Procedure DashboardRecycledOasisUpdate'
		DROP Procedure DashboardRecycledOasisUpdate
	END
GO

PRINT 'Creating Procedure DashboardRecycledOasisUpdate'
GO
CREATE Procedure DashboardRecycledOasisUpdate
(
		@CallID int,
		@Inactive smallint = null,
		@LastStatEmployeeID int = null
)
AS
/******************************************************************************
**	File: DashboardRecycledOasisUpdate.sql
**	Name: DashboardRecycledOasisUpdate
**	Desc: Updates Call table for Oasis only changes call active
**	Auth: jth
**	Date: 12/13/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/13/2010		jth						Initial Sproc Creation
*******************************************************************************/

UPDATE
	Call	
SET 
		CallActive = @Inactive,
		LastModified = GetDate(),
		CallSaveLastByID = @LastStatEmployeeID,
		AuditLogTypeID = 3 /* 3 modified */
WHERE 
	CallID = @CallID 				

GO
