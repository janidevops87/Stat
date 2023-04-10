IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAMonitoringForm]
	PRINT 'Dropping Procedure: UpdateQAMonitoringForm'
END
	PRINT 'Creating Procedure: UpdateQAMonitoringForm'
GO

CREATE PROCEDURE [dbo].[UpdateQAMonitoringForm]
(
	@QAMonitoringFormID int,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QAMonitoringFormName varchar(255) = NULL,
	--@QAMonitoringFormLogo image = NULL,
	--@QAMonitoringFormStatTracLink varchar(255) = NULL,
	@QAMonitoringFormCalculateScore smallint = NULL,
	@QAMonitoringFormRequireReview smallint = NULL,
	@QAMonitoringFormActive smallint = NULL,
	@QAMonitoringFormInactiveComments varchar(1000) = NULL,
	@QAMonitoringFormScore dec = 0,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: UpdateQAMonitoringForm.sql
**		Name: UpdateQAMonitoringForm
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
**      03/09       jth         trackingid added 
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QAMonitoringForm]
	SET
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID),
		[QATrackingTypeID] = IsNull(@QATrackingTypeID, QATrackingTypeID),
		[QAMonitoringFormName] = IsNull(@QAMonitoringFormName, QAMonitoringFormName),
		--[QAMonitoringFormLogo] = IsNull(@QAMonitoringFormLogo, QAMonitoringFormLogo),
		--[QAMonitoringFormStatTracLink] = IsNull(@QAMonitoringFormStatTracLink, QAMonitoringFormStatTracLink),
		[QAMonitoringFormCalculateScore] = IsNull(@QAMonitoringFormCalculateScore, QAMonitoringFormCalculateScore),
		[QAMonitoringFormRequireReview] = IsNull(@QAMonitoringFormRequireReview, QAMonitoringFormRequireReview),
		[QAMonitoringFormActive] = IsNull(@QAMonitoringFormActive, QAMonitoringFormActive),
		[QAMonitoringFormInactiveComments] = IsNull(@QAMonitoringFormInactiveComments, QAMonitoringFormInactiveComments),
		QAMonitoringFormScore = @QAMonitoringFormScore,
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[QAMonitoringFormID] = @QAMonitoringFormID

	RETURN @@Error
GO
