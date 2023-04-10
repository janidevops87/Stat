

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDuplicateSearchRuleUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDuplicateSearchRuleUpdate'
		DROP Procedure OrganizationDuplicateSearchRuleUpdate
	END
GO

PRINT 'Creating Procedure OrganizationDuplicateSearchRuleUpdate'
GO
CREATE Procedure OrganizationDuplicateSearchRuleUpdate
(
		@OrganizationDuplicateSearchRuleId int = null,
		@OrganizationId int = null,
		@DuplicateSearchRuleId int = null,
		@DuplicateSearchRule varchar(100) = null,
		@CallTypeID int = null,
		@CallType varchar(50) = null,
		@NumberOfDaysToSearch int = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationDuplicateSearchRuleUpdate.sql
**	Name: OrganizationDuplicateSearchRuleUpdate
**	Desc: Updates OrganizationDuplicateSearchRule Based on Id field 
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
	dbo.OrganizationDuplicateSearchRule 	
SET 
		OrganizationId = @OrganizationId,
		DuplicateSearchRuleId = @DuplicateSearchRuleId,
		CallTypeID = @CallTypeID,
		NumberOfDaysToSearch = @NumberOfDaysToSearch,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	OrganizationDuplicateSearchRuleId = @OrganizationDuplicateSearchRuleId 				

GO

GRANT EXEC ON OrganizationDuplicateSearchRuleUpdate TO PUBLIC
GO
