

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IddListSelect')
	BEGIN
		PRINT 'Dropping Procedure IddListSelect'
		DROP Procedure IddListSelect
	END
GO

PRINT 'Creating Procedure IddListSelect'
GO
CREATE Procedure IddListSelect
(
		@IddId int = null,		
		@CountryId int = null					
)
AS
/******************************************************************************
**	File: IddListSelect.sql
**	Name: IddListSelect
**	Desc: Selects multiple rows of Idd Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Idd.IddId AS ListId,
		Idd.Idd AS FieldValue
	FROM 
		dbo.Idd 
	WHERE 
		Idd.IddId = ISNULL(@IddId, Idd.IddId)
	AND
		Idd.CountryId = ISNULL(@CountryId, Idd.CountryId)				
	ORDER BY 2
GO

GRANT EXEC ON IddListSelect TO PUBLIC
GO
