
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'EmailTypeDelete')
			BEGIN
				PRINT 'Dropping Procedure EmailTypeDelete'
				DROP Procedure EmailTypeDelete
			END
		GO

		PRINT 'Creating Procedure EmailTypeDelete'
		GO

		CREATE PROCEDURE dbo.EmailTypeDelete
		(	
			@EmailTypeID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: EmailTypeDelete.sql 
		**	Name: EmailTypeDelete
		**	Desc: Updates and Deletes a row of EmailType, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/6/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE EmailType
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			EmailTypeID = @EmailTypeID
			
		DELETE 
			EmailType
		WHERE
			EmailTypeID = @EmailTypeID

		GO

		GRANT EXEC ON EmailTypeDelete TO PUBLIC
		GO
		