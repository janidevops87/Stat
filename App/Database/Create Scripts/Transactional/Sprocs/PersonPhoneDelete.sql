
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonPhoneDelete')
			BEGIN
				PRINT 'Dropping Procedure PersonPhoneDelete'
				DROP Procedure PersonPhoneDelete
			END
		GO

		PRINT 'Creating Procedure PersonPhoneDelete'
		GO

		CREATE PROCEDURE dbo.PersonPhoneDelete
		(	
			@PersonPhoneID int = null,
			@PersonID int = null,
			@OrganizationID int = NULL,															
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: PersonPhoneDelete.sql 
		**	Name: PersonPhoneDelete
		**	Desc: Updates and Deletes a row of PersonPhone, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/6/2009		Bret Knoll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@PersonPhoneID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0 OR COALESCE(@PersonID, 0) <> 0)
		BEGIN

			UPDATE PersonPhone
			SET		
				PersonPhone.LastModified = COALESCE(@LastModified, GetDate()),
				PersonPhone.LastStatEmployeeId = COALESCE(@LastStatEmployeeId, PersonPhone.LastStatEmployeeId ),
				PersonPhone.AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			FROM PersonPhone
			JOIN Person ON PersonPhone.PersonID = Person.PersonID
			WHERE
				PersonPhoneID = COALESCE(@PersonPhoneID, PersonPhoneID)
			AND
				PersonPhone.PersonID = COALESCE(@PersonID, PersonPhone.PersonID)	
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID )	
				
			DELETE 
				PersonPhone
			FROM PersonPhone
			JOIN Person ON PersonPhone.PersonID = Person.PersonID
			WHERE
				PersonPhoneID = COALESCE(@PersonPhoneID, PersonPhoneID)
			AND
				PersonPhone.PersonID = COALESCE(@PersonID, PersonPhone.PersonID)	
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, Person.OrganizationID )	
		END
		GO

		GRANT EXEC ON PersonPhoneDelete TO PUBLIC
		GO
		