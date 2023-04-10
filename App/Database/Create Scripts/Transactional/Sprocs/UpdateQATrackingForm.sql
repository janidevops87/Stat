 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQATrackingForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQATrackingForm]
	PRINT 'Dropping Procedure: UpdateQATrackingForm'
END
	PRINT 'Creating Procedure: UpdateQATrackingForm'
GO

CREATE PROCEDURE [dbo].[UpdateQATrackingForm]
(
	@QATrackingFormID int,
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
**		File: UpdateQATrackingForm.sql
**		Name: UpdateQATrackingForm
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
	
	UPDATE [QATrackingForm]
	SET
		[QAProcessStepID] = IsNull(@QAProcessStepID, QAProcessStepID),
		[PersonID] = IsNull(@PersonID, PersonID),
		[QATrackingEventDateTime] = IsNull(@QATrackingEventDateTime, QATrackingEventDateTime),
		[QATrackingCAPANumber] = IsNull(@QATrackingCAPANumber, QATrackingCAPANumber),
		[QATrackingApproved] = IsNull(@QATrackingApproved, QATrackingApproved),
		[QATrackingStatusID] = IsNull(@QATrackingStatusID, QATrackingStatusID),
		QATrackingFormPoints = @QATrackingFormPoints,
		QATrackingFormComments = @QATrackingFormComments,
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = IsNull(@AuditLogTypeID, AuditLogTypeID)
	WHERE 
[QATrackingFormID] = @QATrackingFormID

	RETURN @@Error
GO