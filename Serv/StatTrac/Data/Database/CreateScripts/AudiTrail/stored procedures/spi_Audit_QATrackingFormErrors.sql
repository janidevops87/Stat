 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATrackingFormErrors]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATrackingFormErrors]
			PRINT 'Dropping Procedure: spi_Audit_QATrackingFormErrors'
	END

PRINT 'Creating Procedure: spi_Audit_QATrackingFormErrors'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATrackingFormErrors]
(
	@QATrackingFormErrorsID int = NULL,
	@QATrackingFormID int = NULL,
	@QAErrorLogID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATrackingFormErrors.sql 
**		Name: spi_Audit_QATrackingFormErrors
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

	INSERT INTO [QATrackingFormErrors]
	(
		[QATrackingFormErrorsID],
		[QATrackingFormID],
		[QAErrorLogID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingFormErrorsID,
		@QATrackingFormID,
		@QAErrorLogID,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
