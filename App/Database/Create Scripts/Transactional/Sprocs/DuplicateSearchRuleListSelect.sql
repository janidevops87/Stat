

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DuplicateSearchRuleListSelect')
	BEGIN
		PRINT 'Dropping Procedure DuplicateSearchRuleListSelect'
		DROP Procedure DuplicateSearchRuleListSelect
	END
GO

PRINT 'Creating Procedure DuplicateSearchRuleListSelect'
GO
CREATE Procedure DuplicateSearchRuleListSelect
(
		@DuplicateSearchRuleId int = null					
)
AS
/******************************************************************************
**	File: DuplicateSearchRuleListSelect.sql
**	Name: DuplicateSearchRuleListSelect
**	Desc: Selects multiple rows of DuplicateSearchRule Based on Id  fields 
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
		DuplicateSearchRule.DuplicateSearchRuleId AS ListId,
		DuplicateSearchRule.DuplicateSearchRule AS FieldValue
	FROM 
		dbo.DuplicateSearchRule 
	WHERE 
		DuplicateSearchRule.DuplicateSearchRuleId = ISNULL(@DuplicateSearchRuleId, DuplicateSearchRule.DuplicateSearchRuleId)				
	ORDER BY 2
GO

GRANT EXEC ON DuplicateSearchRuleListSelect TO PUBLIC
GO
