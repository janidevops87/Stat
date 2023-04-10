IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAErrorType]
	PRINT 'Dropping Procedure: UpdateQAErrorType'
END
	PRINT 'Creating Procedure: UpdateQAErrorType'
GO

CREATE PROCEDURE [dbo].[UpdateQAErrorType]
(
	@QAErrorTypeID int,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QAErrorLocationID int = NULL,
	@QAErrorTypeDescription varchar(255) = NULL,
	@QAErrorRequireReview smallint = NULL,
	@QAErrorTypeActive smallint = NULL,
	@QAErrorTypeInactiveComments varchar(1000) = NULL,
	@QAErrorTypeAssignedPoints int = NULL,
	@QAErrorTypeAutomaticZeroScore smallint = NULL,
	@QAErrorTypeDisplayNA smallint = NULL,
	@QAErrorTypeDisplayComments smallint = NULL,
	@QAErrorTypeGenerateLogIfNo smallint = NULL,
	@QAErrorTypeGenerateLogIfYes smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAErrorType.sql
**		Name: UpdateQAErrorType
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/22/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/22/2009	ccarroll	initial
**		08/17/2009  ccarroll	added Column QAErrorTypeGenerateLogIfYes (used in reports) 
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QAErrorType]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[QATrackingTypeID] = IsNull(@QATrackingTypeID, QATrackingTypeID),
		[QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID),
		[QAErrorTypeDescription] = IsNull(@QAErrorTypeDescription, QAErrorTypeDescription),
		[QAErrorRequireReview] = IsNull(@QAErrorRequireReview, QAErrorRequireReview),
		[QAErrorTypeActive] = IsNull(@QAErrorTypeActive, QAErrorTypeActive),
		[QAErrorTypeInactiveComments] = IsNull(@QAErrorTypeInactiveComments, QAErrorTypeInactiveComments),
		[QAErrorTypeAssignedPoints] = IsNull(@QAErrorTypeAssignedPoints, QAErrorTypeAssignedPoints),
		[QAErrorTypeAutomaticZeroScore] = IsNull(@QAErrorTypeAutomaticZeroScore, QAErrorTypeAutomaticZeroScore),
		[QAErrorTypeDisplayNA] = IsNull(@QAErrorTypeDisplayNA, QAErrorTypeDisplayNA),
		[QAErrorTypeDisplayComments] = IsNull(@QAErrorTypeDisplayComments, QAErrorTypeDisplayComments),
		[QAErrorTypeGenerateLogIfNo] = IsNull(@QAErrorTypeGenerateLogIfNo, QAErrorTypeGenerateLogIfNo),
		[QAErrorTypeGenerateLogIfYes] = IsNull(@QAErrorTypeGenerateLogIfYes, QAErrorTypeGenerateLogIfYes),
	
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QAErrorTypeID] = @QAErrorTypeID

	RETURN @@Error
GO

