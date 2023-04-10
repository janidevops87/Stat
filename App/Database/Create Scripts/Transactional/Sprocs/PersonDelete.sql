
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonDelete')
			BEGIN
				PRINT 'Dropping Procedure PersonDelete'
				DROP Procedure PersonDelete
			END
		GO

		PRINT 'Creating Procedure PersonDelete'
		GO

		CREATE PROCEDURE dbo.PersonDelete
		(	
			@PersonID int = NULL,	
			@OrganizationID int = NULL,																								
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: PersonDelete.sql 
		**	Name: PersonDelete
		**	Desc: Updates and Deletes a row of Person, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/15/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@PersonID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			EXEC ContactCallInstructionDelete  @PersonID = @PersonID, @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		  
			EXEC PersonPhoneDelete  @PersonID = @PersonID, @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		  
			EXEC ContactRoleDelete @PersonID = @PersonID, @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		  
			EXEC StatEmployeeDelete  @PersonID = @PersonID, @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		  
			EXEC WebPersonDelete @PersonID = @PersonID, @OrganizationID = @OrganizationID, @LastStatEmployeeId = @LastStatEmployeeId, @LastModified = @LastModified, @AuditLogTypeId = @AuditLogTypeId		  

			UPDATE Person
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			WHERE
				PersonID = COALESCE(@PersonID, PersonID)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				Person
			WHERE
				PersonID = COALESCE(@PersonID, PersonID)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON PersonDelete TO PUBLIC
		GO
		