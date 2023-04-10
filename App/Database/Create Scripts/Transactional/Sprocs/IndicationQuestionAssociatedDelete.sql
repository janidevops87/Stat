
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'IndicationQuestionAssociatedDelete')
			BEGIN
				PRINT 'Dropping Procedure IndicationQuestionAssociatedDelete'
				DROP Procedure IndicationQuestionAssociatedDelete
			END
		GO

		PRINT 'Creating Procedure IndicationQuestionAssociatedDelete'
		GO

		CREATE PROCEDURE dbo.IndicationQuestionAssociatedDelete
		(	
			@IndicationQuestionAssociatedID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: IndicationQuestionAssociatedDelete.sql 
		**	Name: IndicationQuestionAssociatedDelete
		**	Desc: Updates and Deletes a row of IndicationQuestionAssociated, updating AuditTrail
		**	Auth: ccarroll
		**	Date: 12/03/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	12/03/2009		ccarroll	 		Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE IndicationQuestionAssociated
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			IndicationQuestionAssociatedID = @IndicationQuestionAssociatedID
			
		DELETE 
			IndicationQuestionAssociated
		WHERE
			IndicationQuestionAssociatedID = @IndicationQuestionAssociatedID

		GO

		GRANT EXEC ON IndicationQuestionAssociatedDelete TO PUBLIC
		GO
		