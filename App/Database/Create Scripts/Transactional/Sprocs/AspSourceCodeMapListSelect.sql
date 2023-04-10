IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AspSourceCodeMapListSelect')
	BEGIN
		PRINT 'Dropping Procedure AspSourceCodeMapListSelect'
		DROP Procedure AspSourceCodeMapListSelect
	END
GO

PRINT 'Creating Procedure AspSourceCodeMapListSelect'
GO
CREATE Procedure AspSourceCodeMapListSelect
(
		@SourceCodeID int = null
)
AS
/******************************************************************************
**	File: AspSourceCodeMapListSelect.sql
**	Name: AspSourceCodeMapListSelect
**	Desc: Selects multiple rows of AspSourceCodeMap Based on Id  fields 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AspSourceCodeMap.AspSourceCodeID AS ListId,
		AspSourceCodeMap.AspSourceCodeName AS FieldValue
	FROM 
		dbo.AspSourceCodeMap

	WHERE 
		AspSourceCodeMap.SourceCodeID = ISNULL(@SourceCodeID, AspSourceCodeMap.SourceCodeID)

	ORDER BY 1
GO

GRANT EXEC ON AspSourceCodeMapListSelect TO PUBLIC
GO
