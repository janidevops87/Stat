
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDuplicateSearchRuleDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationDuplicateSearchRuleDelete'
				DROP Procedure OrganizationDuplicateSearchRuleDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationDuplicateSearchRuleDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationDuplicateSearchRuleDelete
		(	
			@OrganizationDuplicateSearchRuleId int = NULL,		
			@OrganizationID int = NULL,									
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationDuplicateSearchRuleDelete.sql 
		**	Name: OrganizationDuplicateSearchRuleDelete
		**	Desc: Updates and Deletes a row of OrganizationDuplicateSearchRule, updating AuditTrail
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		**	Called By: 
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:				Description:
		**	--------		--------			----------------------------------
		**	7/13/2009		Bret Knoll			Initial Sproc Creation
		**  01/18/2011		Bret Knoll			Updated to handle cascade delete from Organization
		*******************************************************************************/
		IF(COALESCE(@OrganizationDuplicateSearchRuleId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN


			UPDATE OrganizationDuplicateSearchRule
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationDuplicateSearchRuleId = COALESCE(@OrganizationDuplicateSearchRuleId, OrganizationDuplicateSearchRuleId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				OrganizationDuplicateSearchRule
			WHERE
				OrganizationDuplicateSearchRuleId = COALESCE(@OrganizationDuplicateSearchRuleId, OrganizationDuplicateSearchRuleId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationDuplicateSearchRuleDelete TO PUBLIC
		GO
		