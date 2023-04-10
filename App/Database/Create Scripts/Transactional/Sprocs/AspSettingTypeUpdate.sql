

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AspSettingTypeUpdate')
	BEGIN
		PRINT 'Dropping Procedure AspSettingTypeUpdate'
		DROP Procedure AspSettingTypeUpdate
	END
GO

PRINT 'Creating Procedure AspSettingTypeUpdate'
GO
CREATE Procedure AspSettingTypeUpdate
(
		@AspSettingTypeId int = null,
		@AspSettingType nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: AspSettingTypeUpdate.sql
**	Name: AspSettingTypeUpdate
**	Desc: Updates AspSettingType Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.AspSettingType 	
SET 
		AspSettingType = @AspSettingType,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	AspSettingTypeId = @AspSettingTypeId 				

GO

GRANT EXEC ON AspSettingTypeUpdate TO PUBLIC
GO
