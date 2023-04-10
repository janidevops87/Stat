

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomListListSelect10')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCustomListListSelect10'
		DROP Procedure ServiceLevelCustomListListSelect10
	END
GO

PRINT 'Creating Procedure ServiceLevelCustomListListSelect10'
GO
CREATE Procedure ServiceLevelCustomListListSelect10
(
		@ServiceLevelID int = null			
)
AS
/******************************************************************************
**	File: ServiceLevelCustomListListSelect.sql
**	Name: ServiceLevelCustomListListSelect
**	Desc: Selects multiple rows of ServiceLevelCustomList Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/28/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/28/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ServiceLevelCustomList. ServiceLevelCustomListID AS ListId,
		ServiceLevelListItem AS FieldValue

	FROM 
		dbo.ServiceLevelCustomList 
	WHERE 
		ServiceLevelCustomList.ServiceLevelID = ISNULL(@ServiceLevelID, ServiceLevelCustomList.ServiceLevelID)
		and ServiceLevelListField = 10
	ORDER BY 2
GO

GRANT EXEC ON ServiceLevelCustomListListSelect10 TO PUBLIC
GO
