 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridManageQualityMonitoringForms]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridManageQualityMonitoringForms]
	PRINT 'Dropping Procedure: GetQAGridManageQualityMonitoringForms'
END
	PRINT 'Creating Procedure: GetQAGridManageQualityMonitoringForms'
GO

CREATE PROCEDURE [dbo].[GetQAGridManageQualityMonitoringForms]
(
	@OrganizationID int = NULL,
	@QAMonitoringFormActive smallint = NULL
)
/******************************************************************************
**		File: GetQAGridManageQualityMonitoringForms.sql
**		Name: GetQAGridManageQualityMonitoringForms
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/03/2009	ccarroll	initial
**      03/09       jth         no active from logic 
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
IF @QAMonitoringFormActive = 0
		BEGIN
			/* Display All ErrorTypes */
			SET @QAMonitoringFormActive =1
		END
ELSE 
		BEGIN
			/* Only display active ErrorTypes */	 
			SET @QAMonitoringFormActive =null
		END
	SELECT
		QAMonitoringForm.QAMonitoringFormID,
		QAMonitoringForm.QAMonitoringFormName,
		--QAMonitoringForm.QAMonitoringFormLogo,
		QATrackingType.QATrackingTypeID,
		QATrackingType.QATrackingTypeDescription,
		QAMonitoringForm.QAMonitoringFormCalculateScore,				
		QAMonitoringForm.QAMonitoringFormRequireReview,
		QAMonitoringForm.QAMonitoringFormActive,
		QALogos.ImageName
	
	FROM
			  QAMonitoringForm LEFT OUTER JOIN
                      QALogos ON QAMonitoringForm.OrganizationID = QALogos.OrganizationID AND 
                      QAMonitoringForm.QATrackingTypeID = QALogos.TrackingTypeID LEFT OUTER JOIN
                      QATrackingType ON QATrackingType.QATrackingTypeID = QAMonitoringForm.QATrackingTypeID
	WHERE 
		QAMonitoringForm.QAMonitoringFormActive = IsNull(@QAMonitoringFormActive, QAMonitoringForm.QAMonitoringFormActive) AND
		QAMonitoringForm.OrganizationID = IsNull(@OrganizationID, QAMonitoringForm.OrganizationID)


	RETURN @@Error
GO


