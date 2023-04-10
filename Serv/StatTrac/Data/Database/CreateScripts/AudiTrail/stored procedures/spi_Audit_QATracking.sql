IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QATracking]
			PRINT 'Dropping Procedure: spi_Audit_QATracking'
	END

PRINT 'Creating Procedure: spi_Audit_QATracking'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QATracking]
(
	@QATrackingID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QATrackingNumber varchar(20) = NULL,
	@QATrackingNotes varchar(1000) = NULL,
	@QATrackingSourceCode varchar(15) = NULL,
	@QATrackingReferralDateTime datetime = NULL,
	@QATrackingReferralTypeID int = NULL,
	@QATrackingStatusID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: spi_Audit_QATracking.sql 
**		Name: spi_Audit_QATracking
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

	INSERT INTO [QATracking]
	(
		[QATrackingID],
		[OrganizationID],
		[QATrackingTypeID],
		[QATrackingNumber],
		[QATrackingNotes],
		[QATrackingSourceCode],
		[QATrackingReferralDateTime],
		[QATrackingReferralTypeID],
		[QATrackingStatusID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingID,
		@OrganizationID,
		@QATrackingTypeID,
		@QATrackingNumber,
		@QATrackingNotes,
		@QATrackingSourceCode,
		@QATrackingReferralDateTime,
		@QATrackingReferralTypeID,
		@QATrackingStatusID,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	
GO