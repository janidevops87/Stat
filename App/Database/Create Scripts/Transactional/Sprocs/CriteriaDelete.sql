 
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaDelete')
			BEGIN
				PRINT 'Dropping Procedure CriteriaDelete'
				DROP Procedure CriteriaDelete
			END
		GO

		PRINT 'Creating Procedure CriteriaDelete'
		GO

		CREATE PROCEDURE dbo.CriteriaDelete
		(	
			@CriteriaID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaDelete.sql 
		**	Name: CriteriaDelete
		**	Desc: Updates and Deletes a row of Criteria, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/17/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/17/2009		ccarroll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE Criteria
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaID = @CriteriaID
			
		DELETE 
			Criteria
		WHERE
			CriteriaID = @CriteriaID

		GO

		GRANT EXEC ON CriteriaDelete TO PUBLIC
		GO
		