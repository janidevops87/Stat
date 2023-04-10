IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeTransplantCenterSelect')
	BEGIN
		PRINT 'Dropping Procedure SourceCodeTransplantCenterSelect'
		DROP Procedure SourceCodeTransplantCenterSelect
	END
GO

PRINT 'Creating Procedure SourceCodeTransplantCenterSelect'
GO
CREATE Procedure SourceCodeTransplantCenterSelect
(
		@SourceCodeTransplantCenterID int = null output,
		@SourceCodeID int = null,
		@OrganizationID int = null
)
AS
/******************************************************************************
**	File: SourceCodeTransplantCenterSelect.sql
**	Name: SourceCodeTransplantCenterSelect
**	Desc: Selects multiple rows of SourceCodeTransplantCenter Based on Id  fields 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	11/12/2009		ccarroll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		SourceCodeTransplantCenter.SourceCodeTransplantCenterID,
		SourceCodeTransplantCenter.SourceCodeID,
		SourceCodeTransplantCenter.OrganizationID,
		SourceCodeTransplantCenter.TransplantCode,
		SourceCodeTransplantCenter.OrganizationName,
		SourceCodeTransplantCenter.OrganType,
		SourceCodeTransplantCenter.MessageOrganizationID,
		SourceCodeTransplantCenter.MessageOrganizationName,
		SourceCodeTransplantCenter.LastModified,
		SourceCodeTransplantCenter.LastStatEmployeeID,
		SourceCodeTransplantCenter.AuditLogTypeID
	FROM 
		dbo.SourceCodeTransplantCenter 
	WHERE 
		SourceCodeTransplantCenter.SourceCodeTransplantCenterID = ISNULL(@SourceCodeTransplantCenterID, SourceCodeTransplantCenter.SourceCodeTransplantCenterID)
	AND
		SourceCodeTransplantCenter.SourceCodeID = ISNULL(@SourceCodeID, SourceCodeTransplantCenter.SourceCodeID)
	AND
		SourceCodeTransplantCenter.OrganizationID = ISNULL(@OrganizationID, SourceCodeTransplantCenter.OrganizationID)

	ORDER BY 1
GO

GRANT EXEC ON SourceCodeTransplantCenterSelect TO PUBLIC
GO
