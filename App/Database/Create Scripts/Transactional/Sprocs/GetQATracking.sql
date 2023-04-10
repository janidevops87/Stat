IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATracking]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATracking]
	PRINT 'Dropping Procedure: GetQATracking'
END
	PRINT 'Creating Procedure: GetQATracking'
GO

CREATE PROCEDURE [dbo].[GetQATracking]
(
	@QATrackingNumber varchar(20) = NULL,
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetQATracking.sql
**		Name: GetQATracking
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
**      03/10       jth         change to do this by tracking number...this is used for dupe checking
**	   04/2010		bret			updating to include in release
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
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
	
	FROM
			[QATracking]
	WHERE 
		[QATrackingNumber] = IsNull(@QATrackingNumber, QATrackingNumber) AND
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID)


	RETURN @@Error
GO


