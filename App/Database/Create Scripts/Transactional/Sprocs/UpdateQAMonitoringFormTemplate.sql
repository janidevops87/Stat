IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAMonitoringFormTemplate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAMonitoringFormTemplate]
	PRINT 'Dropping Procedure: UpdateQAMonitoringFormTemplate'
END
	PRINT 'Creating Procedure: UpdateQAMonitoringFormTemplate'
GO

CREATE PROCEDURE [dbo].[UpdateQAMonitoringFormTemplate]
(
	@QAMonitoringFormTemplateID int,
	@QAMonitoringFormID int = NULL,
	@QAErrorTypeID int,
	@QAMonitoringFormTemplateOrder int = NULL,
	@QAMonitoringFormTemplateActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAMonitoringFormTemplate.sql
**		Name: UpdateQAMonitoringFormTemplate
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
	
	UPDATE [QAMonitoringFormTemplate]
	SET
		[QAMonitoringFormID] = IsNull(@QAMonitoringFormID, QAMonitoringFormID),
		[QAErrorTypeID] = IsNull(@QAErrorTypeID, QAErrorTypeID),
		[QAMonitoringFormTemplateOrder] = IsNull(@QAMonitoringFormTemplateOrder, QAMonitoringFormTemplateOrder),
		[QAMonitoringFormTemplateActive] = IsNull(@QAMonitoringFormTemplateActive, QAMonitoringFormTemplateActive),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QAMonitoringFormTemplateID] = @QAMonitoringFormTemplateID

	RETURN @@Error
GO
