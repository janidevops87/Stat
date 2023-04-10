PRINT 'Sproc: dbo.spu_Audit_QATrackingForm'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingForm'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingForm
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingForm
(
 @QATrackingFormID int 
,@QAProcessStepID int 
,@PersonID int 
,@QATrackingEventDateTime datetime 
,@QATrackingCAPANumber varchar(20)
,@QATrackingApproved smallint 
,@QATrackingStatusID int 
,@QATrackingFormPoints numeric(5, 4)
,@QATrackingFormComments varchar(1000)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingForm
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
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --QAProcessStepID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --PersonID 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QATrackingEventDateTime 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --QATrackingCAPANumber 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --QATrackingApproved 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --QATrackingStatusID 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --QATrackingFormPoints 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --QATrackingFormComments 
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --LastModified 
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --AuditLogTypeID 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QATrackingForm
	WHERE 
		QATrackingFormID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QATrackingForm
(
 QATrackingFormID
,QAProcessStepID
,PersonID
,QATrackingEventDateTime
,QATrackingCAPANumber
,QATrackingApproved
,QATrackingStatusID
,QATrackingFormPoints
,QATrackingFormComments
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@QAProcessStepID, 0) = 0 THEN -2 ELSE @QAProcessStepID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@PersonID, 0) = 0 THEN -2 ELSE @PersonID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QATrackingEventDateTime, '') = '' THEN '1900-01-01'  ELSE @QATrackingEventDateTime END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@QATrackingCAPANumber, '') = '' THEN 'ILB'  ELSE @QATrackingCAPANumber END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@QATrackingApproved, 0) = 0 THEN 0 ELSE @QATrackingApproved END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@QATrackingStatusID, 0) = 0 THEN 0 ELSE @QATrackingStatusID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@QATrackingFormPoints, 0) = 0 THEN 0 ELSE @QATrackingFormPoints END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@QATrackingFormComments, '') = '' THEN 'ILB'  ELSE @QATrackingFormComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
end
GO

