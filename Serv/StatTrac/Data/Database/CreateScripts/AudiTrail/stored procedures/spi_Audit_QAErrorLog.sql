PRINT 'Sproc: spi_Audit_QAErrorLog'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spi_Audit_QAErrorLog'))
BEGIN
	DROP PROCEDURE dbo.spi_Audit_QAErrorLog
END
GO

create PROCEDURE dbo.spi_Audit_QAErrorLog
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
)
AS
/***************************************************************************************************
**	Name: dbo.spi_Audit_QAErrorLog 
**	Desc: Audit Trail Insert Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	06/27/2012	John K	Initial Sproc Creation 
***************************************************************************************************/

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
 @QAErrorLogID 
,@QATrackingID 
,@QAProcessStepID 
,@QAErrorLocationID 
,@QAErrorTypeID 
,@QAMonitoringFormTemplateID 
,@StatEmployeeID 
,@QAErrorLogNumberOfErrors 
,@QAErrorLogDateTime 
,@QAErrorLogHowIdentifiedID 
,@QAErrorLogTicketNumber 
,@QAErrorLogComments 
,@QAErrorLogCorrection 
,@QAErrorLogCorrectionPersonID 
,@QAErrorLogCorrectionLastModified 
,@QAErrorLogPointsYes 
,@QAErrorLogPointsNo 
,@QAErrorLogPointsNA 
,@QAErrorStatusID 
,@LastModified 
,@LastStatEmployeeID 
,@AuditLogTypeID 
,@QAErrorLogPersonID 
)
GO

