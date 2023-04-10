 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQATrackingFormErrors]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQATrackingFormErrors]
	PRINT 'Dropping Procedure: DeleteQATrackingFormErrors'
END
	PRINT 'Creating Procedure: DeleteQATrackingFormErrors'
GO

CREATE PROCEDURE [dbo].[DeleteQATrackingFormErrors]
(@QATrackingFormErrorsID int
,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQATrackingFormErrors.sql
**		Name: DeleteQATrackingFormErrors
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

	UPDATE
			[QATrackingFormErrors]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	  QATrackingFormErrorsID =  @QATrackingFormErrorsID

	DELETE 
	FROM   [QATrackingFormErrors]
	WHERE  QATrackingFormErrorsID =  @QATrackingFormErrorsID


	RETURN @@Error
GO