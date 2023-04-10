

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationFsSourceCodeSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationFsSourceCodeSelect'
		DROP Procedure OrganizationFsSourceCodeSelect
	END
GO

PRINT 'Creating Procedure OrganizationFsSourceCodeSelect'
GO
CREATE Procedure OrganizationFsSourceCodeSelect
(
		@OrganizationFsSourceCodeId int = null,
		@OrganizationId int = null,
		@SourceCodeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationFsSourceCodeSelect.sql
**	Name: OrganizationFsSourceCodeSelect
**	Desc: Selects multiple rows of OrganizationFsSourceCode Based on Id  fields 
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
		OrganizationFsSourceCode.OrganizationFsSourceCodeId,
		OrganizationFsSourceCode.OrganizationId,		
		OrganizationFsSourceCode.SourceCodeId,
		SourceCode.SourceCodeName AS SourceCode,
		FsSourceCode.SourceCodeID AS FsSourceCodeId,
		FsSourceCode.SourceCodeName AS FsSourceCode,
		OrganizationFsSourceCode.LastModified,
		OrganizationFsSourceCode.LastStatEmployeeId,
		OrganizationFsSourceCode.AuditLogTypeId
	FROM 
		dbo.OrganizationFsSourceCode 
	JOIN
		SourceCode ON SourceCode.SourceCodeId = OrganizationFsSourceCode.SourceCodeId	
	JOIN
		SourceCode FsSourceCode ON FsSourceCode.SourceCodeId = OrganizationFsSourceCode.FsSourceCodeId	
	WHERE 
		OrganizationFsSourceCode.OrganizationFsSourceCodeId = ISNULL(@OrganizationFsSourceCodeId, OrganizationFsSourceCodeId)
	AND
		OrganizationFsSourceCode.OrganizationId = ISNULL(@OrganizationId, OrganizationId)
	AND
		OrganizationFsSourceCode.SourceCodeId = ISNULL(@SourceCodeId, OrganizationFsSourceCode.SourceCodeId)				
	ORDER BY 1
GO

GRANT EXEC ON OrganizationFsSourceCodeSelect TO PUBLIC
GO
