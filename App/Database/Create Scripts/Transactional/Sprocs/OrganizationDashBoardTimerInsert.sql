

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDashBoardTimerInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDashBoardTimerInsert'
		DROP Procedure OrganizationDashBoardTimerInsert
	END
GO

PRINT 'Creating Procedure OrganizationDashBoardTimerInsert'
GO
CREATE Procedure OrganizationDashBoardTimerInsert
(
		@OrganizationDashBoardTimerId int = null output,
		@OrganizationId int = null,
		@Organization varchar(80) = null,
		@DashBoardWindowId int = null,
		@DashBoardWindow varchar(100) = null,
		@DashBoardTimerTypeId int = null,
		@DashBoardTimerType varchar(100) = null,
		@ExpirationMinutes int = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null							
)
AS
/******************************************************************************
**	File: OrganizationDashBoardTimerInsert.sql
**	Name: OrganizationDashBoardTimerInsert
**	Desc: Inserts OrganizationDashBoardTimer Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
INSERT	OrganizationDashBoardTimer
	(
		OrganizationId,
		DashBoardWindowId,
		DashBoardTimerTypeId,
		ExpirationMinutes,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@DashBoardWindowId,
		@DashBoardTimerTypeId,
		@ExpirationMinutes,
		GetDate(),
		@LastStatEmployeeId,
		1
	)


SET @OrganizationDashBoardTimerID = SCOPE_IDENTITY()

EXEC OrganizationDashBoardTimerSelect @OrganizationDashBoardTimerID

GO

GRANT EXEC ON OrganizationDashBoardTimerInsert TO PUBLIC
GO
