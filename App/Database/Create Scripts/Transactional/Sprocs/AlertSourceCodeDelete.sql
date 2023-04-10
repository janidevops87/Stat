
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AlertSourceCodeDelete')
			BEGIN
				PRINT 'Dropping Procedure AlertSourceCodeDelete'
				DROP Procedure AlertSourceCodeDelete
			END
		GO

		PRINT 'Creating Procedure AlertSourceCodeDelete'
		GO

		CREATE PROCEDURE dbo.AlertSourceCodeDelete
		(	
			@AlertSourceCodeID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: AlertSourceCodeDelete.sql 
		**	Name: AlertSourceCodeDelete
		**	Desc: Updates and Deletes a row of AlertSourceCode, updating AuditTrail
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

		UPDATE AlertSourceCode
		SET		
			LastModified = GetDate()

		WHERE
			AlertSourceCodeID = @AlertSourceCodeID
			
		DELETE 
			AlertSourceCode
		WHERE
			AlertSourceCodeID = @AlertSourceCodeID

		GO

		GRANT EXEC ON AlertSourceCodeDelete TO PUBLIC
		GO
		