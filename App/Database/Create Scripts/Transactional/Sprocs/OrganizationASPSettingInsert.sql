

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationASPSettingInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationASPSettingInsert'
		DROP Procedure OrganizationASPSettingInsert
	END
GO

PRINT 'Creating Procedure OrganizationASPSettingInsert'
GO
CREATE Procedure OrganizationASPSettingInsert
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
**	File: OrganizationASPSettingInsert.sql
**	Name: OrganizationASPSettingInsert
**	Desc: Inserts OrganizationASPSetting Based on Id field 
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

INSERT	OrganizationASPSetting
	(
		OrganizationId,
		AspSettingTypeId,
		LinkToStatlinePhoneSystem,
		AutoDisplaySourceCode,
		AutoDisplaySourceCodeId,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@AspSettingTypeId,
		@LinkToStatlinePhoneSystem,
		@AutoDisplaySourceCode,
		@AutoDisplaySourceCodeId,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @OrganizationASPSettingID = SCOPE_IDENTITY()

EXEC OrganizationASPSettingSelect @OrganizationASPSettingID

GO

GRANT EXEC ON OrganizationASPSettingInsert TO PUBLIC
GO
