

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCustomListInsert')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCustomListInsert'
		DROP Procedure ServiceLevelCustomListInsert
	END
GO

PRINT 'Creating Procedure ServiceLevelCustomListInsert'
GO
CREATE Procedure ServiceLevelCustomListInsert
(
		@ServiceLevelID int = null,
		@ServiceLevelListField smallint = null,
		@ServiceLevelListItem varchar(40) = null,
		@ServiceLevelCustomListID int = null output,
		@LastModified smalldatetime = null					
)
AS
/******************************************************************************
**	File: ServiceLevelCustomListInsert.sql
**	Name: ServiceLevelCustomListInsert
**	Desc: Inserts ServiceLevelCustomList Based on Id field 
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

INSERT	ServiceLevelCustomList
	(
		ServiceLevelID,
		ServiceLevelListField,
		ServiceLevelListItem,
		LastModified
	)
VALUES
	(
		@ServiceLevelID,
		@ServiceLevelListField,
		@ServiceLevelListItem,
		@LastModified
	)

SET @ServiceLevelCustomListID = SCOPE_IDENTITY()

EXEC ServiceLevelCustomListSelect @ServiceLevelCustomListID

GO

GRANT EXEC ON ServiceLevelCustomListInsert TO PUBLIC
GO
