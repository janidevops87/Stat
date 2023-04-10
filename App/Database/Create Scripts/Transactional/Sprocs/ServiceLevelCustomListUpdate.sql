

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomListUpdate')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCustomListUpdate'
		DROP Procedure ServiceLevelCustomListUpdate
	END
GO

PRINT 'Creating Procedure ServiceLevelCustomListUpdate'
GO
CREATE Procedure ServiceLevelCustomListUpdate
(
		@ServiceLevelID int = null,
		@ServiceLevelListField smallint = null,
		@ServiceLevelListItem varchar(40) = null,
		@ServiceLevelCustomListID int = null output,
		@LastModified smalldatetime = null					
)
AS
/******************************************************************************
**	File: ServiceLevelCustomListUpdate.sql
**	Name: ServiceLevelCustomListUpdate
**	Desc: Updates ServiceLevelCustomList Based on Id field 
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

UPDATE
	dbo.ServiceLevelCustomList 	
SET 
		ServiceLevelID = @ServiceLevelID,
		ServiceLevelListField = @ServiceLevelListField,
		ServiceLevelListItem = @ServiceLevelListItem,
		LastModified = GetDate()
WHERE 
	ServiceLevelCustomListID = @ServiceLevelCustomListID 				

GO

GRANT EXEC ON ServiceLevelCustomListUpdate TO PUBLIC
GO
