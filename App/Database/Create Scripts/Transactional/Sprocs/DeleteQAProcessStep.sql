IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAProcessStep]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAProcessStep]
	PRINT 'Dropping Procedure: DeleteQAProcessStep'
END
	PRINT 'Creating Procedure: DeleteQAProcessStep'
GO

CREATE PROCEDURE [dbo].[DeleteQAProcessStep]
(
	@QAProcessStepID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAProcessStep.sql
**		Name: DeleteQAProcessStep
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
			[QAProcessStep]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAProcessStepID] = @QAProcessStepID

	DELETE 
	FROM   [QAProcessStep]
	WHERE  
		[QAProcessStepID] = @QAProcessStepID

	RETURN @@Error
GO


