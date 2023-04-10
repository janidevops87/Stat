

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardWindowSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardWindowSelect'
		DROP Procedure DashBoardWindowSelect
	END
GO

PRINT 'Creating Procedure DashBoardWindowSelect'
GO
CREATE Procedure DashBoardWindowSelect
(
		@DashBoardWindowId int = null					
)
AS
/******************************************************************************
**	File: DashBoardWindowSelect.sql
**	Name: DashBoardWindowSelect
**	Desc: Selects multiple rows of DashBoardWindow Based on Id  fields 
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
		DashBoardWindow.DashBoardWindowId,
		DashBoardWindow.DashBoardWindow,
		DashBoardWindow.LastModified,
		DashBoardWindow.LastStatEmployeeId,
		DashBoardWindow.AuditLogTypeId
	FROM 
		dbo.DashBoardWindow 
	WHERE 
		DashBoardWindow.DashBoardWindowId = ISNULL(@DashBoardWindowId, DashBoardWindowId)				
	ORDER BY 1
GO

GRANT EXEC ON DashBoardWindowSelect TO PUBLIC
GO
