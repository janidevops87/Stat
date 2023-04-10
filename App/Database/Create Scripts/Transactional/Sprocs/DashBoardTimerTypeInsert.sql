

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardTimerTypeInsert')
	BEGIN
		PRINT 'Dropping Procedure DashBoardTimerTypeInsert'
		DROP Procedure DashBoardTimerTypeInsert
	END
GO

PRINT 'Creating Procedure DashBoardTimerTypeInsert'
GO
CREATE Procedure DashBoardTimerTypeInsert
(
		@DashBoardTimerTypeId int = null,
		@DashBoardTimerType nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardTimerTypeInsert.sql
**	Name: DashBoardTimerTypeInsert
**	Desc: Inserts DashBoardTimerType Based on Id field 
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

INSERT	DashBoardTimerType
	(
		DashBoardTimerType,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@DashBoardTimerType,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @DashBoardTimerTypeID = SCOPE_IDENTITY()

EXEC DashBoardTimerTypeSelect @DashBoardTimerTypeID

GO

GRANT EXEC ON DashBoardTimerTypeInsert TO PUBLIC
GO
