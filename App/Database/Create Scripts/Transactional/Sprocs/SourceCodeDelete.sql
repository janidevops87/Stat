
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SourceCodeDelete')
			BEGIN
				PRINT 'Dropping Procedure SourceCodeDelete'
				DROP Procedure SourceCodeDelete
			END
		GO

		PRINT 'Creating Procedure SourceCodeDelete'
		GO

		CREATE PROCEDURE dbo.SourceCodeDelete
		(	
			@SourceCodeID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: SourceCodeDelete.sql 
		**	Name: SourceCodeDelete
		**	Desc: Updates and Deletes a row of SourceCode, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/23/2009		ccarroll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE SourceCode
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			SourceCodeID = @SourceCodeID
			
		DELETE 
			SourceCode
		WHERE
			SourceCodeID = @SourceCodeID

		GO

		GRANT EXEC ON SourceCodeDelete TO PUBLIC
		GO
		