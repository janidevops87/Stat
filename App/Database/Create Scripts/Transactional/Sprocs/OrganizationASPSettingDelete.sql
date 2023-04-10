
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationASPSettingDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationASPSettingDelete'
				DROP Procedure OrganizationASPSettingDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationASPSettingDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationASPSettingDelete
		(	
			@OrganizationASPSettingId int = NULL,	
			@OrganizationID int = NULL,									
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationASPSettingDelete.sql 
		**	Name: OrganizationASPSettingDelete
		**	Desc: Updates and Deletes a row of OrganizationASPSetting, updating AuditTrail
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
		IF(COALESCE(@OrganizationASPSettingId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE OrganizationASPSetting
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationASPSettingId = COALESCE( @OrganizationASPSettingId, OrganizationASPSettingId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				OrganizationASPSetting
			WHERE
				OrganizationASPSettingId = COALESCE(@OrganizationASPSettingId, OrganizationASPSettingId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationASPSettingDelete TO PUBLIC
		GO
		