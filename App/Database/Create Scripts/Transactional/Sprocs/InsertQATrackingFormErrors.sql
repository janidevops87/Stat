 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQATrackingFormErrors]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQATrackingFormErrors]
			PRINT 'Dropping Procedure: InsertQATrackingFormErrors'
	END

PRINT 'Creating Procedure: InsertQATrackingFormErrors'
GO

CREATE PROCEDURE [dbo].[InsertQATrackingFormErrors]
(
	@QATrackingFormErrorsID int = NULL OUTPUT,
	@QATrackingFormID int = NULL,
	@QAErrorLogID int = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQATrackingFormErrors.sql
**		Name: InsertQATrackingFormErrors
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: jth
**		Date: 04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		04/2009	jth	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingFormErrors]
	(
		[QATrackingFormID],
		[QAErrorLogID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingFormID,
		@QAErrorLogID,
		GetDate(),
		@LastStatEmployeeID,
		@AuditLogTypeID
	)

	SELECT @QATrackingFormErrorsID = SCOPE_IDENTITY();

	RETURN @@Error
GO