 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAMonitoringForm]
			PRINT 'Dropping Procedure: spi_Audit_QAMonitoringForm'
	END

PRINT 'Creating Procedure: spi_Audit_QAMonitoringForm'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAMonitoringForm]
(
	@QAMonitoringFormID int = NULL,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QAMonitoringFormName varchar(255) = NULL,
	@QAMonitoringFormRequireReview smallint = NULL,
	@QAMonitoringFormCalculateScore smallint = NULL,
	@QAMonitoringFormActive smallint = NULL,
	@QAMonitoringFormInactiveComments varchar(1000) = NULL,
	@QAMonitoringFormScore decimal(5,0) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QAMonitoringForm.sql 
**		Name: spi_Audit_QAMonitoringForm
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

	INSERT INTO [QAMonitoringForm]
	(
		[QAMonitoringFormID],
		[OrganizationID],
		[QATrackingTypeID],
		[QAMonitoringFormName],
		[QAMonitoringFormRequireReview],
		[QAMonitoringFormCalculateScore],
		[QAMonitoringFormActive],
		[QAMonitoringFormInactiveComments],
		[QAMonitoringFormScore],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAMonitoringFormID,
		@OrganizationID,
		@QATrackingTypeID,
		@QAMonitoringFormName,
		@QAMonitoringFormRequireReview,
		@QAMonitoringFormCalculateScore,
		@QAMonitoringFormActive,
		@QAMonitoringFormInactiveComments,
		@QAMonitoringFormScore,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
