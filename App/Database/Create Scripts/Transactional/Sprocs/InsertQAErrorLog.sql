IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAErrorLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAErrorLog]
			PRINT 'Dropping Procedure: InsertQAErrorLog'
	END

PRINT 'Creating Procedure: InsertQAErrorLog'
GO

CREATE PROCEDURE [dbo].[InsertQAErrorLog]
(
	@QAErrorLogID int = NULL OUTPUT,
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
**		File: InsertQAErrorLog.sql
**		Name: InsertQAErrorLog
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

	INSERT INTO [QAErrorLog]
	(
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
		[QAErrorLogPersonID]
	)
	VALUES
	(
		@QATrackingID,
		@QAProcessStepID,
		@QAErrorLocationID,
		@QAErrorTypeID,
		@QAMonitoringFormTemplateID,
		@StatEmployeeID,
		@QAErrorLogNumberOfErrors,
		@QAErrorLogDateTime,
		@QAErrorLogHowIdentifiedID,
		@QAErrorLogTicketNumber,
		@QAErrorLogComments,
		@QAErrorLogCorrection,
		@QAErrorLogCorrectionPersonID,
		@QAErrorLogCorrectionLastModified,
		@QAErrorLogPointsYes,
		@QAErrorLogPointsNo,
		@QAErrorLogPointsNA,
		@QAErrorStatusID,
		GetDate(),
		@LastStatEmployeeID,
		1, -- Create
		@QAErrorLogPersonID
	)

	SELECT @QAErrorLogID = SCOPE_IDENTITY();

	--- update CallNumber
	UPDATE
		QAErrorLog
	SET
		
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = 3, -- 3 = Modify	
		LastModified = GetDate()
	WHERE
		QAErrorLogID = @QAErrorLogID 	

SELECT
QAErrorLogID,
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
		[QAErrorLogPersonID]
FROM
	QAErrorLog
WHERE
	QAErrorLogID  = @QAErrorLogID 



GO

GRANT EXEC ON InsertCall TO PUBLIC

GO
