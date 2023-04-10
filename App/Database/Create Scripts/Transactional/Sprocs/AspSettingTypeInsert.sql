

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'AspSettingTypeInsert')
	BEGIN
		PRINT 'Dropping Procedure AspSettingTypeInsert'
		DROP Procedure AspSettingTypeInsert
	END
GO

PRINT 'Creating Procedure AspSettingTypeInsert'
GO
CREATE Procedure AspSettingTypeInsert
(
		@AspSettingTypeId int = null,
		@AspSettingType nvarchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: AspSettingTypeInsert.sql
**	Name: AspSettingTypeInsert
**	Desc: Inserts AspSettingType Based on Id field 
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

INSERT	AspSettingType
	(
		AspSettingType,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@AspSettingType,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @AspSettingTypeID = SCOPE_IDENTITY()

EXEC AspSettingTypeSelect @AspSettingTypeID

GO

GRANT EXEC ON AspSettingTypeInsert TO PUBLIC
GO
