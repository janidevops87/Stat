
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'MessageDelete')
			BEGIN
				PRINT 'Dropping Procedure MessageDelete'
				DROP Procedure MessageDelete
			END
		GO

		PRINT 'Creating Procedure MessageDelete'
		GO

		CREATE PROCEDURE dbo.MessageDelete
		(	
			@MessageID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: MessageDelete.sql 
		**	Name: MessageDelete
		**	Desc: Updates and Deletes a row of Message, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 1/7/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	1/7/2011		Bret Knoll			Initial Sproc Creation
		*******************************************************************************/
		DECLARE @callId int
		SELECT 	@callId  = Message.CallID FROM Message WHERE Message.MessageID = @MessageID		
		
		exec spi_CallRecycleSuspend 
			@callId = @callId,
			@callSaveLastByID = @LastStatEmployeeId

		GO

		GRANT EXEC ON MessageDelete TO PUBLIC
		GO
		