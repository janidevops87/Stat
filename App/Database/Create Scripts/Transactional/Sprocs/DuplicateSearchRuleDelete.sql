
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DuplicateSearchRuleDelete')
			BEGIN
				PRINT 'Dropping Procedure DuplicateSearchRuleDelete'
				DROP Procedure DuplicateSearchRuleDelete
			END
		GO

		PRINT 'Creating Procedure DuplicateSearchRuleDelete'
		GO

		CREATE PROCEDURE dbo.DuplicateSearchRuleDelete
		(	
			@DuplicateSearchRuleId int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: DuplicateSearchRuleDelete.sql 
		**	Name: DuplicateSearchRuleDelete
		**	Desc: Updates and Deletes a row of DuplicateSearchRule, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE DuplicateSearchRule
		SET		
			LastModified = GetDate(),
			LastStatEmployeeId = ISNULL(@LastStatEmployeeId, LastStatEmployeeId ),
			AuditLogTypeId = 4 -- deleted

		WHERE
			DuplicateSearchRuleId = @DuplicateSearchRuleId
			
		DELETE 
			DuplicateSearchRule
		WHERE
			DuplicateSearchRuleId = @DuplicateSearchRuleId

		GO

		GRANT EXEC ON DuplicateSearchRuleDelete TO PUBLIC
		GO
		