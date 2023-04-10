
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationAliasDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationAliasDelete'
				DROP Procedure OrganizationAliasDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationAliasDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationAliasDelete
		(	
			@OrganizationAliasId int = null,
			@OrganizationID int = NULL,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationAliasDelete.sql 
		**	Name: OrganizationAliasDelete
		**	Desc: Updates and Deletes a row of OrganizationAlias, updating AuditTrail
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
		IF(COALESCE(@OrganizationAliasId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE OrganizationAlias
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationAliasId = COALESCE(@OrganizationAliasId, OrganizationAliasId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				OrganizationAlias
			WHERE
				OrganizationAliasId = COALESCE(@OrganizationAliasId, OrganizationAliasId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END

		GO

		GRANT EXEC ON OrganizationAliasDelete TO PUBLIC
		GO
		