 		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CriteriaIndicationDelete')
			BEGIN
				PRINT 'Dropping Procedure CriteriaIndicationDelete'
				DROP Procedure CriteriaIndicationDelete
			END
		GO

		PRINT 'Creating Procedure CriteriaIndicationDelete'
		GO

		CREATE PROCEDURE dbo.CriteriaIndicationDelete
		(	
			@CriteriaIndicationID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: CriteriaIndicationDelete.sql 
		**	Name: CriteriaIndicationDelete
		**	Desc: Updates and Deletes a row of CriteriaIndication, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/22/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/22/2009		ccarroll			Initial Sproc Creation
		**	07/09/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE CriteriaIndication
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			CriteriaIndicationID = @CriteriaIndicationID
			
		DELETE 
			CriteriaIndication
		WHERE
			CriteriaIndicationID = @CriteriaIndicationID

		GO

		GRANT EXEC ON CriteriaIndicationDelete TO PUBLIC
		GO
		