

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'RaceListSelect')
	BEGIN
		PRINT 'Dropping Procedure RaceListSelect'
		DROP Procedure RaceListSelect
	END
GO

PRINT 'Creating Procedure RaceListSelect'
GO
CREATE Procedure RaceListSelect
(
		@RaceID int = null output					
)
AS
/******************************************************************************
**	File: RaceListSelect.sql
**	Name: RaceListSelect
**	Desc: Selects multiple rows of Race Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Race.RaceID AS ListId,
		Race.RaceName AS FieldValue
	FROM 
		dbo.Race 
	WHERE 
		Race.RaceID = ISNULL(@RaceID, Race.RaceID)				
	ORDER BY 2
GO

GRANT EXEC ON RaceListSelect TO PUBLIC
GO
