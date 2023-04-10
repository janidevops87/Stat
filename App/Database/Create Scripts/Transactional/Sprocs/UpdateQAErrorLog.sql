IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateQAErrorLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateQAErrorLog]
	PRINT 'Dropping Procedure: UpdateQAErrorLog'
END
	PRINT 'Creating Procedure: UpdateQAErrorLog'
GO

CREATE PROCEDURE [dbo].[UpdateQAErrorLog]
(
	@QAErrorLogID int,
	@QATrackingID int = NULL,
	@QAProcessStepID int = NULL,
	@QAErrorLocationID int = NULL,
	@QAErrorTypeID int = NULL,
	@QAMonitoringFormTemplateID int = NULL,
	@StatEmployeeID int = NULL,
	@QAErrorLogNumberOfErrors int = NULL,
	@QAErrorLogDateTime datetime = NULL,
	@QAErrorLogHowIdentifiedID int = NULL,
	@QAErrorLogTicketNumber varchar(250) = NULL,
	@QAErrorLogComments varchar(1000) = NULL,
	@QAErrorLogCorrection varchar(1000) = NULL,
	@QAErrorLogCorrectionPersonID int = NULL,
	@QAErrorLogCorrectionLastModified datetime = NULL,
	@QAErrorLogPointsYes smallint = NULL,
	@QAErrorLogPointsNo smallint = NULL,
	@QAErrorLogPointsNA smallint = NULL,
	@QAErrorStatusID int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL,
	@QAErrorLogPersonID int = Null
)
/******************************************************************************
**		File: UpdateQAErrorLog.sql
**		Name: UpdateQAErrorLog
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
**      1/10        jth         change to use new field qaerrorlogpersonid
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [QAErrorLog]
	SET
		[QATrackingID] = IsNull(@QATrackingID, QATrackingID),
		[QAProcessStepID] = IsNull(@QAProcessStepID, QAProcessStepID),
		[QAErrorLocationID] = IsNull(@QAErrorLocationID, QAErrorLocationID),
		[QAErrorTypeID] = IsNull(@QAErrorTypeID, QAErrorTypeID),
		[QAMonitoringFormTemplateID] = IsNull(@QAMonitoringFormTemplateID, QAMonitoringFormTemplateID),
		[StatEmployeeID] = IsNull(@StatEmployeeID, StatEmployeeID),
		[QAErrorLogNumberOfErrors] = IsNull(@QAErrorLogNumberOfErrors, QAErrorLogNumberOfErrors),
		[QAErrorLogDateTime] = IsNull(@QAErrorLogDateTime, QAErrorLogDateTime),
		[QAErrorLogHowIdentifiedID] = IsNull(@QAErrorLogHowIdentifiedID, QAErrorLogHowIdentifiedID),
		[QAErrorLogTicketNumber] = IsNull(@QAErrorLogTicketNumber, QAErrorLogTicketNumber),
		[QAErrorLogComments] = @QAErrorLogComments,
		[QAErrorLogCorrection] = IsNull(@QAErrorLogCorrection, QAErrorLogCorrection),
		[QAErrorLogCorrectionPersonID] = IsNull(@QAErrorLogCorrectionPersonID, QAErrorLogCorrectionPersonID),
		[QAErrorLogCorrectionLastModified] = IsNull(@QAErrorLogCorrectionLastModified, QAErrorLogCorrectionLastModified),
		[QAErrorLogPointsYes] = IsNull(@QAErrorLogPointsYes, QAErrorLogPointsYes),
		[QAErrorLogPointsNo] = IsNull(@QAErrorLogPointsNo, QAErrorLogPointsNo),
		[QAErrorLogPointsNA] = IsNull(@QAErrorLogPointsNA, QAErrorLogPointsNA),
		[QAErrorStatusID] = IsNull(@QAErrorStatusID, QAErrorStatusID),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3, --Modify
		[QAErrorLogPersonID] = IsNull(@QAErrorLogPersonID, QAErrorLogPersonID)
	WHERE 
		[QAErrorLogID] = @QAErrorLogID

	RETURN @@Error
GO