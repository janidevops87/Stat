
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertDelete')
			BEGIN
				PRINT 'Dropping Procedure AlertDelete'
				DROP Procedure AlertDelete
			END
		GO

		PRINT 'Creating Procedure AlertDelete'
		GO

		CREATE PROCEDURE dbo.AlertDelete
		(	
			@AlertID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: AlertDelete.sql 
		**	Name: AlertDelete
		**	Desc: Updates and Deletes a row of Alert, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 1/26/2011
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	1/26/2011		Bret Knoll			Initial Sproc Creation (9376)
		*******************************************************************************/

		UPDATE Alert
		SET		
			LastModified = GetDate()

		WHERE
			AlertID = @AlertID
			
		DELETE 
			Alert
		WHERE
			AlertID = @AlertID

		GO

		GRANT EXEC ON AlertDelete TO PUBLIC
		GO
		