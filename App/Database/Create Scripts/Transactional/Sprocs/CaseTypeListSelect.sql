

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CaseTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure CaseTypeListSelect'
		DROP Procedure CaseTypeListSelect
	END
GO

PRINT 'Creating Procedure CaseTypeListSelect'
GO
CREATE Procedure CaseTypeListSelect
(
		@CaseTypeId int = null					
)
AS
/******************************************************************************
**	File: CaseTypeListSelect.sql
**	Name: CaseTypeListSelect
**	Desc: Selects multiple rows of CaseType Based on Id  fields 
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
		CaseType.CaseTypeId AS ListId,
		CaseType.CaseType AS FieldValue
	FROM 
		dbo.CaseType 
	WHERE 
		CaseType.CaseTypeId = ISNULL(@CaseTypeId, CaseType.CaseTypeId)				
	ORDER BY 2
GO

GRANT EXEC ON CaseTypeListSelect TO PUBLIC
GO
