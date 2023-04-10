

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationASPSettingUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationASPSettingUpdate'
		DROP Procedure OrganizationASPSettingUpdate
	END
GO

PRINT 'Creating Procedure OrganizationASPSettingUpdate'
GO
CREATE Procedure OrganizationASPSettingUpdate
(
		@OrganizationASPSettingId int = null,
		@OrganizationId int = null,
		@AspSettingTypeId int = null,
		@AspSettingType varchar(100) = null,
		@LinkToStatlinePhoneSystem bit = null,
		@AutoDisplaySourceCode bit = null,
		@AutoDisplaySourceCodeId int = null,
		@SourceCode varchar(10) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationASPSettingUpdate.sql
**	Name: OrganizationASPSettingUpdate
**	Desc: Updates OrganizationASPSetting Based on Id field 
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
	dbo.OrganizationASPSetting 	
SET 
		OrganizationId = @OrganizationId,
		AspSettingTypeId = @AspSettingTypeId,
		LinkToStatlinePhoneSystem = @LinkToStatlinePhoneSystem,
		AutoDisplaySourceCode = @AutoDisplaySourceCode,
		AutoDisplaySourceCodeId = @AutoDisplaySourceCodeId,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	OrganizationASPSettingId = @OrganizationASPSettingId 				

GO

GRANT EXEC ON OrganizationASPSettingUpdate TO PUBLIC
GO
