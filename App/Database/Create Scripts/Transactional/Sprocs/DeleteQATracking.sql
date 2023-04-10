IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQATracking]
	PRINT 'Dropping Procedure: DeleteQATracking'
END
	PRINT 'Creating Procedure: DeleteQATracking'
GO

CREATE PROCEDURE [dbo].[DeleteQATracking]
(
	@QATrackingID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQATracking.sql
**		Name: DeleteQATracking
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 01/22/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/22/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[QATracking]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QATrackingID] = @QATrackingID

	DELETE 
	FROM   [QATracking]
	WHERE  
		[QATrackingID] = @QATrackingID

	RETURN @@Error
GO
