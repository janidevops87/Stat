

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDisplaySettingInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDisplaySettingInsert'
		DROP Procedure OrganizationDisplaySettingInsert
	END
GO

PRINT 'Creating Procedure OrganizationDisplaySettingInsert'
GO
CREATE Procedure OrganizationDisplaySettingInsert
(
		@OrganizationDisplaySettingId int = null,
		@OrganizationId int = null,
		@DashBoardDisplaySettingId int = null,
		@DashBoardDisplaySetting varchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null						
)
AS
/******************************************************************************
**	File: OrganizationDisplaySettingInsert.sql
**	Name: OrganizationDisplaySettingInsert
**	Desc: Inserts OrganizationDisplaySetting Based on Id field 
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

INSERT	OrganizationDisplaySetting
	(
		OrganizationId,
		DashBoardDisplaySettingId,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@DashBoardDisplaySettingId,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @OrganizationDisplaySettingID = SCOPE_IDENTITY()

EXEC OrganizationDisplaySettingSelect @OrganizationDisplaySettingID

GO

GRANT EXEC ON OrganizationDisplaySettingInsert TO PUBLIC
GO
