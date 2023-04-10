

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDuplicateSearchRuleInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDuplicateSearchRuleInsert'
		DROP Procedure OrganizationDuplicateSearchRuleInsert
	END
GO

PRINT 'Creating Procedure OrganizationDuplicateSearchRuleInsert'
GO
CREATE Procedure OrganizationDuplicateSearchRuleInsert
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
**	File: OrganizationDuplicateSearchRuleInsert.sql
**	Name: OrganizationDuplicateSearchRuleInsert
**	Desc: Inserts OrganizationDuplicateSearchRule Based on Id field 
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

INSERT	OrganizationDuplicateSearchRule
	(
		OrganizationId,
		DuplicateSearchRuleId,
		CallTypeID,
		NumberOfDaysToSearch,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@DuplicateSearchRuleId,
		@CallTypeID,
		@NumberOfDaysToSearch,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @OrganizationDuplicateSearchRuleID = SCOPE_IDENTITY()

EXEC OrganizationDuplicateSearchRuleSelect @OrganizationDuplicateSearchRuleID

GO

GRANT EXEC ON OrganizationDuplicateSearchRuleInsert TO PUBLIC
GO
