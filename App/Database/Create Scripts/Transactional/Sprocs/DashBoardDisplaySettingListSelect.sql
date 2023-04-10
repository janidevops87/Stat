

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardDisplaySettingListSelect')
	BEGIN
		PRINT 'Dropping Procedure DashBoardDisplaySettingListSelect'
		DROP Procedure DashBoardDisplaySettingListSelect
	END
GO

PRINT 'Creating Procedure DashBoardDisplaySettingListSelect'
GO
CREATE Procedure DashBoardDisplaySettingListSelect
(
		@DashBoardDisplaySettingId int = null					
)
AS
/******************************************************************************
**	File: DashBoardDisplaySettingListSelect.sql
**	Name: DashBoardDisplaySettingListSelect
**	Desc: Selects multiple rows of DashBoardDisplaySetting Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		DashBoardDisplaySetting.DashBoardDisplaySettingId AS ListId,
		DashBoardDisplaySetting.DashBoardDisplaySetting AS FieldValue
	FROM 
		dbo.DashBoardDisplaySetting 
	WHERE 
		DashBoardDisplaySetting.DashBoardDisplaySettingId = ISNULL(@DashBoardDisplaySettingId, DashBoardDisplaySetting.DashBoardDisplaySettingId)				
	ORDER BY 2
GO

GRANT EXEC ON DashBoardDisplaySettingListSelect TO PUBLIC
GO
