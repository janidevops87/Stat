

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AspSettingTypeListSelect')
	BEGIN
		PRINT 'Dropping Procedure AspSettingTypeListSelect'
		DROP Procedure AspSettingTypeListSelect
	END
GO

PRINT 'Creating Procedure AspSettingTypeListSelect'
GO
CREATE Procedure AspSettingTypeListSelect
(
		@AspSettingTypeId int = null					
)
AS
/******************************************************************************
**	File: AspSettingTypeListSelect.sql
**	Name: AspSettingTypeListSelect
**	Desc: Selects multiple rows of AspSettingType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AspSettingType.AspSettingTypeId AS ListId,
		AspSettingType.AspSettingType AS FieldValue
	FROM 
		dbo.AspSettingType 
	WHERE 
		AspSettingType.AspSettingTypeId = ISNULL(@AspSettingTypeId, AspSettingType.AspSettingTypeId)				
	ORDER BY 2
GO

GRANT EXEC ON AspSettingTypeListSelect TO PUBLIC
GO
