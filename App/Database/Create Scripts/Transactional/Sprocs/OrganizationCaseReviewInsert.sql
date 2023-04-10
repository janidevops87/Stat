

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationCaseReviewInsert')
	BEGIN
		PRINT 'Dropping Procedure OrganizationCaseReviewInsert'
		DROP Procedure OrganizationCaseReviewInsert
	END
GO

PRINT 'Creating Procedure OrganizationCaseReviewInsert'
GO
CREATE Procedure OrganizationCaseReviewInsert
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
**	File: OrganizationCaseReviewInsert.sql
**	Name: OrganizationCaseReviewInsert
**	Desc: Inserts OrganizationCaseReview Based on Id field 
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

INSERT	OrganizationCaseReview
	(
		OrganizationId,
		CaseTypeId,
		CaseReviewPercentage,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
VALUES
	(
		@OrganizationId,
		@CaseTypeId,
		@CaseReviewPercentage,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	)

SET @OrganizationCaseReviewID = SCOPE_IDENTITY()

EXEC OrganizationCaseReviewSelect @OrganizationCaseReviewID

GO

GRANT EXEC ON OrganizationCaseReviewInsert TO PUBLIC
GO
