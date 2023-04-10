
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaSourceCodeDelete')
			BEGIN
				PRINT 'Dropping Procedure CriteriaSourceCodeDelete'
				DROP Procedure CriteriaSourceCodeDelete
			END
		GO

		PRINT 'Creating Procedure CriteriaSourceCodeDelete'
		GO

		CREATE PROCEDURE dbo.CriteriaSourceCodeDelete
		(	
			@CriteriaSourceCodeID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaSourceCodeDelete.sql 
		**	Name: CriteriaSourceCodeDelete
		**	Desc: Updates and Deletes a row of CriteriaSourceCode, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/21/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/21/2009		ccarroll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE CriteriaSourceCode
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaSourceCodeID = @CriteriaSourceCodeID
			
		DELETE 
			CriteriaSourceCode
		WHERE
			CriteriaSourceCodeID = @CriteriaSourceCodeID

		GO

		GRANT EXEC ON CriteriaSourceCodeDelete TO PUBLIC
		GO
		