IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAMonitoringForm]
	PRINT 'Dropping Procedure: DeleteQAMonitoringForm'
END
	PRINT 'Creating Procedure: DeleteQAMonitoringForm'
GO

CREATE PROCEDURE [dbo].[DeleteQAMonitoringForm]
(
	@QAMonitoringFormID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAMonitoringForm.sql
**		Name: DeleteQAMonitoringForm
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
			[QAMonitoringForm]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAMonitoringFormID] = @QAMonitoringFormID

	DELETE 
	FROM   [QAMonitoringForm]
	WHERE  
		[QAMonitoringFormID] = @QAMonitoringFormID

	RETURN @@Error
GO


