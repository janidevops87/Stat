

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'LogEventTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure LogEventTypeListSelect'
		DROP Procedure LogEventTypeListSelect
	END
GO

PRINT 'Creating Procedure LogEventTypeListSelect'
GO
CREATE Procedure LogEventTypeListSelect
(
		@LogEventTypeID int = null output					
)
AS
/******************************************************************************
**	File: LogEventTypeListSelect.sql
**	Name: LogEventTypeListSelect
**	Desc: Selects multiple rows of LogEventType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/17/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/17/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		LogEventType.LogEventTypeID AS ListId,
		LogEventType.LogEventTypeName AS FieldValue
	FROM 
		dbo.LogEventType 
	WHERE 
		LogEventType.LogEventTypeID = ISNULL(@LogEventTypeID, LogEventType.LogEventTypeID)				
	ORDER BY 2
GO

GRANT EXEC ON LogEventTypeListSelect TO PUBLIC
GO
