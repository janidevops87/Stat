PRINT 'Sproc: dbo.spu_Audit_QAErrorLog'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorLog'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorLog
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorLog
(
 @QAErrorLogID int 
,@QATrackingID int 
,@QAProcessStepID int 
,@QAErrorLocationID int 
,@QAErrorTypeID int 
,@QAMonitoringFormTemplateID int 
,@StatEmployeeID int 
,@QAErrorLogNumberOfErrors int 
,@QAErrorLogDateTime datetime 
,@QAErrorLogHowIdentifiedID int 
,@QAErrorLogTicketNumber varchar(20)
,@QAErrorLogComments varchar(1000)
,@QAErrorLogCorrection varchar(1000)
,@QAErrorLogCorrectionPersonID int 
,@QAErrorLogCorrectionLastModified datetime 
,@QAErrorLogPointsYes smallint 
,@QAErrorLogPointsNo smallint 
,@QAErrorLogPointsNA smallint 
,@QAErrorStatusID int 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@QAErrorLogPersonID int 
,@PKC1 int
,@Bitmap binary(4)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorLog
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
**  04/28/2013	jth			fixed offsets, lastmodified, laststatemployeeid and auditlogtype 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --QATrackingID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --QAProcessStepID 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QAErrorLocationID 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --QAErrorTypeID 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --QAMonitoringFormTemplateID 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --StatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --QAErrorLogNumberOfErrors 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --QAErrorLogDateTime 
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --QAErrorLogHowIdentifiedID 
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --QAErrorLogTicketNumber 
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --QAErrorLogComments 
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --QAErrorLogCorrection 
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --QAErrorLogCorrectionPersonID 
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --QAErrorLogCorrectionLastModified 
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --QAErrorLogPointsYes 
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --QAErrorLogPointsNo 
AND SUBSTRING(@Bitmap, 3, 1) & 2 <> 2 --QAErrorLogPointsNA 
AND SUBSTRING(@Bitmap, 3, 1) & 4 <> 4 --QAErrorStatusID 
AND SUBSTRING(@Bitmap, 3, 1) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 3, 1) & 16 <> 16 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 3, 1) & 32 <> 32 --AuditLogTypeID 
AND SUBSTRING(@Bitmap, 3, 1) & 64 <> 64 --QAErrorLogPersonID 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QAErrorLog
	WHERE 
		QAErrorLogID = @pkc1
	ORDER BY
		LastModified DESC

INSERT INTO dbo.QAErrorLog
(
 QAErrorLogID
,QATrackingID
,QAProcessStepID
,QAErrorLocationID
,QAErrorTypeID
,QAMonitoringFormTemplateID
,StatEmployeeID
,QAErrorLogNumberOfErrors
,QAErrorLogDateTime
,QAErrorLogHowIdentifiedID
,QAErrorLogTicketNumber
,QAErrorLogComments
,QAErrorLogCorrection
,QAErrorLogCorrectionPersonID
,QAErrorLogCorrectionLastModified
,QAErrorLogPointsYes
,QAErrorLogPointsNo
,QAErrorLogPointsNA
,QAErrorStatusID
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
,QAErrorLogPersonID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@QATrackingID, 0) = 0 THEN -2 ELSE @QATrackingID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QAProcessStepID, 0) = 0 THEN -2 ELSE @QAProcessStepID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QAErrorLocationID, 0) = 0 THEN -2 ELSE @QAErrorLocationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@QAErrorTypeID, 0) = 0 THEN -2 ELSE @QAErrorTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@QAMonitoringFormTemplateID, 0) = 0 THEN -2 ELSE @QAMonitoringFormTemplateID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@StatEmployeeID, 0) = 0 THEN -2 ELSE @StatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@QAErrorLogNumberOfErrors, 0) = 0 THEN 0 ELSE @QAErrorLogNumberOfErrors END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@QAErrorLogDateTime, '') = '' THEN '1900-01-01'  ELSE @QAErrorLogDateTime END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@QAErrorLogHowIdentifiedID, 0) = 0 THEN -2 ELSE @QAErrorLogHowIdentifiedID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@QAErrorLogTicketNumber, '') = '' THEN 'ILB'  ELSE @QAErrorLogTicketNumber END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@QAErrorLogComments, '') = '' THEN 'ILB'  ELSE @QAErrorLogComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@QAErrorLogCorrection, '') = '' THEN 'ILB'  ELSE @QAErrorLogCorrection END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@QAErrorLogCorrectionPersonID, 0) = 0 THEN -2 ELSE @QAErrorLogCorrectionPersonID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@QAErrorLogCorrectionLastModified, '') = '' THEN '1900-01-01'  ELSE @QAErrorLogCorrectionLastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@QAErrorLogPointsYes, 0) = 0 THEN 0 ELSE @QAErrorLogPointsYes END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@QAErrorLogPointsNo, 0) = 0 THEN 0 ELSE @QAErrorLogPointsNo END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 2 = 2 AND ISNULL(@QAErrorLogPointsNA, 0) = 0 THEN 0 ELSE @QAErrorLogPointsNA END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 4 = 4 AND ISNULL(@QAErrorStatusID, 0) = 0 THEN -2 ELSE @QAErrorStatusID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 16 = 16 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 32 = 32 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 64 = 64 AND ISNULL(@QAErrorLogPersonID, 0) = 0 THEN -2 ELSE @QAErrorLogPersonID END
)
end
GO

