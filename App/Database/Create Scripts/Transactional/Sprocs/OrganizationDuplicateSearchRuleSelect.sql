

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDuplicateSearchRuleSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDuplicateSearchRuleSelect'
		DROP Procedure OrganizationDuplicateSearchRuleSelect
	END
GO

PRINT 'Creating Procedure OrganizationDuplicateSearchRuleSelect'
GO
CREATE Procedure OrganizationDuplicateSearchRuleSelect
(
		@OrganizationDuplicateSearchRuleId int = null,
		@OrganizationId int = null,
		@DuplicateSearchRuleId int = null					
)
AS
/******************************************************************************
**	File: OrganizationDuplicateSearchRuleSelect.sql
**	Name: OrganizationDuplicateSearchRuleSelect
**	Desc: Selects multiple rows of OrganizationDuplicateSearchRule Based on Id  fields 
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
		OrganizationDuplicateSearchRule.OrganizationDuplicateSearchRuleId,
		OrganizationDuplicateSearchRule.OrganizationId,
		OrganizationDuplicateSearchRule.CallTypeID,
		CallTypeName AS CallType,
		OrganizationDuplicateSearchRule.DuplicateSearchRuleId,
		DuplicateSearchRule AS DuplicateSearchRule,
		OrganizationDuplicateSearchRule.NumberOfDaysToSearch,
		OrganizationDuplicateSearchRule.LastModified,
		OrganizationDuplicateSearchRule.LastStatEmployeeId,
		OrganizationDuplicateSearchRule.AuditLogTypeId
	FROM 
		dbo.OrganizationDuplicateSearchRule 
	JOIN
		DuplicateSearchRule ON DuplicateSearchRule.DuplicateSearchRuleId = OrganizationDuplicateSearchRule.DuplicateSearchRuleId	
	JOIN
		CallType ON CallType.CallTypeID = OrganizationDuplicateSearchRule.CallTypeID
	WHERE 
		OrganizationDuplicateSearchRule.OrganizationDuplicateSearchRuleId = ISNULL(@OrganizationDuplicateSearchRuleId, OrganizationDuplicateSearchRule.OrganizationDuplicateSearchRuleId)
	AND
		OrganizationDuplicateSearchRule.OrganizationId = ISNULL(@OrganizationId, OrganizationDuplicateSearchRule.OrganizationId)
	AND
		OrganizationDuplicateSearchRule.DuplicateSearchRuleId = ISNULL(@DuplicateSearchRuleId, OrganizationDuplicateSearchRule.DuplicateSearchRuleId)				
		
	ORDER BY 1
GO

GRANT EXEC ON OrganizationDuplicateSearchRuleSelect TO PUBLIC
GO
