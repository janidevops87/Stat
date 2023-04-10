

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationAliasUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationAliasUpdate'
		DROP Procedure OrganizationAliasUpdate
	END
GO

PRINT 'Creating Procedure OrganizationAliasUpdate'
GO
CREATE Procedure OrganizationAliasUpdate
(
		@OrganizationAliasId int = null,
		@OrganizationId int = null,
		@OrganizationAliasName nvarchar(80) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationAliasUpdate.sql
**	Name: OrganizationAliasUpdate
**	Desc: Updates OrganizationAlias Based on Id field 
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
	dbo.OrganizationAlias 	
SET 
		OrganizationId = @OrganizationId,
		OrganizationAliasName = @OrganizationAliasName,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	OrganizationAliasId = @OrganizationAliasId 				

GO

GRANT EXEC ON OrganizationAliasUpdate TO PUBLIC
GO
