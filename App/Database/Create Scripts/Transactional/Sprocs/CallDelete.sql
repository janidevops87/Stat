
		IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'callDelete')
			BEGIN
				PRINT 'Dropping Procedure callDelete'
				DROP Procedure callDelete
			END
		GO

		PRINT 'Creating Procedure callDelete'
		GO

		CREATE PROCEDURE dbo.callDelete
		(	
			@CallID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: callDelete.sql 
		**	Name: callDelete
		**	Desc: Updates and Deletes a row of call, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 12/14/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/14/2009		Bret Knoll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE call
		SET		
			LastModified = GetDate(),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CallID = @CallID
			
		DELETE 
			call
		WHERE
			CallID = @CallID

		GO

		GRANT EXEC ON callDelete TO PUBLIC
		GO
		