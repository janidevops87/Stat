IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAErrorType]
			PRINT 'Dropping Procedure: InsertQAErrorType'
	END

PRINT 'Creating Procedure: InsertQAErrorType'
GO

CREATE PROCEDURE [dbo].[InsertQAErrorType]
(
	@QAErrorTypeID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = Null,
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
**		File: InsertQAErrorType.sql
**		Name: InsertQAErrorType
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
**      02/09       jth         use now for last modified instead of a parm
**      03/09       jth         can't use error type in an insert!
**		08/17/2009  ccarroll	added Column QAErrorTypeGenerateLogIfYes (used in reports) 
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorType]
	(
		[OrganizationID],
		[QATrackingTypeID],
		[QAErrorLocationID],
		[QAErrorTypeDescription],
		[QAErrorRequireReview],
		[QAErrorTypeActive],
		[QAErrorTypeInactiveComments],
		[QAErrorTypeAssignedPoints],
		[QAErrorTypeAutomaticZeroScore],
		[QAErrorTypeDisplayNA],
		[QAErrorTypeDisplayComments],
		[QAErrorTypeGenerateLogIfNo],
		[QAErrorTypeGenerateLogIfYes],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@OrganizationID,
		@QATrackingTypeID,
		@QAErrorLocationID,
		@QAErrorTypeDescription,
		@QAErrorRequireReview,
		@QAErrorTypeActive,
		@QAErrorTypeInactiveComments,
		@QAErrorTypeAssignedPoints,
		@QAErrorTypeAutomaticZeroScore,
		@QAErrorTypeDisplayNA,
		@QAErrorTypeDisplayComments,
		@QAErrorTypeGenerateLogIfNo,
		@QAErrorTypeGenerateLogIfYes,

		GetDate(),
		@LastStatEmployeeID,
		1 --Create
	)

	SELECT @QAErrorTypeID = SCOPE_IDENTITY();

	RETURN @@Error
GO
