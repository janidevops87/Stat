

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AspSettingTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure AspSettingTypeSelect'
		DROP Procedure AspSettingTypeSelect
	END
GO

PRINT 'Creating Procedure AspSettingTypeSelect'
GO
CREATE Procedure AspSettingTypeSelect
(
		@AspSettingTypeId int = null					
)
AS
/******************************************************************************
**	File: AspSettingTypeSelect.sql
**	Name: AspSettingTypeSelect
**	Desc: Selects multiple rows of AspSettingType Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		AspSettingType.AspSettingTypeId,
		AspSettingType.AspSettingType,
		AspSettingType.LastModified,
		AspSettingType.LastStatEmployeeId,
		AspSettingType.AuditLogTypeId
	FROM 
		dbo.AspSettingType 
	WHERE 
		AspSettingType.AspSettingTypeId = ISNULL(@AspSettingTypeId, AspSettingTypeId)				
	ORDER BY 1
GO

GRANT EXEC ON AspSettingTypeSelect TO PUBLIC
GO
