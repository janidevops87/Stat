

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSourceCodeListSelect')
	BEGIN
		PRINT 'Dropping Procedure CriteriaSourceCodeListSelect'
		DROP Procedure CriteriaSourceCodeListSelect
	END
GO

PRINT 'Creating Procedure CriteriaSourceCodeListSelect'
GO
CREATE Procedure CriteriaSourceCodeListSelect
(
		@CriteriaSourceCodeID int = null output,
		@CriteriaID int = null,
		@SourceCodeID int = null					
)
AS
/******************************************************************************
**	File: CriteriaSourceCodeListSelect.sql
**	Name: CriteriaSourceCodeListSelect
**	Desc: Selects multiple rows of CriteriaSourceCode Based on Id  fields 
**	Auth: ccarroll
**	Date: 12/21/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/21/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CriteriaSourceCode.CriteriaSourceCodeID AS ListId

	FROM 
		dbo.CriteriaSourceCode 
	WHERE 
		CriteriaSourceCode.CriteriaSourceCodeID = ISNULL(@CriteriaSourceCodeID, CriteriaSourceCode.CriteriaSourceCodeID)
	AND
		CriteriaSourceCode.CriteriaID = ISNULL(@CriteriaID, CriteriaSourceCode.CriteriaID)
	AND
		CriteriaSourceCode.SourceCodeID = ISNULL(@SourceCodeID, CriteriaSourceCode.SourceCodeID)				
	ORDER BY 1
GO

GRANT EXEC ON CriteriaSourceCodeListSelect TO PUBLIC
GO
