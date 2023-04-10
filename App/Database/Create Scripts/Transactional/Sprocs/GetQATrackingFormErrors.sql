 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATrackingFormErrors]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATrackingFormErrors]
	PRINT 'Dropping Procedure: GetQATrackingFormErrors'
END
	PRINT 'Creating Procedure: GetQATrackingFormErrors'
GO

CREATE PROCEDURE [dbo].[GetQATrackingFormErrors]
(
@QATrackingFormErrorsID int
)
/******************************************************************************
**		File: GetQATrackingFormErrors.sql
**		Name: GetQATrackingFormErrors
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
		[QATrackingFormErrorsID],
		[QATrackingFormID],
		[QAErrorLogID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QATrackingFormErrors]
	WHERE QATrackingFormErrorsID =  @QATrackingFormErrorsID



	RETURN @@Error
GO