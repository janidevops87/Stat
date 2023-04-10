IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAMonitoringFormTemplate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAMonitoringFormTemplate]
	PRINT 'Dropping Procedure: GetQAMonitoringFormTemplate'
END
	PRINT 'Creating Procedure: GetQAMonitoringFormTemplate'
GO

CREATE PROCEDURE [dbo].[GetQAMonitoringFormTemplate]
(
	--@QAMonitoringFormTemplateID int = NULL,
	@QAMonitoringFormID int = NULL
	--@QAErrorTypeID int = NULL
)
/******************************************************************************
**		File: GetQAMonitoringFormTemplate.sql
**		Name: GetQAMonitoringFormTemplate
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      03/09       jth         select by qamonitorformid only
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QAMonitoringFormTemplateID],
		[QAMonitoringFormID],
		[QAErrorTypeID],
		[QAMonitoringFormTemplateOrder],
		[QAMonitoringFormTemplateActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QAMonitoringFormTemplate]
	WHERE 
		--[QAMonitoringFormTemplateID] = IsNull(@QAMonitoringFormTemplateID, QAMonitoringFormTemplateID) AND
		[QAMonitoringFormID] = IsNull(@QAMonitoringFormID, QAMonitoringFormID) --AND
		--[QAErrorTypeID] = IsNull(@QAErrorTypeID, QAErrorTypeID)


	RETURN @@Error
GO


