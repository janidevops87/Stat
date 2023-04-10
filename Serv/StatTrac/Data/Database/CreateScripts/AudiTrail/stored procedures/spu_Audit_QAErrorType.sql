PRINT 'Sproc: dbo.spu_Audit_QAErrorType'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QAErrorType'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QAErrorType
END
GO

CREATE PROCEDURE dbo.spu_Audit_QAErrorType
(
 @QAErrorTypeID int 
,@OrganizationID int 
,@QATrackingTypeID int 
,@QAErrorLocationID int 
,@QAErrorTypeDescription varchar(255)
,@QAErrorRequireReview smallint 
,@QAErrorTypeActive smallint 
,@QAErrorTypeInactiveComments varchar(1000)
,@QAErrorTypeAssignedPoints int 
,@QAErrorTypeAutomaticZeroScore smallint 
,@QAErrorTypeDisplayNA smallint 
,@QAErrorTypeDisplayComments smallint 
,@QAErrorTypeGenerateLogIfNo smallint 
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@QAErrorTypeGenerateLogIfYes smallint 
,@PKC1 int
,@Bitmap binary(3)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QAErrorType
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
AND SUBSTRING(@Bitmap, 1, 1) & 8 <> 8 --QAErrorLocationID 
AND SUBSTRING(@Bitmap, 1, 1) & 16 <> 16 --QAErrorTypeDescription 
AND SUBSTRING(@Bitmap, 1, 1) & 32 <> 32 --QAErrorRequireReview 
AND SUBSTRING(@Bitmap, 1, 1) & 64 <> 64 --QAErrorTypeActive 
AND SUBSTRING(@Bitmap, 1, 1) & 128 <> 128 --QAErrorTypeInactiveComments 
AND SUBSTRING(@Bitmap, 2, 1) & 1 <> 1 --QAErrorTypeAssignedPoints 
AND SUBSTRING(@Bitmap, 2, 1) & 2 <> 2 --QAErrorTypeAutomaticZeroScore 
AND SUBSTRING(@Bitmap, 2, 1) & 4 <> 4 --QAErrorTypeDisplayNA 
AND SUBSTRING(@Bitmap, 2, 1) & 8 <> 8 --QAErrorTypeDisplayComments 
AND SUBSTRING(@Bitmap, 2, 1) & 16 <> 16 --QAErrorTypeGenerateLogIfNo 
AND SUBSTRING(@Bitmap, 2, 1) & 32 <> 32 --LastModified 
AND SUBSTRING(@Bitmap, 2, 1) & 64 <> 64 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 2, 1) & 128 <> 128 --AuditLogTypeID 
AND SUBSTRING(@Bitmap, 3, 1) & 1 <> 1 --QAErrorTypeGenerateLogIfYes 
)
Begin
-- get the basic values if they do not exists
	SELECT TOP 1
		@lastModified = ISNULL(@lastModified, GetDate()),
		@lastStatEmployeeID = ISNULL(@lastStatEmployeeID, lastStatEmployeeID),
		@AuditLogTypeID = ISNULL(@AuditLogTypeID,3)
	FROM
		QAErrorType
	WHERE 
		QAErrorTypeID = @pkc1
	ORDER BY
		LastModified DESC
	
INSERT INTO dbo.QAErrorType
(
 QAErrorTypeID
,OrganizationID
,QATrackingTypeID
,QAErrorLocationID
,QAErrorTypeDescription
,QAErrorRequireReview
,QAErrorTypeActive
,QAErrorTypeInactiveComments
,QAErrorTypeAssignedPoints
,QAErrorTypeAutomaticZeroScore
,QAErrorTypeDisplayNA
,QAErrorTypeDisplayComments
,QAErrorTypeGenerateLogIfNo
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
,QAErrorTypeGenerateLogIfYes
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 4 = 4 AND ISNULL(@QATrackingTypeID, 0) = 0 THEN -2 ELSE @QATrackingTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 8 = 8 AND ISNULL(@QAErrorLocationID, 0) = 0 THEN -2 ELSE @QAErrorLocationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 16 = 16 AND ISNULL(@QAErrorTypeDescription, '') = '' THEN 'ILB'  ELSE @QAErrorTypeDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 32 = 32 AND ISNULL(@QAErrorRequireReview, 0) = 0 THEN 0 ELSE @QAErrorRequireReview END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 64 = 64 AND ISNULL(@QAErrorTypeActive, 0) = 0 THEN 0 ELSE @QAErrorTypeActive END,
CASE WHEN SUBSTRING(@Bitmap, 1, 1) & 128 = 128 AND ISNULL(@QAErrorTypeInactiveComments, '') = '' THEN 'ILB'  ELSE @QAErrorTypeInactiveComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 1 = 1 AND ISNULL(@QAErrorTypeAssignedPoints, 0) = 0 THEN 0 ELSE @QAErrorTypeAssignedPoints END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 2 = 2 AND ISNULL(@QAErrorTypeAutomaticZeroScore, 0) = 0 THEN 0 ELSE @QAErrorTypeAutomaticZeroScore END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 4 = 4 AND ISNULL(@QAErrorTypeDisplayNA, 0) = 0 THEN 0 ELSE @QAErrorTypeDisplayNA END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 8 = 8 AND ISNULL(@QAErrorTypeDisplayComments, 0) = 0 THEN 0 ELSE @QAErrorTypeDisplayComments END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 16 = 16 AND ISNULL(@QAErrorTypeGenerateLogIfNo, 0) = 0 THEN 0 ELSE @QAErrorTypeGenerateLogIfNo END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 32 = 32 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 64 = 64 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 2, 1) & 128 = 128 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END,
CASE WHEN SUBSTRING(@Bitmap, 3, 1) & 1 = 1 AND ISNULL(@QAErrorTypeGenerateLogIfYes, 0) = 0 THEN 0 ELSE @QAErrorTypeGenerateLogIfYes END
)
end
GO

