

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AgeIntervalListSelect')
	BEGIN
		PRINT 'Dropping Procedure AgeIntervalListSelect'
		DROP Procedure AgeIntervalListSelect
	END
GO

PRINT 'Creating Procedure AgeIntervalListSelect'
GO
CREATE Procedure AgeIntervalListSelect
(
		@AgeIntervalID int = null output					
)
AS
/******************************************************************************
**	File: AgeIntervalListSelect.sql
**	Name: AgeIntervalListSelect
**	Desc: Selects multiple rows of AgeInterval Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/22/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/22/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AgeInterval.AgeIntervalID AS ListId,
		AgeInterval.AgeInterval AS FieldValue
	FROM 
		dbo.AgeInterval 
	WHERE 
		AgeInterval.AgeIntervalID = ISNULL(@AgeIntervalID, AgeInterval.AgeIntervalID)				
	ORDER BY 1
GO

GRANT EXEC ON AgeIntervalListSelect TO PUBLIC
GO
