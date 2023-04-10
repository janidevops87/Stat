
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AspSourceCodeMapDelete')
			BEGIN
				PRINT 'Dropping Procedure AspSourceCodeMapDelete'
				DROP Procedure AspSourceCodeMapDelete
			END
		GO

		PRINT 'Creating Procedure AspSourceCodeMapDelete'
		GO

		CREATE PROCEDURE dbo.AspSourceCodeMapDelete
		(	
			@AspSourceCodeMapID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: AspSourceCodeMapDelete.sql 
		**	Name: AspSourceCodeMapDelete
		**	Desc: Updates and Deletes a row of AspSourceCodeMap, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/23/2009		ccarroll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE AspSourceCodeMap
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			AspSourceCodeMapID = @AspSourceCodeMapID
			
		DELETE 
			AspSourceCodeMap
		WHERE
			AspSourceCodeMapID = @AspSourceCodeMapID

		GO

		GRANT EXEC ON AspSourceCodeMapDelete TO PUBLIC
		GO
		