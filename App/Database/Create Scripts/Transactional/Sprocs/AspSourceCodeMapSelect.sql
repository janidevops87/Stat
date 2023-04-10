

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AspSourceCodeMapSelect')
	BEGIN
		PRINT 'Dropping Procedure AspSourceCodeMapSelect'
		DROP Procedure AspSourceCodeMapSelect
	END
GO

PRINT 'Creating Procedure AspSourceCodeMapSelect'
GO
CREATE Procedure AspSourceCodeMapSelect
(
		@SourceCodeID int = null
)
AS
/******************************************************************************
**	File: AspSourceCodeMapSelect.sql
**	Name: AspSourceCodeMapSelect
**	Desc: Selects multiple rows of AspSourceCodeMap Based on Id  fields 
**	Auth: ccarroll
**	Date: 10/23/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	10/23/2009		ccarroll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AspSourceCodeMap.AspSourceCodeMapID,
		AspSourceCodeMap.SourceCodeID,
		AspSourceCodeMap.AspSourceCodeID,
		AspSourceCodeMap.LastModified,
		AspSourceCodeMap.LastStatEmployeeID,
		AspSourceCodeMap.AuditLogTypeID,
		AspSourceCodeMap.AspSourceCodeName
	FROM 
		dbo.AspSourceCodeMap

	WHERE 
		AspSourceCodeMap.SourceCodeID = ISNULL(@SourceCodeID, AspSourceCodeMap.SourceCodeID)

	ORDER BY 1
GO

GRANT EXEC ON AspSourceCodeMapSelect TO PUBLIC
GO
