IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQATrackingbyNumber]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQATrackingbyNumber]
	PRINT 'Dropping Procedure: GetQATrackingbyNumber'
END
	PRINT 'Creating Procedure: GetQATrackingbyNumber'
GO

CREATE PROCEDURE [dbo].[GetQATrackingbyNumber]
(
	@QATrackingNumber varchar(20) = NULL
	
)
/******************************************************************************
**		File: GetQATrackingbyNumber.sql
**		Name: GetQATrackingbyNumber
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/2009		jth			initial
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
		[QATrackingNumber] = @QATrackingNumber
		


	RETURN @@Error
GO


 