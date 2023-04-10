

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CaseTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure CaseTypeSelect'
		DROP Procedure CaseTypeSelect
	END
GO

PRINT 'Creating Procedure CaseTypeSelect'
GO
CREATE Procedure CaseTypeSelect
(
		@CaseTypeId int = null					
)
AS
/******************************************************************************
**	File: CaseTypeSelect.sql
**	Name: CaseTypeSelect
**	Desc: Selects multiple rows of CaseType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CaseType.CaseTypeId,
		CaseType.CaseType,
		CaseType.LastModified,
		CaseType.LastStatEmployeeId,
		CaseType.AuditLogTypeId
	FROM 
		dbo.CaseType 
	WHERE 
		CaseType.CaseTypeId = ISNULL(@CaseTypeId, CaseTypeId)				
	ORDER BY 1
GO

GRANT EXEC ON CaseTypeSelect TO PUBLIC
GO
