
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardWindowDelete')
			BEGIN
				PRINT 'Dropping Procedure DashBoardWindowDelete'
				DROP Procedure DashBoardWindowDelete
			END
		GO

		PRINT 'Creating Procedure DashBoardWindowDelete'
		GO

		CREATE PROCEDURE dbo.DashBoardWindowDelete
		(	
			@DashBoardWindowId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: DashBoardWindowDelete.sql 
		**	Name: DashBoardWindowDelete
		**	Desc: Updates and Deletes a row of DashBoardWindow, updating AuditTrail
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

		UPDATE DashBoardWindow
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			DashBoardWindowId = @DashBoardWindowId
			
		DELETE 
			DashBoardWindow
		WHERE
			DashBoardWindowId = @DashBoardWindowId

		GO

		GRANT EXEC ON DashBoardWindowDelete TO PUBLIC
		GO
		