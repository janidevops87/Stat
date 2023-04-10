

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardWindowListSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardWindowListSelect'
		DROP Procedure DashBoardWindowListSelect
	END
GO

PRINT 'Creating Procedure DashBoardWindowListSelect'
GO
CREATE Procedure DashBoardWindowListSelect
(
		@DashBoardWindowId int = null					
)
AS
/******************************************************************************
**	File: DashBoardWindowListSelect.sql
**	Name: DashBoardWindowListSelect
**	Desc: Selects multiple rows of DashBoardWindow Based on Id  fields 
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
		DashBoardWindow.DashBoardWindowId AS ListId,
		DashBoardWindow.DashBoardWindow AS FieldValue
	FROM 
		dbo.DashBoardWindow 
	WHERE 
		DashBoardWindow.DashBoardWindowId = ISNULL(@DashBoardWindowId, DashBoardWindow.DashBoardWindowId)				
	ORDER BY 2
GO

GRANT EXEC ON DashBoardWindowListSelect TO PUBLIC
GO
