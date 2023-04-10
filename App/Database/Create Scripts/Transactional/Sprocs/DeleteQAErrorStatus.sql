IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorStatus]
	PRINT 'Dropping Procedure: DeleteQAErrorStatus'
END
	PRINT 'Creating Procedure: DeleteQAErrorStatus'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorStatus]
(
	@QAErrorStatusID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAErrorStatus.sql
**		Name: DeleteQAErrorStatus
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
			[QAErrorStatus]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAErrorStatusID] = @QAErrorStatusID

	DELETE 
	FROM   [QAErrorStatus]
	WHERE  
		[QAErrorStatusID] = @QAErrorStatusID

	RETURN @@Error
GO

