

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardDisplaySettingInsert')
	BEGIN
		PRINT 'Dropping Procedure DashBoardDisplaySettingInsert'
		DROP Procedure DashBoardDisplaySettingInsert
	END
GO

PRINT 'Creating Procedure DashBoardDisplaySettingInsert'
GO
CREATE Procedure DashBoardDisplaySettingInsert
(
		@DashBoardDisplaySettingId int = null,
		@DashBoardDisplaySetting nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: DashBoardDisplaySettingInsert.sql
**	Name: DashBoardDisplaySettingInsert
**	Desc: Inserts DashBoardDisplaySetting Based on Id field 
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

INSERT	DashBoardDisplaySetting
	(
		DashBoardDisplaySetting,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@DashBoardDisplaySetting,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @DashBoardDisplaySettingID = SCOPE_IDENTITY()

EXEC DashBoardDisplaySettingSelect @DashBoardDisplaySettingID

GO

GRANT EXEC ON DashBoardDisplaySettingInsert TO PUBLIC
GO
