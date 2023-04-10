

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeTypeListSelect'
		DROP Procedure SourceCodeTypeListSelect
	END
GO

PRINT 'Creating Procedure SourceCodeTypeListSelect'
GO
CREATE Procedure SourceCodeTypeListSelect
(
		@SourceCodeTypeId int = null output					
)
AS
/******************************************************************************
**	File: SourceCodeTypeListSelect.sql
**	Name: SourceCodeTypeListSelect
**	Desc: Selects multiple rows of SourceCodeType Based on Id  fields 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**  04/25/2011		ccarroll			Do not display COD or No Call types
**										The 'No Call' type is not in table
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	SELECT
		SourceCodeType.SourceCodeTypeId AS ListId,
		SourceCodeType.SourceCodeTypeName AS FieldValue
	FROM 
		dbo.SourceCodeType 
	WHERE 
		SourceCodeType.SourceCodeTypeId = ISNULL(@SourceCodeTypeId, SourceCodeType.SourceCodeTypeId) AND				
		SourceCodeType.SourceCodeTypeId <> 5  -- COD
		
	ORDER BY 1
GO

GRANT EXEC ON SourceCodeTypeListSelect TO PUBLIC
GO
