IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaProcessorDelete')
	BEGIN
		PRINT 'Dropping Procedure CriteriaProcessorDelete'
		DROP Procedure CriteriaProcessorDelete
	END
GO

PRINT 'Creating Procedure CriteriaProcessorDelete'
GO
		
		CREATE PROCEDURE [dbo].[CriteriaProcessorDelete]
		(	
			@CriteriaProcessorID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaProcessorDelete.sql 
		**	Name: CriteriaProcessorDelete
		**	Desc: Updates and Deletes a row of CriteriaProcessor, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/18/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/18/2009		ccarroll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE CriteriaProcessor
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaProcessorID = @CriteriaProcessorID
			
		DELETE 
			CriteriaProcessor
		WHERE
			CriteriaProcessorID = @CriteriaProcessorID


GO


