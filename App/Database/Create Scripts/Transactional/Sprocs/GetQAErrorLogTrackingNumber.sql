IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorLogTrackingNumber]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorLogTrackingNumber]
	PRINT 'Dropping Procedure: GetQAErrorLogTrackingNumber'
END
	PRINT 'Creating Procedure: GetQAErrorLogTrackingNumber'
GO

CREATE PROCEDURE [dbo].[GetQAErrorLogTrackingNumber]
(
	@QATrackingNumber varchar(20) = NULL,
	@QATrackingFormID int = null
)
/******************************************************************************
**		File: GetQAErrorLogTrackingNumber.sql
**		Name: GetQAErrorLogTrackingNumber
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
**		03/09		jth			initial
**      05/09		jth			needed to select trackingformid
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		QAErrorLog.QAErrorLogID,
		QAErrorLog.QATrackingID,
		QAErrorLog.QAProcessStepID,
		[QAErrorLocationID],
		[QAErrorTypeID],
		[QAMonitoringFormTemplateID],
		[StatEmployeeID],
		[QAErrorLogNumberOfErrors],
		[QAErrorLogDateTime],
		[QAErrorLogHowIdentifiedID],
		[QAErrorLogTicketNumber],
		[QAErrorLogComments],
		[QAErrorLogCorrection],
		QAErrorLogCorrectionPersonID,
		QAErrorLogCorrectionLastModified,
		[QAErrorLogPointsYes],
		[QAErrorLogPointsNo],
		[QAErrorLogPointsNA],
		[QAErrorStatusID],
		QAErrorLog.LastModified,
		QAErrorLog.LastStatEmployeeID,
		QAErrorLog.AuditLogTypeID,
		QAErrorLog.QATrackingID
	
	FROM
			QAErrorLog INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID LEFT OUTER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
	WHERE 

		QATrackingNumber = @QATrackingNumber and  isNull(QATrackingFormID,0) = ISNULL( @QATrackingFormID,IsNull(QATrackingFormID,0))
		

	RETURN @@Error
GO


 