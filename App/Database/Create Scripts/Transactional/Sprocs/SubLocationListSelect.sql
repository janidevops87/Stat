

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SubLocationListSelect')
	BEGIN
		PRINT 'Dropping Procedure SubLocationListSelect'
		DROP Procedure SubLocationListSelect
	END
GO

PRINT 'Creating Procedure SubLocationListSelect'
GO
CREATE Procedure SubLocationListSelect
(
		@SubLocationID int = null
)
AS
/******************************************************************************
**	File: SubLocationListSelect.sql
**	Name: SubLocationListSelect
**	Desc: Selects multiple rows of SubLocation Based on Id  fields 
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
		SubLocation.SubLocationID AS ListId,
		SubLocation.SubLocationName AS FieldValue
	FROM 
		dbo.SubLocation 
	WHERE 
		SubLocation.SubLocationID = ISNULL(@SubLocationID, SubLocation.SubLocationID)				
	ORDER BY 2
GO

GRANT EXEC ON SubLocationListSelect TO PUBLIC
GO
