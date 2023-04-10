
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeOrganizationDelete')
			BEGIN
				PRINT 'Dropping Procedure SourceCodeOrganizationDelete'
				DROP Procedure SourceCodeOrganizationDelete
			END
		GO

		PRINT 'Creating Procedure SourceCodeOrganizationDelete'
		GO

		CREATE PROCEDURE dbo.SourceCodeOrganizationDelete
		(	
			@SourceCodeOrganizationID int = NULL,
			@OrganizationID int = NULL,																	
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: SourceCodeOrganizationDelete.sql 
		**	Name: SourceCodeOrganizationDelete
		**	Desc: Updates and Deletes a row of SourceCodeOrganization, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/23/2009		ccarroll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@SourceCodeOrganizationID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE SourceCodeOrganization
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			WHERE
				SourceCodeOrganizationID = COALESCE(@SourceCodeOrganizationID, SourceCodeOrganizationID )
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
				
			DELETE 
				SourceCodeOrganization
			WHERE
				SourceCodeOrganizationID = COALESCE(@SourceCodeOrganizationID, SourceCodeOrganizationID )
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON SourceCodeOrganizationDelete TO PUBLIC
		GO
		