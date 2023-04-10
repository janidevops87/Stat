

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DuplicateSearchRuleInsert')
	BEGIN
		PRINT 'Dropping Procedure DuplicateSearchRuleInsert'
		DROP Procedure DuplicateSearchRuleInsert
	END
GO

PRINT 'Creating Procedure DuplicateSearchRuleInsert'
GO
CREATE Procedure DuplicateSearchRuleInsert
(
		@DuplicateSearchRuleId int = null,
		@DuplicateSearchRule nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DuplicateSearchRuleInsert.sql
**	Name: DuplicateSearchRuleInsert
**	Desc: Inserts DuplicateSearchRule Based on Id field 
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

INSERT	DuplicateSearchRule
	(
		DuplicateSearchRule,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@DuplicateSearchRule,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @DuplicateSearchRuleID = SCOPE_IDENTITY()

EXEC DuplicateSearchRuleSelect @DuplicateSearchRuleID

GO

GRANT EXEC ON DuplicateSearchRuleInsert TO PUBLIC
GO
