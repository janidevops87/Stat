 

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ServiceLevelCallTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure ServiceLevelCallTypeListSelect'
		DROP Procedure ServiceLevelCallTypeListSelect
	END
GO

PRINT 'Creating Procedure ServiceLevelCallTypeListSelect'
GO
CREATE Procedure ServiceLevelCallTypeListSelect
(
		@ServiceLevelID int = null output,
		@CallTypeID int = Null
				
)
AS
/******************************************************************************
**	File: ServiceLevelCallTypeListSelect.sql
**	Name: ServiceLevelCallTypeListSelect
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
	AND	ServiceLevel.ServiceLevelTriageLevel = ISNULL(@CallTypeID, ServiceLevel.ServiceLevelTriageLevel)
	AND ServiceLevelStatus = 0				
	ORDER BY 2
GO

GRANT EXEC ON ServiceLevelCallTypeListSelect TO PUBLIC
GO
