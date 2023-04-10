
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'FieldDelete')
			BEGIN
				PRINT 'Dropping Procedure FieldDelete'
				DROP Procedure FieldDelete
			END
		GO

		PRINT 'Creating Procedure FieldDelete'
		GO

		CREATE PROCEDURE dbo.FieldDelete
		(	
			@FieldID int = null,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: FieldDelete.sql 
		**	Name: FieldDelete
		**	Desc: Updates and Deletes a row of Field, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 12/7/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/7/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE Field
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			FieldID = @FieldID
			
		DELETE 
			Field
		WHERE
			FieldID = @FieldID

		GO

		GRANT EXEC ON FieldDelete TO PUBLIC
		GO
		