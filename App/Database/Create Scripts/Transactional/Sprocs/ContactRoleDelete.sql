
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ContactRoleDelete')
			BEGIN
				PRINT 'Dropping Procedure ContactRoleDelete'
				DROP Procedure ContactRoleDelete
			END
		GO

		PRINT 'Creating Procedure ContactRoleDelete'
		GO

		CREATE PROCEDURE dbo.ContactRoleDelete
		(	
			@WebPersonID int = NULL,
			@PersonID int = null,
			@OrganizationID int = NULL,															
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ContactRoleDelete.sql 
		**	Name: ContactRoleDelete
		**	Desc: Updates and Deletes a row of UserRoles, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 1/18/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	1/18/2011		Bret Knoll			Initial Sproc Creation
		*******************************************************************************/
		IF(COALESCE(@WebPersonID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0 OR COALESCE(@PersonID, 0) <> 0)
		BEGIN
		
			
			UPDATE UserRoles
			SET		
				UserRoles.LastModified = COALESCE(@LastModified, GetDate()),
				UserRoles.LastStatEmployeeId = COALESCE(@LastStatEmployeeId,UserRoles.LastStatEmployeeId ),
				UserRoles.AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			FROM UserRoles
			JOIN WebPerson ON UserRoles.WebPersonID = WebPerson.WebPersonID
			JOIN Person ON WebPerson.PersonID = Person.PersonID
			WHERE
				UserRoles.WebPersonID = COALESCE(@WebPersonID, UserRoles.WebPersonID )
			AND
				Person.PersonID = 	COALESCE(@PersonID, Person.PersonID)
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID)	
				
			DELETE 
				UserRoles
			FROM UserRoles
			JOIN WebPerson ON UserRoles.WebPersonID = WebPerson.WebPersonID
			JOIN Person ON WebPerson.PersonID = Person.PersonID
			WHERE
				UserRoles.WebPersonID = COALESCE(@WebPersonID, UserRoles.WebPersonID )
			AND
				Person.PersonID = 	COALESCE(@PersonID, Person.PersonID)
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID)	
		END
		GO

		GRANT EXEC ON ContactRoleDelete TO PUBLIC
		GO
		