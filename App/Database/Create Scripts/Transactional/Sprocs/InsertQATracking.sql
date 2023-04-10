IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQATracking]
			PRINT 'Dropping Procedure: InsertQATracking'
	END

PRINT 'Creating Procedure: InsertQATracking'
GO

CREATE PROCEDURE [dbo].[InsertQATracking]
(
	@QATrackingID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QATrackingNumber varchar(255) = NULL,
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
**		File: InsertQATracking.sql
**		Name: InsertQATracking
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

	INSERT INTO [QATracking]
	(
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
		@OrganizationID,
		@QATrackingTypeID,
		@QATrackingNumber,
		@QATrackingNotes,
		@QATrackingSourceCode,
		@QATrackingReferralDateTime,
		@QATrackingReferralTypeID,
		@QATrackingStatusID,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @QATrackingID = SCOPE_IDENTITY();

	RETURN @@Error
GO