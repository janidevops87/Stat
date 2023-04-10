

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SubLocationLevelListSelect')
	BEGIN
		PRINT 'Dropping Procedure SubLocationLevelListSelect'
		DROP Procedure SubLocationLevelListSelect
	END
GO

PRINT 'Creating Procedure SubLocationLevelListSelect'
GO
CREATE Procedure SubLocationLevelListSelect
(
		@SubLocationLevelID int = null
)
AS
/******************************************************************************
**	File: SubLocationLevelListSelect.sql
**	Name: SubLocationLevelListSelect
**	Desc: Selects multiple rows of SubLocationLevel Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/21/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		SubLocationLevel.SubLocationLevelID AS ListId,
		SubLocationLevel.SubLocationLevelName AS FieldValue
	FROM 
		dbo.SubLocationLevel 
	WHERE 
		SubLocationLevel.SubLocationLevelID = ISNULL(@SubLocationLevelID, SubLocationLevel.SubLocationLevelID)				
	ORDER BY 2
GO

GRANT EXEC ON SubLocationLevelListSelect TO PUBLIC
GO
