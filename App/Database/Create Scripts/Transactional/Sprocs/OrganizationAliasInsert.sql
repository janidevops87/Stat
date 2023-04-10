

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationAliasInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationAliasInsert'
		DROP Procedure OrganizationAliasInsert
	END
GO

PRINT 'Creating Procedure OrganizationAliasInsert'
GO
CREATE Procedure OrganizationAliasInsert
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
**	File: OrganizationAliasInsert.sql
**	Name: OrganizationAliasInsert
**	Desc: Inserts OrganizationAlias Based on Id field 
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

INSERT	OrganizationAlias
	(
		OrganizationId,
		OrganizationAliasName,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@OrganizationAliasName,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @OrganizationAliasID = SCOPE_IDENTITY()

EXEC OrganizationAliasSelect @OrganizationAliasID

GO

GRANT EXEC ON OrganizationAliasInsert TO PUBLIC
GO
