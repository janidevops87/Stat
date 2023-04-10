IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAMonitoringFormTemplate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAMonitoringFormTemplate]
			PRINT 'Dropping Procedure: InsertQAMonitoringFormTemplate'
	END

PRINT 'Creating Procedure: InsertQAMonitoringFormTemplate'
GO

CREATE PROCEDURE [dbo].[InsertQAMonitoringFormTemplate]
(
	@QAMonitoringFormTemplateID int = NULL OUTPUT,
	@QAMonitoringFormID int = NULL,
	@QAErrorTypeID int,
	@QAMonitoringFormTemplateOrder int = NULL,
	@QAMonitoringFormTemplateActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQAMonitoringFormTemplate.sql
**		Name: InsertQAMonitoringFormTemplate
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

	INSERT INTO [QAMonitoringFormTemplate]
	(
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
		@QAMonitoringFormID,
		@QAErrorTypeID,
		@QAMonitoringFormTemplateOrder,
		@QAMonitoringFormTemplateActive,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @QAMonitoringFormTemplateID = SCOPE_IDENTITY();

	RETURN @@Error
GO