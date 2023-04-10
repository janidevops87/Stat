
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GenderDelete')
			BEGIN
				PRINT 'Dropping Procedure GenderDelete'
				DROP Procedure GenderDelete
			END
		GO

		PRINT 'Creating Procedure GenderDelete'
		GO

		CREATE PROCEDURE dbo.GenderDelete
		(	
			@GenderID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: GenderDelete.sql 
		**	Name: GenderDelete
		**	Desc: Updates and Deletes a row of Gender, updating AuditTrail
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

		UPDATE Gender
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			GenderID = @GenderID
			
		DELETE 
			Gender
		WHERE
			GenderID = @GenderID

		GO

		GRANT EXEC ON GenderDelete TO PUBLIC
		GO
		