PRINT 'Sproc: dbo.spu_Audit_QAMonitoringFormTemplate'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAMonitoringFormTemplate'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAMonitoringFormTemplate
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAMonitoringFormTemplate
(
 @QAMonitoringFormTemplateID int 
,@QAMonitoringFormID int 
,@QAErrorTypeID int 
,@QAMonitoringFormTemplateOrder int 
,@QAMonitoringFormTemplateActive smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAMonitoringFormTemplate
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
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --QAMonitoringFormID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --QAErrorTypeID 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QAMonitoringFormTemplateOrder 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --QAMonitoringFormTemplateActive 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --LastModified 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --AuditLogTypeID 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QAMonitoringFormTemplate
	WHERE 
		QAMonitoringFormTemplateID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QAMonitoringFormTemplate
(
 QAMonitoringFormTemplateID
,QAMonitoringFormID
,QAErrorTypeID
,QAMonitoringFormTemplateOrder
,QAMonitoringFormTemplateActive
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@QAMonitoringFormID, 0) = 0 THEN -2 ELSE @QAMonitoringFormID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QAErrorTypeID, 0) = 0 THEN -2 ELSE @QAErrorTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QAMonitoringFormTemplateOrder, 0) = 0 THEN 0 ELSE @QAMonitoringFormTemplateOrder END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@QAMonitoringFormTemplateActive, 0) = 0 THEN 0 ELSE @QAMonitoringFormTemplateActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
end
GO

