

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DuplicateSearchRuleDefaultSelect')
	BEGIN
		PRINT 'Dropping Procedure DuplicateSearchRuleDefaultSelect'
		DROP Procedure DuplicateSearchRuleDefaultSelect
	END
GO

PRINT 'Creating Procedure DuplicateSearchRuleDefaultSelect'
GO
CREATE Procedure DuplicateSearchRuleDefaultSelect
(
		@DuplicateSearchRuleDefaultID int = null,
		@DuplicateSearchRuleID int = null,
		@CallTypeID int = null					
)
AS
/******************************************************************************
**	File: DuplicateSearchRuleDefaultSelect.sql
**	Name: DuplicateSearchRuleDefaultSelect
**	Desc: Selects multiple rows of DuplicateSearchRuleDefault Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 8/5/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	8/5/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**  06/28/2011		ccarroll			Added ISNull for NumberOfDaysToSearch wi:12954
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DuplicateSearchRuleDefault.DuplicateSearchRuleDefaultID,
		DuplicateSearchRuleDefault.DuplicateSearchRuleID,
		DuplicateSearchRule AS DuplicateSearchRule,
		DuplicateSearchRuleDefault.CallTypeID,
		CallType.CallTypeName AS CallType,
		IsNull(DuplicateSearchRuleDefault.NumberOfDaysToSearch, 0) AS NumberOfDaysToSearch,
		DuplicateSearchRuleDefault.LastModified,
		DuplicateSearchRuleDefault.LastStatEmployeeId,
		DuplicateSearchRuleDefault.AuditLogTypeId
	FROM 
		dbo.DuplicateSearchRuleDefault 
	JOIN
		DuplicateSearchRule ON DuplicateSearchRule.DuplicateSearchRuleID = DuplicateSearchRuleDefault.DuplicateSearchRuleID
	JOIN
		CallType ON CallType.CallTypeID = DuplicateSearchRuleDefault.CallTypeID
	WHERE 
		DuplicateSearchRuleDefault.DuplicateSearchRuleDefaultID = ISNULL(@DuplicateSearchRuleDefaultID, DuplicateSearchRuleDefault.DuplicateSearchRuleDefaultID)
	AND
		DuplicateSearchRuleDefault.DuplicateSearchRuleID = ISNULL(@DuplicateSearchRuleID, DuplicateSearchRuleDefault.DuplicateSearchRuleID)
	AND
		DuplicateSearchRuleDefault.CallTypeID = ISNULL(@CallTypeID, DuplicateSearchRuleDefault.CallTypeID)				
	ORDER BY 1
GO

GRANT EXEC ON DuplicateSearchRuleDefaultSelect TO PUBLIC
GO
