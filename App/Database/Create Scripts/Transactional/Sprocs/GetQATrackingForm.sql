 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATrackingForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATrackingForm]
	PRINT 'Dropping Procedure: GetQATrackingForm'
END
	PRINT 'Creating Procedure: GetQATrackingForm'
GO

CREATE PROCEDURE [dbo].[GetQATrackingForm]
(
	@QATrackingFormID int = null
)
/******************************************************************************
**		File: GetQATrackingForm.sql
**		Name: GetQATrackingForm
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QATrackingFormID],
		[QAProcessStepID],
		[PersonID],
		[QATrackingEventDateTime],
		[QATrackingCAPANumber],
		[QATrackingApproved],
		[QATrackingStatusID],QATrackingFormPoints,
		QATrackingFormComments,
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QATrackingForm]
	WHERE  QATrackingFormID  = @QATrackingFormID



	RETURN @@Error
GO