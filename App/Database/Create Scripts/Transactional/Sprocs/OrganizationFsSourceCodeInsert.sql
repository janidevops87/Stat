

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationFsSourceCodeInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationFsSourceCodeInsert'
		DROP Procedure OrganizationFsSourceCodeInsert
	END
GO

PRINT 'Creating Procedure OrganizationFsSourceCodeInsert'
GO
CREATE Procedure OrganizationFsSourceCodeInsert
(
		@OrganizationFsSourceCodeId int = null,
		@OrganizationId int = null,
		@SourceCodeId int = null,
		@SourceCode varchar(10) = null,
		@FsSourceCodeId int = null,
		@FsSourceCode varchar(10) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null							
)
AS
/******************************************************************************
**	File: OrganizationFsSourceCodeInsert.sql
**	Name: OrganizationFsSourceCodeInsert
**	Desc: Inserts OrganizationFsSourceCode Based on Id field 
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

INSERT	OrganizationFsSourceCode
	(
		OrganizationId,
		SourceCodeId,
		FsSourceCodeId,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@SourceCodeId,
		@FsSourceCodeId,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @OrganizationFsSourceCodeID = SCOPE_IDENTITY()

EXEC OrganizationFsSourceCodeSelect @OrganizationFsSourceCodeID

GO

GRANT EXEC ON OrganizationFsSourceCodeInsert TO PUBLIC
GO
