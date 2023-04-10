

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure PersonTypeListSelect'
		DROP Procedure PersonTypeListSelect
	END
GO

PRINT 'Creating Procedure PersonTypeListSelect'
GO
CREATE Procedure PersonTypeListSelect
(
		@PersonTypeID int = null output					
)
AS
/******************************************************************************
**	File: PersonTypeListSelect.sql
**	Name: PersonTypeListSelect
**	Desc: Selects multiple rows of PersonType Based on Id  fields 
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
		PersonType.PersonTypeID AS ListId,
		PersonType.PersonTypeName AS FieldValue
	FROM 
		dbo.PersonType 
	WHERE 
		PersonType.PersonTypeID = ISNULL(@PersonTypeID, PersonType.PersonTypeID)				
	ORDER BY 2
GO

GRANT EXEC ON PersonTypeListSelect TO PUBLIC
GO
