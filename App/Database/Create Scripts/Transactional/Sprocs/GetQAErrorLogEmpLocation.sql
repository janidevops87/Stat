 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAErrorLogEmpLocation]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAErrorLogEmpLocation]
	PRINT 'Dropping Procedure: GetQAErrorLogEmpLocation'
END
	PRINT 'Creating Procedure: GetQAErrorLogEmpLocation'
GO

CREATE PROCEDURE [dbo].[GetQAErrorLogEmpLocation]
(
	@StatEmployeeID int = NULL, 
	@QAErrorLocationID int = NULL
)
/******************************************************************************
**		File: GetQAErrorLogEmpLocation.sql
**		Name: GetQAErrorLogEmpLocation
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**      02/09       jth         initial
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
		QAErrorLogPersonID
	
	FROM
			[QAErrorLog]
	WHERE 
		
		[QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID) AND
		[QAErrorLogPersonID] = IsNull(@StatEmployeeID, QAErrorLogPersonID)
		


	RETURN @@Error
GO


