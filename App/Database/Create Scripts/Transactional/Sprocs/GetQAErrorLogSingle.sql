IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorLogSingle]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorLogSingle]
	PRINT 'Dropping Procedure: GetQAErrorLogSingle'
END
	PRINT 'Creating Procedure: GetQAErrorLogSingle'
GO

CREATE PROCEDURE [dbo].[GetQAErrorLogSingle]
(
	@QAErrorLogID int = NULL
)
/******************************************************************************
**		File: GetQAErrorLogSingle.sql
**		Name: GetQAErrorLogSingle
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
**		03/2009		jth			initial
**      06/09       jth         added correction log fields
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QAErrorLogID],
		[QATrackingID],
		[QAProcessStepID],
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
		isnull(QAErrorLogCorrectionLastModified,getdate())as QAErrorLogCorrectionLastModified,
		[QAErrorLogPointsYes],
		[QAErrorLogPointsNo],
		[QAErrorLogPointsNA],
		[QAErrorStatusID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		(select statemployeefirstname + ' ' + statemployeelastname from statemployee where statemployeeid = QAErrorLogCorrectionPersonID) as lastmod
	
	FROM
			[QAErrorLog]
	WHERE 
		
		[QAErrorLogID] = IsNull(@QAErrorLogID, QAErrorLogID)


	RETURN @@Error
GO


 