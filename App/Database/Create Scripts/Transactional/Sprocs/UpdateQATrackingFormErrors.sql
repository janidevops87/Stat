 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQATrackingFormErrors]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQATrackingFormErrors]
	PRINT 'Dropping Procedure: UpdateQATrackingFormErrors'
END
	PRINT 'Creating Procedure: UpdateQATrackingFormErrors'
GO

CREATE PROCEDURE [dbo].[UpdateQATrackingFormErrors]
(
	@QATrackingFormErrorsID int,
	@QATrackingFormID int = NULL,
	@QAErrorLogID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQATrackingFormErrors.sql
**		Name: UpdateQATrackingFormErrors
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
	
	UPDATE [QATrackingFormErrors]
	SET
		[QATrackingFormID] = IsNull(@QATrackingFormID, QATrackingFormID),
		[QAErrorLogID] = IsNull(@QAErrorLogID, QAErrorLogID),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = IsNull(@AuditLogTypeID, AuditLogTypeID)
	WHERE 
QATrackingFormErrorsID =  @QATrackingFormErrorsID

	RETURN @@Error
GO