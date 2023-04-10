

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDashBoardTimerUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDashBoardTimerUpdate'
		DROP Procedure OrganizationDashBoardTimerUpdate
	END
GO

PRINT 'Creating Procedure OrganizationDashBoardTimerUpdate'
GO
CREATE Procedure OrganizationDashBoardTimerUpdate
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
**	File: OrganizationDashBoardTimerUpdate.sql
**	Name: OrganizationDashBoardTimerUpdate
**	Desc: Updates OrganizationDashBoardTimer Based on Id field 
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
UPDATE
	dbo.OrganizationDashBoardTimer 	
SET 
		OrganizationId = @OrganizationId,
		DashBoardWindowId = @DashBoardWindowId,
		DashBoardTimerTypeId = @DashBoardTimerTypeId,
		ExpirationMinutes = @ExpirationMinutes,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = 3 /* modified */
WHERE 
	OrganizationDashBoardTimerId = @OrganizationDashBoardTimerId 			

GO

GRANT EXEC ON OrganizationDashBoardTimerUpdate TO PUBLIC
GO
