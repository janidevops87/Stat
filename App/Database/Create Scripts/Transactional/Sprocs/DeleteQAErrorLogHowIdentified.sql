IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAErrorLogHowIdentified]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAErrorLogHowIdentified]
	PRINT 'Dropping Procedure: DeleteQAErrorLogHowIdentified'
END
	PRINT 'Creating Procedure: DeleteQAErrorLogHowIdentified'
GO

CREATE PROCEDURE [dbo].[DeleteQAErrorLogHowIdentified]
(
	@QAErrorLogHowIdentifiedID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAErrorLogHowIdentified.sql
**		Name: DeleteQAErrorLogHowIdentified
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
			[QAErrorLogHowIdentified]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAErrorLogHowIdentifiedID] = @QAErrorLogHowIdentifiedID

	DELETE 
	FROM   [QAErrorLogHowIdentified]
	WHERE  
		[QAErrorLogHowIdentifiedID] = @QAErrorLogHowIdentifiedID

	RETURN @@Error
GO



