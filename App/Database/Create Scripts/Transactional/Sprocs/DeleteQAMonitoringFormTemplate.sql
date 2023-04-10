IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteQAMonitoringFormTemplate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteQAMonitoringFormTemplate]
	PRINT 'Dropping Procedure: DeleteQAMonitoringFormTemplate'
END
	PRINT 'Creating Procedure: DeleteQAMonitoringFormTemplate'
GO

CREATE PROCEDURE [dbo].[DeleteQAMonitoringFormTemplate]
(
	@QAMonitoringFormTemplateID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteQAMonitoringFormTemplate.sql
**		Name: DeleteQAMonitoringFormTemplate
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
			[QAMonitoringFormTemplate]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	[QAMonitoringFormTemplateID] = @QAMonitoringFormTemplateID

	DELETE 
	FROM   [QAMonitoringFormTemplate]
	WHERE  
		[QAMonitoringFormTemplateID] = @QAMonitoringFormTemplateID

	RETURN @@Error
GO
