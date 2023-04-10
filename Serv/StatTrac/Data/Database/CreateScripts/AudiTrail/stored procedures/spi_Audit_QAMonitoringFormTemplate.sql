 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAMonitoringFormTemplate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAMonitoringFormTemplate]
			PRINT 'Dropping Procedure: spi_Audit_QAMonitoringFormTemplate'
	END

PRINT 'Creating Procedure: spi_Audit_QAMonitoringFormTemplate'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAMonitoringFormTemplate]
(
	@QAMonitoringFormTemplateID int = NULL,
	@QAMonitoringFormID int = NULL,
	@QAErrorTypeID int,
	@QAMonitoringFormTemplateOrder int = NULL,
	@QAMonitoringFormTemplateActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAMonitoringFormTemplate.sql 
**		Name: spi_Audit_QAMonitoringFormTemplate
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAMonitoringFormTemplate]
	(
		[QAMonitoringFormTemplateID],
		[QAMonitoringFormID],
		[QAErrorTypeID],
		[QAMonitoringFormTemplateOrder],
		[QAMonitoringFormTemplateActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAMonitoringFormTemplateID,
		@QAMonitoringFormID,
		@QAErrorTypeID,
		@QAMonitoringFormTemplateOrder,
		@QAMonitoringFormTemplateActive,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
