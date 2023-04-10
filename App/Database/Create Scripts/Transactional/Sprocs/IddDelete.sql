
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IddDelete')
			BEGIN
				PRINT 'Dropping Procedure IddDelete'
				DROP Procedure IddDelete
			END
		GO

		PRINT 'Creating Procedure IddDelete'
		GO

		CREATE PROCEDURE dbo.IddDelete
		(	
			@IddId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: IddDelete.sql 
		**	Name: IddDelete
		**	Desc: Updates and Deletes a row of Idd, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE Idd
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			IddId = @IddId
			
		DELETE 
			Idd
		WHERE
			IddId = @IddId

		GO

		GRANT EXEC ON IddDelete TO PUBLIC
		GO
		