IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationCaseReviewSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationCaseReviewSelect'
		DROP Procedure OrganizationCaseReviewSelect
	END
GO

PRINT 'Creating Procedure OrganizationCaseReviewSelect'
GO
CREATE Procedure OrganizationCaseReviewSelect
(
		@OrganizationCaseReviewId int = null,
		@OrganizationId int = null,
		@CaseTypeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationCaseReviewSelect.sql
**	Name: OrganizationCaseReviewSelect
**	Desc: Selects multiple rows of OrganizationCaseReview Based on Id  fields 
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
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		OrganizationCaseReview.OrganizationCaseReviewId,
		OrganizationCaseReview.OrganizationId,		
		OrganizationCaseReview.CaseTypeId,
		CaseType AS CaseType,
		OrganizationCaseReview.CaseReviewPercentage,
		OrganizationCaseReview.LastModified,
		OrganizationCaseReview.LastStatEmployeeId,
		OrganizationCaseReview.AuditLogTypeId
	FROM 
		dbo.OrganizationCaseReview 
	JOIN
		CaseType ON CaseType.CaseTypeId = OrganizationCaseReview.CaseTypeId	
	WHERE 
		OrganizationCaseReview.OrganizationCaseReviewId = ISNULL(@OrganizationCaseReviewId, OrganizationCaseReview.OrganizationCaseReviewId)
	AND
		OrganizationCaseReview.OrganizationId = ISNULL(@OrganizationId, OrganizationCaseReview.OrganizationId)
	AND
		OrganizationCaseReview.CaseTypeId = ISNULL(@CaseTypeId, OrganizationCaseReview.CaseTypeId)				
	ORDER BY 1
GO

GRANT EXEC ON OrganizationCaseReviewSelect TO PUBLIC
GO
