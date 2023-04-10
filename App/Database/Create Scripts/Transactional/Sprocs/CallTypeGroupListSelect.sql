 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CallTypeGroupListSelect')
	BEGIN
		PRINT 'Dropping Procedure CallTypeGroupListSelect'
		DROP Procedure CallTypeGroupListSelect
	END
GO

PRINT 'Creating Procedure CallTypeGroupListSelect'
GO
CREATE Procedure CallTypeGroupListSelect
(
		@CallTypeGroups nvarchar(20) = null 					
)
AS
/******************************************************************************
**	File: CallTypeGroupListSelect.sql
**	Name: CallTypeGroupListSelect
**	Desc: Selects multiple rows of CallType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/22/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/22/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		CallType.CallTypeID AS ListId,
		CallType.CallTypeName AS FieldValue
	FROM 
		dbo.CallType 
	WHERE 
		PATINDEX('%' + CallType.CallTypeName + '%', IsNull(@CallTypeGroups, CallType.CallTypeName)) > 0			
	ORDER BY 1
GO

GRANT EXEC ON CallTypeGroupListSelect TO PUBLIC
GO
