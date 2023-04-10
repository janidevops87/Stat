IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorLog]
	PRINT 'Dropping Procedure: DeleteQAErrorLog'
END
	PRINT 'Creating Procedure: DeleteQAErrorLog'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorLog]
(
	@QAErrorLogID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAErrorLog.sql
**		Name: DeleteQAErrorLog
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
			[QAErrorLog]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAErrorLogID] = @QAErrorLogID

	DELETE 
	FROM   [QAErrorLog]
	WHERE  
		[QAErrorLogID] = @QAErrorLogID

	RETURN @@Error
GO