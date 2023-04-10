
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'ContactCallInstructionDelete')
			BEGIN
				PRINT 'Dropping Procedure ContactCallInstructionDelete'
				DROP Procedure ContactCallInstructionDelete
			END
		GO

		PRINT 'Creating Procedure ContactCallInstructionDelete'
		GO

		CREATE PROCEDURE dbo.ContactCallInstructionDelete
		(	
			@ContactCallInstructionID int = NULL,	
			@PersonID int = null,
			@OrganizationID int = NULL,															
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: ContactCallInstructionDelete.sql 
		**	Name: ContactCallInstructionDelete
		**	Desc: Updates and Deletes a row of ContactCallInstruction, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 9/18/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/18/2009		Bret Knoll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@ContactCallInstructionID, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0 OR COALESCE(@PersonID, 0) <> 0)
		BEGIN

			UPDATE ContactCallInstruction
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				--LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted
			FROM ContactCallInstruction
			JOIN PersonPhone ON ContactCallInstruction.PersonPhoneID = PersonPhone.PersonPhoneID
			JOIN Person ON PersonPhone.PersonID = Person.PersonID
			WHERE
				ContactCallInstructionID = COALESCE(@ContactCallInstructionID, ContactCallInstructionID )
			AND
				PersonPhone.PersonID = COALESCE(@PersonID, PersonPhone.PersonID)
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, OrganizationID)

		
			DELETE 
				ContactCallInstruction
			FROM ContactCallInstruction
			JOIN PersonPhone ON ContactCallInstruction.PersonPhoneID = PersonPhone.PersonPhoneID
			JOIN Person ON PersonPhone.PersonID = Person.PersonID
			WHERE
				ContactCallInstructionID = COALESCE(@ContactCallInstructionID, ContactCallInstructionID )
			AND
				PersonPhone.PersonID = COALESCE(@PersonID, PersonPhone.PersonID)
			AND
				Person.OrganizationID = COALESCE(@OrganizationID, OrganizationID)
		END
		GO

		GRANT EXEC ON ContactCallInstructionDelete TO PUBLIC
		GO
		