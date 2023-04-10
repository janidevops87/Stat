  IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridAddEditQualityMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridAddEditQualityMonitoringForm]
	PRINT 'Dropping Procedure: GetQAGridAddEditQualityMonitoringForm'
END
	PRINT 'Creating Procedure: GetQAGridAddEditQualityMonitoringForm'
GO

CREATE PROCEDURE [dbo].[GetQAGridAddEditQualityMonitoringForm]
(
	@QAMonitoringFormID int = NULL,
	@QATrackingFormID int = Null
)
/******************************************************************************
**		File: GetQAGridAddEditQualityMonitoringForm.sql
**		Name: GetQAGridAddEditQualityMonitoringForm
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/10/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/10/2009	ccarroll	initial
**      02/09       jth         use tracking number and not trackingid
**      02/09       jth         fixed join to return correct error type data
**      03/09       jth         added columns and order by
**      03/09       jth         where clause had search by tracking number and s/b formid
**      04/09       jth         added trackingformid as criteria
**		12/08/2009	ccarroll	removed table alias in ORDER BY for SQL Server 2008 update.
**		03/16/2010	ccarroll	Added this note for inclusion in release
********************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
				QAErrorLog.QAErrorLogID,
				QAMonitoringForm.QAMonitoringFormName,
				QAErrorLocation.QAErrorLocationID,
				isnull(QAErrorLocation.QAErrorLocationDescription,'Default') as QAErrorLocationDescription,
				--QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,
				QAErrorType.QAErrorTypeDescription,
				QAErrorType.QAErrorTypeAssignedPoints,
				QAErrorLog.QAErrorLogPointsYes,
				QAErrorLog.QAErrorLogPointsNo,
				QAErrorLog.QAErrorLogPointsNA,
				QAErrorLog.QAErrorLogComments,
				QAErrorLog.StatEmployeeID,
				QAErrorType.QAErrorTypeDisplayNA,
				QAErrorType.QAErrorTypeDisplayComments, 
                QAMonitoringForm.QAMonitoringFormCalculateScore,
                QAErrorType.QAErrorTypeAutomaticZeroScore,
                QAMonitoringForm.QAMonitoringFormID,
                QAErrorType.QAErrorTypeGenerateLogIfNo,
                QAErrorLog.QAErrorLogNumberOfErrors,
                isnull(QAMonitoringFormTemplate.QAMonitoringFormTemplateOrder,0) AS QAMonitoringFormTemplateOrder, 
				QALogos.ImageName
	FROM            QATrackingFormErrors INNER JOIN
                      QAErrorLog INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID ON 
                      QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID LEFT OUTER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID LEFT OUTER JOIN
                      QAMonitoringFormTemplate ON 
                      QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID LEFT OUTER JOIN
                      QALogos RIGHT OUTER JOIN
                      QAMonitoringForm ON QALogos.OrganizationID = QAMonitoringForm.OrganizationID AND 
                      QALogos.TrackingTypeID = QAMonitoringForm.QATrackingTypeID ON 
                      QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID LEFT OUTER JOIN
                      QAErrorLocation ON QAErrorType.QAErrorLocationID = QAErrorLocation.QAErrorLocationID

	WHERE		QAMonitoringFormTemplate.QAMonitoringFormID =  @QAMonitoringFormID and QATrackingFormID = @QATrackingFormID
	
	ORDER BY
				QAErrorLocationDescription,
				QAMonitoringFormTemplateOrder
	
	RETURN @@Error
GO


