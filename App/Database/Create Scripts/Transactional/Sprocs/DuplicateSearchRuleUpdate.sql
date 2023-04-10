

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DuplicateSearchRuleUpdate')
	BEGIN
		PRINT 'Dropping Procedure DuplicateSearchRuleUpdate'
		DROP Procedure DuplicateSearchRuleUpdate
	END
GO

PRINT 'Creating Procedure DuplicateSearchRuleUpdate'
GO
CREATE Procedure DuplicateSearchRuleUpdate
(
		@DuplicateSearchRuleId int = null,
		@DuplicateSearchRule nvarchar(100) = null,
		@DefaultNumberOfDaysToSearch int = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DuplicateSearchRuleUpdate.sql
**	Name: DuplicateSearchRuleUpdate
**	Desc: Updates DuplicateSearchRule Based on Id field 
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

UPDATE
	dbo.DuplicateSearchRule 	
SET 
		DuplicateSearchRule = @DuplicateSearchRule,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	DuplicateSearchRuleId = @DuplicateSearchRuleId 				

GO

GRANT EXEC ON DuplicateSearchRuleUpdate TO PUBLIC
GO
