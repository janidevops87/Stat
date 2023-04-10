

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDisplaySettingUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDisplaySettingUpdate'
		DROP Procedure OrganizationDisplaySettingUpdate
	END
GO

PRINT 'Creating Procedure OrganizationDisplaySettingUpdate'
GO
CREATE Procedure OrganizationDisplaySettingUpdate
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
**	File: OrganizationDisplaySettingUpdate.sql
**	Name: OrganizationDisplaySettingUpdate
**	Desc: Updates OrganizationDisplaySetting Based on Id field 
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
	dbo.OrganizationDisplaySetting 	
SET 
		OrganizationId = @OrganizationId,
		DashBoardDisplaySettingId = @DashBoardDisplaySettingId,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	OrganizationDisplaySettingId = @OrganizationDisplaySettingId 				

GO

GRANT EXEC ON OrganizationDisplaySettingUpdate TO PUBLIC
GO
