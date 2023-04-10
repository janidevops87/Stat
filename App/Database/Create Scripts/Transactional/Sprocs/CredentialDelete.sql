
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CredentialDelete')
			BEGIN
				PRINT 'Dropping Procedure CredentialDelete'
				DROP Procedure CredentialDelete
			END
		GO

		PRINT 'Creating Procedure CredentialDelete'
		GO

		CREATE PROCEDURE dbo.CredentialDelete
		(	
			@CredentialID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CredentialDelete.sql 
		**	Name: CredentialDelete
		**	Desc: Updates and Deletes a row of Credential, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 9/14/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/14/2009		Bret Knoll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE Credential
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CredentialID = @CredentialID
			
		DELETE 
			Credential
		WHERE
			CredentialID = @CredentialID

		GO

		GRANT EXEC ON CredentialDelete TO PUBLIC
		GO
		