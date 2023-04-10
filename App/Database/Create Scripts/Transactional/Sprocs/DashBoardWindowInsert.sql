

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardWindowInsert')
	BEGIN
		PRINT 'Dropping Procedure DashBoardWindowInsert'
		DROP Procedure DashBoardWindowInsert
	END
GO

PRINT 'Creating Procedure DashBoardWindowInsert'
GO
CREATE Procedure DashBoardWindowInsert
(
		@DashBoardWindowId int = null,
		@DashBoardWindow nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardWindowInsert.sql
**	Name: DashBoardWindowInsert
**	Desc: Inserts DashBoardWindow Based on Id field 
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

INSERT	DashBoardWindow
	(
		DashBoardWindow,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@DashBoardWindow,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @DashBoardWindowID = SCOPE_IDENTITY()

EXEC DashBoardWindowSelect @DashBoardWindowID

GO

GRANT EXEC ON DashBoardWindowInsert TO PUBLIC
GO
