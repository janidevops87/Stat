

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationASPSettingSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationASPSettingSelect'
		DROP Procedure OrganizationASPSettingSelect
	END
GO

PRINT 'Creating Procedure OrganizationASPSettingSelect'
GO
CREATE Procedure OrganizationASPSettingSelect
(
		@OrganizationASPSettingId int = null,
		@OrganizationId int = null
)
AS
/******************************************************************************
**	File: OrganizationASPSettingSelect.sql
**	Name: OrganizationASPSettingSelect
**	Desc: Selects multiple rows of OrganizationASPSetting Based on Id  fields 
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
		OrganizationASPSetting.OrganizationASPSettingId,
		OrganizationASPSetting.OrganizationId,
		OrganizationASPSetting.AspSettingTypeId,
		AspSettingType AS AspSettingType,
		OrganizationASPSetting.LinkToStatlinePhoneSystem,
		OrganizationASPSetting.AutoDisplaySourceCode,
		OrganizationASPSetting.AutoDisplaySourceCodeId,
		SourceCodeName AS SourceCode,
		OrganizationASPSetting.LastModified,
		OrganizationASPSetting.LastStatEmployeeId,
		OrganizationASPSetting.AuditLogTypeId
	FROM 
		dbo.OrganizationASPSetting 
	LEFT JOIN
		AspSettingType ON AspSettingType.AspSettingTypeId = OrganizationASPSetting.AspSettingTypeId
	LEFT JOIN
		SourceCode ON SourceCode.SourceCodeId = OrganizationASPSetting.AutoDisplaySourceCodeId	
	WHERE 
		OrganizationASPSetting.OrganizationASPSettingId = ISNULL(@OrganizationASPSettingId, OrganizationASPSetting.OrganizationASPSettingId)
	AND
		OrganizationASPSetting.OrganizationId = ISNULL(@OrganizationId, OrganizationASPSetting.OrganizationId)
	ORDER BY 1
GO

GRANT EXEC ON OrganizationASPSettingSelect TO PUBLIC
GO
