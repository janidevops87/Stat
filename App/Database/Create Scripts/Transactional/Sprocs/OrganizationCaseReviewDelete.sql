
		IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationCaseReviewDelete')
			BEGIN
				PRINT 'Dropping Procedure OrganizationCaseReviewDelete'
				DROP Procedure OrganizationCaseReviewDelete
			END
		GO

		PRINT 'Creating Procedure OrganizationCaseReviewDelete'
		GO

		CREATE PROCEDURE dbo.OrganizationCaseReviewDelete
		(	
			@OrganizationCaseReviewId int = NULL,					
			@OrganizationID int = NULL,			
			@LastStatEmployeeId int = null,
			@LastModified datetime = null,
			@AuditLogTypeId int = null
		)
		AS
		/******************************************************************************
		**	File: OrganizationCaseReviewDelete.sql 
		**	Name: OrganizationCaseReviewDelete
		**	Desc: Updates and Deletes a row of OrganizationCaseReview, updating AuditTrail
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
		IF(COALESCE(@OrganizationCaseReviewId, 0) <> 0 OR COALESCE(@OrganizationID, 0) <> 0)
		BEGIN

			UPDATE OrganizationCaseReview
			SET		
				LastModified = COALESCE(@LastModified, GetDate()),
				LastStatEmployeeId = COALESCE(@LastStatEmployeeId, LastStatEmployeeId ),
				AuditLogTypeId = COALESCE(@AuditLogTypeId, 4) -- deleted

			WHERE
				OrganizationCaseReviewId = COALESCE(@OrganizationCaseReviewId, OrganizationCaseReviewId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
				
			DELETE 
				OrganizationCaseReview
			WHERE
				OrganizationCaseReviewId = COALESCE(@OrganizationCaseReviewId, OrganizationCaseReviewId)
			AND
				OrganizationId = COALESCE(@OrganizationID, OrganizationId)
		END
		GO

		GRANT EXEC ON OrganizationCaseReviewDelete TO PUBLIC
		GO
		