IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorType]
	PRINT 'Dropping Procedure: DeleteQAErrorType'
END
	PRINT 'Creating Procedure: DeleteQAErrorType'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorType]
(
	@QAErrorTypeID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAErrorType.sql
**		Name: DeleteQAErrorType
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
			[QAErrorType]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAErrorTypeID] = @QAErrorTypeID

	DELETE 
	FROM   [QAErrorType]
	WHERE  
		[QAErrorTypeID] = @QAErrorTypeID

	RETURN @@Error
GO


