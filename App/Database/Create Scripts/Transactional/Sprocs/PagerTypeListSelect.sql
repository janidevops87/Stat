

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PagerTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure PagerTypeListSelect'
		DROP Procedure PagerTypeListSelect
	END
GO

PRINT 'Creating Procedure PagerTypeListSelect'
GO
CREATE Procedure PagerTypeListSelect
(
		@PagerTypeID int = null output					
)
AS
/******************************************************************************
**	File: PagerTypeListSelect.sql
**	Name: PagerTypeListSelect
**	Desc: Selects multiple rows of PagerType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 10/6/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/6/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)

*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		PagerType.PagerTypeID AS ListId,
		PagerType.PagerType AS FieldValue
	FROM 
		dbo.PagerType 
	WHERE 
		PagerType.PagerTypeID = ISNULL(@PagerTypeID, PagerType.PagerTypeID)				
	ORDER BY 2
GO

GRANT EXEC ON PagerTypeListSelect TO PUBLIC
GO
