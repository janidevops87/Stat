

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DuplicateSearchRuleSelect')
	BEGIN
		PRINT 'Dropping Procedure DuplicateSearchRuleSelect'
		DROP Procedure DuplicateSearchRuleSelect
	END
GO

PRINT 'Creating Procedure DuplicateSearchRuleSelect'
GO
CREATE Procedure DuplicateSearchRuleSelect
(
		@DuplicateSearchRuleId int = null					
)
AS
/******************************************************************************
**	File: DuplicateSearchRuleSelect.sql
**	Name: DuplicateSearchRuleSelect
**	Desc: Selects multiple rows of DuplicateSearchRule Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DuplicateSearchRule.DuplicateSearchRuleId,
		DuplicateSearchRule.DuplicateSearchRule,		
		DuplicateSearchRule.LastModified,
		DuplicateSearchRule.LastStatEmployeeId,
		DuplicateSearchRule.AuditLogTypeId
	FROM 
		dbo.DuplicateSearchRule 
	WHERE 
		DuplicateSearchRule.DuplicateSearchRuleId = ISNULL(@DuplicateSearchRuleId, DuplicateSearchRuleId)				
	ORDER BY 1
GO

GRANT EXEC ON DuplicateSearchRuleSelect TO PUBLIC
GO
