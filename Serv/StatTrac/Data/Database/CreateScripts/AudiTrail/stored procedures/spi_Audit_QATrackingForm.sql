IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATrackingForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATrackingForm]
			PRINT 'Dropping Procedure: spi_Audit_QATrackingForm'
	END

PRINT 'Creating Procedure: spi_Audit_QATrackingForm'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATrackingForm]
(
	@QATrackingFormID int = NULL,
	@QAProcessStepID int = NULL,
	@PersonID int = NULL,
	@QATrackingEventDateTime datetime = NULL,
	@QATrackingCAPANumber varchar(20) = NULL,
	@QATrackingApproved smallint = NULL,
	@QATrackingStatusID int = NULL,
	@QATrackingFormPoints numeric(5,4) = NULL,
	@QATrackingFormComments varchar(1000) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATrackingForm.sql 
**		Name: spi_Audit_QATrackingForm
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

	INSERT INTO [QATrackingForm]
	(
		[QATrackingFormID],
		[QAProcessStepID],
		[PersonID],
		[QATrackingEventDateTime],
		[QATrackingCAPANumber],
		[QATrackingApproved],
		[QATrackingStatusID],
		[QATrackingFormPoints],
		[QATrackingFormComments],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingFormID,
		@QAProcessStepID,
		@PersonID,
		@QATrackingEventDateTime,
		@QATrackingCAPANumber,
		@QATrackingApproved,
		@QATrackingStatusID,
		@QATrackingFormPoints,
		@QATrackingFormComments,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO
 