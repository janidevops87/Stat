
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SecurityRuleDelete')
			BEGIN
				PRINT 'Dropping Procedure SecurityRuleDelete'
				DROP Procedure SecurityRuleDelete
			END
		GO

		PRINT 'Creating Procedure SecurityRuleDelete'
		GO

		CREATE PROCEDURE dbo.SecurityRuleDelete
		(	
			@SecurityRuleID int,					
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: SecurityRuleDelete.sql 
		**	Name: SecurityRuleDelete
		**	Desc: Updates and Deletes a row of SecurityRule, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 9/4/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	9/4/2009		Bret Knoll			Initial Sproc Creation
		**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
		*******************************************************************************/

		UPDATE SecurityRule
		SET		
			LastModified = GetDate(),
			LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID ),
			AuditLogTypeID = 4 -- deleted

		WHERE
			SecurityRuleID = @SecurityRuleID
			
		DELETE 
			SecurityRule
		WHERE
			SecurityRuleID = @SecurityRuleID

		GO

		GRANT EXEC ON SecurityRuleDelete TO PUBLIC
		GO
		