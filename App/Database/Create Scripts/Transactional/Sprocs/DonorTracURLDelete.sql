
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DonorTracURLDelete')
			BEGIN
				PRINT 'Dropping Procedure DonorTracURLDelete'
				DROP Procedure DonorTracURLDelete
			END
		GO

		PRINT 'Creating Procedure DonorTracURLDelete'
		GO

		CREATE PROCEDURE dbo.DonorTracURLDelete
		(	
			@DonorTracURLID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: DonorTracURLDelete.sql 
		**	Name: DonorTracURLDelete
		**	Desc: Updates and Deletes a row of DonorTracURL, updating AuditTrail
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

		UPDATE DonorTracURL
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			DonorTracURLID = @DonorTracURLID
			
		DELETE 
			DonorTracURL
		WHERE
			DonorTracURLID = @DonorTracURLID

		GO

		GRANT EXEC ON DonorTracURLDelete TO PUBLIC
		GO
		