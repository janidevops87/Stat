PRINT 'Sproc: dbo.spu_Audit_QATrackingType'
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND object_id = OBJECT_ID('dbo.spu_Audit_QATrackingType'))
BEGIN
	DROP PROCEDURE dbo.spu_Audit_QATrackingType
END
GO

CREATE PROCEDURE dbo.spu_Audit_QATrackingType
(
 @QATrackingTypeID int 
,@OrganizationID int 
,@QATrackingTypeDescription varchar(255)
,@LastModified datetime 
,@LastStatEmployeeID int 
,@AuditLogTypeID int 
,@PKC1 int
,@Bitmap binary(1)
)
AS
/***************************************************************************************************
**	Name: dbo.spu_Audit_QATrackingType
**	Desc: Audit Trail Update Stored Procedure
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date      	Author			Description/Work Item#
**	----------	------------	--------------------------------------------------------------------
**	04/25/2012	ccarroll	Initial Sproc Creation 
***************************************************************************************************/

IF NOT (
SUBSTRING(@Bitmap, 1, 0) & 2 <> 2 --OrganizationID 
AND SUBSTRING(@Bitmap, 1, 0) & 4 <> 4 --QATrackingTypeDescription 
AND SUBSTRING(@Bitmap, 1, 0) & 8 <> 8 --LastModified 
AND SUBSTRING(@Bitmap, 1, 0) & 16 <> 16 --LastStatEmployeeID 
AND SUBSTRING(@Bitmap, 1, 0) & 32 <> 32 --AuditLogTypeID 
)


INSERT INTO dbo.QATrackingType
(
 QATrackingTypeID
,OrganizationID
,QATrackingTypeDescription
,LastModified
,LastStatEmployeeID
,AuditLogTypeID
)
VALUES 
( 
@PKC1,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 2 = 2 AND ISNULL(@OrganizationID, 0) = 0 THEN -2 ELSE @OrganizationID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 4 = 4 AND ISNULL(@QATrackingTypeDescription, '') = '' THEN 'ILB'  ELSE @QATrackingTypeDescription END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 8 = 8 AND ISNULL(@LastModified, '') = '' THEN '1900-01-01'  ELSE @LastModified END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 16 = 16 AND ISNULL(@LastStatEmployeeID, 0) = 0 THEN -2 ELSE @LastStatEmployeeID END,
CASE WHEN SUBSTRING(@Bitmap, 1, 0) & 32 = 32 AND ISNULL(@AuditLogTypeID, 0) = 0 THEN -2 ELSE @AuditLogTypeID END
)
GO

