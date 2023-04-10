IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQATracking]
	PRINT 'Dropping Procedure: UpdateQATracking'
END
	PRINT 'Creating Procedure: UpdateQATracking'
GO

CREATE PROCEDURE [dbo].[UpdateQATracking]
(
	@QATrackingID int,
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
**		File: UpdateQATracking.sql
**		Name: UpdateQATracking
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
**      02/09       jth         misssing processstepid
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QATracking]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[QATrackingTypeID] = IsNull(@QATrackingTypeID, QATrackingTypeID),
		[QATrackingNumber] = IsNull(@QATrackingNumber, QATrackingNumber),
		[QATrackingNotes] = IsNull(@QATrackingNotes, QATrackingNotes),
		[QATrackingSourceCode] = IsNull(@QATrackingSourceCode, QATrackingSourceCode),
		[QATrackingReferralDateTime] = IsNull(@QATrackingReferralDateTime, QATrackingReferralDateTime),
		[QATrackingReferralTypeID] = IsNull(@QATrackingReferralTypeID, QATrackingReferralTypeID),
		[QATrackingStatusID] = IsNull(@QATrackingStatusID, QATrackingStatusID),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QATrackingID] = @QATrackingID

	RETURN @@Error
GO
