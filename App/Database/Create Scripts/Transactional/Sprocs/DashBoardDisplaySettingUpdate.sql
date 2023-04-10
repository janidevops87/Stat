

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardDisplaySettingUpdate')
	BEGIN
		PRINT 'Dropping Procedure DashBoardDisplaySettingUpdate'
		DROP Procedure DashBoardDisplaySettingUpdate
	END
GO

PRINT 'Creating Procedure DashBoardDisplaySettingUpdate'
GO
CREATE Procedure DashBoardDisplaySettingUpdate
(
		@DashBoardDisplaySettingId int = null,
		@DashBoardDisplaySetting nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardDisplaySettingUpdate.sql
**	Name: DashBoardDisplaySettingUpdate
**	Desc: Updates DashBoardDisplaySetting Based on Id field 
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

UPDATE
	dbo.DashBoardDisplaySetting 	
SET 
		DashBoardDisplaySetting = @DashBoardDisplaySetting,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	DashBoardDisplaySettingId = @DashBoardDisplaySettingId 				

GO

GRANT EXEC ON DashBoardDisplaySettingUpdate TO PUBLIC
GO
