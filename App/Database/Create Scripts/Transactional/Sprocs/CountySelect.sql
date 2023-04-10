

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CountySelect')
	BEGIN
		PRINT 'Dropping Procedure CountySelect'
		DROP Procedure CountySelect
	END
GO

PRINT 'Creating Procedure CountySelect'
GO
CREATE Procedure CountySelect
(
		@CountyID int = null output,
		@StateID int = null					
)
AS
/******************************************************************************
**	File: CountySelect.sql
**	Name: CountySelect
**	Desc: Selects multiple rows of county Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 11/5/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/5/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		county.CountyID,
		county.CountyName,
		county.StateID,
		State.StateAbbrv AS State,
		county.Verified,
		county.Inactive,
		county.LastModified,
		county.UpdatedFlag
	FROM 
		dbo.county 
	JOIN
		State ON State.StateID = county.StateID
	WHERE 
		county.CountyID = ISNULL(@CountyID, county.CountyID)
	AND
		county.StateID = ISNULL(@StateID, county.StateID)				
	ORDER BY 2
GO

GRANT EXEC ON CountySelect TO PUBLIC
GO
