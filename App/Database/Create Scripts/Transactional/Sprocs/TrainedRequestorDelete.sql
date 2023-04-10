
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'TrainedRequestorDelete')
			BEGIN
				PRINT 'Dropping Procedure TrainedRequestorDelete'
				DROP Procedure TrainedRequestorDelete
			END
		GO

		PRINT 'Creating Procedure TrainedRequestorDelete'
		GO

		CREATE PROCEDURE dbo.TrainedRequestorDelete
		(	
			@TrainedRequestorID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: TrainedRequestorDelete.sql 
		**	Name: TrainedRequestorDelete
		**	Desc: Updates and Deletes a row of TrainedRequestor, updating AuditTrail
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

		UPDATE TrainedRequestor
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			TrainedRequestorID = @TrainedRequestorID
			
		DELETE 
			TrainedRequestor
		WHERE
			TrainedRequestorID = @TrainedRequestorID

		GO

		GRANT EXEC ON TrainedRequestorDelete TO PUBLIC
		GO
		