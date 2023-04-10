

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DisplayScreenListSelect')
	BEGIN
		PRINT 'Dropping Procedure DisplayScreenListSelect'
		DROP Procedure DisplayScreenListSelect
	END
GO

PRINT 'Creating Procedure DisplayScreenListSelect'
GO
CREATE Procedure DisplayScreenListSelect
(
		@DisplayScreenID int = null output					
)
AS
/******************************************************************************
**	File: DisplayScreenListSelect.sql
**	Name: DisplayScreenListSelect
**	Desc: Selects multiple rows of DisplayScreen Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/22/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/22/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DisplayScreen.DisplayScreenID AS ListId,
		DisplayScreen.DisplayScreen AS FieldValue
	FROM 
		dbo.DisplayScreen 
	WHERE 
		DisplayScreen.DisplayScreenID = ISNULL(@DisplayScreenID, DisplayScreen.DisplayScreenID)				
	ORDER BY 2
GO

GRANT EXEC ON DisplayScreenListSelect TO PUBLIC
GO
