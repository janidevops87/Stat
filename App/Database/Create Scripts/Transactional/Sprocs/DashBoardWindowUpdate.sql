

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardWindowUpdate')
	BEGIN
		PRINT 'Dropping Procedure DashBoardWindowUpdate'
		DROP Procedure DashBoardWindowUpdate
	END
GO

PRINT 'Creating Procedure DashBoardWindowUpdate'
GO
CREATE Procedure DashBoardWindowUpdate
(
		@DashBoardWindowId int = null,
		@DashBoardWindow nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardWindowUpdate.sql
**	Name: DashBoardWindowUpdate
**	Desc: Updates DashBoardWindow Based on Id field 
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
	dbo.DashBoardWindow 	
SET 
		DashBoardWindow = @DashBoardWindow,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	DashBoardWindowId = @DashBoardWindowId 				

GO

GRANT EXEC ON DashBoardWindowUpdate TO PUBLIC
GO
