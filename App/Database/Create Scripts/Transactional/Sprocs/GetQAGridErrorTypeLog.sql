 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridErrorTypeLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridErrorTypeLog]
	PRINT 'Dropping Procedure: GetQAGridErrorTypeLog'
END
	PRINT 'Creating Procedure: GetQAGridErrorTypeLog'
GO

CREATE PROCEDURE [dbo].[GetQAGridErrorTypeLog]
(
	@QATrackingID int = NULL,
	@QAErrorLocationID int = NULL,
	@PersonID int = NULL
)
/******************************************************************************
**		File: GetQAGridErrorTypeLog.sql
**		Name: GetQAGridErrorTypeLog
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/28/2009	ccarroll	initial
**      02/09       jth         we don't need tracking number
**      1/10        jth         change to use new field qaerrorlogpersonid
**      2/10        jth         put tracking id back in as parm
**	   04/2010		bret			updating to include in release
**      05/10       jth         return trackingformid
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
				QAErrorLog.QAErrorLogID,
				QAErrorLog.QAErrorTypeID,
				QAErrorType.QAErrorTypeDescription,
				QAErrorLog.QAProcessStepID,
				QAProcessStep.QAProcessStepDescription,
				QAErrorLog.QAErrorLogNumberOfErrors,
				CONVERT(CHAR(10),QAErrorLog.QAErrorLogDateTime,101) + ' ' +
				CONVERT(CHAR(5),QAErrorLog.QAErrorLogDateTime,108) as QAErrorLogDateTimeString,
				QAErrorLog.QAErrorLogDateTime,
				QAErrorLog.QAErrorLogHowIdentifiedID,
				QAErrorLogHowIdentified.QAErrorLogHowIdentifiedDescription,
				QAErrorLog.QAErrorLogTicketNumber,
				QAErrorLog.QAErrorLogComments,
				QAErrorLog.QAErrorStatusID,
				QAErrorStatus.QAErrorStatusDescription,
				QAErrorLog.QAErrorLogCorrection,
				CONVERT(CHAR(10),QAErrorLogCorrectionLastModified,101) + ' ' +
				CONVERT(CHAR(5),QAErrorLogCorrectionLastModified,108)+ '  ' +
				(select statemployeefirstname + ' ' + statemployeelastname from statemployee where statemployeeid = QAErrorLogCorrectionPersonID)
				as QAErrorLogCorrectionLog,
				QAErrorLog.QAErrorLocationID,QAErrorLog.StatEmployeeID,QAErrorLog.QAErrorLogPersonID,
				(select QAErrorLocationDescription from  QAErrorLocation where  QAErrorLocation.QAErrorLocationID = QAErrorLog.QAErrorLocationID) as  'LocationDesc',
				(select QATrackingType.QATrackingTypeDescription from  QATrackingType where  QATrackingType.QATrackingTypeID=(select QAErrorType.QATrackingTypeID from QAErrorType where QAErrorType.QAErrorTypeID = QAErrorLog.QAErrorTypeID)) as  'TrackingTypeDesc',
				QATrackingFormID
	FROM		QAErrorLog
	
	LEFT JOIN	QAErrorType ON QAErrorType.QAErrorTypeID = QAErrorLog.QAErrorTypeID
	LEFT JOIN	QAProcessStep ON QAProcessStep.QAProcessStepID = QAErrorLog.QAProcessStepID
	LEFT JOIN	QAErrorLogHowIdentified ON QAErrorLogHowIdentified.QAErrorLogHowIdentifiedID = QAErrorLog.QAErrorLogHowIdentifiedID
	LEFT JOIN	QAErrorStatus ON QAErrorStatus.QAErrorStatusID = QAErrorLog.QAErrorStatusID
	LEFT OUTER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
	WHERE
			QAErrorLog.QAErrorLogPersonID = @PersonID AND
			QAErrorLog.QATrackingID = IsNull(@QATrackingID, QAErrorLog.QATrackingID) AND
			QAErrorLog.QAErrorLocationID = IsNull(@QAErrorLocationID, QAErrorLog.QAErrorLocationID) and
			(QAErrorLog.QAErrorLogNumberOfErrors > 0 or QAMonitoringFormTemplateID is null)
			

	RETURN @@Error
GO


 