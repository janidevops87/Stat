
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationFsSourceCodeDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationFsSourceCodeDelete'
				DROP Procedure OrganizationFsSourceCodeDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationFsSourceCodeDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationFsSourceCodeDelete
		(	
			@OrganizationFsSourceCodeId int = NULL,					
			@OrganizationID int = NULL,									
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationFsSourceCodeDelete.sql 
		**	Name: OrganizationFsSourceCodeDelete
		**	Desc: Updates and Deletes a row of OrganizationFsSourceCode, updating AuditTrail
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
		IF(COALESCE(@OrganizationFsSourceCodeId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE OrganizationFsSourceCode
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationFsSourceCodeId = COALESCE(@OrganizationFsSourceCodeId, OrganizationFsSourceCodeId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				OrganizationFsSourceCode
			WHERE
				OrganizationFsSourceCodeId = COALESCE(@OrganizationFsSourceCodeId, OrganizationFsSourceCodeId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationFsSourceCodeDelete TO PUBLIC
		GO
		