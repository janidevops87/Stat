

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CallTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure CallTypeListSelect'
		DROP Procedure CallTypeListSelect
	END
GO

PRINT 'Creating Procedure CallTypeListSelect'
GO
CREATE Procedure CallTypeListSelect
(
		@CallTypeID int = null 					
)
AS
/******************************************************************************
**	File: CallTypeListSelect.sql
**	Name: CallTypeListSelect
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
		CallType.CallTypeID = ISNULL(@CallTypeID, CallType.CallTypeID)				
	ORDER BY 1
GO

GRANT EXEC ON CallTypeListSelect TO PUBLIC
GO
