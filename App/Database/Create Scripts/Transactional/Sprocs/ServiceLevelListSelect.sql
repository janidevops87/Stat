

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelListSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelListSelect'
		DROP Procedure ServiceLevelListSelect
	END
GO

PRINT 'Creating Procedure ServiceLevelListSelect'
GO
CREATE Procedure ServiceLevelListSelect
(
		@ServiceLevelID int = null output
				
)
AS
/******************************************************************************
**	File: ServiceLevelListSelect.sql
**	Name: ServiceLevelListSelect
**	Desc: Selects multiple rows of ServiceLevel Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		ServiceLevel.ServiceLevelID AS ListId,
		ServiceLevelGroupName AS FieldValue
	FROM 
		dbo.ServiceLevel 
	WHERE 
		ServiceLevel.ServiceLevelID = ISNULL(@ServiceLevelID, ServiceLevel.ServiceLevelID)
	
	and ServiceLevelStatus = 0				
	ORDER BY 2
GO

GRANT EXEC ON ServiceLevelListSelect TO PUBLIC
GO
