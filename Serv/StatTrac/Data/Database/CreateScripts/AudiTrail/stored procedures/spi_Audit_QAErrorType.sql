IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAErrorType]
			PRINT 'Dropping Procedure: spi_Audit_QAErrorType'
	END

PRINT 'Creating Procedure: spi_Audit_QAErrorType'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAErrorType]
(
	@QAErrorTypeID int = NULL,
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
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAErrorType.sql 
**		Name: spi_Audit_QAErrorType
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAErrorType]
	(
		[QAErrorTypeID],
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
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorTypeID,
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
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
 