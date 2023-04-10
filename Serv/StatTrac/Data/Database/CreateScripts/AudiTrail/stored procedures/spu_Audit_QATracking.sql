PRINT 'Sproc: dbo.spu_Audit_QATracking'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATracking'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATracking
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATracking
(
 @QATrackingID int 
,@OrganizationID int 
,@QATrackingTypeID int 
,@QATrackingNumber varchar(20)
,@QATrackingNotes varchar(1000)
,@QATrackingSourceCode varchar(15)
,@QATrackingReferralDateTime datetime 
,@QATrackingReferralTypeID int 
,@QATrackingStatusID int 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(2)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATracking
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
SUBSTRING(@Bitmap, 1, 1) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 1) & 4 <> 4 --QATrackingTypeID 
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QATrackingNumber 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --QATrackingNotes 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --QATrackingSourceCode 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --QATrackingReferralDateTime 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --QATrackingReferralTypeID 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --QATrackingStatusID 
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
		QATracking
	WHERE 
		QATrackingID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QATracking
(
 QATrackingID
,OrganizationID
,QATrackingTypeID
,QATrackingNumber
,QATrackingNotes
,QATrackingSourceCode
,QATrackingReferralDateTime
,QATrackingReferralTypeID
,QATrackingStatusID
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QATrackingTypeID, 0) = 0 THEN -2 ELSE @QATrackingTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QATrackingNumber, '') = '' THEN 'ILB'  ELSE @QATrackingNumber END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@QATrackingNotes, '') = '' THEN 'ILB'  ELSE @QATrackingNotes END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@QATrackingSourceCode, '') = '' THEN 'ILB'  ELSE @QATrackingSourceCode END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@QATrackingReferralDateTime, '') = '' THEN '1900-01-01'  ELSE @QATrackingReferralDateTime END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@QATrackingReferralTypeID, 0) = 0 THEN 0 ELSE @QATrackingReferralTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@QATrackingStatusID, 0) = 0 THEN 0 ELSE @QATrackingStatusID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
End
GO

