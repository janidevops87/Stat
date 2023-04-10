

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardDisplaySettingSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardDisplaySettingSelect'
		DROP Procedure DashBoardDisplaySettingSelect
	END
GO

PRINT 'Creating Procedure DashBoardDisplaySettingSelect'
GO
CREATE Procedure DashBoardDisplaySettingSelect
(
		@DashBoardDisplaySettingId int = null					
)
AS
/******************************************************************************
**	File: DashBoardDisplaySettingSelect.sql
**	Name: DashBoardDisplaySettingSelect
**	Desc: Selects multiple rows of DashBoardDisplaySetting Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DashBoardDisplaySetting.DashBoardDisplaySettingId,
		DashBoardDisplaySetting.DashBoardDisplaySetting,
		DashBoardDisplaySetting.LastModified,
		DashBoardDisplaySetting.LastStatEmployeeId,
		DashBoardDisplaySetting.AuditLogTypeId
	FROM 
		dbo.DashBoardDisplaySetting 
	WHERE 
		DashBoardDisplaySetting.DashBoardDisplaySettingId = ISNULL(@DashBoardDisplaySettingId, DashBoardDisplaySettingId)				
	ORDER BY 1
GO

GRANT EXEC ON DashBoardDisplaySettingSelect TO PUBLIC
GO
