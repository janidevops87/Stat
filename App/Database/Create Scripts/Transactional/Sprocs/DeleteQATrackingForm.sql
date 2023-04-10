 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQATrackingForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQATrackingForm]
	PRINT 'Dropping Procedure: DeleteQATrackingForm'
END
	PRINT 'Creating Procedure: DeleteQATrackingForm'
GO

CREATE PROCEDURE [dbo].[DeleteQATrackingForm]
(@QATrackingFormID int,
@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQATrackingForm.sql
**		Name: DeleteQATrackingForm
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
			[QATrackingForm]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	QATrackingFormID  = @QATrackingFormID 

	DELETE 
	FROM   [QATrackingForm]
	WHERE  QATrackingFormID  = @QATrackingFormID 


	RETURN @@Error
GO
