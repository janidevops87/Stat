

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'FieldSelect')
	BEGIN
		PRINT 'Dropping Procedure FieldSelect'
		DROP Procedure FieldSelect
	END
GO

PRINT 'Creating Procedure FieldSelect'
GO
CREATE Procedure FieldSelect
(
		@FieldID int = null					
)
AS
/******************************************************************************
**	File: FieldSelect.sql
**	Name: FieldSelect
**	Desc: Selects multiple rows of Field Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/7/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/7/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Field.FieldID,
		Field.FieldName,
		Field.LastModified,
		Field.LastStatEmployeeID,
		Field.AuditLogTypeID
	FROM 
		dbo.Field 

	WHERE 
		Field.FieldID = ISNULL(@FieldID, Field.FieldID)				
	ORDER BY 1
GO

GRANT EXEC ON FieldSelect TO PUBLIC
GO
