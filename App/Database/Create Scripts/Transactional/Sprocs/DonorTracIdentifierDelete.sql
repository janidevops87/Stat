
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracIdentifierDelete')
			BEGIN
				PRINT 'Dropping Procedure DonorTracIdentifierDelete'
				DROP Procedure DonorTracIdentifierDelete
			END
		GO

		PRINT 'Creating Procedure DonorTracIdentifierDelete'
		GO

		CREATE PROCEDURE dbo.DonorTracIdentifierDelete
		(	
			@DonorTracIdentifierID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: DonorTracIdentifierDelete.sql 
		**	Name: DonorTracIdentifierDelete
		**	Desc: Updates and Deletes a row of DonorTracIdentifier, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 10/23/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	10/23/2009		ccarroll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE DonorTracIdentifier
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			DonorTracIdentifierID = @DonorTracIdentifierID
			
		DELETE 
			DonorTracIdentifier
		WHERE
			DonorTracIdentifierID = @DonorTracIdentifierID

		GO

		GRANT EXEC ON DonorTracIdentifierDelete TO PUBLIC
		GO
		