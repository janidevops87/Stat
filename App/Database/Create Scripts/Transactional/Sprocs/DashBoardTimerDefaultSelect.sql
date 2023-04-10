

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardTimerDefaultSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardTimerDefaultSelect'
		DROP Procedure DashBoardTimerDefaultSelect
	END
GO

PRINT 'Creating Procedure DashBoardTimerDefaultSelect'
GO
CREATE Procedure DashBoardTimerDefaultSelect
(
		@DashBoardTimerDefaultId int = null,
		@DashBoardWindowId int = null,
		@DashBoardTimerTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardTimerDefaultSelect.sql
**	Name: DashBoardTimerDefaultSelect
**	Desc: Selects multiple rows of DashBoardTimerDefault Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 8/5/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	8/5/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DashBoardTimerDefault.DashBoardTimerDefaultId,
		DashBoardTimerDefault.DashBoardWindowId,
		DashBoardWindow AS DashBoardWindow,
		DashBoardTimerDefault.DashBoardTimerTypeId,
		DashBoardTimerType AS DashBoardTimerType,
		DashBoardTimerDefault.ExpirationMinutes,
		DashBoardTimerDefault.LastModified,
		DashBoardTimerDefault.LastStatEmployeeId,
		DashBoardTimerDefault.AuditLogTypeId
	FROM 
		dbo.DashBoardTimerDefault 
	JOIN
		DashBoardWindow ON DashBoardWindow.DashBoardWindowId = DashBoardTimerDefault.DashBoardWindowId
	JOIN
		DashBoardTimerType ON DashBoardTimerType.DashBoardTimerTypeId = DashBoardTimerDefault.DashBoardTimerTypeId
	WHERE 
		DashBoardTimerDefault.DashBoardTimerDefaultId = ISNULL(@DashBoardTimerDefaultId, DashBoardTimerDefault.DashBoardTimerDefaultId)
	AND
		DashBoardTimerDefault.DashBoardWindowId = ISNULL(@DashBoardWindowId, DashBoardTimerDefault.DashBoardWindowId)
	AND
		DashBoardTimerDefault.DashBoardTimerTypeId = ISNULL(@DashBoardTimerTypeId, DashBoardTimerDefault.DashBoardTimerTypeId)				
	ORDER BY 1
GO

GRANT EXEC ON DashBoardTimerDefaultSelect TO PUBLIC
GO
