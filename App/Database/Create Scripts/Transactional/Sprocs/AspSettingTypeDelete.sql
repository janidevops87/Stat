
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AspSettingTypeDelete')
			BEGIN
				PRINT 'Dropping Procedure AspSettingTypeDelete'
				DROP Procedure AspSettingTypeDelete
			END
		GO

		PRINT 'Creating Procedure AspSettingTypeDelete'
		GO

		CREATE PROCEDURE dbo.AspSettingTypeDelete
		(	
			@AspSettingTypeId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: AspSettingTypeDelete.sql 
		**	Name: AspSettingTypeDelete
		**	Desc: Updates and Deletes a row of AspSettingType, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE AspSettingType
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			AspSettingTypeId = @AspSettingTypeId
			
		DELETE 
			AspSettingType
		WHERE
			AspSettingTypeId = @AspSettingTypeId

		GO

		GRANT EXEC ON AspSettingTypeDelete TO PUBLIC
		GO
		