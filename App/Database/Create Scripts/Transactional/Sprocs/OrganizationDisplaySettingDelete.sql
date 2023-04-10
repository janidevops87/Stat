
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDisplaySettingDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationDisplaySettingDelete'
				DROP Procedure OrganizationDisplaySettingDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationDisplaySettingDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationDisplaySettingDelete
		(	
			@OrganizationDisplaySettingId int = NULL,					
			@OrganizationID int = NULL,						
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationDisplaySettingDelete.sql 
		**	Name: OrganizationDisplaySettingDelete
		**	Desc: Updates and Deletes a row of OrganizationDisplaySetting, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/

		IF(COALESCE(@OrganizationDisplaySettingId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE OrganizationDisplaySetting
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationDisplaySettingId = COALESCE(@OrganizationDisplaySettingId, OrganizationDisplaySettingId )
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		
			DELETE 
				OrganizationDisplaySetting
			WHERE
				OrganizationDisplaySettingId = COALESCE(@OrganizationDisplaySettingId, OrganizationDisplaySettingId )
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationDisplaySettingDelete TO PUBLIC
		GO
		