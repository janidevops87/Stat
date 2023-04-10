

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GenderListSelect')
	BEGIN
		PRINT 'Dropping Procedure GenderListSelect'
		DROP Procedure GenderListSelect
	END
GO

PRINT 'Creating Procedure GenderListSelect'
GO
CREATE Procedure GenderListSelect
(
		@GenderID int = null output					
)
AS
/******************************************************************************
**	File: GenderListSelect.sql
**	Name: GenderListSelect
**	Desc: Selects multiple rows of Gender Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 9/15/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	9/15/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Gender.GenderID AS ListId,
		Gender.Gender AS FieldValue
	FROM 
		dbo.Gender 
	WHERE 
		Gender.GenderID = ISNULL(@GenderID, Gender.GenderID)				
	ORDER BY 2
GO

GRANT EXEC ON GenderListSelect TO PUBLIC
GO
