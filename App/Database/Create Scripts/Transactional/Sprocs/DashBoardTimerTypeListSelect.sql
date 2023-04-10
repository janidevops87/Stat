

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardTimerTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardTimerTypeListSelect'
		DROP Procedure DashBoardTimerTypeListSelect
	END
GO

PRINT 'Creating Procedure DashBoardTimerTypeListSelect'
GO
CREATE Procedure DashBoardTimerTypeListSelect
(
		@DashBoardTimerTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardTimerTypeListSelect.sql
**	Name: DashBoardTimerTypeListSelect
**	Desc: Selects multiple rows of DashBoardTimerType Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DashBoardTimerType.DashBoardTimerTypeId AS ListId,
		DashBoardTimerType.DashBoardTimerType AS FieldValue
	FROM 
		dbo.DashBoardTimerType 
	WHERE 
		DashBoardTimerType.DashBoardTimerTypeId = ISNULL(@DashBoardTimerTypeId, DashBoardTimerType.DashBoardTimerTypeId)				
	ORDER BY 2
GO

GRANT EXEC ON DashBoardTimerTypeListSelect TO PUBLIC
GO
