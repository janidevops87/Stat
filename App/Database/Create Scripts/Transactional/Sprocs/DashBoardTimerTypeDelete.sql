
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashBoardTimerTypeDelete')
			BEGIN
				PRINT 'Dropping Procedure DashBoardTimerTypeDelete'
				DROP Procedure DashBoardTimerTypeDelete
			END
		GO

		PRINT 'Creating Procedure DashBoardTimerTypeDelete'
		GO

		CREATE PROCEDURE dbo.DashBoardTimerTypeDelete
		(	
			@DashBoardTimerTypeId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: DashBoardTimerTypeDelete.sql 
		**	Name: DashBoardTimerTypeDelete
		**	Desc: Updates and Deletes a row of DashBoardTimerType, updating AuditTrail
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

		UPDATE DashBoardTimerType
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			DashBoardTimerTypeId = @DashBoardTimerTypeId
			
		DELETE 
			DashBoardTimerType
		WHERE
			DashBoardTimerTypeId = @DashBoardTimerTypeId

		GO

		GRANT EXEC ON DashBoardTimerTypeDelete TO PUBLIC
		GO
		