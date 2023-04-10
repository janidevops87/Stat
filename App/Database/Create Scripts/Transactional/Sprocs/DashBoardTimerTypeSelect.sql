

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardTimerTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardTimerTypeSelect'
		DROP Procedure DashBoardTimerTypeSelect
	END
GO

PRINT 'Creating Procedure DashBoardTimerTypeSelect'
GO
CREATE Procedure DashBoardTimerTypeSelect
(
		@DashBoardTimerTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardTimerTypeSelect.sql
**	Name: DashBoardTimerTypeSelect
**	Desc: Selects multiple rows of DashBoardTimerType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DashBoardTimerType.DashBoardTimerTypeId,
		DashBoardTimerType.DashBoardTimerType,
		DashBoardTimerType.LastModified,
		DashBoardTimerType.LastStatEmployeeId,
		DashBoardTimerType.AuditLogTypeId
	FROM 
		dbo.DashBoardTimerType 
	WHERE 
		DashBoardTimerType.DashBoardTimerTypeId = ISNULL(@DashBoardTimerTypeId, DashBoardTimerTypeId)				
	ORDER BY 1
GO

GRANT EXEC ON DashBoardTimerTypeSelect TO PUBLIC
GO
