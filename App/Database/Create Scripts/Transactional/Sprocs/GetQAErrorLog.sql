IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorLog]
	PRINT 'Dropping Procedure: GetQAErrorLog'
END
	PRINT 'Creating Procedure: GetQAErrorLog'
GO

CREATE PROCEDURE [dbo].[GetQAErrorLog]
(
	@QAErrorTypeID int = NULL,
	@StatEmployeeID int = NULL,
	@QAErrorLocationID int = NULL
)
/******************************************************************************
**		File: GetQAErrorLog.sql
**		Name: GetQAErrorLog
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
**      02/09       jth         remove unnecessary parms
**      03/09       jth         added lastmod
**      02/10       jth         this should lookup by new field qaerrorlogpersonid...(statemployeeid parm)
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
		QAErrorLogCorrectionLastModified,
		[QAErrorLogPointsYes],
		[QAErrorLogPointsNo],
		[QAErrorLogPointsNA],
		[QAErrorStatusID],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		(select statemployeefirstname + ' ' + statemployeelastname from statemployee where statemployeeid = QAErrorLogCorrectionPersonID) as lastmod,
		[QAErrorLogPersonID]
	
	FROM
			[QAErrorLog]
	WHERE 
		[QAErrorLogPersonID] = IsNull(@StatEmployeeID, QAErrorLogPersonID) AND
		--[QATrackingID] = IsNull(@QATrackingID, QATrackingID) AND
		--[QAProcessStepID] = IsNull(@QAProcessStepID, QAProcessStepID) AND
		[QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID) AND
		[QAErrorTypeID] = IsNull(@QAErrorTypeID, QAErrorTypeID) --AND
		--[QAErrorLogHowIdentifiedID] = IsNull(@QAErrorLogHowIdentifiedID, QAErrorLogHowIdentifiedID) AND
		--[QAErrorStatusID] = IsNull(@QAErrorStatusID, QAErrorStatusID)


	RETURN @@Error
GO


