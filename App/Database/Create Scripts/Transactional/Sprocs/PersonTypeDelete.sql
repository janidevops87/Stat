
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PersonTypeDelete')
			BEGIN
				PRINT 'Dropping Procedure PersonTypeDelete'
				DROP Procedure PersonTypeDelete
			END
		GO

		PRINT 'Creating Procedure PersonTypeDelete'
		GO

		CREATE PROCEDURE dbo.PersonTypeDelete
		(	
			@PersonTypeID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: PersonTypeDelete.sql 
		**	Name: PersonTypeDelete
		**	Desc: Updates and Deletes a row of PersonType, updating AuditTrail
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
		*******************************************************************************/

		UPDATE PersonType
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			PersonTypeID = @PersonTypeID
			
		DELETE 
			PersonType
		WHERE
			PersonTypeID = @PersonTypeID

		GO

		GRANT EXEC ON PersonTypeDelete TO PUBLIC
		GO
		