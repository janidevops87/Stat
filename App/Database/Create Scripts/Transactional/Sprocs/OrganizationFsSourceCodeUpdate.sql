

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationFsSourceCodeUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationFsSourceCodeUpdate'
		DROP Procedure OrganizationFsSourceCodeUpdate
	END
GO

PRINT 'Creating Procedure OrganizationFsSourceCodeUpdate'
GO
CREATE Procedure OrganizationFsSourceCodeUpdate
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
**	File: OrganizationFsSourceCodeUpdate.sql
**	Name: OrganizationFsSourceCodeUpdate
**	Desc: Updates OrganizationFsSourceCode Based on Id field 
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
	dbo.OrganizationFsSourceCode 	
SET 
		OrganizationId = @OrganizationId,
		SourceCodeId = @SourceCodeId,
		FsSourceCodeId = @FsSourceCodeId,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	OrganizationFsSourceCodeId = @OrganizationFsSourceCodeId 				

GO

GRANT EXEC ON OrganizationFsSourceCodeUpdate TO PUBLIC
GO
