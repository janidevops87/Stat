

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationCaseReviewUpdate')
	BEGIN
		PRINT 'Dropping Procedure OrganizationCaseReviewUpdate'
		DROP Procedure OrganizationCaseReviewUpdate
	END
GO

PRINT 'Creating Procedure OrganizationCaseReviewUpdate'
GO
CREATE Procedure OrganizationCaseReviewUpdate
(
		@OrganizationCaseReviewId int = null,
		@OrganizationId int = null,
		@CaseTypeId int = null,
		@CaseType varchar(100) = null,
		@CaseReviewPercentage int = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationCaseReviewUpdate.sql
**	Name: OrganizationCaseReviewUpdate
**	Desc: Updates OrganizationCaseReview Based on Id field 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/

UPDATE
	dbo.OrganizationCaseReview 	
SET 
		OrganizationId = @OrganizationId,
		CaseTypeId = @CaseTypeId,
		CaseReviewPercentage = @CaseReviewPercentage,
		LastModified = GetDate(),
		LastStatEmployeeId = @LastStatEmployeeId,
		AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify
WHERE 
	OrganizationCaseReviewId = @OrganizationCaseReviewId 				

GO

GRANT EXEC ON OrganizationCaseReviewUpdate TO PUBLIC
GO
