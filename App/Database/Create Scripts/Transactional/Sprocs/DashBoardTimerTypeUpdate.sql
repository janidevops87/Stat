

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardTimerTypeUpdate')
	BEGIN
		PRINT 'Dropping Procedure DashBoardTimerTypeUpdate'
		DROP Procedure DashBoardTimerTypeUpdate
	END
GO

PRINT 'Creating Procedure DashBoardTimerTypeUpdate'
GO
CREATE Procedure DashBoardTimerTypeUpdate
(
		@DashBoardTimerTypeId int = null,
		@DashBoardTimerType nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardTimerTypeUpdate.sql
**	Name: DashBoardTimerTypeUpdate
**	Desc: Updates DashBoardTimerType Based on Id field 
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
	dbo.DashBoardTimerType 	
SET 
		DashBoardTimerType = @DashBoardTimerType,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	DashBoardTimerTypeId = @DashBoardTimerTypeId 				

GO

GRANT EXEC ON DashBoardTimerTypeUpdate TO PUBLIC
GO
