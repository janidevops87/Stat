PRINT 'Sproc: dbo.spu_Audit_QATrackingFormErrors'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingFormErrors'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingFormErrors
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingFormErrors
(
 @QATrackingFormErrorsID int 
,@QATrackingFormID int 
,@QAErrorLogID int 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingFormErrors
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
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --QATrackingFormID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --QAErrorLogID 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --AuditLogTypeID 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QATrackingFormErrors
	WHERE 
		QATrackingFormErrorsID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QATrackingFormErrors
(
 QATrackingFormErrorsID
,QATrackingFormID
,QAErrorLogID
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@QATrackingFormID, 0) = 0 THEN -2 ELSE @QATrackingFormID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QAErrorLogID, 0) = 0 THEN -2 ELSE @QAErrorLogID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
end
GO

