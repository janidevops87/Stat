

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomListSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCustomListSelect'
		DROP Procedure ServiceLevelCustomListSelect
	END
GO

PRINT 'Creating Procedure ServiceLevelCustomListSelect'
GO
CREATE Procedure ServiceLevelCustomListSelect
(
		@ServiceLevelID int = null			
)
AS
/******************************************************************************
**	File: ServiceLevelCustomListSelect.sql
**	Name: ServiceLevelCustomListSelect
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
		ServiceLevelCustomList.ServiceLevelID,
		ServiceLevelCustomList.ServiceLevelListField,
		ServiceLevelCustomList.ServiceLevelListItem,
		ServiceLevelCustomList.ServiceLevelCustomListID,
		ServiceLevelCustomList.LastModified
	FROM 
		dbo.ServiceLevelCustomList 
	JOIN
		ServiceLevel ON ServiceLevel.ServiceLevelID = ServiceLevelCustomList.ServiceLevelID
	WHERE 
		ServiceLevelCustomList.ServiceLevelID = ISNULL(@ServiceLevelID, ServiceLevelCustomList.ServiceLevelID)
	
	ORDER BY 1
GO

GRANT EXEC ON ServiceLevelCustomListSelect TO PUBLIC
GO
