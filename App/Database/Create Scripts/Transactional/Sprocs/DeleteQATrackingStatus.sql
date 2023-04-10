 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQATrackingStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQATrackingStatus]
	PRINT 'Dropping Procedure: DeleteQATrackingStatus'
END
	PRINT 'Creating Procedure: DeleteQATrackingStatus'
GO

CREATE PROCEDURE [dbo].[DeleteQATrackingStatus]
(
	@QATrackingStatusID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQATrackingStatus.sql
**		Name: DeleteQATrackingStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 01/30/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/30/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[QATrackingStatus]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QATrackingStatusID] = @QATrackingStatusID

	DELETE 
	FROM   [QATrackingStatus]
	WHERE  
		[QATrackingStatusID] = @QATrackingStatusID

	RETURN @@Error
GO

