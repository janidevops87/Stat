

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CountryCodeListSelect')
	BEGIN
		PRINT 'Dropping Procedure CountryCodeListSelect'
		DROP Procedure CountryCodeListSelect
	END
GO

PRINT 'Creating Procedure CountryCodeListSelect'
GO
CREATE Procedure CountryCodeListSelect
(
		@CountryCodeId int = null,
		@CountryId int = null					
)
AS
/******************************************************************************
**	File: CountryCodeListSelect.sql
**	Name: CountryCodeListSelect
**	Desc: Selects multiple rows of CountryCode Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CountryCode.CountryCodeId AS ListId,
		CountryCode.CountryCode AS FieldValue
	FROM 
		dbo.CountryCode 
	WHERE 
		CountryCode.CountryCodeId = ISNULL(@CountryCodeId, CountryCode.CountryCodeId)
	AND
		CountryCode.CountryId = ISNULL(@CountryId, CountryCode.CountryId)				
	ORDER BY 2
GO

GRANT EXEC ON CountryCodeListSelect TO PUBLIC
GO
