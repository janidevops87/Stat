
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'PagerTypeDelete')
			BEGIN
				PRINT 'Dropping Procedure PagerTypeDelete'
				DROP Procedure PagerTypeDelete
			END
		GO

		PRINT 'Creating Procedure PagerTypeDelete'
		GO

		CREATE PROCEDURE dbo.PagerTypeDelete
		(	
			@PagerTypeID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: PagerTypeDelete.sql 
		**	Name: PagerTypeDelete
		**	Desc: Updates and Deletes a row of PagerType, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/6/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE PagerType
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			PagerTypeID = @PagerTypeID
			
		DELETE 
			PagerType
		WHERE
			PagerTypeID = @PagerTypeID

		GO

		GRANT EXEC ON PagerTypeDelete TO PUBLIC
		GO
		