
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'WebPersonDelete')
			BEGIN
				PRINT 'Dropping Procedure WebPersonDelete'
				DROP Procedure WebPersonDelete
			END
		GO

		PRINT 'Creating Procedure WebPersonDelete'
		GO

		CREATE PROCEDURE dbo.WebPersonDelete
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
		**	File: WebPersonDelete.sql 
		**	Name: WebPersonDelete
		**	Desc: Updates and Deletes a row of WebPerson, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 10/29/2010
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/29/2010		Bret Knoll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@WebPersonID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0 OR COALESCE(@PersonID, 0) <> 0)
		BEGIN

			UPDATE WebPerson
			SET		
				WebPerson.LastModified = COALESCE(@LastModified, GetDate()),
				WebPerson.LastStatEmployeeId = COALESCE(@LastStatEmployeeId, WebPerson.LastStatEmployeeId ),
				WebPerson.AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			FROM WebPerson
			JOIN Person ON WebPerson.PersonID = Person.PersonID
			WHERE
				WebPersonID = COALESCE(@WebPersonID, WebPersonID)
			AND
				WebPerson.PersonID = COALESCE(@PersonID, WebPerson.PersonID)	
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID)
				
			DELETE 
				WebPerson
			FROM WebPerson
			JOIN Person ON WebPerson.PersonID = Person.PersonID
			WHERE
				WebPersonID = COALESCE(@WebPersonID, WebPersonID)
			AND
				WebPerson.PersonID = COALESCE(@PersonID, WebPerson.PersonID)	
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID)
		END
		GO

		GRANT EXEC ON WebPersonDelete TO PUBLIC
		GO
		