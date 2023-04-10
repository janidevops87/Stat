 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQATrackingForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQATrackingForm]
			PRINT 'Dropping Procedure: InsertQATrackingForm'
	END

PRINT 'Creating Procedure: InsertQATrackingForm'
GO

CREATE PROCEDURE [dbo].[InsertQATrackingForm]
(
	@QATrackingFormID int = NULL OUTPUT,
	@QAProcessStepID int = NULL,
	@PersonID int = NULL,
	@QATrackingEventDateTime datetime = NULL,
	@QATrackingCAPANumber varchar(20) = NULL,
	@QATrackingApproved smallint = NULL,
	@QATrackingStatusID int = NULL,
	@QATrackingFormPoints decimal(5,4) = 0,
	@QATrackingFormComments varchar(1000) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQATrackingForm.sql
**		Name: InsertQATrackingForm
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

	INSERT INTO [QATrackingForm]
	(
		[QAProcessStepID],
		[PersonID],
		[QATrackingEventDateTime],
		[QATrackingCAPANumber],
		[QATrackingApproved],
		[QATrackingStatusID],
		QATrackingFormPoints,
		QATrackingFormComments,
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAProcessStepID,
		@PersonID,
		@QATrackingEventDateTime,
		@QATrackingCAPANumber,
		@QATrackingApproved,
		@QATrackingStatusID,
		@QATrackingFormPoints,
		@QATrackingFormComments,
		GetDate(),
		@LastStatEmployeeID,
		@AuditLogTypeID
	)

	SELECT @QATrackingFormID = SCOPE_IDENTITY();

	RETURN @@Error
GO